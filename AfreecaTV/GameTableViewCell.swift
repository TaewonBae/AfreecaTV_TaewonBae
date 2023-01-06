//
//  SportsTableViewCell.swift
//  AfreecaTV
//
//  Created by 배태원 on 2023/01/07.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nick: UILabel!
    @IBOutlet weak var view_cnt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
