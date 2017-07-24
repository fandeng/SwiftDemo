//
//  FindTableViewCell.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/24.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

class FindTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showCellWithData(imgUrl:String, title:String) {
        
        imgView.sd_setImage(with: URL.init(string: imgUrl), placeholderImage: UIImage.init(named: "placeholder"))
        
        titleLabel.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
