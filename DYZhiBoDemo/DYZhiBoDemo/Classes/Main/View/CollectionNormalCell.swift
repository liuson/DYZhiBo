//
//  CollectionNormalCell.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/4.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK:- 定义模型
    var anchor : AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
//            print("roomNameLabel.text = \(String(describing: roomNameLabel.text))")
            onlineBtn.setTitle(onlineStr, for: UIControlState())

//            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            bgImageView.kf.setImage(with: iconURL)
            
            roomNameLabel.text = anchor.room_name

        }
    }
}
