//
//  HomeTableViewCell.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/05.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel! // 방송 제목
    @IBOutlet weak var thumb: UIImageView! // 방송 썸네일
    @IBOutlet weak var profile: UIImageView! // BJ 프로필
    @IBOutlet weak var nick: UILabel! // BJ 닉네임
    @IBOutlet weak var view_cnt: UILabel! // 시청자 수
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
