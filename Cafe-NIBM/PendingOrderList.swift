//
//  PendingOrderList.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit

class PendingOrderList:UITableView {
    
    var data:[PendingOrder] = []

    var onSumChanged:((_ quantity:Int,_ price:Int)->Void)?
    var heightConstraint:NSLayoutConstraint?
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        delegate = self
        dataSource = self
    }
    

    // MARK: - Table view data source
}

extension PendingOrderList : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func addOrder(foodDetail:FoodDetail){
        data.append(PendingOrder(foodName: foodDetail.title, quantity: 1, originalPrice: foodDetail.cost))
        insertRows(at: [IndexPath(row: data.count - 1, section: 0)], with: .top)
    }
    func resetList(){
        data = []
        reloadData()
        refreshChanges()
    }
    func updateSumValues(){
        var totalQuantity = 0
        var totalCost = 0
        for value in data{
            totalQuantity += value.quantity
            totalCost += value.originalPrice * value.quantity
        }
        onSumChanged?(totalQuantity,totalCost)
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("pending food inserted")
        let cell = tableView.dequeueReusableCell(withIdentifier: "pendingOrder", for: indexPath) as! PendingOrderCell
        cell.information = data[indexPath.row]
        cell.itemName.text = data[indexPath.row].foodName
        cell.itemPrice.text = "Rs \(String(data[indexPath.row].originalPrice * data[indexPath.row].quantity))"
        cell.qty.text = String(data[indexPath.row].quantity)
        cell.onQuantityChange = {change in
            let currentQty = Int(cell.qty.text!)!
            if(change == -1 && currentQty == 1){
                self.data.remove(at: indexPath.row)
                self.reloadData()
                self.refreshChanges()
                return
            }
            self.data[indexPath.row].quantity = currentQty + change
            
            cell.information?.quantity = self.data[indexPath.row].quantity
            cell.qty.text = String(currentQty + change)
            cell.itemPrice.text = String(cell.information!.originalPrice * cell.information!.quantity)
            self.updateSumValues()
        }
        refreshChanges()
        
        return cell
    }
    func refreshChanges() {
        if(data.count<5){
            heightConstraint?.constant = contentSize.height
        }
        // Configure the cell...
        updateSumValues()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
}
