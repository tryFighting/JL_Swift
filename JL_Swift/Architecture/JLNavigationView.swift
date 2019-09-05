//
//  JLNavigationView.swift
//  JL_Swift
//
//  Created by zrq on 2019/9/3.
//  Copyright © 2019 com.baidu.www. All rights reserved.
//

import UIKit

import SnapKit
@objc protocol BaseViewDataSource: NSObjectProtocol{
    func navigationBarTitle(navigationBar: JLNavigationView) -> NSMutableAttributedString?
    func navigationBarBackgroundImage(navigationBar: JLNavigationView) -> UIImage?
    func navigationBarBackgroundColor(navigationBar: JLNavigationView) -> UIColor?
    func navigationBarHiddenBottomLine(navigationBar: JLNavigationView) -> Bool
    //    func navigationBarHeight(navigationBar: JLNavigationView) -> CGFloat
    
    ///自定义左边视图
    func navigationBarLeft(navigationBar: JLNavigationView) -> UIView?
    ///自定义右边视图
    func navigationBarRight(navigationBar: JLNavigationView) -> UIView?
    ///自定义中间视图
    func navigationBarMiddle(navigationBar: JLNavigationView) -> UIView?
    
    @objc optional func navigationBarLeftButton(navigationBar: JLNavigationView,left: UIButton) -> UIImage?
    @objc optional func navigationBarRightButton(navigationBar: JLNavigationView,right: UIButton) -> UIImage?
}
@objc protocol BaseViewDelegate {
    func leftButton(navigationBar: JLNavigationView,left: UIView)
    func rightButton(navigationBar: JLNavigationView,right: UIView)
    func titleClickEvent(navigationBar: JLNavigationView,title: UILabel)
}
class JLNavigationView: UIView{
    var delegate: BaseViewDelegate?
    var backImage: UIImage?
    private var _datasource: BaseViewDataSource?
    
    var datasource: BaseViewDataSource?{
        get{
            return _datasource
        }set{
            _datasource = newValue
            ///数据源协议背景颜色
            self.backgroundColor = self.datasource?.navigationBarBackgroundColor(navigationBar: self)
            ///数据源协议是否隐藏分割线
            self.bottomBlackLineView.isHidden = self.datasource?.navigationBarHiddenBottomLine(navigationBar: self) ?? false
            
            ///数据源协议背景图片
            self.backImage = self.datasource?.navigationBarBackgroundImage(navigationBar: self)
            self.layer.contents = self.backImage?.cgImage
            
            ///数据源的文本属性
            self.title = self.datasource?.navigationBarTitle(navigationBar: self)
            
            ///三个视图数据源
            let view1 = self.datasource?.navigationBarLeft(navigationBar: self)
            let view2 = self.datasource?.navigationBarRight(navigationBar: self)
            if let left = view1 {
                self.leftView.addSubview(left)
            }
            if let right = view2{
                self.rightView.addSubview(right)
            }
            self.layoutIfNeeded()
        }
    }
    var bottomBlackLineView: UIView
    let titleView: UILabel
    let leftView: UIView
    let rightView: UIView
    private var _title: NSMutableAttributedString?
    var title: NSMutableAttributedString?{
        get{
            return _title
        }set{
            _title = newValue
            self.titleView.textColor = UIColor.black
            self.titleView.numberOfLines = 0
            self.titleView.textAlignment = NSTextAlignment.center
            self.titleView.isUserInteractionEnabled = true
            self.titleView.lineBreakMode = NSLineBreakMode.byClipping
            self.titleView.attributedText = _title
            self.layoutIfNeeded()
        }
    }
    
    
    override init(frame: CGRect) {
        
        self.bottomBlackLineView = UIView()
        self.bottomBlackLineView.backgroundColor = UIColor.gray
        self.titleView = UILabel()
        self.titleView.backgroundColor = UIColor.clear
        
        self.leftView = UIView()
        self.leftView.backgroundColor = UIColor.clear
        
        self.rightView = UIView()
        self.rightView.backgroundColor = UIColor.clear
        
        
        super.init(frame: frame)
        self.addSub(self.bottomBlackLineView,self.titleView,self.leftView,self.rightView)
        self.leftView.isUserInteractionEnabled = true
        self.titleView.isUserInteractionEnabled = true
        let left = UITapGestureRecognizer(target: self, action: #selector(click(sender:)))
        self.backgroundColor = UIColor.white
        self.leftView.addGestureRecognizer(left)
        
        let right = UITapGestureRecognizer(target: self, action: #selector(click(sender1:)))
        self.rightView.addGestureRecognizer(right)
        
        let middle = UITapGestureRecognizer(target: self, action: #selector(click(sender2:)))
        self.titleView.addGestureRecognizer(middle)
    }
    @objc func click(sender: UITapGestureRecognizer){
        delegate?.leftButton(navigationBar: self, left: sender.view!)
    }
    @objc func click(sender1: UITapGestureRecognizer){
        delegate?.rightButton(navigationBar: self, right: sender1.view!)
    }
    @objc func click(sender2: UITapGestureRecognizer){
        delegate?.titleClickEvent(navigationBar: self, title: sender2.view as! UILabel)
    }
    
    override func layoutSubviews() {
        self.bottomBlackLineView.snp.makeConstraints { (make) in
            make.width.equalTo(ScreentW)
            make.left.right.equalTo(0);
            make.top.equalTo(NavigationBarHeight - 0.5)
            make.height.equalTo(0.5)
        }
        self.titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset((NavigationBarHeight - StatusBarHeight)/2)
            make.height.equalTo(30)
            make.width.equalTo(ScreentW/2)
        }
        self.leftView.snp.makeConstraints { (make) in
            make.height.equalTo(self.titleView.snp_height)
            make.left.equalTo(10)
            make.centerY.equalTo(self.titleView.snp.centerY)
            make.right.equalTo(self.titleView.snp_left).offset(-10)
        }
        self.rightView.snp.makeConstraints { (make) in
            make.height.equalTo(self.titleView.snp_height)
            make.right.equalTo(-10)
            make.left.equalTo(self.titleView.snp_right).offset(10)
            make.centerY.equalTo(self.titleView.snp.centerY)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


