//
//  AnchorGroup.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/10.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

@objcMembers class AnchorGroup : BaseGameModel {
    
   
    
    var room_list : [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
        
    }
    
    
    var icon_name : String = "home_header_normal"

    
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
}
