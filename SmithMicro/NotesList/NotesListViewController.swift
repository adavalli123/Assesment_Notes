//
//  NotesListViewController.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/3/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit
import CodableFirebase
import Firebase

class NotesListViewController: UITableViewController {
    var viewModal = NotesListViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        setupUI()
        updateUIOnceWegotNewNotes()
    }
    
    private func setupUI() {
        let addNotesBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNotes))
        self.tableView.tableFooterView = UIView()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [spacer, addNotesBarButton]
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    private func updateUIOnceWegotNewNotes() {
        viewModal.addNoteChangeListioner { [weak self] (notes)  in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.viewModal.notes = notes
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func addNotes() {
        let notesVC = AddNotesViewController()
        notesVC.viewModal.folder = viewModal.folder
        notesVC.viewModal.user = viewModal.user
        notesVC.viewModal.index = viewModal.notes.count
        notesVC.viewModal.notes = viewModal.notes
        self.navigationController?.pushViewController(notesVC, animated: true)
    }
    
}

extension NotesListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.notes.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Folder from : " + (viewModal.folder?.folderName ?? "")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = viewModal.notes[indexPath.row].text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notesVC = AddNotesViewController()
        notesVC.viewModal.note = viewModal.notes[indexPath.row]
        notesVC.viewModal.user = viewModal.user
        notesVC.viewModal.folder = viewModal.folder
        notesVC.viewModal.index = indexPath.row
        notesVC.viewModal.wasupdatedFlow = true
        notesVC.viewModal.notes = viewModal.notes
        self.navigationController?.pushViewController(notesVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModal.deleteNotes(at: indexPath.row)
        }
    }
}
