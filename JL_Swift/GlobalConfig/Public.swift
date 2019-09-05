//
//  Public.swift
//  JL_Swift
//
//  Created by zrq on 2019/9/3.
//  Copyright © 2019 com.baidu.www. All rights reserved.
//

import UIKit
//布局设置
let ScreentW = UIScreen.main.bounds.width
let ScreentH = UIScreen.main.bounds.height

///以iPhone6为基准适配
let KScaleW = UIScreen.main.bounds.width/375.0
let KScaleH = UIScreen.main.bounds.height/667.0

///状态栏高度
let StatusBarHeight = UIApplication.shared.statusBarFrame.height

///导航栏高度
let NavigationBarHeight = StatusBarHeight + 44

//系统版本
let IS_IOS_VERSION = floorf((UIDevice.current.systemVersion as NSString).floatValue)

//判断机型是否为iPhone X 和 iPhone XS
let IS_iPhoneX = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)
//判断机型是否为iPhone XR
let IS_iPhoneXR = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!) : false)
//判断机型是否为iPhoneXs Max
let IS_iPhoneXs_Max = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2688).equalTo((UIScreen.main.currentMode?.size)!) : false)
