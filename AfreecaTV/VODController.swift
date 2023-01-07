//
//  VODController.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/04.
//

import UIKit

class VODController: UIViewController{
    

    @IBOutlet weak var vod_navigationbar: UINavigationBar!
    @IBOutlet weak var vod_nav_item: UINavigationItem!
    
    @IBOutlet weak var vod_img1: UIImageView!
    @IBOutlet weak var vod_img2: UIImageView!
    @IBOutlet weak var vod_img3: UIImageView!
    @IBOutlet weak var vod_img4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vod_navigationbar.shadowImage = UIImage()
        setupNavigationBarItems()
        setVODImage()
        
        
    }
    private func setVODImage(){
        if let url_profile = NSURL(string:AfreecaURL.vodURL)
        {
            vod_img2.downloaded(from: url_profile as URL)
            vod_img2.layer.cornerRadius = vod_img2.bounds.width/2
            vod_img4.downloaded(from: url_profile as URL)
            vod_img4.layer.cornerRadius = vod_img2.bounds.width/2
            
        }
        if let url1 = NSURL(string:AfreecaURL.vodURL1)
        {
            vod_img1.downloaded(from: url1 as URL)

        }
        if let url2 = NSURL(string:AfreecaURL.vodURL2)
        {
            vod_img3.downloaded(from: url2 as URL)

        }
    }
    private func setupNavigationBarItems(){
        //왼쪽 로고
        let img = UIImage.init(named: "vod_text")
        let logoImageView = UIImageView.init(image: img)
        logoImageView.frame = CGRectMake(0, 0, 40, 34)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let space = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = -0
        let width1 = imageItem.customView?.widthAnchor.constraint(equalToConstant: 48)
        width1?.isActive = true
        let height1 = imageItem.customView?.heightAnchor.constraint(equalToConstant: 17)
        height1?.isActive = true
        vod_nav_item.leftBarButtonItems = [space, imageItem]
        
        // top right bar 버튼 이미지
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 20.0, y: 20.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"logo_img2"), for: .normal)
        menuBtn.backgroundColor = UIColor(red: 66/255, green: 121/255, blue: 254/255, alpha: 1)
        menuBtn.layer.cornerRadius = menuBtn.bounds.width/2

        // UIBarButtonItem의 rightBarButtonItem 할당
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let width2 = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 25)
        width2?.isActive = true
        let height2 = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 25)
        height2?.isActive = true
        vod_nav_item.rightBarButtonItem = menuBarItem
    }
  
}
