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

    //配置するテーブルビューに関するセッティング
    private let sectionCount = 1
    private let cellCount = RightMenuSetting.cellTitleList.count
    private let cellHeight = 43.5

    override func viewDidLoad() {
        super.viewDidLoad()

        rightMenuTableView.delegate = self
        rightMenuTableView.dataSource = self
        
        //Xibのクラスを読み込む宣言を行う
        let nibDefault: UINib = UINib(nibName: "RightMenuTableViewCell", bundle: nil)
        rightMenuTableView.registerNib(nibDefault, forCellReuseIdentifier: "RightMenuTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension RightMenuViewController: UITableViewDelegate {

    //テーブルのセル高さ ※任意
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
}

extension RightMenuViewController: UITableViewDataSource {
    
    //テーブルの要素数を設定する ※必須
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionCount
    }
    
    //テーブルの行数を設定する ※必須
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    //表示するセルの中身を設定する ※必須
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RightMenuTableViewCell") as? RightMenuTableViewCell

        cell!.rightMenuTitleLabel.text = RightMenuSetting.cellTitleList[indexPath.row]

        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell!
    }
    
}
