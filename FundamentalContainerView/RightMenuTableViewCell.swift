//
//  RightMenuTableViewCell.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class RightMenuTableViewCell: UITableViewCell {
    
    //UITableViewCellの部品
    @IBOutlet weak var rightMenuImageView: UIImageView!
    @IBOutlet weak var rightMenuTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
