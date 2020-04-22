//
//  BookTableViewCell.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/22/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
