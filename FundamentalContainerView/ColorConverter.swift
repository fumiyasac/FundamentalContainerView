//
//  ColorConverter.swift
//  FundamentalContainerView
//
//  Created by 酒井文也 on 2016/09/11.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//WebのカラーコードをiOS用のものに変換する構造体
struct ColorConverter {
    
    //16進数のカラーコードをiOSの設定に変換するメソッド
    static func colorWithHexString (hex: String) -> UIColor {
        
        //受け取った値を大文字に変換する
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        //#があれば取り除く
        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }
        
        //コードの設定に間違っている(正しい16進数表記ではない)場合はグレーカラーにする
        if cString.characters.count != 6 {
            return UIColor.gray
        }
        
        //各々のコード部分を抜き出して変換を行う
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        //RGBの形式に直してUIColorクラスに渡す
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}
