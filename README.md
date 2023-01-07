# AfreecaTV-배태원
- [아프리카TV Open API]를 사용하여 방송 리스트를 조회하고 카테고리로 필터링할 수 있는 어플리케이션입니다.
- 리스트에서 방송을 클릭하면 방송 상세 정보를 확인할 수 있습니다.


![001](https://user-images.githubusercontent.com/43931412/211161982-5d581f41-b1d2-44e6-b799-090aa9f58060.png)

## LanchScreen & MainScreen
- 로딩화면과 나머지 화면입니다.
- MainController에 UITabBarController를 사용하여 홈, 게임, VOD, MY(즐겨찾기), 더보기(설정) 5가지 화면을 구성했습니다.
![002](https://user-images.githubusercontent.com/43931412/211161986-0d09f9b6-39c9-44a5-9603-8d5583b5978c.png)

## 홈 & 게임
- 홈 & 게임 화면은 Tableview와 tableviewcell로 구성되어있으며, cell의 UI 컴포넌트는 label, imageview이며, 해당 컴포넌트들은 (방송 제목, BJ닉네임, 방송 썸네일 이미지, BJ프로필 이미지, 시청자 수)를 표시해줍니다.
- 상단 NavigationBar의 오른쪽에있는 메뉴를 선택하면 카테고리 리스트를 불러올 수 있도록 AlertController를 통해 메뉴를 구성하였으며, 홈 카테고리에서는 (전체방송, 토크/캠방, 먹방/쿡방), 게임 카테고리에서는 (게임 전체, LOL, 배틀그라운드, 피파온라인4, 서든어택)을 불러올 수 있습니다.
![003](https://user-images.githubusercontent.com/43931412/211161992-2a849572-5c83-43a0-8133-d3b19bf73fff.png)
![004](https://user-images.githubusercontent.com/43931412/211161999-7bf078a6-007a-4ce4-8349-c89b44df13c5.png)

### 1.URL 연결 및 Data Pasing & Decoding
- url은 AfreecaURL 클래스에 어디에서나 접근할 수 있도록 카테고리 별로 전역 변수를 설정했습니다. (카테고리별로 'select_vaule'을 다르게 설정)
```swift
class AfreecaURL {
    public static var gameURL = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00040000&order_type=view_cnt&page_no=1" // 전체 0, 게임00040000
}
```
- URL 연결을 위한 getData함수
- getData 함수는 url을 string형으로 받기위해 string type의 parameter를 가집니다.(parameter에는 위에 설정한 전역 변수를 넣어줍니다.)
- getData 함수 안에서는 parameter로 받은 주소를 url형태로 바꿔준 뒤 URL Session을 만들고 URL Session 인스턴스에게 task(data, header, error처리)를 할당합니다.
- Json Data에 data를 넣어주고 JSON 객체에서 데이터 타입의 인스턴스를 디코딩해줍니다.  (do ~ try catch로 에러 처리)
- tableview를 reload 할 때 DispatchQueue를 통해 Main Thread가 아닌 별도의 Thread에서 처리한 뒤 Main Thread로 결과만을 전달하여 화면에 표시합니다.
```swift
//MARK: - URL 연결 및 Data Decode
func getData(url: String){
    // 1. URL 
    if let url = URL(string: url){
        // 2. URL Session 
        let session = URLSession(configuration: .default)
        // 3. URL Session dataTask 
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
                        self.home_tableview.reloadData() //cell 업데이트   
                    }
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
}
```
```swift
- JSON 파싱을 쉽게 하기 위한 BroadData형 구조체 선언해줍니다. -> Codable 프로토콜 준수 / Tree 형태 : Objecct > broad > [broad_title, broad_thumb,,,,]
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
```


- 서버에서 가져온 
![005](https://user-images.githubusercontent.com/43931412/211162001-ec67d9c3-4b00-41f6-b77c-8aa5fa79996f.png)


```swift
import UIKit
class MainController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

## 개발 환경

- 언어 : swift
- xcode : 14.2
- Deployment Target : iOS15

## API (아프리카TV OpenAPI)

https://developers.afreecatv.com/?szWork=openapi
