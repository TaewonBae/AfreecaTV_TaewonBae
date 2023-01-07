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
