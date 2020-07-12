//
//  ViewController.swift
//  firebaseDeneme
//
//  Created by EYMENKO on 18.06.2020.
//  Copyright © 2020 muratocak. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var userNameText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  
    
    
    @IBAction func clickedSignUp(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" && emailText.text != "" {
             
             Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (auth, error) in
                 if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                 } else {
                     
                     let fireStore = Firestore.firestore()
                     
                    let userDictionary = ["email" : self.emailText.text!, "username": self.userNameText.text!] as [String : Any]
                     
                     fireStore.collection("UserInfo").addDocument(data: userDictionary) { (error) in
                         if error != nil {
                             //
                         }
                     }	
                     
                     self.performSegue(withIdentifier: "touploadVC", sender: nil)
                 }
             }
             
             
             
         } else {
            self.makeAlert(titleInput: "Error", messageInput: "Username/Password/Email ?")
         }
         
    }
    
    
    
    
    @IBAction func singInClicked(_ sender: Any) {
        
        if passwordText.text != "" && emailText.text != "" {
                  
                  Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (result, error) in
                      if error != nil {
                        self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                      } else {
                          self.performSegue(withIdentifier: "touploadVC", sender: nil)
                      }
                  }

              } else {
            self.makeAlert(titleInput: "Error", messageInput: "Password/Email ?")

              }
              
              
        
    }
    
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
}

