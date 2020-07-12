//
//  ListVC.swift
//  firebaseDeneme
//
//  Created by EYMENKO on 28.06.2020.
//  Copyright © 2020 muratocak. All rights reserved.
//

import UIKit
import Firebase

class ListVC: UIViewController {
    
  /*  @IBOutlet var Tableview: UITableView!
    
    var customerListArray = [String] ()
     var documentidArray = [String] ()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       getDataFromFireStore()
        
        Tableview.delegate = self
        Tableview.dataSource = self
       
    }
    

    
    func getDataFromFireStore() {
        
        let firestoreDatabase = Firestore.firestore()
       
          
        firestoreDatabase.collection("Customers").whereField("CustomerOwner", isEqualTo: userSingleton.sharedUserInfo.username).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print ("Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.documentidArray.removeAll(keepingCapacity: false)
                    self.customerListArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        let documentid = document.documentID
                        print(documentid)
                       
                        if let customerList = document.get("CustomerName") as? String {
                            self.customerListArray.append(customerList)
                        }
                    }
                    self.Tableview.reloadData()
                }  } } }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = customerListArray[indexPath.row]
        return cell
    }
    
    */
}
