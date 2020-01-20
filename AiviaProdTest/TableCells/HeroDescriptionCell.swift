//
//  HeroDescriptionCell.swift
//  AiviaProdTest
//
//  Created by Adam on 2020-01-19.
//  Copyright © 2020 Adam. All rights reserved.
//

import UIKit

class HeroDescriptionCell: UITableViewCell {
    
    //Custom cell used to contain the category and value information used on the detail view controller
    
    @IBOutlet weak var categoryLabel: UILabel! //Outlet for the category label on the left
    @IBOutlet weak var valueLabel: UILabel! //Outlet for the value label on the right

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
