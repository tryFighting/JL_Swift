//
//  JLBaseViewController.swift
//  JL_Swift
//
//  Created by zrq on 2019/9/3.
//  Copyright © 2019 com.baidu.www. All rights reserved.
//

import UIKit

@objc protocol JLBaseViewControllerDataSource {
    @objc optional func navUIControllerNeedNavBar(navUIController: JLBaseViewController) -> Bool
}
class JLBaseViewController: UIViewController {
    lazy var baseV: JLNavigationView = {
        let base = JLNavigationView(frame: CGRect(x: 0, y: 0, width: ScreentW, height: NavigationBarHeight))
        base.isHidden = !navUIControllerNeedNavBar(navUIController: self)
        base.backgroundColor = UIColor.white
        base.delegate = self
        base.datasource = self
        return base
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.baseV)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
extension JLBaseViewController: BaseViewDelegate{
    func leftButton(navigationBar: JLNavigationView, left: UIView) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightButton(navigationBar: JLNavigationView, right: UIView) {
        
    }
    
    func titleClickEvent(navigationBar: JLNavigationView, title: UILabel) {
        
    }
    
    
}
extension JLBaseViewController: BaseViewDataSource{
    func navigationBarBackgroundColor(navigationBar: JLNavigationView) -> UIColor? {
        ///导航栏的背景颜色
        return UIColor.white
    }
    func navigationBarBackgroundImage(navigationBar: JLNavigationView) -> UIImage? {
        return nil
    }
    func navigationBarTitle(navigationBar: JLNavigationView) -> NSMutableAttributedString? {
        ///改变文本的颜色
        return self.changeTitle(input: self.title ?? self.navigationItem.title ?? "")
    }
    
    func changeTitle(input: String) -> NSMutableAttributedString?{
        let title: NSMutableAttributedString = NSMutableAttributedString(string: input)
        title.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: NSMakeRange(0,title.length))
        title.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], range: NSMakeRange(0,title.length))
        return title
    }
    func navigationBarHiddenBottomLine(navigationBar: JLNavigationView) -> Bool {
        return false
    }
    
    func navigationBarLeft(navigationBar: JLNavigationView) -> UIView? {
        return nil
    }
    
    func navigationBarRight(navigationBar: JLNavigationView) -> UIView? {
        return nil
    }
    
    func navigationBarMiddle(navigationBar: JLNavigationView) -> UIView? {
        return nil
    }
}
extension JLBaseViewController: JLBaseViewControllerDataSource{
    func navUIControllerNeedNavBar(navUIController: JLBaseViewController) -> Bool {
        return true
    }
}
