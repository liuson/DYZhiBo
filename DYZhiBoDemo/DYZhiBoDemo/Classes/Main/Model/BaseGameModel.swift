//
//  BaseGameModel.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/10.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

@objcMembers class BaseGameModel: NSObject {
    //MARK:- 定义属性
     var tag_name : String = ""
     var icon_url : String = ""
    
    
    //MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(dict : [String : Any]){
        super.init()
        
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        print(key)
    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        //重新使用value赋值给str属性就可以成功调用didSet方法
////        guard let newStr = value as? String else{
////            return
////        }
////        print(key)
//    }
}
