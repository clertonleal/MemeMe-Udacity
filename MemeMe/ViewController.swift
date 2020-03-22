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
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toollBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    private var keyboardManager: KeyboardManager!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        configureTextFields()
        keyboardManager = KeyboardManager(view: view, shouldUpScreen: { self.bottomTextField.isEditing })
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
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        memeImage.image = nil
        
        shareButton.isEnabled = false
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let viewController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: [])
        viewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
            }
        }
        
        present(viewController, animated: true)
    }
    
    private func configureTextFields() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let memeTextAttributes = getTextFieldAttributes()
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    private func save() {
        // TODO will be implemented in the next chalenge
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImage.image!, memedImage: generateMemedImage())
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

