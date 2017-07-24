//
//  HomeRequestServices.swift
//  
//
//  Created by 樊登 on 2017/7/20.
//
//

import UIKit

class HomeRequestServices: YTKRequest {
    
    var requestBody = [String: AnyObject]()
   
    override func requestMethod() -> YTKRequestMethod {
        return YTKRequestMethod(rawValue: 1)!
    }
    
    override func requestSerializerType() -> YTKRequestSerializerType {
        return YTKRequestSerializerType(rawValue: 1)!
    }

    //网络请求方法
    func addRequest(userid:String,type:String,columnid:String,pagenum:String,pagesize:String) {
        
        var body = [String : AnyObject]()
       
        body["userid"]   = userid as AnyObject
        body["type"]     = type as AnyObject
        body["columnid"] = columnid as AnyObject
        body["pagenum"]  = pagenum as AnyObject
        body["pagesize"] = pagesize as AnyObject
       
        requestBody["request_body"] = body as AnyObject?
        requestBody["request_head"] = CommonMethod.shared.publicRequestHeader(processcode: "queryinformation") as AnyObject?
    }
    
    override func requestArgument() -> Any? {
        return requestBody
    }
    

}
