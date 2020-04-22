//
//  LanguageTableViewCell.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/22/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    @IBOutlet var language: UILabel!
    @IBOutlet var year: UILabel!
    @IBOutlet var pic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

