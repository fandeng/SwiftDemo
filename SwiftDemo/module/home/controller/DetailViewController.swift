//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/19.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webview: UIWebView!
    
    var serviceurl = String()
    var navTitle = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navTitle
        self.createBackButton();
        
        self.webview.loadRequest(NSURLRequest.init(url: NSURL(string: self.serviceurl)! as URL) as URLRequest)
        
    }
    
    //webview代理
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.showHud(in: self.view, title: "正在加载...", isShow: true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideHud()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.hideHud()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
