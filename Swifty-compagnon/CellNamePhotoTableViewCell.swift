//
//  CellNamePhotoTableViewCell.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 2/22/17.
//  Copyright © 2017 Erwan SEVENO. All rights reserved.
//

import UIKit

class CellNamePhotoTableViewCell: UITableViewCell {


    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var textName: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    
    
}
