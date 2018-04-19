//
//  NetworkTools.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/9.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
            
//            do{
//                let jsonData = try JSONSerialization.data(withJSONObject: result, options: JSONSerialization.WritingOptions.init(rawValue: 0))
//                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
//                    print("JSONString = \(JSONString)")
//                    let jsonData:Data = JSONString.data(using: .utf8)!
//
//                    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                     guard let allResulrDict = dict as? [String : Any] else {return}
//                    finishedBack(allResulrDict)
//
//                }
//            }catch{
//
//            }
            //4.返回结果
//            let json = JSON(data: result)
            finishedBack(result)

        }
        
        
    }
}

//extension NetworkTools{
//    func getDictionaryFromJSONString(jsonString:String) -> NSDictionary {
//        let jsonData:Data = jsonString.data(using: .utf8)!
//
//        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//        if dict != nil {
//            return dict as! NSDictionary
//        }
//        return NSDictionary()
//    }
//}

