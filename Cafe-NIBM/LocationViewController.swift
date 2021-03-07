//
//  LocationViewController.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit
import SPPermissions

class LocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnShowPermission(_ sender: Any)
    {
        let controller = SPPermissions.dialog([.locationWhenInUse])
        
        controller.titleText = "Location permission"
        controller.present(on: self)
        
    }
    
}
