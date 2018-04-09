//
//  UIBarButtonItem+Extension.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/3/21.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    //构造方法
    //便利构造函数
    convenience init(name:String,highImageName:String="",size:CGSize=CGSize.zero){
        let btn = UIButton()
        let norImg = UIImage(named: name)

        btn.setImage(norImg, for: .normal)
        
        if highImageName != "" {
            let hightImg = UIImage(named: highImageName)
            btn.setImage(hightImg, for: .highlighted)

        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)

        }
        
        
        self.init(customView: btn)
    }
    
    
    
}
