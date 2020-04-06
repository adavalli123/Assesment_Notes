//
//  FolderListViewModal.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/4/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

struct FolderListViewModal {
    var folders: [Folder] = []
    var folderID: String?
    var user: Users?
    var folderName: String = ""
    
    let db = Firestore.firestore().collection(Constants.folders)
    
    func updateFolderDB() {
        guard let email = user?.email else { return }
        let count = String(describing: self.folders.count)
        let db = Firestore.firestore().collection(FolderListViewModal.baseurl(email: email))
        db.document(count).setData([
            Constants.folderName: folderName,
            Constants.userID: email,
            Constants.folderID: count,
            Constants.numberOfNotes: 0,
            Constants.timestamp: Date.getTimestamp(),
            Constants.notes: []
        ])
    }
    
    func addFolderChangeListioner(completion: @escaping ([Folder])->Void) {
        let db = Firestore.firestore().collection(FolderListViewModal.baseurl(email: user?.email))
        db.addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            var folders = [Folder]()
            documents.forEach({ (document) in
                guard let folder = FirebaseDecoder.decoder(Folder.self, from: document.data()) else { return }
                folders.append(folder)
            })
            
            let sortedFolder = folders.sorted(by: {$0.folderID < $1.folderID})
            completion(sortedFolder)
        }
    }
    
    func deleteFolder(folder: Folder?) {
        guard let folder = folder else { return }
        let folderDatabase = Firestore.firestore().collection(FolderListViewModal.baseurl(email: user?.email))
        folderDatabase.document(folder.folderID).delete() { error in
            guard error == nil else { return }
        }
    }
    
    func deleteNotesInsideFolder(folder: Folder?) {
        let db = Firestore.firestore().collection(AddNewNoteViewModal.path(userID: user?.email, folderId: folder?.folderID))
        db.getDocuments { (snapshot, error) in
            guard error == nil, let documents = snapshot?.documents else { return }
            documents.forEach({ (document) in
                Firestore.firestore().collection(AddNewNoteViewModal.path(userID: self.user?.email, folderId: folder?.folderID)).document(document.documentID).delete() { error in
                    guard error == nil else { return }
                }
            })
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
    }
    
    static func baseurl(email: String?) -> String {
        return "users/" + (email ?? "") + "/" + Constants.folders
    }
}

extension FolderListViewModal {
    enum Constants {
        static let folders = "folders"
        static let folderName = "folderName"
        static let userID = "userID"
        static let folderID = "folderID"
        static let numberOfNotes = "numberOfNotes"
        static let timestamp = "timestamp"
        static let notes = "notes"
    }
}
