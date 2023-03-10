//
//  EsportsController.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/04.
//

import UIKit


class GameController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var broadData : BroadData? //(optional)broad property 변수 생성
    @IBOutlet weak var game_navigationbar: UINavigationBar!
    @IBOutlet weak var game_nav_item: UINavigationItem!
    @IBOutlet weak var game_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        game_navigationbar.shadowImage = UIImage()
        setupNavigationBarItems()
        
        game_tableview.delegate = self
        game_tableview.dataSource = self
        
        getData(url: AfreecaURL.gameURL)
        
        
    }
    
    //table view 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    //섹션의 row의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    //tableview cell 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = game_tableview.dequeueReusableCell(withIdentifier: "game_tableviewcell", for: indexPath) as! GameTableViewCell
        // cell에 text, image 설정
        cell.title.text = broadData?.broad[indexPath.row].broad_title
        cell.nick.text = broadData?.broad[indexPath.row].user_nick
        cell.view_cnt.text = broadData?.broad[indexPath.row].total_view_cnt
        //cell 이미지 corner 설정 480 * 270 >> imageview 16:9
        cell.profile.layer.masksToBounds = true
        cell.profile.layer.cornerRadius = cell.profile.bounds.width/2
        cell.thumb.layer.masksToBounds = true
        cell.thumb.layer.cornerRadius = 10
        // BJ 프로필, 썸네일 이미지 cell에 할당
        DispatchQueue.main.async { [self] in
            //optional data >> string >> url
            if let profile_str = broadData?.broad[indexPath.row].profile_img
            {
                let profile_str2 = "https:" + profile_str
                if let profile_url = NSURL(string:profile_str2)
                {
                    cell.profile.downloaded(from: profile_url as URL)
                    
                }
            }
            if let thumb_str = broadData?.broad[indexPath.row].broad_thumb
            {
                let thumb_str2 = "https:" + thumb_str
                if let thumb_url = NSURL(string:thumb_str2)
                {
                    cell.thumb.downloaded(from: thumb_url as URL)
                }
            }
            
        }
        
        return cell
    }
    //섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cell 클릭 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 방송 상세 정보 alert로 띄우기 (Bj이름, 방송시작시간, 방송해상도, 방송화질, 총 시청자 수)
        let str_nick : String = ""+(broadData?.broad[indexPath.row].user_nick)!
        let str_broad_start : String = ""+(broadData?.broad[indexPath.row].broad_start)!
        let grade = ""+(broadData?.broad[indexPath.row].broad_grade)!
        var str_broad_grade : String = ""
        if(grade=="19"){
            str_broad_grade = "연령 제한 방송(19세)"
        }else{
            str_broad_grade = "일반 방송"
        }
        let str_broad_bps : String = ""+(broadData?.broad[indexPath.row].broad_bps)!
        let str_resolution : String = ""+(broadData?.broad[indexPath.row].broad_resolution)!
        let str_total_view_cnt : String = ""+(broadData?.broad[indexPath.row].total_view_cnt)!
        
        let alert = UIAlertController(title: str_nick+"님의 방송 상세 정보", message: "방송 시작 시간 : "+str_broad_start+"\n방송등급 : "+str_broad_grade+"\n방송 화질 : "+str_broad_bps+"kbps(최대 8000kbps)\n방송 해상도 : "+str_resolution+"\n총 시청자 수 : "+str_total_view_cnt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in}))
        self.present(alert, animated: true, completion: nil)
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
        game_nav_item.rightBarButtonItem = menuBarItem2
        
        //왼쪽 로고
        let logoImage = UIImage.init(named: "game_text")
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRectMake(-40, 0, 50, 34)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -25
        let currWidth3 = imageItem.customView?.widthAnchor.constraint(equalToConstant: 52)
        currWidth3?.isActive = true
        let currHeight3 = imageItem.customView?.heightAnchor.constraint(equalToConstant: 20)
        currHeight3?.isActive = true
        game_nav_item.leftBarButtonItems = [negativeSpacer, imageItem]
    }
    
    //팁 버튼관련 클릭 이벤트
    @IBAction func onClick_list(_ sender: Any) {
        
        //action sheet title 지정
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        //옵션 초기화
        let action1 = UIAlertAction(title: "게임 전체", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.getData(url: AfreecaURL.gameURL)
            }
        })
        //        action1.setValue(UIImage(named: "logo_text")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
        let action2 = UIAlertAction(title: "LOL", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.getData(url: AfreecaURL.gameURL1)
            }
        })
        let action3 = UIAlertAction(title: "배틀그라운드", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.getData(url: AfreecaURL.gameURL2)
            }
        })
        let action4 = UIAlertAction(title: "피파온라인4", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.getData(url: AfreecaURL.gameURL3)
            }
        })
        let action5 = UIAlertAction(title: "서든어택", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.getData(url: AfreecaURL.gameURL4)
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
        optionMenu.addAction(cancelAction)
        //show
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    //MARK: - URL 연결 및 Data Decode 
    func getData(url: String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let JSONdata = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(BroadData.self, from: JSONdata)
                        self.broadData = decodedData
                        DispatchQueue.main.async {
                            self.game_tableview.reloadData() //cell 업데이트   >> UI 관련 소스는 main Thread에서 처리
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
