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
    public static var AfreecaURL4 = ""
    
    
    //챌린지 관련
    public static var challenge_goal_value = ""
    public static var challenge_totalday_value: Int = 0 // 7, 14, 30
    public static var challenge_duringday_value = "" // 기간 2022.06.22 - 2022. 06.29
    public static var challenge_rewardImg_value:Any?
    public static var challenge_rewardText_value = ""
    public static var challenge_status = ""
    public static var challenge_stamp:Int = 0 //스탬프 갯수
    public static var challenge_stamp_ox_value = ""
    public static var challenge_d_day_str = "" //d-18 or 성공 or 실패
    //챌린지 스탬프
    public static var challenge_number:Int = 1
    public static var challenge_stamp_dday_value = ""
    public static var challenge_stamp_duringday_value = ""
    public static var challenge_stamp_text1_value = ""
    public static var challenge_stamp_text2_value = ""
    public static var challenge_stamp_image_value:Any?
    public static var challenge_stamp_percent_value = ""
    public static var challenge_stamp_progress_value:Float = 0.00
    public static var challenge_stamp_current_status=""
    public static var challenge_stamp_diff_day:Int = 0 //스탬프 찍기위한 날짜 차이

    //챌린지 레코드
    public static var challenge_record_num:Int = 1
    //스탬프 Dialog1 관련
    public static var stamp_dialog1_ox_day = ""
    public static var stamp_dialog1_totalday:Int = 0
    public static var stamp_dialog1_stampNum:Int = 0
    public static var stamp_dialog1_current_status = ""
    public static var stamp_dialog1_goal = ""
    public static var stamp_dialog1_reward = ""
    
    //가족 정보 수정 관련
    public static var family_name = ""
    public static var family_image:Any?
    public static var family_child_birth = ""
    
}
