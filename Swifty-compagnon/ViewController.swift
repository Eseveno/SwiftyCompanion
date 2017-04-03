//
//  ViewController.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 10/27/16.
//  Copyright © 2016 Erwan SEVENO. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var Login: UITextField!
    var apiController : APIController? = nil
    var realtoken : String = ""
    var all = APIController()
    var user : Userinfo?
    var buttonpressed : Bool = false

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var Button: UIButton!

    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background42")!)
        self.Button.setTitle("GO", for: .normal)
        all.getTokenFromCode{
            token in
            self.all.token = token
            
        }
    }

    @IBAction func buttongo(_ sender: UIButton) {
        
        if (Login.text != "" && self.buttonpressed == false) {
            if checkEndUrl(endUrl: Login.text!) == false{
                return
            }
            self.buttonpressed = true
            activityIndicator.startAnimating()
            all.getinfo(name: Login.text!, completionHandler2: {
                if (self.all.httperror == 0){
                    self.user = Userinfo(_namelvl: self.all.namelvl , _photo: self.all.url , _level: self.all.lvl , _login : self.all.login, _project : self.all.project, _grade : self.all.grade, _phone : self.all.phone, _location : self.all.location)
                    print(self.all.namelvl)
                }
                if (self.all.httperror == 1){
                    DispatchQueue.main.async(execute: {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.buttonpressed = false

                    })
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.presentSecondview()
                })
                
            })
        }
    }
    
    
    func presentSecondview(){
        let vc = SecondViewController()
        vc.user = self.user
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        self.buttonpressed = false
        present(vc, animated: false, completion: nil)
    }

    
    func checkEndUrl(endUrl: String) -> Bool{
        let toto = CharacterSet.alphanumerics
        
        for uni in endUrl.unicodeScalars {
            if !toto.contains(uni) {
                return false
            }
        }
        return true
    }
    
}
