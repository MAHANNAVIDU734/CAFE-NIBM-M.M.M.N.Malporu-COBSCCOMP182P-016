//
//  FoodDetailScreen.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit

class FoodDetailScreen: UIViewController {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    @IBOutlet weak var promotion: UIPaddingLabel!
    var foodDetail:FoodDetail!
    var onOrderedRecieved : (()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImage.image = foodDetail.image
        name.text = foodDetail.title
        price.text = "Rs. \(foodDetail.cost)"
        foodDescription.text = foodDetail.foodDescription
        if(foodDetail.promotion == 0){
            promotion.isHidden = true
        }else{
            promotion.text = "\(foodDetail.promotion)% OFF"
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onMakePhoneCall(_ sender: Any) {
        UIApplication.shared.open(URL(string:"tel://\(foodDetail.phoneNumber)")!, options: [:], completionHandler: nil)
    }
    @IBAction func onOrder(_ sender: RoundButton) {
        onOrderedRecieved?()
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
