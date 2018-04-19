//
//  CollectionPrettyCell.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/9.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {

    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    var anchor : AnchorModel? {
        didSet{
            guard let anchor = anchor else {
                return
            }
            
            var onlinestr  : String = ""
            if anchor.online >= 10000 {
                onlinestr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlinestr = "\(anchor.online)在线"
            }
//            print("onlinestr=\(anchor.online)")

            onlineBtn.setTitle(onlinestr, for: .normal)
           
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            guard let iconUrl = NSURL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with:ImageResource(downloadURL: iconUrl as URL))
            
//            print("nickname=\(anchor.nickname)")

            nickNameLabel.text = anchor.nickname
        }
    }
    
    
}
