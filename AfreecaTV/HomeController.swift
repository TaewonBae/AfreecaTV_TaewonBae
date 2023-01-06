//
//  HomeController.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/04.
//

import UIKit

//JSON 파싱을 쉽게 하기 위한 방송Data형 구조체 만들기 -> Codable 프로토콜 준수해야됨. / Tree 형태 : Objecct > broad > [broad_title, broad_thumb,,,,]
struct BroadData : Codable{
    let broad : [Broad] //배열로 되어있어서 배열로 선언
    let total_cnt : Int
}

struct Broad : Codable{
    let broad_title : String// 방송 제목
    let broad_thumb : String // 방속 썸네일 480*720
    let user_nick : String // BJ 닉네임
    let profile_img : String // BJ 프로필 이미지
    let total_view_cnt : String // 총 시청자 수
    let broad_start : String // 방송 시작 시간
    let broad_grade : String // 방송 등급
    let broad_bps : String // 방송 화질
    let broad_resolution : String // 방송 해상도
}


class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var broadData : BroadData? //(optional)broad property 변수 생성
    //    var categoryData : CategoryData? //(optional) category property 변수 생성
    //    var filterData : FilterData? // filter property 변수 생성
    @IBOutlet weak var home_tableview: UITableView! //home tableview
    @IBOutlet weak var home_navigationbar: UINavigationBar!
    @IBOutlet weak var home_nav_item: UINavigationItem!
    // 방송 리스트URL >> 전체 불러오려면 select_value=00130000 >> select_value=0, 나머지 URL은 AfreecaURL.swift 파일에 글로벌 변수 선언
    let afreecaURL = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=0&order_type=view_cnt&page_no=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation setting
        home_navigationbar.shadowImage = UIImage()
        setupNavigationBarItems()
        
        home_tableview.delegate = self
        home_tableview.dataSource = self
        
        getData()
        
    }
    
    //MARK: - URL 연결 및 Data Decode, 전체
    func getData(){
        // 1. URL 만들기
        if let url = URL(string: afreecaURL){
            // 2. URL Session 만들기
            let session = URLSession(configuration: .default)
            // 3. URL Session 인스턴스에게 task 주기 (data, header, error처리)
            let task = session.dataTask(with: url) { [self] (data, response, error) in
                // 에러가 났을경우 에러메시지 출력후 종료
                if error != nil{
                    print(error!)
                    return
                }
                //Json data에 data 넣기
                if let JSONdata = data {
                    //print(JSONdata, response!)//몇 byte 왔는지, response의 정보 출력
                    //let dataString = String(data: JSONdata, encoding: .utf8)
                    //print(dataString!) //JSON data 출력
                    //JSON 객체에서 데이터 타입의 인스턴스를 디코딩 + do ~ try catch로 에러 처리
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(BroadData.self, from: JSONdata)
                        self.broadData = decodedData
                        
                        DispatchQueue.main.async {
                            self.home_tableview.reloadData() //cell 업데이트   >> UI 관련 소스는 main Thread에서 처리
                        }
                        
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    //MARK: - URL 연결 및 Data Decode, 토크/캠방
    func getData2(){
        if let url = URL(string: AfreecaURL.AfreecaURL2){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                // 에러가 났을경우 에러메시지 출력후 종료
                if error != nil{
                    print(error!)
                    return
                }
                //Json data에 data 넣기
                if let JSONdata = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(BroadData.self, from: JSONdata)
                        self.broadData = decodedData
                        
                        DispatchQueue.main.async {
                            
                            self.home_tableview.reloadData()
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    //MARK: - URL 연결 및 Data Decode, 먹방/쿡방
    func getData3(){
        if let url = URL(string: AfreecaURL.AfreecaURL3){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                // 에러가 났을경우 에러메시지 출력후 종료
                if error != nil{
                    print(error!)
                    return
                }
                //Json data에 data 넣기
                if let JSONdata = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(BroadData.self, from: JSONdata)
                        self.broadData = decodedData
                        
                        DispatchQueue.main.async {
                            
                            self.home_tableview.reloadData()
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    //table view 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    //섹션의 row의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
    }
    //tableview cell 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = home_tableview.dequeueReusableCell(withIdentifier: "home_tableviewcell", for: indexPath) as! HomeTableViewCell
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
    //팁 버튼관련
    private func setupNavigationBarItems(){
        // 이미지 및 크기 조절
        let category_btn = UIButton(type: .custom)
        category_btn.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        category_btn.setImage(UIImage(named:"broad_list_gray"), for: .normal)
        category_btn.addTarget(self, action: #selector(onClick_list(_:)), for: UIControl.Event.touchUpInside)
        
        // UIBarButtonItem의 rightBarButtonItem 할당
        let categoryBarItem = UIBarButtonItem(customView: category_btn)
        let category_width = categoryBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        category_width?.isActive = true
        let category_height = categoryBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        category_height?.isActive = true
        home_nav_item.rightBarButtonItem = categoryBarItem
        
        //왼쪽 로고
        let logoImage = UIImage.init(named: "logo_text")
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
        home_nav_item.leftBarButtonItems = [negativeSpacer, imageItem]
        
    }
    
    //팁 버튼관련 클릭 이벤트
    @IBAction func onClick_list(_ sender: Any) {
        
        //action sheet title 지정
        let optionMenu = UIAlertController(title: nil, message: "카테고리", preferredStyle: .actionSheet)
        
        //옵션 초기화
        let action1 = UIAlertAction(title: "전체", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.getData()
            }
        })
        let action2 = UIAlertAction(title: "토크/캠방", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.getData2()
            }
        })
        let action3 = UIAlertAction(title: "먹방/쿡방", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.getData3()
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

//image url >> table cell 내에서 이미지 처리시 상당한 Delay 걸림
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleToFill){
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {return}
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill){
        guard let url = URL(string: link) else {return }
        downloaded(from: url, contentMode: mode)
    }
}
