//
//  UploadViewController.swift
//  InstaFirebase
//
//  Created by Zeynep Özdemir Açıkgöz on 1.07.2022.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        selectImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        selectImage.addGestureRecognizer(gestureRecognizer)
        
       /* uploadButton.isUserInteractionEnabled = true
        let gestureRecognizerButton = UITapGestureRecognizer(target: self, action: #selector(gestureButton))
        
        uploadButton.addTarget(self, action: #selector(self.gestureButton(sender:)), for: .touchUpInside)
    }
    
    @objc func gestureButton(sender: UIButton){
        
        }
        */

        
    }
    
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makealert(titleInput : String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func uploadButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let uuid = UUID().uuidString
        let mediaFolder = storageReferance.child("Media")
        
        if let data = selectImage.image?.jpegData(compressionQuality: 0.9){
            let imageReferange = mediaFolder.child("\(uuid).jpeg")
            imageReferange.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    print(error?.localizedDescription)
                    
                }else{
                    imageReferange.downloadURL { url, error in
                        if error == nil{
                            let imageurl = url?.absoluteString

                            
                            //DATABASE
                            
                            
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReferance : DocumentReference? = nil
                            let  firestorePost = ["imageUrl" : imageurl!, "posteBy": Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil{
                                    
                                    self.makealert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                }else{
                                    
                                    self.selectImage.image = UIImage(named: "selectimage")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                    }
                    
                }
            }
            
        }
            
    }
    
}
}
