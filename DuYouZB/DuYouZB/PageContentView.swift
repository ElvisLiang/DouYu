//
//  PageContentView.swift
//  DuYouZB
//
//  Created by Elvis on 2018/4/15.
//  Copyright © 2018年 Elvis. All rights reserved.
//

import UIKit
private let contentCellID = "contentCellID"

protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView,progress : CGFloat,sourceIndex:Int,targetIndex:Int)
}
class PageContentView: UIView {
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX:CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    private  lazy var collectionView : UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self as! UICollectionViewDelegate
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
     init(frame: CGRect,childVcs : [UIViewController],parentViewController:UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame:frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageContentView{
    private func setupUI(){
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for:indexPath)
//        for view in cell.contentView.subviews{
//            view.removeFromSuperview()
//        }
        let childVc = childVcs[indexPath.item]
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
extension PageContentView{
    func setCurrentIndex(currentIndex:Int){
        let offsetX = CGFloat(CGFloat(currentIndex)*collectionView.frame.width)
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated:true)
    }
}
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX>startOffsetX{
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex+1
            if(targetIndex >= childVcs.count){
                targetIndex  = childVcs.count-1
            }
            if currentOffsetX-startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            progress = floor(currentOffsetX/scrollViewW)-currentOffsetX/scrollViewW
            sourceIndex = targetIndex+1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count-1
            }
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
