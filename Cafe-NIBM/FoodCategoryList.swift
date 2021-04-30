//
//  FoodCategoryList.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit

class FoodCategoryList: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    var selectedIndex = 0
    var data:[String] = []
    var onCatergorySelected : ((Int,String)->Void)?
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        delegate = self
        dataSource = self
    }
    func setData(_ newData:[String]){
        data = newData
        reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCatergoryCell", for: indexPath) as! FoodCategoryCell
        cell.bodyBtn.setTitle(data[indexPath.row], for:.normal)
        if(selectedIndex == indexPath.row){
            cell.bodyBtn.backgroundColor = .link
            cell.bodyBtn.setTitleColor(.white, for: .normal)
            cell.tag = 2
        }else if(cell.tag == 2){
            cell.bodyBtn.backgroundColor = nil
            cell.bodyBtn.setTitleColor(.black, for: .normal)
            cell.tag = 0
        }
        cell.userPressBtn = {button in
            self.selectedIndex = indexPath.row
            self.reloadData()
            self.onCatergorySelected?(indexPath.row,self.data[indexPath.row])
            //self.reloadItems(at: indexesToUpdate)
        }
//        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

}
