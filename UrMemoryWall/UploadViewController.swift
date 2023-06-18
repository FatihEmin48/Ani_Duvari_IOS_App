//
//  UploadViewController.swift
//  AniDuvarim
//
//  Created by Fatih Karahan on 16.06.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)

        // Do any additional setup after loading the view.
    }
    
    @objc func gorselSec() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            
            imageReferance.putData(data, metadata: nil) { storagemetadata, error in
                if error != nil {
                    self.hataMesajiGoster(title: "ERROR!", message: error?.localizedDescription ?? "Error, Try Again")
                } else {
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl{
                                
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = ["gorselUrl" : imageUrl, "yorum" : self.commentTextField.text!, "email" : Auth.auth().currentUser!.email, "tarih" : FieldValue.serverTimestamp()] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                    if error != nil {
                                        self.hataMesajiGoster(title: "Error", message: error?.localizedDescription ?? "Error, Try Again")
                                    } else {
                                        self.commentTextField.text = ""
                                        self.imageView.image = UIImage(named: "photoIcon")
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func hataMesajiGoster(title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
