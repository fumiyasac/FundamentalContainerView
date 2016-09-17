//
//  ContentDetailViewController.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ContentDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    //動かす対象のコンテナビュー
    @IBOutlet weak var popSlideView: UIView!
    
    //ポップアップもどきの上Constaint
    @IBOutlet weak var topPopupConstraint: NSLayoutConstraint!
    
    //ポップアップもどきの下Constaint
    @IBOutlet weak var bottomPopupConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationControllerのデリゲート
        self.navigationController?.delegate = self
        
        //タイトル用の色および書式の設定
        let attrsMainTitle = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 15)!
        ]
        self.navigationItem.title = "Detail Page"
        self.navigationController?.navigationBar.titleTextAttributes = attrsMainTitle
    }
    
    //ボトムのポップアップを開く
    func openBottomPopup() {
        topPopupConstraint.constant = 17
        bottomPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.26, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
            
            //変更したAutoLayoutのConstant値を適用する
            {
                self.view.layoutIfNeeded()
            }, completion: { finished in
            }
        )
    }
    
    //ボトムのポップアップを閉じる
    func closeBottomPopup() {
        topPopupConstraint.constant = 137
        bottomPopupConstraint.constant = -120
        UIView.animate(withDuration: 0.26, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
            
            //変更したAutoLayoutのConstant値を適用する
            {
                self.view.layoutIfNeeded()
            }, completion: { finished in
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
