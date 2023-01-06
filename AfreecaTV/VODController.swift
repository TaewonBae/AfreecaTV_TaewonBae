//
//  VODController.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/04.
//

import UIKit

class VODController: UIViewController{
    //
    @IBOutlet weak var vod_navigationbar: UINavigationBar!
    @IBOutlet weak var vod_nav_item: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vod_navigationbar.shadowImage = UIImage()
        setupNavigationBarItems()
    }
    private func setupNavigationBarItems(){
        //왼쪽 로고
        let logoImage = UIImage.init(named: "vod_text")
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRectMake(0, 0, 40, 34)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -0
        let currWidth3 = imageItem.customView?.widthAnchor.constraint(equalToConstant: 48)
        currWidth3?.isActive = true
        let currHeight3 = imageItem.customView?.heightAnchor.constraint(equalToConstant: 17)
        currHeight3?.isActive = true
        vod_nav_item.leftBarButtonItems = [negativeSpacer, imageItem]
    }
    
}
