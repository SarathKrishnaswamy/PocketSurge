//
//  BillsTableViewCell.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 29/06/21.
//

import UIKit

class BillsTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var CatLbl: UILabel!
    @IBOutlet weak var AmountLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TitleLbl.font = UIFont.getMediumFontWith(size: TEXT_MEDIUM)
        CatLbl.font = UIFont.getRegularFontWith(size: TEXT_SMALL)
        AmountLbl.font = UIFont.getMediumFontWith(size: TEXT_SMALL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
