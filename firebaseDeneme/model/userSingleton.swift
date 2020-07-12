//
//  userSingleton.swift
//  firebaseDeneme
//
//  Created by EYMENKO on 28.06.2020.
//  Copyright © 2020 muratocak. All rights reserved.
//

import Foundation

class userSingleton {
    
    static let sharedUserInfo = userSingleton()
    
    var email = ""
    var username = ""
    
    private init () {
        
    }
    
    
    
}
