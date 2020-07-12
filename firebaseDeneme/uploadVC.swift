//
//  uploadVC.swift
//  firebaseDeneme
//
//  Created by EYMENKO on 22.06.2020.
//  Copyright © 2020 muratocak. All rights reserved.
//

import UIKit
import Firebase

class uploadVC: UIViewController {
    
    @IBOutlet var customerText: UITextField!
    @IBOutlet var refCodeText: UITextField!
    @IBOutlet var lotNumText: UITextField!
    
    
    @IBOutlet var refCodeLabel: UILabel!
    @IBOutlet var lotNumLabel: UILabel!
    
    
    let firestoreDatabase = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInfo()
       
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeybord))
        view.addGestureRecognizer(gestureRecognizer)
        
       
        
    }
    
    @objc func hideKeybord() {
        view.endEditing(true)
    }
    
  
    @IBAction func tranferClicked(_ sender: Any) {
        
        let customerName = self.customerText.text
        let referansCode = self.refCodeText.text
        let lotNumberCode = self.lotNumText.text
        
        firestoreDatabase.collection("Customers")
            .whereField("CustomerOwner", isEqualTo: userSingleton.sharedUserInfo.username)
            .whereField("CustomerName", isEqualTo: self.customerText.text!).getDocuments { (snapshot, error) in
                
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        
                        let documentid = document.documentID
                       
                       if var referansCodeArray = document.get("ReferanceCodeArray") as? [String], var lotNumArray = document.get("LotNumberCodeArray") as? [String] {
                        referansCodeArray.append(referansCode!)
                        lotNumArray.append(lotNumberCode!)
                            
                          
                            let additionalToCustomer = ["ReferanceCodeArray" : referansCodeArray, "LotNumberCodeArray" : lotNumArray] as [String : Any]
                            self.firestoreDatabase.collection("Customers").document(documentid).setData(additionalToCustomer, merge: true) { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                                } else {
                                    self.customerText.text = ""
                                    self.refCodeText.text = ""
                                    self.lotNumText.text = ""
                                }
                            }
                        }
                }  } else {
                let customerDictionary = ["date" : FieldValue.serverTimestamp(), "CustomerOwner" : userSingleton.sharedUserInfo.username, "CustomerName" : customerName!, "ReferanceCodeArray" : [referansCode], "LotNumberCodeArray" : [lotNumberCode] ] as [String : Any]
                self.firestoreDatabase.collection("Customers").addDocument(data: customerDictionary) { (error) in
                     if error != nil {
                     self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                     } else {
                    
                       self.customerText.text = ""
                       self.refCodeText.text = ""
                       self.lotNumText.text = ""
                    }  }  }  } }
        self.performSegue(withIdentifier: "toListVC", sender: nil)
    }
    
    
    
    @IBAction func clickedUpload(_ sender: Any) {
        
        let refCode = self.refCodeText.text
        let lotNumCode = self.lotNumText.text
     
        
        firestoreDatabase.collection("myStorage").whereField("StorageOwner", isEqualTo: userSingleton.sharedUserInfo.username).getDocuments { (snapshot, error) in
                    if error != nil {
                        self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    } else {
                        if snapshot?.isEmpty == false && snapshot != nil {
                            for document in snapshot!.documents {
                                
                                let documentid = document.documentID
                               
                                if var refCodeArray = document.get("refCodeArray") as? [String], var lotNumArray = document.get("lotNumArray") as? [String] {
                                refCodeArray.append(refCode!)
                                lotNumArray.append(lotNumCode!)
                                   
                                   
                                    let additionalDictionary = ["refCodeArray" : refCodeArray, "lotNumArray" : lotNumArray] as [String : Any]
                                    self.firestoreDatabase.collection("myStorage").document(documentid).setData(additionalDictionary, merge: true) { (error) in
                                        if error != nil {
                                            self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                        }
                                        }
                                    } else {
                                        self.refCodeText.text = ""
                                        self.lotNumText.text = ""
                                }
                            }
                        } else {
                            let snapDictionary = ["date" : FieldValue.serverTimestamp(), "StorageOwner" : userSingleton.sharedUserInfo.username, "refCodeArray" : [refCode!], "lotNumArray" : [lotNumCode!]] as [String : Any]
                                       
                            self.firestoreDatabase.collection("myStorage").addDocument(data: snapDictionary) { (error) in
                                         if error != nil {
                                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                         }  else {
                                                        self.refCodeText.text = ""
                                                        self.lotNumText.text = ""
        } } } } }
  self.performSegue(withIdentifier: "toListVC", sender: nil)
        
}
    
    
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
    }
    
    func getUserInfo() {

    self.firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
        if error != nil {
            self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
        }else {
            if snapshot?.isEmpty == false && snapshot != nil {
                for document in snapshot!.documents {
                    if let username = document.get("username") as? String {
                        userSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                        userSingleton.sharedUserInfo.username = username
                        
                    }
                }
            }
        }
            
        }
    }
    
    @IBAction func scannerClicked(_ sender: Any) {
        
        
        
    }
    
    
    
}
        
        
        
