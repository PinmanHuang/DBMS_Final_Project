//
//  SelectTableViewCell.swift
//  DBMS_Final_Project
//
//  Created by Joyce Huang on 2020/5/28.
//  Copyright © 2020 Huang Joyce. All rights reserved.
//

import UIKit

class SelectTableViewCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var label_2: UILabel!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var dataLabel_2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
