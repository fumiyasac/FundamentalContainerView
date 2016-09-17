//
//  DeviceSize.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//現在表示しているデバイスのサイズを返す構造体
struct DeviceSize {
    
    //デバイスのCGRectを取得
    static func bounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    //デバイスの画面の横サイズを取得
    static func screenWidth() -> Int {
        return Int(UIScreen.main.bounds.size.width)
    }
    
    //デバイスの画面の縦サイズを取得
    static func screenHeight() -> Int {
        return Int(UIScreen.main.bounds.size.height)
    }
    
}
