//
//  PageTitleView.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/4/2.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index : Int)
}


private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    
    private var titles : [String]
    private var currIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        return scrollLine
    }()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //MARK:- 设置ui
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加对应的lable
        setTitleLables()
        
        //添加底部滑动线
        setBottomLineAndMenu()
    }
    
    private func setTitleLables(){
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0

        for (index,title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = NSTextAlignment.center
            
            let labelX = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给Lab添加属性
            label.isUserInteractionEnabled = true
            let gesTap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(gesTap)
        }
    }
    
    
    private func setBottomLineAndMenu(){
        let bottomLine = UIView()
        let lineH :CGFloat = 0.5
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


extension PageTitleView{
    //事件监听加@objc
    @objc private func titleLabelClick(tapGes:UITapGestureRecognizer){
        print("----")
        
        guard let currLabel = tapGes.view as? UILabel else {
            return
        }
        
        let oldLabel = titleLabels[currIndex]
        
        currLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.0)
        
        currIndex = currLabel.tag
        
        //修改选中横线位置
        let scrollLinePosition = CGFloat(currIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        
        //关联cell视图
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currIndex)
        
    }
}

//暴露方法
extension PageTitleView{
    func setTitle(progress:CGFloat, sourceIndex:Int, targerIndex:Int) {
//        print("set titleView")
        //取出label
        let sourceLab = titleLabels[sourceIndex]
        let targerLab = titleLabels[targerIndex]
        
        //出来滑动条位置
        let moveTotalX = targerLab.frame.origin.x - sourceLab.frame.origin.x
        let moveX = progress * moveTotalX
        scrollLine.frame.origin.x = moveX + sourceLab.frame.origin.x
        
        //颜色渐变
        //取出变化范围
        let colorDelta = (kSelectedColor.0-kNormalColor.0,kSelectedColor.1-kNormalColor.1,kSelectedColor.2-kNormalColor.2)
        
        sourceLab.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        
        targerLab.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)

        //记录当前最新的位置
        currIndex = targerIndex
        
    }
}
