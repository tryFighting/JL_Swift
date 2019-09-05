//
//  JLBaseWebViewController.swift
//  JL_Swift
//
//  Created by zrq on 2019/9/3.
//  Copyright © 2019 com.baidu.www. All rights reserved.
//

import UIKit

import WebKit
class JLBaseWebController: JLBaseViewController {
    lazy var wkwebview: WKWebView = {
        let userContent = WKUserContentController()
        let userScript = WKUserScript(source: "document.cookie='token=123456; path=/'", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        userContent.addUserScript(userScript)
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.processPool = WKProcessPool()
        config.preferences.minimumFontSize = 10;
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.userContentController = userContent
        let  wk = WKWebView(frame: CGRect(x: 0, y: NavigationBarHeight, width: ScreentW,height: ScreentH), configuration: config)
        wk.navigationDelegate = self
        wk.uiDelegate = self
        ///添加监听title和进度条
        //wk.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        wk.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        return wk
    }()
    lazy var progress: UIProgressView = {
        let prog = UIProgressView(progressViewStyle: .default)
        prog.frame = CGRect(x: 0, y: NavigationBarHeight, width: ScreentW, height: 3)
        prog.progressTintColor = UIColor.red
        prog.trackTintColor = UIColor.white
        prog.alpha = 1.0
        return prog
    }()
    var loadUrlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.wkwebview)
        self.view.addSubview(self.progress)
        let request = NSMutableURLRequest(url: URL(string: self.loadUrlString!)!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 60)
        self.wkwebview.load(request as URLRequest)
    }
    deinit {
        // self.wkwebview.removeObserver(self, forKeyPath: "title")
        self.wkwebview.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}
extension JLBaseWebController: WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progress.isHidden = false
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
}
///GitHub:受SDWebView启发
extension JLBaseWebController{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" && object is WKWebView{
            self.progress.alpha = 1.0
            let animated = Float(self.wkwebview.estimatedProgress)  > self.progress.progress
            self.progress.setProgress(Float(self.wkwebview.estimatedProgress), animated: animated)
            if self.wkwebview.estimatedProgress >= 1.0{
                UIView.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self.progress.alpha = 0.0
                }) { (finished) in
                    self.progress.setProgress(0.0, animated: false)
                }
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

