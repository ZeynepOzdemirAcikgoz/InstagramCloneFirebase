//
//  ViewController.swift
//  InstaFirebase
//
//  Created by Zeynep Özdemir Açıkgöz on 1.07.2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func singInCLicked(_ sender: Any) {
        //performSegue(withIdentifier: "toFeedVC", sender: nil)
        if emailtext.text != "" && passwordText.text != ""{
            
            Auth.auth().signIn(withEmail: emailtext.text!, password: passwordText.text!) { authdata, error in
                if error != nil{
                    self.makealert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                    
                }else{
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }
    }
    
    @IBAction func singUpClicked(_ sender: Any) {
    
        if emailtext.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailtext.text!, password: passwordText.text!) { authdata, error in
                if error != nil{
                    self.makealert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                    
                }else{
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else{
            makealert(titleInput: "Error!", messageInput: "Username/Password?")
            
        }
    
    }
    func makealert(titleInput : String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}

