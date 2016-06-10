//
//  AppState.swift
//  photosharing
//
//  Created by Rohan Desai on 6/4/16.
//  Copyright © 2016 rd. All rights reserved.
//

import Foundation

class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    var displayName: String?
    var photoUrl: NSURL?
}