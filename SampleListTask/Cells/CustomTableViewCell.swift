//
//  CustomTableViewCell.swift
//  SampleListTask
//
//  Created by Narendra Biswa on 03/04/20.
//  Copyright © 2020 Narendra Biswa. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var rowImageView: UIImageView!
    @IBOutlet weak var rowTitleLabel: UILabel!
    @IBOutlet weak var rowDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
