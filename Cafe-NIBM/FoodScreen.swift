//
//  FoodScreen.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit
import Firebase
class FoodScreen: UIViewController {

    @IBOutlet weak var activeOrderList: PendingOrderList!
    @IBOutlet weak var foodCatergories: FoodCategoryList!
    @IBOutlet weak var cartItemCounter: UILabel!
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    @IBOutlet weak var orderBtn: RoundButton!
    
    let db = Firestore.firestore()
    let imageStore = Storage.storage()
    
   @IBAction func onOrdered(_ sender: Any) {
    let activeOrderScreen = tabBarController!.viewControllers![1] as!OrderListController
        activeOrderScreen.newOrderToAdded = activeOrderList.data
        activeOrderList.resetList()
        tabBarController?.selectedViewController = activeOrderScreen
        
        //activeOrderScreen.addOrder(order:orderQty.data)
    }
    func loadData(catergory:String?){
        var foodList:[FoodDetail] = []
        var catergories:[String] = ["All"]
        var reference = db.collection("Foods").limit(to: 200)
        if(catergory != nil){
            reference = reference.whereField("type", isEqualTo:catergory!)
        }
        reference.getDocuments(completion: {snapshot,err in
            if(err != nil){
               print(err)
            }
            for (index,document) in (snapshot?.documents ?? []).enumerated(){
                let food = document.data()
                var foodDetail = FoodDetail(image: nil,
                    title: food["title"] as! String,
                    foodDescription: food["description"] as! String,
                    promotion:(food["promotion"] as? Int) ?? 0,
                    cost: food["cost"] as! Int,
                    phoneNumber: food["phoneNumber"] as! Int,
                    type: food["type"] as! String
                )
                if(food.keys.contains("promotion")){
                    foodDetail.promotion = food["promotion"] as! Int
                }
                if(catergory == nil){
                    if(!catergories.contains(foodDetail.type)){
                        catergories.append(foodDetail.type)
                    }
                }
                
                self.imageStore.reference(withPath: "foods/\(document.documentID).jpg").getData(maxSize: 1 * 1024 * 1024, completion: {data,imageErr in
                    
                    if(imageErr != nil){
//                        print(imageErr)
                    }else{
//                        self.foodList.provideImage(index: index, newImage: UIImage(data: data!))
                    }
                })
                foodList.append(foodDetail)
            }
            if(catergory==nil){
                self.foodCatergories.setData(catergories)
            }
//            self.foodList.updateData(foodList)
            })
    }
    
    override func viewDidLoad() {
        orderBtn.isHidden = true
        heightContraint.constant = 0
        
        activeOrderList.onSumChanged = {quantity,cost in
            print("quantity changed")
            self.orderBtn.isHidden = (cost == 0)
            self.cartItemCounter.text = "\(quantity) items"
            self.orderBtn.setTitle("Order (Rs. \(cost))", for: .normal)
        }
        activeOrderList.heightConstraint = heightContraint
        super.viewDidLoad()
//            let detailScreen = self.storyboard?.instantiateViewController(identifier: "foodDetailScreen") as! FoodDetailScreen
//            detailScreen.foodDetail = selectedDetail
//            detailScreen.onOrderedRecieved = {
//                self.activeOrderList.addOrder(foodDetail: selectedDetail)
//            }
//            self.navigationController?.pushViewController(detailScreen, animated: false)
//        }
//        foodCatergories.onCatergorySelected = {index,catergory in
//            self.loadData(catergory: index == 0 ? nil : catergory)
//        }
//        loadData(catergory: nil)
//    }
//    @IBAction func onSignOut(_ sender: Any) {
//        try? Auth.auth().signOut()
       // let authenticateScreen = storyboard!.instantiateViewController(identifier: "authScreen")
//        print("user signed out")
//        let rootNavigator = navigationController?.tabBarController?.navigationController
//        let loginScreen = storyboard!.instantiateViewController(withIdentifier: "authScreen")
//        rootNavigator!.setViewControllers([loginScreen], animated: true)
       
//    }
    

    
//}
    }
}
