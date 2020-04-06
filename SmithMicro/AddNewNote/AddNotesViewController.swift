//
//  AddNotesViewController.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/3/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import CodableFirebase

class AddNotesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var viewModal = AddNewNoteViewModal()
    var notesTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupBarButtons()
    }
    
    private func setupUI() {
        notesTextView.text = viewModal.note?.text ?? ""
        notesTextView.isScrollEnabled = false
        notesTextView.sizeToFit()
        notesTextView.scrollIndicatorInsets = .zero
        view.addSubview(notesTextView)
        notesTextView.addConstaintsToSuperview()
    }
    
    private func setupBarButtons() {
        let trashBarButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(selectedTrash))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(selectedShare))
        let photosBarButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(selectedCamera))
        
        let addNotesBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNotes))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [trashBarButton, spacer, shareButton, spacer, photosBarButton, spacer, addNotesBarButton]
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        toolbar.items = toolbarItems
        toolbar.sizeToFit()
        notesTextView.inputAccessoryView = toolbar

    }
    
    @objc func addNotes() {
        self.notesTextView.text = ""
        self.viewModal.index = viewModal.notes?.count ?? 0
        viewModal.createdNewInstance = false
    }
    
    @objc func selectedShare() {
        guard notesTextView.text.isEmpty == false else { return }
        let text = notesTextView.text ?? ""
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModal.updateOrCreateNew(text: notesTextView.text)
    }
    
    
    @objc func selectedTrash() {
        viewModal.deletedSelectedNotes()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectedCamera() {
        // Handle Camera action
    }
}

extension AddNotesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
}

