//
//  NotesListViewModal.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/5/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase
import FirebaseStorage

struct NotesListViewModal {
    var user: Users?
    var notes: [Note] = []
    var folder: Folder?
    
    func addNoteChangeListioner(completion: @escaping ([Note]) -> Void) {
        let db = Firestore.firestore().collection(AddNewNoteViewModal.path(userID: user?.email, folderId: folder?.folderID))
        db.addSnapshotListener { (snapshot, error) in
            var notes: [Note] = []
            guard let documents = snapshot?.documents else { return }
            documents.forEach({ (document) in
                guard let note = FirebaseDecoder.decoder(Note.self, from: document.data()) else { return }
                notes.append(note)
            })
            
            let sortedNotes = notes.sorted(by: {$0.notesID < $1.notesID})
            completion(sortedNotes)
        }
    }
    
    func deleteNotes(at index: Int) {
        let db = Firestore.firestore().collection(AddNewNoteViewModal.path(userID: user?.email, folderId: folder?.folderID))
        db.document("\(index)").delete() { error in }
    }
}
