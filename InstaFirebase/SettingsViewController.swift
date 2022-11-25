//
//  SettingsViewController.swift
//  InstaFirebase
//
//  Created by Zeynep Özdemir Açıkgöz on 1.07.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)

            
        }catch{
         
            print("Error!!")
        }

}
}
