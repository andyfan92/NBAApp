//
//  PlayerTableViewCell.swift
//  NBAStat
//
//  Created by fan on 12/9/21.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var fullNamelbl: UILabel!
    
    @IBOutlet weak var yearsProlbl: UILabel!
    
    @IBOutlet weak var collegeNamelbl: UILabel!
    
    
    @IBOutlet weak var affiliationlbl: UILabel!
    
    
    @IBOutlet weak var heightlbl: UILabel!
    
    @IBOutlet weak var weightlbl: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
