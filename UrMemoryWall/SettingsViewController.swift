//
//  SettingsViewController.swift
//  AniDuvarim
//
//  Created by Fatih Karahan on 16.06.2023.
//

import UIKit
import Firebase


class SettingsViewController: UIViewController {

 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cikisYapTiklandi(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("Error")
        }
    }

}
