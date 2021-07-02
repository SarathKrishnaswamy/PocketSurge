//
//  CategoryTableViewCell.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 02/07/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var ThumbnailImage: UIImageView!
    @IBOutlet weak var CategoryLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
