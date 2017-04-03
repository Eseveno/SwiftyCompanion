//
//  PhotoName.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 2/22/17.
//  Copyright © 2017 Erwan SEVENO. All rights reserved.
//

import UIKit

class PhotoName: UIViewController {


    var cpyname: String?
    var cpyphoto: String?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = cpyname
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
