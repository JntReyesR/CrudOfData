//
//  TVCAnimals.swift
//  
//
//  Created by Jeanette Reyes on 4/29/19.
//

import UIKit

class TVCAnimals: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblKind: UILabel!
    @IBOutlet weak var lblClassification: UILabel!
    @IBOutlet weak var lblLessons: UILabel!
    @IBOutlet weak var lblCharacteristics: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
