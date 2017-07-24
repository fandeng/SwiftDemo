//
//  ShowPhotoViewController.swift
//  SwiftDemo
//
//  Created by 樊登 on 2017/7/21.
//  Copyright © 2017年 樊登. All rights reserved.
//

import UIKit

class ShowPhotoViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imgArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "展示选择的图片"
        self.createBackButton()
        collectionView.register(UINib.init(nibName: "ShowPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "showphoto_id")
    }
    
    // MARK: UICollectionViewDataSource''
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (CommonMethod.shared.kScreenW-40)/2, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ShowPhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "showphoto_id", for: indexPath) as! ShowPhotoCollectionViewCell
        
        let assets = imgArray[indexPath.row] as! LGPhotoAssets
        
        cell.imgView.image = assets.originImage()!
        
        return cell
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
