//
//  highScoreRowTableViewCell.swift
//  DemoMemoryGame
//
//  Created by Manish on 04/02/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class highScoreRowTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var rankText: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
