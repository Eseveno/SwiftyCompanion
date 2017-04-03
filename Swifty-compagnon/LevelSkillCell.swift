//
//  LevelSkillCell.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 3/6/17.
//  Copyright © 2017 Erwan SEVENO. All rights reserved.
//

import UIKit

class LevelSkillCell: UITableViewCell{


    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var levelSkillTable: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.levelSkillTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func tableView(_ mainTable: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//       return (30)
//    }
    
    
}
