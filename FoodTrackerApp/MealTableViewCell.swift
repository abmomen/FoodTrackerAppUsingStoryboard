//
//  MealTableViewCell.swift
//  FoodTrackerApp
//
//  Created by Sharetrip-iOS on 9/22/19.
//  Copyright © 2019 Tbbd iOS. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    

}
