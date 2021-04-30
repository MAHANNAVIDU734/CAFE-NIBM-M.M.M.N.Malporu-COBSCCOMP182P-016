//
//  OrderListController.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class OrderListController: UITableViewController {
    let db = Firestore.firestore()
    let auth = Auth.auth()
    var newOrderToAdded:[PendingOrder]?

    
    var finishedOrder:[Reciept] = []{
        didSet{
            updatePastOrders(finishedOrder)
        }
    }
    func updatePastOrders(_ reciepts :[Reciept]) {
        db.document("user/\(auth.currentUser!.uid)").updateData(["history":FieldValue.arrayUnion(reciepts.map{$0.asDictionary()}) ])
    }
    var data:[OrderStatus] = []//[OrderStatus(orderID: 345, status: "On the way")]
    var didDataLoaded = false
    let statusConstants:[Int:String] = [
        1:"waiting to accept",
        2:"Preparing Food",
        3:"ready to pickup"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("created")
        db.document("orders/\(auth.currentUser!.uid)")
            .addSnapshotListener({documentSnapshot,err in
            
            if(err == nil){
                if !documentSnapshot!.exists{
                    return
                }
                var expiredOrdersPresent = false
                self.data = []
                let orderList = (documentSnapshot!.data()?["orderList"] ?? []) as! [[String:Any]]
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = DateFormatingStrings.cellDateFormat
                for order in orderList{
                    let orderStatus = self.mapDictionaryToData(order: order)
                    if orderStatus.status > 3{
                        expiredOrdersPresent = true
                        self.finishedOrder.append(Reciept(date: dateFormater.string(from: Date()), products: orderStatus.orderInfo!))
                    }else{
                        self.data.append(orderStatus)
                    }
                    
                }
                if(expiredOrdersPresent){
                    self.data = self.data.filter{$0.status < 4}
                    self.db.document("orders/\(self.auth.currentUser!.uid)").updateData(["orderList":self.mapDataToDictionary()])
                }
            }
            if(!self.didDataLoaded && self.newOrderToAdded != nil){
                self.addOrderToData()
                self.db.document("orders/\(self.auth.currentUser!.uid)").updateData(["orderList":self.mapDataToDictionary()])
                
                self.newOrderToAdded = nil
            }
            self.tableView.reloadData()
            self.didDataLoaded = true
        })
 
    }
    func addOrderToData(){
        print("adding an order")
        self.data.append(OrderStatus(orderID: (self.data.map({$0.orderID}).max() ?? 99) + 1, status: 1, orderInfo:newOrderToAdded))
    }
    func mapDictionaryToData(order:[String:Any])->OrderStatus{
        return OrderStatus.decodeAsStruct(data: order)
    }
    func mapDataToDictionary()->[[String:Any]]{
        
        return data.map({$0.asDictionary()})

    }
    override func viewWillAppear(_ animated: Bool) {
        if(newOrderToAdded != nil && didDataLoaded){
            print("new order added")
            //self.data.append(OrderStatus(orderID: (self.data.map({$0.orderID}).max() ?? 99) + 1, status: 1))
            addOrderToData()
            self.newOrderToAdded = nil
            db.document("orders/\(auth.currentUser!.uid)").updateData(["orderList":mapDataToDictionary()])
        }
    }

 
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        cell.orderID.text = String(data[indexPath.row].orderID)
//        if(data[indexPath.row].status == 3){
//            cell.orderStatus.textColor = .green
//        }
//        cell.orderStatus.text = statusConstants[data[indexPath.row].status]
//        return cell
    }
    

