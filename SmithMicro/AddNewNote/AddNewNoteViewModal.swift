//
//  AddNewNoteViewModal.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/5/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation
import Firebase

struct AddNewNoteViewModal {
    var user: Users?
    var note: Note?
    var notes: [Note]?
    var folder: Folder?
    var index: Int = 0
    var wasupdatedFlow = false
    var createdNewInstance = true
    
    func updateOrCreateNew(text: String) {
        guard text.isEmpty == false else { return }
        let db = Firestore.firestore().collection(AddNewNoteViewModal.path(userID: user?.email, folderId: folder?.folderID))
        if wasupdatedFlow == true && createdNewInstance == true {
            db.document("\(index)").updateData([
                "text": text
            ])
        } else {
            db.document("\(index)").setData([
                "folderID": folder?.folderID ?? "",
                "text": text,
                "timestamp": Date.getTimestamp(),
                "notesID": notes?.count ?? 0,
                "url": [],
            ])
        }
    }
    
    func deletedSelectedNotes() {
        let folderDatabase = Firestore.firestore().collection(AddNewNoteViewModal.path(userID: user?.email, folderId: folder?.folderID))
        folderDatabase.document("\(index)").delete() { error in
            guard error == nil else { return }
        }
    }
    
    static func path(userID:String?, folderId: String?) -> String {
        let users = "users/"
        let userID = userID ?? ""
        let folders = "/folders/"
        let folderIndex = folderId ?? ""
        let notes = "/notes"
        return users + userID + folders + folderIndex + notes
    }
}
