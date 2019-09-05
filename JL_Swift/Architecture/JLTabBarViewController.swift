//
//  JLTabBarViewController.swift
//  JL_Swift
//
//  Created by zrq on 2019/9/3.
//  Copyright © 2019 com.baidu.www. All rights reserved.
//

import UIKit

class JLTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupChildControllers()
    }
}
extension JLTabBarViewController{
    
    fileprivate func setupChildControllers(){
        let array = [
            ["clsName":"JLHomeViewController","title":"首页","imageName":""],
            ["clsName":"JLMyViewController","title":"我的","imageName":""]
        ]
        ///写入文件字典数组
        //        let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
        //        (data as NSData).write(toFile: "/Users/zrq/Desktop/main.json", atomically: true)
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    /// dict消息字典转控制器
    ///
    /// - Parameter dict: tabbar信息字典
    /// - Returns: UIViewController
    private func controller(dict: [String: String]) ->UIViewController{
        //1.获取字典内容
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace() + "." + clsName) as? UIViewController.Type
            else {
                return UIViewController()
                
        }
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        //设置tabbar的字体（在normal状态） 选中状态需要在高亮状态上设置
        //vc.tabBarItem.setTitleTextAttributes([], for: )
        //    vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.orange], for: .highlighted)
        //        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font:24], for: .normal)
        tabBar.tintColor = UIColor.red
        let nav = PLNavViewController(rootViewController:vc)
        return nav
        
    }
}
extension JLTabBarViewController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
}
extension Bundle{
    func nameSpace() -> String {
        return   Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
