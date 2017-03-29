//
//  CustomTableViewCell.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2016/12/10.
//  Copyright © 2016年 kinokodata. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
