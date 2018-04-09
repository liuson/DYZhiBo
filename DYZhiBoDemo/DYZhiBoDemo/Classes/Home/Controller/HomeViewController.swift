//
//  HomeViewController.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/3/21.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

private let pageTitleH : CGFloat = 40

class HomeViewController: UIViewController {

    
    //MARK:- 定义标题栏视图
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleVFrame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: pageTitleH)
        let titleArray : [String] = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleVFrame, titles: titleArray)
//        titleView.backgroundColor = UIColor.purple
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kNavigationBarH+pageTitleH, width: kScreenW, height: kScreenH-kNavigationBarH-pageTitleH-kTabBarH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommentController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVc: childVcs, parentViewController: self)
        contentView.pageCVDelegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController{
    private func setupUI(){
        
        //不需要调整uiscrollview内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setNavigationBar()
        
//        view.addSubview(pageTitleView)
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setNavigationBar(){
        
//        self.navigationController?.navigationBar.tintColor = UIColor.orange
        self.navigationController?.navigationBar.barTintColor = UIColor.orange

        //一般方法
//        let button = UIButton()
//        button.setImage(UIImage(named: "homeLogoIcon"), for: .normal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(name: "homeLogoIcon", highImageName: "", size: CGSize.zero)
        
        //构造方法
        let size = CGSize(width: 30, height: 30)
        
        let historyItem = UIBarButtonItem(name: "home_newGameicon", highImageName: "", size: size)
//        let searchItem = UIBarButtonItem(name: "home_newSeacrhcon", highImageName: "", size: size)
        let qrcodeItem = UIBarButtonItem(name: "home_newSaoicon", highImageName: "", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,qrcodeItem]
        
    }
}


extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate{
    func pageContentView(pageContentView: PageContentView, progressValue: CGFloat, sourceIndx: Int, targerIndex: Int) {
        print("pageContentView")
        pageTitleView.setTitle(progress: progressValue, sourceIndex: sourceIndx, targerIndex: targerIndex)
    }
}
