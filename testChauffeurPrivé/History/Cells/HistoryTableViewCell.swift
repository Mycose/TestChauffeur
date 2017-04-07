//
//  HistoryTableViewCell.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright © 2017 Clément Morissard. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(address: String) {
        nameLabel.text = address
    }

}
