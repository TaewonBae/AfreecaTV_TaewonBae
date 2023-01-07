//
//  AfreecaURL.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/07.
//

import Foundation

struct AfreecaURL {

    //1. URL
    
    public static var AfreecaURL1 = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=0&order_type=view_cnt&page_no=1" // 전체 0
    public static var AfreecaURL2 = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00130000&order_type=view_cnt&page_no=1" //토크/캠방 00130000
    public static var AfreecaURL3 = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00330000&order_type=view_cnt&page_no=1" //먹방/쿡방 00330000
    
    public static var gameURL = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00040000&order_type=view_cnt&page_no=1" // 게임 00040000
    
    public static var gameURL1 = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00040019&order_type=view_cnt&page_no=1" // LOL 00040019

    public static var gameURL2 = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00040066&order_type=view_cnt&page_no=1" // 배틀그라운드 00040066
    public static var gameURL3 = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00040070&order_type=view_cnt&page_no=1" // 피파온라인4 00040070
    public static var gameURL4 = "https://openapi.afreecatv.com/broad/list?client_id=af_mobilelab_dev_e0f147f6c034776add2142b425e81777&select_key=cate&select_value=00040005&order_type=view_cnt&page_no=1" // 서든어택 00040005
    //VOD
    public static var vodURL:String = "https://stimg.afreecatv.com/LOGO/af/afligue101/afligue101.jpg"
    public static var vodURL1:String = "https://iflv14.afreecatv.com/save/afreeca/station/2023/0102/06/thumb/1672609802923248_L_7.jpg"
    public static var vodURL2:String = "https://iflv14.afreecatv.com/save/afreeca/station/2023/0102/03/thumb/1672596111595410_L_7.jpg"

}
