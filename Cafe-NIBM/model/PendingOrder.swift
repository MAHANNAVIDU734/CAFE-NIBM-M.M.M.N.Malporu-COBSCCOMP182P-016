//
//  PendingOrder.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import Foundation
struct PendingOrder:Codable {
    var foodName:String
    var quantity:Int
    var originalPrice:Int

    func asDictionary()->[String:Any]{
        let data = try? JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
    }
}
