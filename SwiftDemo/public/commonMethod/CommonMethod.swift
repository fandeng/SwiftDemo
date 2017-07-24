//
//  CommonMethod.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/20.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

class CommonMethod: NSObject {
    
    //单例
    static let shared = CommonMethod.init()
    private override init(){}
    //屏幕宽度
    public let kScreenW = UIScreen.main.bounds.width
    //屏幕高度
    public let kScreenH = UIScreen.main.bounds.height

    //请求报文头
    func publicRequestHeader(processcode:String)->[String: AnyObject]?{
        
        var header = [String : AnyObject]()
        header["inf_code"] = processcode as AnyObject?
        header["req_time"] = self.curTimeWithFormat() as AnyObject?
        header["uid"] = self.deviceUUIDString() as AnyObject?
        header["token"] = "" as AnyObject?
        header["appid"] = "egj" as AnyObject?
        header["channelid"] = "2" as AnyObject?
        
        return header;
        
    }
    //获取当前时间戳
    func curTimeWithFormat() -> String {
        let timeInterval:TimeInterval = NSDate().timeIntervalSince1970
        let timeStamp = Int(timeInterval*1000)
        
        return String(timeStamp);
    }
    //获取uuid
    func deviceUUIDString() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!;
    }
    //获取版本号
    func clientVersionCode() -> String {
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        return currentVersion
    }
   
}
