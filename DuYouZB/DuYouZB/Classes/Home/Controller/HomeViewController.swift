//
//  HomeViewController.swift
//  DuYouZB
//
//  Created by Elvis on 2018/4/12.
//  Copyright © 2018年 Elvis. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let KTitleBarH:CGFloat = 40
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x:0,y:KStatusBarH+KNavigationBarH,width:KScreenW,height:KTitleBarH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame,titles: titles)
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}


extension HomeViewController{
    private func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
    }
    
    
    private func setupNavigationBar(){
        let size = CGSize(width:30,height:50)
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo") , for: UIControlState.normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        let historyItem = UIBarButtonItem.creatTime(imageName: "history_btn_pk", highhImageName: "history_btn_pk", size: size)
        let searchItem = UIBarButtonItem.creatTime(imageName: "dy_navi_search", highhImageName: "anchor_music_search_button_icon-1", size: size)
        let qrcodeItem = UIBarButtonItem.creatTime(imageName: "scanIconHL", highhImageName: "scanIcon", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
