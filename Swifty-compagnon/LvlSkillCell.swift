//
//  LvlSkillCell.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 3/17/17.
//  Copyright © 2017 Erwan SEVENO. All rights reserved.
//

import UIKit

class LvlSkillCell: UITableViewCell {

    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var level: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
