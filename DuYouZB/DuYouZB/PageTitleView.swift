//
//  PageTitleView.swift
//  DuYouZB
//
//  Created by Elvis on 2018/4/12.
//  Copyright © 2018年 Elvis. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTiltleView(titleView:PageTitleView,selectedIndex : Int)
}
private let KNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let KSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
class PageTitleView: UIView {
    private var titles : [String]
    private var currentIndex : Int = 0
    private var titlesLabel : [UILabel] = [UILabel]()
     var delegate :PageTitleViewDelegate?
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private  lazy var scrollLine : UIView  = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
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
        setupBottonLineSAndScrollLine()
    }
    private func setupBottonLineSAndScrollLine(){
        let bottomLine = UIView()
        let lineH = CGFloat(0.5)
        bottomLine.frame = CGRect(x:0,y:frame.height-lineH,width:frame.width,height:lineH)
        guard  let firstLabel = titlesLabel.first else {
            return
        }
        addSubview(bottomLine)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x:firstLabel.frame.origin.x,y:CGFloat(32),width:firstLabel.frame.width,height:CGFloat(2))
        firstLabel.textColor = UIColor.orange
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
            label.tag = index
            scrollView.addSubview(label)
            titlesLabel.append(label)
            label.isUserInteractionEnabled = true
            let tagGes = UITapGestureRecognizer(target:self,action:#selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tagGes)
        }
    }
}
extension PageTitleView{
    @objc private func titleLabelClick(tapGes:UITapGestureRecognizer){
     guard let currentLabel = tapGes.view as? UILabel else {return}
        let oldLabel = titlesLabel[currentIndex]
        print(currentIndex)
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.black
        currentIndex = currentLabel.tag
        let scrollLineX = CGFloat(currentIndex)*scrollLine.frame.width
        UIView.animate(withDuration: 0.15){
            self.scrollLine.frame.origin.x = scrollLineX
        }
        delegate?.pageTiltleView(titleView: self,selectedIndex: currentLabel.tag)
    }
}
extension PageTitleView{
    func setTitleWithProgress(progress : CGFloat,sourceIndex : Int,targetIndex : Int){
        let sourceLabel = titlesLabel[sourceIndex]
        let targetLabel = titlesLabel[targetIndex]
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = moveX+sourceLabel.frame.origin.x
         let colorDelta = (KSelectColor.0 - KNormalColor.0,KSelectColor.1 - KNormalColor.1,KSelectColor.2 - KNormalColor.2)
        sourceLabel.textColor = UIColor(r:KSelectColor.0-colorDelta.0,g:KSelectColor.1-colorDelta.1,b:KSelectColor.2-colorDelta.2)
        targetLabel.textColor = UIColor(r:KNormalColor.0+colorDelta.0,g:KNormalColor.1+colorDelta.1,b:KNormalColor.2+colorDelta.2)
        currentIndex = targetIndex
    }
}
