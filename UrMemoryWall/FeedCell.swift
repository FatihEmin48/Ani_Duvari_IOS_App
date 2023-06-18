//
//  FeedCell.swift
//  AniDuvarim
//
//  Created by Fatih Karahan on 18.06.2023.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var yorumText: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var emailText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
