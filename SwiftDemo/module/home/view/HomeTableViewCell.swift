//
//  HomeTableViewCell.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/19.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showCellWithData(model:ArticlelistModel){
        
        self.imgView.sd_setImage(with: URL.init(string: model.cover), placeholderImage: UIImage.init(named: "placeholder"))
        
        self.titleLabel.text = model.title
        
        let author = "作者:" + model.author
        
        var time = ""
        
        if !model.createtime.isEmpty {
            time = "   " + (model.createtime as NSString).substring(to: 10)
        }
        self.timeLabel.text = author + time
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
