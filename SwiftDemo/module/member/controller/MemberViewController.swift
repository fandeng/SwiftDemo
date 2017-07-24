//
//  MemberViewController.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/21.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

let MemberIdentifier = "membercell_id"

class MemberViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, LGPhotoPickerViewControllerDelegate,LGPhotoPickerBrowserViewControllerDataSource, LGPhotoPickerBrowserViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var listarray = ["照片选择器","照片浏览器","网络图片浏览器","单张拍照","手动连拍"]
    
    var photoArray = [AnyObject]()
    var urlArray = [AnyObject]()
    var showType = LGShowImageType(rawValue: 0)
    let cycleArray = ["http://mem.suwenjk.com/healthy-web/downfile?fileId=170719171901868466606942223939",
                      "http://mem.suwenjk.com/healthy-web/downfile?fileId=170719172453527600651198291571",
                      "http://mem.suwenjk.com/healthy-web/downfile?fileId=170626155939659297311226863446",
                      "http://mem.suwenjk.com/healthy-web/downfile?fileId=170510113944696342024268454411"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "服务"
        //注册自定义cell
        self.tableView.register(UINib.init(nibName: "MemberTableViewCell", bundle: nil), forCellReuseIdentifier: MemberIdentifier)
        self.prepareForPhotoBroswerWithImage()
        self.prepareForPhotoBroswerWithURL()
    }
    /**
     *  给照片浏览器传image的时候先包装成LGPhotoPickerBrowserPhoto对象
     */
    func prepareForPhotoBroswerWithImage() {
        
        for i in 0..<5 {
            let photo = LGPhotoPickerBrowserPhoto()
            photo.photoImage = UIImage(named: "broswerPic\(i).jpg")
            photoArray.append(photo)
        }
    }
    /**
     *  给照片浏览器传URL的时候先包装成LGPhotoPickerBrowserPhoto对象
     */
    func prepareForPhotoBroswerWithURL() {
        for url in cycleArray {
            let photo = LGPhotoPickerBrowserPhoto()
            photo.photoURL = NSURL(string: url)! as URL
            urlArray.append(photo)
        }
    }
    /**
     *  初始化相册选择器
     */
    func presentPhotoPickerViewControllerWithStyle(style:LGShowImageType) {
        
        let pickerVc = LGPhotoPickerViewController.init(show: style)
        pickerVc?.status = PickerViewShowStatus(rawValue: 1)!;
        pickerVc?.maxCount = 9;   // 最多能选9张图片
        pickerVc?.delegate = self;
        self.showType = style;
        pickerVc?.showPickerVc(self)
    }
    /**
     *  初始化图片浏览器
     */
    func pushPhotoBroswerWithStyle(style:LGShowImageType) {
        let BroswerVC = LGPhotoPickerBrowserViewController.init();
        BroswerVC.delegate = self;
        BroswerVC.dataSource = self;
        BroswerVC.showType = style;
        self.showType = style;
        self.present(BroswerVC, animated: true, completion: nil)
    }
    /**
     *  初始化自定义相机（单拍）
     */
    func presentCameraSingle() {
        let cameraVC = ZLCameraViewController.init();
        // 拍照最多个数
        cameraVC.maxCount = 1;
        // 单拍
        cameraVC.cameraType = ZLCameraType(rawValue: 0)!;
        cameraVC.callback = { (cameraPhoto) -> () in
            print(cameraPhoto as! [AnyObject]);
        }
        cameraVC.showPickerVc(self)
    }
    /**
     *  初始化自定义相机（连拍）
     */
    func presentCameraContinuous() {
        let cameraVC = ZLCameraViewController.init();
        // 拍照最多个数
        cameraVC.maxCount = 9;
        // 单拍
        cameraVC.cameraType = ZLCameraType(rawValue: 1)!;
        cameraVC.callback = { (cameraPhoto) -> () in
            print(cameraPhoto as! [AnyObject]);
        }
        cameraVC.showPickerVc(self)
    }
    //tableView协议方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listarray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MemberTableViewCell = tableView.dequeueReusableCell(withIdentifier: MemberIdentifier, for: indexPath)as! MemberTableViewCell
        
        cell.titleLabel.text = listarray[indexPath.row]
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.row) {
        case 0:
            self.presentPhotoPickerViewControllerWithStyle(style: LGShowImageType(rawValue: 0)!)
            break;
        case 1:
            self.pushPhotoBroswerWithStyle(style: LGShowImageType(rawValue: 1)!);
            break;
        case 2:
            self.pushPhotoBroswerWithStyle(style: LGShowImageType(rawValue: 2)!);
            break;
        case 3:
            self.presentCameraSingle()
            break;
        case 4:
            self.presentCameraContinuous()
            break;
        default:
            break;
        }
    }
    //LGPhotoPickerViewControllerDelegate
    func pickerViewControllerDoneAsstes(_ assets: [Any]!, isOriginal original: Bool) {
        
        let detailVC = ShowPhotoViewController()
        
        detailVC.hidesBottomBarWhenPushed = true
        
        detailVC.imgArray = assets! as [AnyObject]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    //LGPhotoPickerBrowserViewControllerDataSource
    func photoBrowser(_ photoBrowser: LGPhotoPickerBrowserViewController!, numberOfItemsInSection section: UInt) -> Int {
        if (self.showType == LGShowImageType(rawValue: 1)!) {
            return photoArray.count;
        } else if (self.showType == LGShowImageType(rawValue: 2)!) {
            return urlArray.count;
        } else {
            print("非法数据源");
            return 0;
        }
    }
    func photoBrowser(_ pickerBrowser: LGPhotoPickerBrowserViewController!, photoAt indexPath: IndexPath!) -> LGPhotoPickerBrowserPhotoProtocol! {
        
        if (self.showType == LGShowImageType(rawValue: 1)!) {
            
            return photoArray[indexPath.item] as! LGPhotoPickerBrowserPhotoProtocol
        } else if (self.showType == LGShowImageType(rawValue: 2)!) {
            return urlArray[indexPath.item] as! LGPhotoPickerBrowserPhotoProtocol
        } else {
            print("非法数据源");
            return nil;
        }
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
