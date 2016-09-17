//
//  RightMenuViewController.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

struct RightMenuSetting {
    static let cellTitleList: [String] = [
        "メニュー内容その1(未定)",
        "メニュー内容その2(未定)",
        "メニュー内容その3(未定)",
        "メニュー内容その4(未定)",
        "メニュー内容その5(未定)",
        "メニュー内容その6(未定)",
        "メニュー内容その7(未定)",
        "メニュー内容その8(未定)",
        "メニュー内容その9(未定)",
        "メニュー内容その10(未定)",
        "メニュー内容その11(未定)",
        "メニュー内容その12(未定)",
        ]
}

class RightMenuViewController: UIViewController {
    
    @IBOutlet weak var rightMenuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightMenuTableView.delegate = self
        rightMenuTableView.dataSource = self
        
        //Xibのクラスを読み込む宣言を行う
        let nibDefault: UINib = UINib(nibName: "RightMenuTableViewCell", bundle: nil)
        rightMenuTableView.register(nibDefault, forCellReuseIdentifier: "RightMenuTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension RightMenuViewController: UITableViewDelegate {
    
    //テーブルのセル高さ ※任意
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
}

extension RightMenuViewController: UITableViewDataSource {
    
    //テーブルの要素数を設定する ※必須
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //テーブルの行数を設定する ※必須
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RightMenuSetting.cellTitleList.count
    }
    
    //表示するセルの中身を設定する ※必須
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RightMenuTableViewCell") as? RightMenuTableViewCell
        
        cell!.rightMenuTitleLabel.text = RightMenuSetting.cellTitleList[indexPath.row]
        
        cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
    }
    
}
