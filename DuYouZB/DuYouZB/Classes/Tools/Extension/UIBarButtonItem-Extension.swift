//
//  UIBarButtonItem-Extension.swift
//  DuYouZB
//
//  Created by Elvis on 2018/4/12.
//  Copyright © 2018年 Elvis. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    class func creatTime(imageName : String,highhImageName : String,size : CGSize)->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named:highhImageName), for: UIControlState.highlighted)
        btn.sizeToFit()
        btn.frame = CGRect(origin: CGPoint.zero,size:size)
        return UIBarButtonItem(customView:btn)
    }
}
