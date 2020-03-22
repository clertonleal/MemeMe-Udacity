//
//  ViewController.swift
//  MemeMe
//
//  Created by Clêrton Cunha Leal on 21/03/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toollBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    private var keyboardManager: KeyboardManager!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topLabel.delegate = self
        bottomLabel.delegate = self
        keyboardManager = KeyboardManager(view: view, shouldUpScreen: { self.bottomLabel.isEditing })
        keyboardManager.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardManager.unsubscribeFromKeyboardNotifications()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func generateMemedImage() -> UIImage {
        menuVisibility(visibility: true)
        let image = generateScreenShot(view: view)
        menuVisibility(visibility: false)
        return image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let takedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            memeImage.image = takedImage
        }
        
        shareButton.isEnabled = true
        
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func selectImageFromGalery(_ sender: Any) {
        openImageSelector(type: .photoLibrary)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        openImageSelector(type: .camera)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        topLabel.text = "TOP"
        bottomLabel.text = "BOTTOM"
        memeImage.image = nil
        
        shareButton.isEnabled = false
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let viewController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: [])
        present(viewController, animated: true)
    }

    private func openImageSelector(type: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = type
        present(pickerController, animated: true, completion: nil)
    }
    
    private func menuVisibility(visibility: Bool) {
        toollBar.isHidden = visibility
        navigationBar.isHidden = visibility
    }
    
}

