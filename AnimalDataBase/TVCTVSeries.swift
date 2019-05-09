//
//  TVCTVSeries.swift
//  AnimalDataBase
//
//  Created by Jeanette reyes on 4/30/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit

class TVCTVSeries: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblCreator: UILabel!
    @IBOutlet weak var lblProtagonists: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
