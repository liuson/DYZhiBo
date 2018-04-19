//
//  ReCommentViewModel.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/9.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

class ReCommentViewModel:BaseViewModel {
    
//    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()

    fileprivate lazy var bigDataGroup :AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGruop : AnchorGroup = AnchorGroup()
    
}

//MRAK:- 发送请求
extension ReCommentViewModel{
    //1.推荐数据
    func requestData(_ finishCallback : @escaping () -> ()) {
        let parameters = ["limit" : "4","offset" : "0","time" : Date.getCurrenTime()]
        
        let dGroup = DispatchGroup()
        print("Date.getCurrenTime()=\(Date.getCurrenTime())")
        dGroup.enter()
        NetworkTools.required(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrenTime()]) { (result) in
            
//            do{
//                let jsonDict = try JSONSerialization.data(withJSONObject: result, options: JSONSerialization.WritingOptions.init(rawValue: 0))
//                if let JSONString = String(data: jsonDict, encoding: String.Encoding.utf8) {
//                    print("JSONString = \(JSONString)")
//                }
//            }catch{
//
//            }

//            guard let dataArray = result["data"] as? [[String :Any]] else {return}
//            print("dataArray = \(dataArray)")
//            for dict in dataArray{
//                let anchor = AnchorModel(dict: dict)
//
//
//                self.bigDataGroup.anchors.append(anchor)
//            }
            
//            guard let resultDict = result as? [String : NSObject] else {return}
//            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
//            let nickname : String = dataArray[0]["nickname"] as! String
//            print("nickname = \(nickname)")
            
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            //2.根据data该key,获取数组

            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            // 3.遍历字典,并且转成模型对象
//
            
            // 3.1.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2.获取主播数据
            for dict in dataArray {
//                print("dict=\(dict)")
                let anchor = AnchorModel(dict: dict)
//                let nickname = anchor.nickname
//                print("nickname=\(nickname)")

                self.bigDataGroup.anchors.append(anchor)
            }
////
//            for model in self.bigDataGroup.anchors{
//                let nickname = model.nickname
//                print("nickname=\(nickname)")
//            }
 
            //3.3.离开组
            dGroup.leave()
        }
        
        // 4.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.required(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGruop.tag_name = "颜值"
            self.prettyGruop.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {

                let anchor = AnchorModel(dict: dict)
                self.prettyGruop.anchors.append(anchor)
            }
//
           
//            for grop in self.prettyGruop.anchors {
//                print(grop.nickname)
//            }
            // 3.3.离开组
            dGroup.leave()
        }
        
        
        // 5.请求2-12部分游戏数据
        dGroup.enter()
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1474252024
        
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
       

        // 6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGruop, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
     
    
}
