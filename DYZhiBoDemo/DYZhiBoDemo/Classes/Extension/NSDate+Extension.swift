//
//  NSDate+Extension.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/10.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrenTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
