//
//  LevelProgressCell.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 3/3/17.
//  Copyright © 2017 Erwan SEVENO. All rights reserved.
//

import UIKit

class LevelProgressCell: UITableViewCell {

    @IBOutlet weak var lvlText: UITextView!
    @IBOutlet weak var lvlBar: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
