//
//  NetworkTools.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/9.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func required(_ type:MethodType, URLString:String,parameters:[String:Any]? = nil, finishedBack: @escaping (_ result : Any)->()){
        //1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        //2.发送请求
        Alamofire.request(URLString,method:method,parameters:parameters).responseJSON { (response) in
            //获取结果
            guard let result = response.result.value else{
                print(response.result.error ?? "error")
                return
            }
            //4.返回结果
            finishedBack(result)
            
        }
        
        
    }
}
