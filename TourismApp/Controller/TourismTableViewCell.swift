//
//  TourismTableViewCell.swift
//  TourismApp
//
//  Created by Ariq Hikari on 10/04/23.
//

import UIKit

class TourismTableViewCell: UITableViewCell {

    @IBOutlet weak var tourismLabel: UILabel!
    @IBOutlet weak var tourismLike: UILabel!
    @IBOutlet weak var tourismImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
