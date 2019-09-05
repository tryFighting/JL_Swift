//
//  JLNavViewController.swift
//  JL_Swift
//
//  Created by zrq on 2019/9/3.
//  Copyright © 2019 com.baidu.www. All rights reserved.
//

import UIKit

class PLNavViewController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ///默认的navigationbar隐藏
        navigationBar.isHidden = true
    }
}
