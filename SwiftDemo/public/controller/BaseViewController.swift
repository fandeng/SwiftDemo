//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/19.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false;
        //修改导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.white;
        
        self.view.backgroundColor = UIColor.colorWithHexString(hex: "#F0F1F2")
        
      
        let item = UITabBarItem.appearance()
        var dic = [String : AnyObject]()
        dic[NSForegroundColorAttributeName] = UIColor.colorWithHexString(hex: "#ff9a14")
        item.setTitleTextAttributes(dic, for: .selected)

    }
    
    open func createBackButton() {
        
        let leftItem = UIBarButtonItem(image: UIImage.init(named: "goback")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(clickBackButtonAction))
        
        self.navigationItem.leftBarButtonItem = leftItem;
    }

    open func clickBackButtonAction(){
        self.navigationController?.popViewController(animated: true)
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
