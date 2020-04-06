//
//  FolderListViewController.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/4/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class FolderListViewController: UITableViewController {
    var user: Users?
    var viewModal = FolderListViewModal()
    var editButton: UIBarButtonItem?
    var doneButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModal.user = user
        
        title = "Folders"
        
        viewModal.addFolderChangeListioner() { [weak self] (folders) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.viewModal.folders = folders
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        self.tableView.dataSource = self
        self.navigationItem.hidesBackButton = true
        
        let addFolderBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFolder))
        self.navigationItem.rightBarButtonItem = addFolderBarButton
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.leftBarButtonItem = logoutButton
        
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editFolders))
        doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEditing))
        self.doneButton?.isEnabled = false
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        if let editButton = editButton, let doneButton = doneButton {
            toolbarItems = [doneButton, spacer, editButton]
            self.navigationController?.setToolbarHidden(false, animated: false)
        }
    }
    
    @objc func addFolder() {
        createAlertViewController()
    }
    
    @objc func editFolders() {
        self.doneButton?.isEnabled = true
        self.editButton?.isEnabled = false
       tableView.setEditing(true, animated: true)
    }
    
    @objc func doneEditing() {
        self.doneButton?.isEnabled = false
        self.editButton?.isEnabled = true
        tableView.setEditing(false, animated: true)
    }
    
    @objc func logout() {
        viewModal.logout()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(identifier: String(describing: ViewController.self)) as? ViewController else { return }
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.setViewControllers([loginVC], animated: true)
    }
    
    private func createAlertViewController() {
        let alertController = UIAlertController(title: "Add Folder Name", message: "", preferredStyle: .alert)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter folder name"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [weak self] alert -> Void in
            guard let folderText = alertController.textFields?.first?.text else { return }
            self?.viewModal.folderName = folderText
            self?.viewModal.updateFolderDB()
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension FolderListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.folders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = viewModal.folders[indexPath.row].folderName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notesListViewController = NotesListViewController()
        notesListViewController.viewModal.user = viewModal.user
        notesListViewController.viewModal.folder = viewModal.folders[indexPath.row]
        navigationController?.title = "Notes List"
        self.navigationController?.pushViewController(notesListViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModal.deleteFolder(folder: viewModal.folders[indexPath.row])
            viewModal.deleteNotesInsideFolder(folder: viewModal.folders[indexPath.row])
        }
    }
}
