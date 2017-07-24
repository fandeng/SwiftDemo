//
//  TitleTableViewCell.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/24.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

class ColumnTableViewCell: UITableViewCell {
    @IBOutlet weak var titlelabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
