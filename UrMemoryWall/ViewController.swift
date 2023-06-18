//
//  ViewController.swift
//  AniDuvarim
//
//  Created by Fatih Karahan on 16.06.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!    
    @IBOutlet weak var sifreTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func girisYapTiklandi(_ sender: Any) {
        //Kullanıcı kaydı kontrol işlemi
        if emailTextField.text != "" && sifreTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil{
                    self.hataMesaji(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error, Try Again")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            self.hataMesaji(titleInput: "Error!", messageInput: "Enter your e-mail and password")
        }
    }
    
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        if emailTextField.text != "" && sifreTextField.text != ""{
            //Kayıt olma işlemi
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil{
                    self.hataMesaji(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error, Try Again")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            //Hata mesajı verilecek
            self.hataMesaji(titleInput: "Error!", messageInput: "Enter your e-mail and password")
        }
    }
    
    func hataMesaji(titleInput: String, messageInput: String){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

