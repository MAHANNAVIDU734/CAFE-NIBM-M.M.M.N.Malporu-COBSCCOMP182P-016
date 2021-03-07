//
//  FoodCategoryCell.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//
import UIKit

class FoodCategoryCell: UICollectionViewCell {
    @IBOutlet weak var bodyBtn: RoundButton!
    var userPressBtn:((UIButton)->Void)?
    @IBAction func onBtnPress(_ sender: UIButton) {
        userPressBtn?(sender)
    }
    
    
}
