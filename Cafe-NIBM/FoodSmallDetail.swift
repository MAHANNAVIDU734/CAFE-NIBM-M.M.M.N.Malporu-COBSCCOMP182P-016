//
//  FoodSmallDetailCell.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit

class FoodSmallDetail: UITableView {

    @IBOutlet weak var promotion: UIPaddingLabel!
    @IBOutlet weak var foodDescription: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
