//
//  PageTitleView.swift
//  DuYouZB
//
//  Created by Elvis on 2018/4/12.
//  Copyright © 2018年 Elvis. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    private var titles : [String]
    
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
     init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
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
        setupTitleLabels()
    }
    private func setupTitleLabels(){
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: CGFloat(16))
            label.textColor = UIColor.black
            label.textAlignment = .center
            
            let labelW:CGFloat = frame.width/CGFloat(titles.count)
            let labelH:CGFloat = frame.height-CGFloat(2)
            let labelX:CGFloat = labelW * CGFloat(index)
            let labelY:CGFloat = 0
            label.frame = CGRect(x:labelX,y:labelY,width:labelW,height:labelH)
            scrollView.addSubview(label)
        }
    }
}
