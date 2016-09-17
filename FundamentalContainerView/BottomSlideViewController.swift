//
//  BottomSlideViewController.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//開閉ステータス
enum BottomStatus {
    case Opened
    case Closed
}

class BottomSlideViewController: UIViewController {
    
    //開閉ステータス管理用のメンバ変数
    var bottomStatus: BottomStatus = BottomStatus.Opened
    
    @IBOutlet weak var statusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popupHandleAction(_ sender: AnyObject) {
        
        //親のViewControllerのメソッドを実行する
        let vc = self.parent as! ContentDetailViewController
        
        if bottomStatus == BottomStatus.Opened {
            vc.closeBottomPopup()
            bottomStatus = BottomStatus.Closed
            statusButton.setTitle("× OPEN", for: .normal)
        } else {
            vc.openBottomPopup()
            bottomStatus = BottomStatus.Opened
            statusButton.setTitle("× CLOSE", for: .normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
