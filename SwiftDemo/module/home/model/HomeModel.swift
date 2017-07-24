//
//  HomeModel.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/20.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit


class HomeModel: NSObject {
    
    var total:String = ""
    var pagenum:String = ""
    var articlelist:[AnyObject] = []
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key.isEqual("articlelist") {
            var temp = [AnyObject]()
            temp = value as! [AnyObject]
            
            var array = [AnyObject]()
            
            for dic in temp {
                let model = ArticlelistModel()
                model.setValuesForKeys(dic as! [String : AnyObject])
                array.append(model)
            }
            articlelist = array
        }else {
            super.setValue(value, forKey: key)
        }
    }
    
}


class ArticlelistModel : NSObject {
    
    var author:String = ""
    var cover:String = ""
    var createtime:String = ""
    var infoid:String = ""
    var infotype:String = ""
    var isliked:String = ""
    var maintext:String = ""
    var originallink:String = ""
    var parentcolumnid:String = ""
    var serviceurl:String = ""
    var summary:String = ""
    var title:String = ""
    var action:String = ""
    var actionvalue:String = ""
    var styleid:String = ""
    var statue:String = ""

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}

