//
//  Common.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/2.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit



let kStatusBar : CGFloat = 20

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height

let isIphoneX = kScreenH == 812 ? true:false
let isIphonePlus = kScreenH == 736 ? true:false
let isIphone6 = kScreenH == 667 ? true:false



let kNavigationBarH : CGFloat = isIphoneX ? 88 : 64
let kTabBarH :CGFloat = isIphoneX ? (49+34) : 49

