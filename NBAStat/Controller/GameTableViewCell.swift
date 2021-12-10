//
//  GameTableViewCell.swift
//  NBAStat
//
//  Created by fan on 12/9/21.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var hTeamScorelbl: UILabel!
    @IBOutlet weak var vTeamScorelbl: UILabel!
    @IBOutlet weak var hTeamlbl: UILabel!
    @IBOutlet weak var vTeamlbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
