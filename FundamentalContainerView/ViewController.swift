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
        wrappingButton.backgroundColor = UIColor.clearColor()
        wrappingButton.enabled = false
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
        mainContents.frame = CGRectMake(
            CGFloat(mainContents.frame.origin.x),
            CGFloat(mainContents.frame.origin.y),
            CGFloat(mainContents.frame.width),
            CGFloat(mainContents.frame.height)
        )

        //初期状態の制約（上下左右:0）
        wrappingButton.frame = CGRectMake(
            CGFloat(wrappingButton.frame.origin.x),
            CGFloat(wrappingButton.frame.origin.y),
            CGFloat(wrappingButton.frame.width),
            CGFloat(wrappingButton.frame.height)
        )

        //初期状態の制約（上:0, 左:0, 下:0, 幅:100）
        leftSideMenu.frame = CGRectMake(
            CGFloat(leftSideMenu.frame.origin.x),
            CGFloat(leftSideMenu.frame.origin.y),
            CGFloat(leftSideMenu.frame.width),
            CGFloat(leftSideMenu.frame.height)
        )

        //初期状態の制約（上:0, 右:0, 下:0, 幅:280）
        rightSideMenu.frame = CGRectMake(
            CGFloat(rightSideMenu.frame.origin.x),
            CGFloat(rightSideMenu.frame.origin.y),
            CGFloat(rightSideMenu.frame.width),
            CGFloat(rightSideMenu.frame.height)
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

            UIView.animateWithDuration(0.26, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations:

                //メインコンテンツと透明ボタンの位置を左へずらす(移動完了時に透明ボタンを有効にする)
                {
                    self.mainContents.frame = CGRectMake(
                        CGFloat(MainContentsSwipeLimitSetting.leftSwipeLimit),
                        CGFloat(self.mainContents.frame.origin.y),
                        CGFloat(self.mainContents.frame.width),
                        CGFloat(self.mainContents.frame.height)
                    )
                    self.wrappingButton.frame = CGRectMake(
                        CGFloat(MainContentsSwipeLimitSetting.leftSwipeLimit),
                        CGFloat(self.wrappingButton.frame.origin.y),
                        CGFloat(self.wrappingButton.frame.width),
                        CGFloat(self.wrappingButton.frame.height)
                    )
                }, completion: { finished in
                    self.wrappingButton.alpha = 1
                    self.wrappingButton.enabled = true
                }
            )
        
        //(Case2)右側メニューを開くとき
        } else if status == MainContentsStatus.RightMenuOpened {

            mainContentsStatus = MainContentsStatus.RightMenuOpened
            rightSideMenu.alpha = 1

            UIView.animateWithDuration(0.26, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations:
                
                //メインコンテンツと透明ボタンの位置を右へずらす(移動完了時に透明ボタンを有効にする)
                {
                    self.mainContents.frame = CGRectMake(
                        CGFloat(MainContentsSwipeLimitSetting.rightSwipeLimit),
                        CGFloat(self.mainContents.frame.origin.y),
                        CGFloat(self.mainContents.frame.width),
                        CGFloat(self.mainContents.frame.height)
                    )
                    self.wrappingButton.frame = CGRectMake(
                        CGFloat(MainContentsSwipeLimitSetting.rightSwipeLimit),
                        CGFloat(self.mainContents.frame.origin.y),
                        CGFloat(self.mainContents.frame.width),
                        CGFloat(self.mainContents.frame.height)
                    )
                }, completion: { finished in
                    self.wrappingButton.alpha = 1
                    self.wrappingButton.enabled = true
                }
            )

        //(Case3)コンテンツ表示状態にする
        } else if status == MainContentsStatus.ContentsDisplay {

            mainContentsStatus = MainContentsStatus.ContentsDisplay
            UIView.animateWithDuration(0.26, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations:
                
                //メインコンテンツと透明ボタンの位置を右へずらす(移動完了時に透明ボタンを有効にする)
                {
                    self.mainContents.frame = CGRectMake(
                        CGFloat(MainContentsSwipeLimitSetting.originXposition),
                        CGFloat(self.mainContents.frame.origin.y),
                        CGFloat(self.mainContents.frame.width),
                        CGFloat(self.mainContents.frame.height)
                    )
                    self.wrappingButton.frame = CGRectMake(
                        CGFloat(MainContentsSwipeLimitSetting.originXposition),
                        CGFloat(self.mainContents.frame.origin.y),
                        CGFloat(self.mainContents.frame.width),
                        CGFloat(self.mainContents.frame.height)
                    )
                }, completion: { finished in
                    self.wrappingButton.alpha = 0
                    self.wrappingButton.enabled = false
                    
                    //アニメーション完了時にコンテンツを完全に見えなくする
                    self.leftSideMenu.alpha = 0
                    self.rightSideMenu.alpha = 0
                }
            )

        }

    }

    //透明ボタンのアクション（コンテンツ表示状態に戻す）
    @IBAction func slideContentClose(sender: AnyObject) {
        handleMainContentsContainerState(MainContentsStatus.ContentsDisplay)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
