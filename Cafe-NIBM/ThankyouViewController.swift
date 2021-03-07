//
//  ThankYouViewController.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit
import Firebase

class ThankyouViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnClicktoLogin(_ sender: Any) {
    
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    

}
