//
//  RightBannerViewController.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class RightBannerViewController: UIViewController {

    //バナー差し込み用スクロールビューとボタン
    @IBOutlet weak var bannerScrollView: UIScrollView!
    @IBOutlet weak var bannerButton: UIButton!

    //バナーローテーション用の(ページ数・ページカウンター・タイマー変数）
    let bannerPageNumber = 2
    var bannerPageCounter = 0
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerScrollView.delegate = self
        
        //バナー画像のローテーション処理
        timer = NSTimer.scheduledTimerWithTimeInterval(300.0, target: self, selector: #selector(RightBannerViewController.bannerViewAnimate), userInfo: nil, repeats: true)
    }

    override func viewDidLayoutSubviews() {
        
        //コンテンツ用のScrollViewを初期化
        initBannerScrollViewDefinition()
        bannerScrollView.contentSize = CGSizeMake(
            CGFloat(Int(bannerScrollView.frame.width) * (bannerPageNumber + 1)),
            CGFloat(Int(bannerScrollView.frame.height))
        )
            
        //UIImageViewを作成してScrollViewへ追加
        for i in 0...bannerPageNumber {
                
            let bannerImageView: UIImageView! = UIImageView(
                frame: CGRect(
                    x: Int(bannerScrollView.frame.width) * i,
                    y: 0,
                    width: Int(bannerScrollView.frame.width),
                    height: Int(bannerScrollView.frame.height)
                )
            )
                
            //FIXME:ローカルのJSONデータを取得して解析したものを入れる予定
            switch (i) {
                case 0:
                    bannerImageView.backgroundColor = UIColor.redColor()
                    break
                case 1:
                    bannerImageView.backgroundColor = UIColor.greenColor()
                    break
                case 2:
                    bannerImageView.backgroundColor = UIColor.blueColor()
                    break
                default:
                    bannerImageView.backgroundColor = UIColor.redColor()
                    break
            }
            bannerScrollView.addSubview(bannerImageView)
        }

    }
    
    //バナー用のUIScrollViewの初期化を行う
    private func initBannerScrollViewDefinition() {
        
        //ScrollViewの各種プロパティ値を設定する
        bannerScrollView.pagingEnabled = false
        bannerScrollView.scrollEnabled = false
        bannerScrollView.directionalLockEnabled = true
        bannerScrollView.showsHorizontalScrollIndicator = false
        bannerScrollView.showsVerticalScrollIndicator = true
        bannerScrollView.bounces = true
        bannerScrollView.scrollsToTop = false
    }
    
    //スクロールを検知した際に行われる処理
    func bannerViewAnimate() {
        
        bannerPageCounter = (bannerPageCounter + 1) % (bannerPageNumber + 1)
        
        UIView.animateWithDuration(0.6, delay: 0, options: [], animations: {
            self.bannerScrollView.contentOffset.x = CGFloat(280 * self.bannerPageCounter)
        }, completion: nil)
    }

    //バナー上の透明ボタンをタップした際のアクション
    @IBAction func bannerViewTapped(sender: AnyObject) {
        print("バナー番号:\(self.bannerPageCounter)番目がタップされました！")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension RightBannerViewController: UIScrollViewDelegate {
    
    //スクロールが発生した際に行われる処理
    func scrollViewDidScroll(scrollview: UIScrollView) {
        
        //現在表示されているページ番号を判別する
        let pageWidth = bannerScrollView.frame.width
        let fractionalPage = Double(bannerScrollView.contentOffset.x / pageWidth)
        
        //ボタン配置用のスクロールビューもスライドさせる
        let page = lround(fractionalPage)
        print("\(page)番目のバナーが表示されました！")
    }
}
