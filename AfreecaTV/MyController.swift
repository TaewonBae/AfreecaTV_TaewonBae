//
//  MyController.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/04.
//

import UIKit

class MyController: UIViewController{
    
    @IBOutlet weak var my_navigationbar: UINavigationBar!
    @IBOutlet weak var my_nav_item: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        my_navigationbar.shadowImage = UIImage()
        setupNavigationBarItems()
    }
    private func setupNavigationBarItems(){
        //왼쪽 로고
        let img = UIImage.init(named: "my_text")
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
        my_nav_item.leftBarButtonItems = [space, imageItem]
        
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
        my_nav_item.rightBarButtonItem = menuBarItem
    }
}
