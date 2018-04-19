//
//  RecommentController.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/4.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

private let kMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalItemW : CGFloat = (kScreenW - 3 * kMargin) / 2
private let kNormalItemH : CGFloat = kNormalItemW * 3 / 4
private let kPrettyItemH : CGFloat = kNormalItemW * 4 / 3


private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"

class RecommentController: UIViewController {

    //定义属性
    private lazy var recommendVM : ReCommentViewModel = ReCommentViewModel()
    var baseVM : BaseViewModel!

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
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)

        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()

//        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
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

//MRAK:- 请求数据
extension RecommentController{
    private func loadData() {
        //
//        baseVM = recommendVM
        recommendVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            // 2.将数据传递给GameView
//            var groups = self.recommendVM.anchorGroups
//            print("groups=",groups)
            // 2.1.移除前两组数据
//            groups.removeFirst()
//            groups.removeFirst()
            
            // 2.2.添加更多组
//            let moreGroup = AnchorGroup()
//            moreGroup.tag_name = "更多"
//            groups.append(moreGroup)
            
        }
        
        
//        NetworkTools.required(.GET, URLString: "http://httpbin.org/get", parameters: ["name":"tom"]) { (result) in
//            print(result)
//        }
    }
}

extension RecommentController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 8
//        }
//        return 4
        print(recommendVM.anchorGroups[section].anchors.count)

        return recommendVM.anchorGroups[section].anchors.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        var cell : UICollectionViewCell!
        
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            let model : AnchorModel = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
//            print("item model =",model.nickname)
            return cell
        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell

        // 2.给cell设置数据
        
//        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
//        cell.backgroundColor = UIColor.red
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
//        headerView.backgroundColor = UIColor.cyan
        // 2.给HeaderView设置数据
        headerView.group = recommendVM.anchorGroups[indexPath.section]

        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}

extension RecommentController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        //解决 滑动条被头视图覆盖问题
        view.layer.zPosition = 0.0
    }
}
