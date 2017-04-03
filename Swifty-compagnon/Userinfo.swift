//
//  Userinfo.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 11/17/16.
//  Copyright © 2016 Erwan SEVENO. All rights reserved.
//

import UIKit

class Userinfo: NSObject {

    var login : String = ""
    var level : Float = 0
    var photoUrl = ""
    var phone : Any
    var grade = ""
    var namelevel: [(String, Float)] = []
    var project: [(String, Any)] = []
    var location : Any
    
    init(_namelvl : [(String, Float)], _photo : String, _level : Float, _login : String , _project : [(String, Any)], _grade : String, _phone : Any, _location : Any)
    {
        phone = _phone
        namelevel = _namelvl
        photoUrl = _photo
        level = _level
        login = _login
        project = _project
        grade = _grade
        location = _location
    }
    
    func removeall(){
        self.login = ""
        self.level = 0
        self.photoUrl = ""
        self.phone = ""
        self.grade = ""
        self.namelevel.removeAll()
        self.project.removeAll()
    }
}

