//
//  TableHeaderViewController.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class TableHeaderViewController: UIViewController {

    //テーブルビューヘッダー用スクロールビュー
    @IBOutlet weak var tableViewHeaderScrollView: UIScrollView!
    @IBOutlet weak var tableViewHeaderPageControl: UIPageControl!
 
    //バナーローテーション用の(ページ数・ページカウンター・タイマー変数）
    let bannerPageNumber = 2
    var bannerPageCounter = 0
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewHeaderScrollView.delegate = self
        
        //バナー画像のローテーション処理
        timer = NSTimer.scheduledTimerWithTimeInterval(18.0, target: self, selector: #selector(TableHeaderViewController.bannerViewAnimate), userInfo: nil, repeats: true)
    }

    //レイアウト処理が完了した際の処理
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        initTableViewHeaderScrollView()
        
        //それぞれの位置を決めうちする
        tableViewHeaderScrollView.frame = CGRectMake(
            CGFloat(0),
            CGFloat(0),
            CGFloat(Int(DeviceSize.screenWidth())),
            CGFloat(180)
        )
        tableViewHeaderPageControl.center = CGPointMake(
            CGFloat(Int(DeviceSize.screenWidth() / 2)),
            CGFloat(150)
        )
        
        //スクロールビュー内のサイズを決定する
        tableViewHeaderScrollView.contentSize = CGSizeMake(
            CGFloat(Int(DeviceSize.screenWidth()) * 3),
            CGFloat(180)
        )
        
        //スクロールビューの中に画像を一列に並べて配置する
        for i in 0...2 {
            
            let targetImageView = UIImageView(
                frame: CGRect(
                    x: Int(DeviceSize.screenWidth()) * i,
                    y: 0,
                    width: Int(DeviceSize.screenWidth()),
                    height: Int(180)
                )
            )
            tableViewHeaderScrollView.addSubview(targetImageView)
            
            //画像の設定変更
            if i == 0 {
                targetImageView.backgroundColor = UIColor.yellowColor()
            } else if i == 1 {
                targetImageView.backgroundColor = UIColor.greenColor()
            } else if (i == 2) {
                targetImageView.backgroundColor = UIColor.blueColor()
            }

        }
        
    }
    
    //スクロールを検知した際に行われる処理
    func bannerViewAnimate() {
        
        bannerPageCounter = (bannerPageCounter + 1) % (bannerPageNumber + 1)
        
        UIView.animateWithDuration(0.84, delay: 0, options: [], animations: {
            self.tableViewHeaderScrollView.contentOffset.x = CGFloat(Int(DeviceSize.screenWidth()) * self.bannerPageCounter)
            }, completion: nil)
    }

    //スクロールビューの初期設定
    private func initTableViewHeaderScrollView() {

        tableViewHeaderScrollView.pagingEnabled = true
        tableViewHeaderScrollView.scrollEnabled = false
        tableViewHeaderScrollView.directionalLockEnabled = false
        tableViewHeaderScrollView.showsHorizontalScrollIndicator = true
        tableViewHeaderScrollView.showsVerticalScrollIndicator = false
        tableViewHeaderScrollView.bounces = false
        tableViewHeaderScrollView.scrollsToTop = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension TableHeaderViewController: UIScrollViewDelegate {
    
    //スクロールが発生した際に行われる処理
    func scrollViewDidScroll(scrollview: UIScrollView) {
        
        //現在表示されているページ番号を判別する
        let pageWidth = tableViewHeaderScrollView.frame.width
        let fractionalPage = Double(tableViewHeaderScrollView.contentOffset.x / pageWidth)
        
        //ボタン配置用のスクロールビューもスライドさせる
        let page = lround(fractionalPage)
        tableViewHeaderPageControl.currentPage = page
    }
    
}
