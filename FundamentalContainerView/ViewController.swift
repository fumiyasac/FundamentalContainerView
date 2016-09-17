//
//  ViewController.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/10.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//サイドメニューの開閉状態のステータス
enum MainContentsStatus {
    case ContentsDisplay
    case DraggingLeft
    case LeftMenuOpened
    case DraggingRight
    case RightMenuOpened
}

//メインコンテンツのスワイプ量に関する設定値
struct MainContentsSwipeLimitSetting {
    static let originXposition: Int = 0
    static let leftSwipeLimit: Int = 100
    static let rightSwipeLimit: Int = -280
}

class ViewController: UIViewController {
    
    //Storyboardへ配置したコンテナビューの部品
    @IBOutlet weak var leftSideMenu: UIView!
    @IBOutlet weak var rightSideMenu: UIView!
    @IBOutlet weak var mainContents: UIView!
    
    //透明ボタン（左右のメニュー開閉時にメインコンテンツを押せなくする）
    @IBOutlet weak var wrappingButton: UIButton!
    
    
    
    //このViewControllerのメニュー状態を格納する変数
    var mainContentsStatus: MainContentsStatus = MainContentsStatus.ContentsDisplay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //透明ボタンの初期状態を決定
        wrappingButton.backgroundColor = UIColor.clear
        wrappingButton.isEnabled = false
        wrappingButton.alpha = 0
        
        //左右メニューの表示状態を決定
        leftSideMenu.alpha = 0
        rightSideMenu.alpha = 0
    }
    
    //レイアウト処理が完了した際の処理
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /**
         * AutoLayoutで設定したパーツのX座標・Y座標・幅・高さを再定義する
         * 今回は制約をいじらない方針
         * (手順1)AutoLayoutで初期状態に対する制約をつける
         * (手順2)初期状態の制約を元にCGRectMakeで位置を再配置する
         *
         */
        
        //初期状態の制約（上下左右:0）
        mainContents.frame = CGRect(
            x: mainContents.frame.origin.x,
            y: mainContents.frame.origin.y,
            width: mainContents.frame.width,
            height: mainContents.frame.height
        )
        
        //初期状態の制約（上下左右:0）
        wrappingButton.frame = CGRect(
            x: wrappingButton.frame.origin.x,
            y: wrappingButton.frame.origin.y,
            width: wrappingButton.frame.width,
            height: wrappingButton.frame.height
        )
        
        //初期状態の制約（上:0, 左:0, 下:0, 幅:100）
        leftSideMenu.frame = CGRect(
            x: leftSideMenu.frame.origin.x,
            y: leftSideMenu.frame.origin.y,
            width: leftSideMenu.frame.width,
            height: leftSideMenu.frame.height
        )
        
        //初期状態の制約（上:0, 右:0, 下:0, 幅:280）
        rightSideMenu.frame = CGRect(
            x: rightSideMenu.frame.origin.x,
            y: rightSideMenu.frame.origin.y,
            width: rightSideMenu.frame.width,
            height: rightSideMenu.frame.height
        )
        
    }
    
    /**
     * ステータスに応じてメインコンテンツの開閉を決定する
     * 左右開閉状態とコンテンツ表示状態のハンドリングを行う
     * ※子のコンテナに配置したボタン等からも実行できるように切り出してある
     */
    func handleMainContentsContainerState(status: MainContentsStatus) {
        
        //(Case1)左側メニューを開くとき
        if status == MainContentsStatus.LeftMenuOpened {
            
            mainContentsStatus = MainContentsStatus.LeftMenuOpened
            leftSideMenu.alpha = 1
            
            UIView.animate(withDuration: 0.26, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
                
                //メインコンテンツと透明ボタンの位置を左へずらす(移動完了時に透明ボタンを有効にする)
                {
                    self.mainContents.frame = CGRect(
                        x: CGFloat(MainContentsSwipeLimitSetting.leftSwipeLimit),
                        y: self.mainContents.frame.origin.y,
                        width: self.mainContents.frame.width,
                        height: self.mainContents.frame.height
                    )
                    self.wrappingButton.frame = CGRect(
                        x: CGFloat(MainContentsSwipeLimitSetting.leftSwipeLimit),
                        y: self.wrappingButton.frame.origin.y,
                        width: self.wrappingButton.frame.width,
                        height: self.wrappingButton.frame.height
                    )
                }, completion: { finished in
                    self.wrappingButton.alpha = 1
                    self.wrappingButton.isEnabled = true
                }
            )
            
            //(Case2)右側メニューを開くとき
        } else if status == MainContentsStatus.RightMenuOpened {
            
            mainContentsStatus = MainContentsStatus.RightMenuOpened
            rightSideMenu.alpha = 1
            
            UIView.animate(withDuration: 0.26, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
                
                //メインコンテンツと透明ボタンの位置を右へずらす(移動完了時に透明ボタンを有効にする)
                {
                    self.mainContents.frame = CGRect(
                        x: CGFloat(MainContentsSwipeLimitSetting.rightSwipeLimit),
                        y: self.mainContents.frame.origin.y,
                        width: self.mainContents.frame.width,
                        height: self.mainContents.frame.height
                    )
                    self.wrappingButton.frame = CGRect(
                        x: CGFloat(MainContentsSwipeLimitSetting.rightSwipeLimit),
                        y: self.wrappingButton.frame.origin.y,
                        width: self.wrappingButton.frame.width,
                        height: self.wrappingButton.frame.height
                    )
                }, completion: { finished in
                    self.wrappingButton.alpha = 1
                    self.wrappingButton.isEnabled = true
                }
            )
            
            //(Case3)コンテンツ表示状態にする
        } else if status == MainContentsStatus.ContentsDisplay {
            
            mainContentsStatus = MainContentsStatus.ContentsDisplay
            UIView.animate(withDuration: 0.26, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
                
                //メインコンテンツと透明ボタンの位置を右へずらす(移動完了時に透明ボタンを有効にする)
                {
                    self.mainContents.frame = CGRect(
                        x: CGFloat(MainContentsSwipeLimitSetting.originXposition),
                        y: self.mainContents.frame.origin.y,
                        width: self.mainContents.frame.width,
                        height: self.mainContents.frame.height
                    )
                    self.wrappingButton.frame = CGRect(
                        x: CGFloat(MainContentsSwipeLimitSetting.originXposition),
                        y: self.mainContents.frame.origin.y,
                        width: self.mainContents.frame.width,
                        height: self.mainContents.frame.height
                    )
                }, completion: { finished in
                    self.wrappingButton.alpha = 0
                    self.wrappingButton.isEnabled = false
                    
                    //アニメーション完了時にコンテンツを完全に見えなくする
                    self.leftSideMenu.alpha = 0
                    self.rightSideMenu.alpha = 0
                }
            )
            
        }
        
    }
    
    //透明ボタンのアクション（コンテンツ表示状態に戻す）
    @IBAction func slideContentClose(_ sender: Any) {
        handleMainContentsContainerState(status: MainContentsStatus.ContentsDisplay)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
