//
//  ViewController.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/19.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

let HomeIdentifier = "homecell_id"

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var listarray = NSMutableArray()
    
    var pagenum = 1
    
    let cycleArray = ["http://mem.suwenjk.com/healthy-web/downfile?fileId=170719171901868466606942223939",
                      "http://mem.suwenjk.com/healthy-web/downfile?fileId=170719172453527600651198291571",
                      "http://mem.suwenjk.com/healthy-web/downfile?fileId=170626155939659297311226863446",
                      "http://mem.suwenjk.com/healthy-web/downfile?fileId=170510113944696342024268454411"]
    let cycleModel = [["title":"家庭自我处理经典秘笈（1）","serviceurl":"http://mem.suwenjk.com/healthy-web/medical/discoverydetail?discoveryId=250"],
                      ["title":"家庭自我处理经典秘笈（2）","serviceurl":"http://mem.suwenjk.com/healthy-web/medical/discoverydetail?discoveryId=251"],
                      ["title":"夏至节气--二十四节气养生要旨","serviceurl":"http://mem.suwenjk.com/healthy-web/medical/discoverydetail?discoveryId=248"],
                      ["title":"你知道为什么要“冬吃萝卜夏吃姜”吗？","serviceurl":"http://mem.suwenjk.com/healthy-web/medical/discoverydetail?discoveryId=136"],
                      ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页";
        //注册自定义cell
        self.tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: HomeIdentifier)
        self.requestListData(isShow: true)
        //刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        //
        self.createTableViewHeaderView()
    }
    //创建头部
    func createTableViewHeaderView() {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: CommonMethod.shared.kScreenW, height: 210))
        headerView.backgroundColor = UIColor(red: 240/255.0, green: 241/255.0, blue: 242/255.0, alpha: 1)
        
        let cycleScrollView = SDCycleScrollView.init(frame: CGRect (x: 0, y: 0, width: CommonMethod.shared.kScreenW, height: 200), shouldInfiniteLoop: true, imageNamesGroup: cycleArray)
        cycleScrollView?.delegate = self
        
        headerView.addSubview(cycleScrollView!)
        
        self.tableView.tableHeaderView = headerView;
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
        request.addRequest(userid: "", type: "0", columnid: "0003", pagenum: "\(pagenum)", pagesize: "20");
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
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifier, for: indexPath)as! HomeTableViewCell
        
        var articleModel = ArticlelistModel()
        
        articleModel = self.listarray[indexPath.row] as! ArticlelistModel
        
        cell.showCellWithData(model: articleModel)
        
        return cell
     
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var articleModel = ArticlelistModel()
        
        articleModel = self.listarray[indexPath.row] as! ArticlelistModel
        
        self.jumpDetailControllerAction(title: articleModel.title, url: articleModel.serviceurl)
    }
    
    //轮播图点击事件
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        var dic = cycleModel[index]
        self.jumpDetailControllerAction(title: dic["title"]!, url: dic["serviceurl"]!)
    }
    //跳转事件
    func jumpDetailControllerAction(title:String, url:String) {
        
        let detailVC = DetailViewController()

        detailVC.hidesBottomBarWhenPushed = true
        
        detailVC.navTitle = title
        
        detailVC.serviceurl = url
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

