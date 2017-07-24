//
//  UIViewController+HUD.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/20.
//  Copyright © 2017年 樊登. All rights reserved.
//

import Foundation




private var HUDKey = "HUDKey"

extension UIViewController {
    
    var hud : MBProgressHUD? {
        get{
            return objc_getAssociatedObject(self, &HUDKey) as? MBProgressHUD
        }
        set{
            objc_setAssociatedObject(self, &HUDKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    //显示提示信息(有菊花, 一直显示, 不消失)，默认文字“加载中”
    func showHud(in view: UIView, title: String, isShow:Bool){
        if isShow {
            let HUD = MBProgressHUD(view: view)
            
            HUD.label.text = title.isEmpty ? "正在加载..." : title
            
            HUD.mode = MBProgressHUDMode(rawValue: 0)!
            
            view.addSubview(HUD)
            
            HUD.show(animated: true)
            
            hud = HUD
        }
    }
    // 移除提示
    func hideHud() {
        //如果解包成功则移除，否则不做任何事
        if let hud = hud {
            hud.hide(animated: true)
        }
    }
    //弱提示 参数：标题，内容，时间：多少秒
    func createAlertView(title:String, message:String, time:TimeInterval) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(removeAlertController(timer:)), userInfo: alertController, repeats: false)
    }
    func removeAlertController(timer:Timer) {
        let alertController = timer.userInfo as! UIAlertController
        alertController.dismiss(animated: true, completion: nil)
    }

}
