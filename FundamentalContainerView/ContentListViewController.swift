//
//  ContentListViewController.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ContentListViewController: UIViewController, UINavigationControllerDelegate {

    //ナビゲーションのアイテム
    var leftMenuButton: UIBarButtonItem!
    var rightMenuButton: UIBarButtonItem!

    //コンテンツ表示用のテーブルビュー
    @IBOutlet weak var listTableView: UITableView!

    /**
     * ヘッダーに入れるコンテナビュー
     * (ポイント)このコンテナに関してはAutoLayoutで制約を張らずにこのViewControllerに置いているだけ
     * → TableViewHeaderをするタイミングでaddSubViewをして、CGRectMakeでサイズを決めうちする。
     *
     */
    @IBOutlet weak var listTableHeader: UIView!
    
    //配置するテーブルビューに関するセッティング
    private let sectionCount = 1
    private let cellCount = 10
    private let cellHeight = 120

    override func viewDidLoad() {
        super.viewDidLoad()

        //UINavigationControllerのデリゲート
        self.navigationController?.delegate = self

        //ナビゲーションと色設定
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
        
        //タイトル用の色および書式の設定
        let attrsMainTitle = [
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 15)!
        ]
        self.navigationItem.title = "Welcome to This Sample!"
        self.navigationController?.navigationBar.titleTextAttributes = attrsMainTitle
        
        //ナビゲーション用の色および書式の設定
        let attrsBarButton = [
            NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 16)!
        ]

        //左メニューボタンの配置
        leftMenuButton = UIBarButtonItem(title: "🔖", style: .Plain, target: self, action: #selector(ContentListViewController.leftMenuButtonTapped(_:)))
        leftMenuButton.setTitleTextAttributes(attrsBarButton, forState: .Normal)
        self.navigationItem.leftBarButtonItem = leftMenuButton

        //右メニューボタンの配置
        rightMenuButton = UIBarButtonItem(title: "≡", style: .Plain, target: self, action: #selector(ContentListViewController.rightMenuButtonTapped(_:)))
        rightMenuButton.setTitleTextAttributes(attrsBarButton, forState: .Normal)
        self.navigationItem.rightBarButtonItem = rightMenuButton
        
        
        //UITableViewControllerのデリゲート
        listTableView.delegate = self
        listTableView.dataSource = self
        
        //Xibのクラスを読み込む宣言を行う
        let nibDefault: UINib = UINib(nibName: "ListTableViewCell", bundle: nil)
        listTableView.registerNib(nibDefault, forCellReuseIdentifier: "ListTableViewCell")
    }

    //レイアウト処理が完了した際の処理
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        //テーブルビューのヘッダーに使用するコンテナの再配置
        listTableHeader.frame = CGRectMake(
            CGFloat(0),
            CGFloat(0),
            CGFloat(DeviceSize.screenWidth()),
            CGFloat(180)
        )

    }

    //左メニューボタンを押した際のアクション
    func leftMenuButtonTapped(sender: UIBarButtonItem) {

        /**
         * 親コントローラーのメソッドを呼び出して左コンテンツを開く
         * このコントローラーはUINavigationControllerDelegateを使っているので、
         * 「ViewController(親) → NavigationController(子) → ContentListViewController(孫)」
         * という図式になります。
         *
         */
        let viewController = self.parentViewController?.parentViewController as! ViewController
        viewController.handleMainContentsContainerState(MainContentsStatus.LeftMenuOpened)
    }

    //右メニューボタンを押した際のアクション
    func rightMenuButtonTapped(sender: UIBarButtonItem) {

        /**
         * 親コントローラーのメソッドを呼び出して右コンテンツを開く
         * このコントローラーはUINavigationControllerDelegateを使っているので、
         * 「ViewController(親) → NavigationController(子) → ContentListViewController(孫)」
         * という図式になります。
         *
         */
        let viewController = self.parentViewController?.parentViewController as! ViewController
        viewController.handleMainContentsContainerState(MainContentsStatus.RightMenuOpened)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ContentListViewController: UITableViewDelegate {
    
    //テーブルのセル高さ ※任意
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }

    //テーブルヘッダに関する処理 ※任意
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        //ヘッダーが必要な物はここにaddSubView → Header用のContainerを突っ込む
        let headerViewBase = UIView()
        headerViewBase.frame = CGRectMake(
            CGFloat(0),
            CGFloat(0),
            CGFloat(DeviceSize.screenWidth()),
            CGFloat(180)
        )
        headerViewBase.backgroundColor = UIColor.redColor()
        headerViewBase.addSubview(listTableHeader)
        headerViewBase.multipleTouchEnabled = true
        listTableHeader.multipleTouchEnabled = true
        return headerViewBase
    }

    //セクションヘッダー高さ ※任意
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(180)
    }

}

extension ContentListViewController: UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("ListTableViewCell") as? ListTableViewCell
        
        cell!.listTitleLabel.text = "タイトルが入ります"
        cell!.accessoryType = UITableViewCellAccessoryType.None
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    //セルをタップした時に呼び出される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("goContentDetail", sender: nil)
    }
    
}
