//
//  ListTableViewCell.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    //一覧セル内に配置するUI部品
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var listTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
