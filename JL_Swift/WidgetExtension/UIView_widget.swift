//
//  UIView_widget.swift
//  JL_Swift
//
//  Created by zrq on 2019/9/3.
//  Copyright © 2019 com.baidu.www. All rights reserved.
//

import UIKit
extension UIView{
    func addSub(_ subviews: UIView...){
        subviews.forEach(addSubview(_:))
    }
}
