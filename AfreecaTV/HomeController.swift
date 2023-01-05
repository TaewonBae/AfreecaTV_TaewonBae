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
}
struct Broad : Codable{
    let broad_title : String// 방송 제목
    let broad_thumb : String // 방속 썸네일 480*720
    let user_nick : String // BJ 닉네임
    let profile_img : String // BJ 프로필 이미지
    let total_view_cnt : String // 총 시청자 수
}
class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var broadData : BroadData? //(optional)property 변수 생성
    
    @IBOutlet weak var home_tableview: UITableView!
    // 방송 리스트URL
    let afreecaURL = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00130000&order_type=view_cnt&page_no=1"
    //    let afreecaURL2 = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00130000&order_type=view_cnt&page_no=1&callback=callback"
    //카테고리 URL
    //    let afreecaURL = "https://openapi.afreecatv.com/broad/category/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&locale=ko_KR"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        home_tableview.delegate = self
        home_tableview.dataSource = self
        getData()
    }
    func getData(){
        // 1. URL 만들기
        if let url = URL(string: afreecaURL){
            // 2. URL Session 만들기
            let session = URLSession(configuration: .default)
            // 3. URL Session 인스턴스에게 task 주기 (data, header, error처리)
            let task = session.dataTask(with: url) { (data, response, error) in
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
        let cell = home_tableview.dequeueReusableCell(withIdentifier: "home_tableviewcell", for: indexPath) as! HomeTableViewCell
        // cell에 text, image 설정
        cell.title.text = broadData?.broad[indexPath.row].broad_title
        cell.nick.text = broadData?.broad[indexPath.row].user_nick
        cell.view_cnt.text = broadData?.broad[indexPath.row].total_view_cnt
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
        print(indexPath.description)
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
