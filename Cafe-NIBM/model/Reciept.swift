//
//  Reciept.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import Foundation
struct Reciept:Codable {
    var date:String
    var products:[PendingOrder]
    var totalCost:Int = 0
    
    func asDictionary()->[String:Any]{
        let data = try? JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
    }
    static func decodeAsStruct(data:[String:Any])->Reciept{
        let serializedData = try! JSONSerialization.data(withJSONObject: data, options: [])
        return try! JSONDecoder().decode(Reciept.self, from: serializedData)
    }
}
