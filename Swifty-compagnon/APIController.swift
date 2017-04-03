//
//  APIController.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 10/27/16.
//  Copyright © 2016 Erwan SEVENO. All rights reserved.
//

import UIKit

let APP_UID = "" // NOPE
let APP_SECRET = "" // NOPE
let AUTHORIZATION_URL = "https://api.intra.42.fr/oauth/authorize?client_id=" + APP_UID + "&response_type=code&redirect_uri=http%3A%2F%2Fwww.42.fr&scope=public%20forum%20projects%20profile%20elearning%20tig"

class APIController: NSObject {

    var httperror = -1;
    var token = ""
    var namelvl:[(name: String, value: Float)] = []
    var lvl : Float = 0
    var url = ""
    var login = ""
    var project: [(name: String, value: Any)] = []
    var grade = ""
    var phone : Any?
    var location : Any?
    
    func getinfo(name : String, completionHandler2: @escaping () -> ()){
        self.httperror = 0
        let url = NSURL(string: "https://api.intra.42.fr/v2/users/" + name)
        let request = NSMutableURLRequest(url: url as! URL)
        
        request.httpMethod = "GET"
        request.setValue("Bearer " + self.token, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print ("error")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                self.httperror = 1
                if httpStatus.statusCode == 401 {
                    self.getTokenFromCode{
                        token in
                        self.token = token
                    }
                }
            }
            else {
            let responseString = String(data: data!, encoding: .utf8)
            let toto = try? JSONSerialization.jsonObject(with: (responseString?.data(using: .utf8))!) as AnyObject
            self.getInfo(json: toto!)
            }
            completionHandler2()
        }
        task.resume()
    }
    
    func getInfo(json : AnyObject){
        
        removeall()
        let test = json["cursus_users"] as? [NSDictionary]
        self.url = json["image_url"] as! String
        self.location = json["location"] as Any
        self.phone = json["phone"] as Any
        for tata in test!
        {
            if (tata["cursus_id"] as! Int == 1)
            {
                self.lvl = tata["level"] as! Float
                self.grade = tata["grade"] as! String
                for name in tata["skills"] as! [NSDictionary]
                {
                    self.namelvl.append((name: name["name"] as! String, value: name["level"] as! Float))
                }
                self.login = ((tata["user"] as! NSDictionary).value(forKey: "login")) as! String
            }
        }
        let project = json["projects_users"] as! [NSDictionary]
        for tupproj in project{
            self.project.append((name: (tupproj["project"] as! NSDictionary).value(forKey: "slug") as! String , value: tupproj["final_mark"] as Any))
        }
    }
    
    func getTokenFromCode(completionHandler: @escaping ( _ : String) -> ())  {
        
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/oauth/token")!)
        request.httpMethod = "POST"
        let postString = "grant_type=client_credentials&client_id=" + APP_UID + "&client_secret=" + APP_SECRET
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = String(data: data, encoding: .utf8)
            let toto = try? JSONSerialization.jsonObject(with: (responseString?.data(using: .utf8))!) as! [String:AnyObject]
            let tokenin = toto?["access_token"]! as! String // you must have APP_UID and APP_SECRET
            completionHandler(tokenin)
        }
        task.resume()
    }
    
    func removeall(){
        self.login = ""
        self.lvl = 0
        self.location = ""
        self.phone = ""
        self.grade = ""
        self.namelvl.removeAll()
        self.project.removeAll()
    }
    
}



extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
