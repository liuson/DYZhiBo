//
//  PageContentView.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/2.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(pageContentView : PageContentView , progressValue : CGFloat , sourceIndx : Int , targerIndex : Int)
}

private let ContenCellID = "ContenCellID"

class PageContentView: UIView {

    private var childVc : [UIViewController]
    private weak var parentVC : UIViewController?
    private var startOfSetX : CGFloat = 0
    weak var pageCVDelegate : PageContentViewDelegate?
    private var isForbodScrollDelegate : Bool = false
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContenCellID)
        
        return collection
        
    }()
    
    init(frame: CGRect,childVc:[UIViewController], parentViewController:UIViewController?) {
        self.childVc = childVc
        self.parentVC = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView{
    private func setupUI(){
        for child in childVc {
            parentVC?.addChildViewController(child)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVc.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContenCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childvc = childVc[indexPath.item]
        childvc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childvc.view)
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbodScrollDelegate = false
        
        startOfSetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("hahah")
        
        if isForbodScrollDelegate {return}
        
        //1.获取数据
        var progressValue : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffSetX = scrollView.contentOffset.x
        let scrollviewW = scrollView.bounds.size.width

        if currentOffSetX > startOfSetX {
            //向左
            //floor() 取整函数
            //1.计算progress
            progressValue = currentOffSetX/scrollviewW - floor(currentOffSetX/scrollviewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffSetX/scrollviewW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex > childVc.count {
                targetIndex = childVc.count - 1
            }
            
            
            if currentOffSetX - startOfSetX == scrollviewW {
                targetIndex = sourceIndex
                progressValue = 1
            }
        }else{
            //向右
            progressValue = 1 - (currentOffSetX/scrollviewW - floor(currentOffSetX/scrollviewW))
            //计算targetIndex
            targetIndex = Int(currentOffSetX/scrollviewW)
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex > childVc.count {
                sourceIndex = childVc.count - 1
            }
        }
        
        pageCVDelegate?.pageContentView(pageContentView: self, progressValue: progressValue, sourceIndx: sourceIndex, targerIndex: targetIndex)
        
        
    }
}

//对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex : Int) {
        //禁止执行代理
        isForbodScrollDelegate = true
        
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offSetX,y:0), animated: false)
        
        
    }
}
