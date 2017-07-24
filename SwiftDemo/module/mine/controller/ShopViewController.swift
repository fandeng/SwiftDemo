//
//  ShopViewController.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/21.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

let ColumnIdentifier = "columncell_id"


class ShopViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var listarray = NSMutableArray()
    
    var pagenum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "购物"
        //注册自定义cell
        self.tableView.register(UINib.init(nibName: "ColumnTableViewCell", bundle: nil), forCellReuseIdentifier: ColumnIdentifier)
        self.tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: HomeIdentifier)
        
        self.requestListData(isShow: true)
        //刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))

    }
    //下拉刷新
    func headerRefresh() {
        tableView.mj_footer.resetNoMoreData();
        pagenum = 1
        self.requestListData(isShow: false)
        
    }
    //上拉刷新
    func footerRefresh() {
        self.requestListData(isShow: false)
    }
    //请求数据
    func requestListData(isShow:Bool) {
        let request = HomeRequestServices()
        request.addRequest(userid: "", type: "0", columnid: "0004", pagenum: "\(pagenum)", pagesize: "20");
        self.showHud(in: self.view,title: "正在加载...", isShow: isShow)
        request .startWithCompletionBlock(success: { [weak self](yrequest) in
            let dic = yrequest.responseJSONObject as! NSDictionary
            
            if dic.count > 0 {
                let model = HomeModel()
                model.setValuesForKeys(dic["response_body"] as! [String : AnyObject])
                
                if (self?.tableView.mj_header.isRefreshing())! || ("\(String(describing: self?.pagenum))".isEqual("1")){
                    self?.listarray.removeAllObjects()
                }
                
                self?.tableView.mj_header.endRefreshing()
                self?.tableView.mj_footer.endRefreshing()
                
                if model.articlelist.count >= 20 {
                    self?.pagenum += 1
                } else {
                    self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                
                self?.listarray.addObjects(from: model.articlelist)
                
                self?.tableView.reloadData()
                self?.hideHud()
            }
            
        }) { (YTKBaseRequest) in
            self.hideHud()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
        
    }
    //tableView协议方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listarray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var articleModel = ArticlelistModel()
        
        articleModel = self.listarray[indexPath.row] as! ArticlelistModel
        
        if articleModel.styleid.isEqual("4") || articleModel.styleid.isEqual("10") {
            return 45
        }
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var articleModel = ArticlelistModel()
        
        articleModel = self.listarray[indexPath.row] as! ArticlelistModel
        
        if articleModel.styleid.isEqual("4") || articleModel.styleid.isEqual("10") {
            let cell : ColumnTableViewCell = tableView.dequeueReusableCell(withIdentifier:ColumnIdentifier, for: indexPath)as! ColumnTableViewCell
            
            cell.titlelabel.text = articleModel.title
            
            return cell
        } else {
            let cell : HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier:HomeIdentifier, for: indexPath)as! HomeTableViewCell
            
            cell.showCellWithData(model: articleModel)
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var articleModel = ArticlelistModel()
        
        articleModel = self.listarray[indexPath.row] as! ArticlelistModel
        
        if articleModel.styleid.isEqual("4") || articleModel.styleid.isEqual("10") {
            
            self.createAlertView(title: "", message: "暂无", time: 1.0)
            
            return
        }
        
        let detailVC = DetailViewController()
        
        detailVC.hidesBottomBarWhenPushed = true
        
        detailVC.navTitle = articleModel.title
        
        detailVC.serviceurl = articleModel.serviceurl
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
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
