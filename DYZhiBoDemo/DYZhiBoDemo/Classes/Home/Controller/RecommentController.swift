//
//  RecommentController.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/4.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

private let kMargin : CGFloat = 10
private let kNormalItemW : CGFloat = (kScreenW - 3 * kMargin) / 2
private let kNormalItemH : CGFloat = kNormalItemW * 3 / 4

private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommentController: UIViewController {

    //定义属性
    private lazy var collectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)

        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RecommentController{
    func setupUI() {
//        view.backgroundColor = UIColor.purple
        
        view.addSubview(collectionView)
        
        if #available(iOS 11.0, *){
            collectionView.contentInsetAdjustmentBehavior = .never
//            collectionView.contentInset = UIEdgeInsetsMake(kNavigationBarH, 0, kTabBarH, 0)
//            collectionView.scrollIndicatorInsets = collectionView.contentInset
        }
    }
}


extension RecommentController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
//        cell.backgroundColor = UIColor.red
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
//        headerView.backgroundColor = UIColor.cyan
        return headerView
    }
    

}

extension RecommentController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        //解决 滑动条被头视图覆盖问题
        view.layer.zPosition = 0.0
    }
}
