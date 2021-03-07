//
//  FoodList.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit
import SkeletonView
class FoodList: UITableView,UITableViewDelegate,UITableViewDataSource {
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        delegate = self
        dataSource = self
    }
    func updateData(_ newData:[FoodDetail]){
        data = newData
        reloadData()
    }
    var onItemSelected:((FoodDetail)->Void)?
    var data:[FoodDetail] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count == 0 ? 3:data.count
    }
    func provideImage(index:Int,newImage:UIImage?) {
        if(newImage == nil){
            return
        }
        data[index].image = newImage
        reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("item pressed here")
        onItemSelected?(data[indexPath.row])
    }
    func transverse(view:UIView,mode:Bool,exceptionView:UIView? = nil){
        if(view is UIButton || view is UILabel || view is UIImageView){
            view.isSkeletonable = true
            if(mode){
                view.showAnimatedGradientSkeleton()
            }else if(view != exceptionView){
                view.hideSkeleton()
            }
            
            
        }
        else{
            for child in view.subviews{
                transverse(view: child,mode:mode,exceptionView: exceptionView
                )
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"foodDetail") as! FoodSmallDetailCell
        if(data.count > 0){
        transverse(view: cell.contentView, mode: false,exceptionView: cell.foodImage)
            if(data[indexPath.row].image != nil){
            cell.foodImage.hideSkeleton()
            cell.foodImage.image = data[indexPath.row].image
            }
                let foodDetail = data[indexPath.row]
                cell.foodImage?.image = foodDetail.image
                cell.foodTitle.text = foodDetail.title
                cell.foodDescription.text = foodDetail.foodDescription
                if(foodDetail.promotion > 0){
                    cell.promotion.isHidden = false
                    cell.promotion.text = "\(foodDetail.promotion)% off"
                }else{
                    cell.promotion.isHidden = true
                }
                cell.cost.text = "Rs.\(foodDetail.cost)"
        
        }else{
            cell.foodDescription.numberOfLines = 2
            transverse(view: cell.contentView, mode: true)
            
        }
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
        

}
