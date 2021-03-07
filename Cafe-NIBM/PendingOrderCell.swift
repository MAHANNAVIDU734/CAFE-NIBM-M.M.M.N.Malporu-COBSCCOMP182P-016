//
//  PendingOrderCell.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit

class PendingOrderCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var qty: UILabel!
    var information:PendingOrder?
   
    var onQuantityChange : ((Int)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onBtnPress(_ sender: UIButton) {
        //2 - Plus
        //1 - Minus
        onQuantityChange?(sender.tag == 2 ? 1:-1)
    }
    

}
