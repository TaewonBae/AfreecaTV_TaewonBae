//
//  EsportsController.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/04.
//

import UIKit

class SportsController: UIViewController{
    
    @IBOutlet weak var sports_navigationbar: UINavigationBar!
    @IBOutlet weak var sports_nav_item: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        sports_navigationbar.shadowImage = UIImage()
        setupNavigationBarItems()
    }
    private func setupNavigationBarItems(){
        // 이미지 및 크기 조절
        let menuBtn2 = UIButton(type: .custom)
        menuBtn2.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        menuBtn2.setImage(UIImage(named:"broad_list_gray"), for: .normal)
        menuBtn2.addTarget(self, action: #selector(onClick_list(_:)), for: UIControl.Event.touchUpInside)
        
        // UIBarButtonItem의 rightBarButtonItem 할당
        let menuBarItem2 = UIBarButtonItem(customView: menuBtn2)
        let currWidth2 = menuBarItem2.customView?.widthAnchor.constraint(equalToConstant: 30)
        currWidth2?.isActive = true
        let currHeight2 = menuBarItem2.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight2?.isActive = true
        sports_nav_item.rightBarButtonItem = menuBarItem2
        
        //왼쪽 로고
        let logoImage = UIImage.init(named: "sports_text")
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRectMake(-40, 0, 50, 34)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -25
        let currWidth3 = imageItem.customView?.widthAnchor.constraint(equalToConstant: 100)
        currWidth3?.isActive = true
        let currHeight3 = imageItem.customView?.heightAnchor.constraint(equalToConstant: 34)
        currHeight3?.isActive = true
        sports_nav_item.leftBarButtonItems = [negativeSpacer, imageItem]
        
    }
   
    //팁 버튼관련 클릭 이벤트
    @IBAction func onClick_list(_ sender: Any) {
        
        //action sheet title 지정
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        //옵션 초기화
        let action1 = UIAlertAction(title: "전체", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("전체 보기")
            DispatchQueue.main.async {
                
            }
        })
        //        action1.setValue(UIImage(named: "logo_text")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
        let action2 = UIAlertAction(title: "스포츠", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("성공한 챌린지")
            DispatchQueue.main.async {
                
            }
        })
        let action3 = UIAlertAction(title: "게임", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {

            }
        })
        let action4 = UIAlertAction(title: "보이는 라딩", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("현재 챌린지")
            DispatchQueue.main.async {
                
            }
        })
        let action5 = UIAlertAction(title: "과거순", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("과거순")
            DispatchQueue.main.async {
                
            }
            
        })
        let action6 = UIAlertAction(title: "최신순", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("최신순")
            DispatchQueue.main.async {
                
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        //action sheet에 옵션 추가.
        optionMenu.addAction(action1)
        optionMenu.addAction(action2)
        optionMenu.addAction(action3)
        optionMenu.addAction(action4)
        optionMenu.addAction(action5)
        optionMenu.addAction(action6)
        optionMenu.addAction(cancelAction)
        //show
        self.present(optionMenu, animated: true, completion: nil)
    }
}
