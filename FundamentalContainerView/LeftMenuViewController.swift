//
//  LeftMenuViewController.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//定数設定などその他
struct LeftButtonSetting {
    
    //ScrollViewに表示するボタン名称に関する設定
    static let buttonSettingList: [String] = [
        "🍅1番目", "🍊2番目", "🍔3番目", "🍟4番目",
        "🍛5番目", "🍜6番目", "🍰7番目", "☕️8番目"
    ]
    
    //ボタンの背景色に関する設定
    static let colorSettingList: [String] = [
        "f8c6c7", "f2cb24", "87c9a3", "b9e4f7",
        "face83", "d2cce6", "ccdc47", "81b7ea"
    ]
}

class LeftMenuViewController: UIViewController {
    
    //ボタン群を格納するためのスクロールビュー
    @IBOutlet weak var leftMenuButtonScrollSet: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftMenuButtonScrollSet.delegate = self
    }
    
    //レイアウト処理が完了した際の処理
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //スクロールビューの定義
        self.initMenuScrollViewDefinition()
        
        //スクロールビューの中身のサイズを設定する
        leftMenuButtonScrollSet.backgroundColor = UIColor.lightGray
        leftMenuButtonScrollSet.contentSize = CGSize(
            width: CGFloat(leftMenuButtonScrollSet.frame.size.width),
            height: CGFloat(100 * LeftButtonSetting.buttonSettingList.count)
        )
        
        //スクロールビューの中にボタンを縦一列に並べて配置する
        for i in 0...(LeftButtonSetting.buttonSettingList.count - 1) {
            
            //メニュー用のスクロールビューにボタンを配置
            let buttonElement: UIButton! = UIButton()
            self.leftMenuButtonScrollSet.addSubview(buttonElement)
            
            buttonElement.frame = CGRect(
                x: 0, y: (100 * i), width: 100, height: 100
            )
            buttonElement.backgroundColor = ColorConverter.colorWithHexString(hex: LeftButtonSetting.colorSettingList[i])
            buttonElement.setTitle(LeftButtonSetting.buttonSettingList[i], for: .normal)
            buttonElement.titleLabel!.font = UIFont(name: "Bold", size: CGFloat(16))
            buttonElement.tag = i
            buttonElement.addTarget(self, action: #selector(LeftMenuViewController.scrollViewButtonTapped(button:)), for: .touchUpInside)
            
        }
        
    }
    
    //Menu用のUIScrollViewの初期化を行う
    private func initMenuScrollViewDefinition() {
        
        leftMenuButtonScrollSet.isPagingEnabled = false
        leftMenuButtonScrollSet.isScrollEnabled = true
        leftMenuButtonScrollSet.isDirectionalLockEnabled = false
        leftMenuButtonScrollSet.showsHorizontalScrollIndicator = false
        leftMenuButtonScrollSet.showsVerticalScrollIndicator = false
        leftMenuButtonScrollSet.bounces = false
        leftMenuButtonScrollSet.scrollsToTop = false
    }
    
    //スクロールビューに配置されたボタンをタップした際に行われる処理
    func scrollViewButtonTapped(button: UIButton){
        
        //押されたボタンのタグを取得
        let buttonNumber: Int = button.tag
        print("\(buttonNumber)番目のボタンが押されました")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension LeftMenuViewController: UIScrollViewDelegate {
}
