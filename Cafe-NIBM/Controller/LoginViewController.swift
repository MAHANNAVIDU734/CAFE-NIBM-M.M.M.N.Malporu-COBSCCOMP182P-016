//
//  LoginViewController.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit
import Firebase
import FirebaseAuth
import SPPermissions


class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnLogin(_ sender: Any) {
        log()
    }
    
    @IBAction func btnForgetpassword(_ sender: Any) {
        ForgetPassword()
    }
    
    
    @IBAction func btnJoinwithCAFENIBM(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    func log()
    {
        if email.text?.isEmpty == true
        {
            
        let alert = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
            
         }
        
        if password.text?.isEmpty == true
        {
            
        let alert = UIAlertController(title: "Error", message: "Please enter your password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
            
         }
            
            
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {(authResult, err) in
            
            if let error = err as NSError?
            {
                    switch AuthErrorCode(rawValue: error.code)
                    {
                    
                    case .operationNotAllowed:

                        let alert = UIAlertController(title: "Error", message: "Email not found", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                        break
                        
                    case .userDisabled:
                    
                        let alert = UIAlertController(title: "Error", message: "This account has been disabled", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                        
                    break
                        
                    case .wrongPassword:
                    
                        let alert = UIAlertController(title: "Error", message: "Invalid Password", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                    break
                    case .invalidEmail:
                     
                        let alert = UIAlertController(title: "Error", message: "Enter a valid mail", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                    break
                        
                    default:
                        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription) ", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                        print("Error: \(error.localizedDescription)")
                    }
                  }
            
            else if(SPPermission.locationWhenInUse.isDenied)
            {
                
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let vc = storyboard.instantiateViewController(identifier: "Location" )
                    vc.modalPresentationStyle = .overFullScreen
             self.present(vc, animated: true)
                  
           }
            else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "Main" )
                       vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
      }
}
    
    func ForgetPassword()
    {
        if email.text?.isEmpty == true{
            let alert = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email.text!) { (error) in
            
        if let error = error as NSError?
        {
                switch AuthErrorCode(rawValue: error.code)
                {
                
                case .invalidEmail:
                    let alert = UIAlertController(title: "Error", message: "Enter a valid mail", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                    break
                
                    default:
                    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription) ", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                    print("Error: \(error.localizedDescription)")
                    
                    
                }
            
        }
            
        else
        {
            let alert = UIAlertController(title: "Reset", message: "Password reset link has been sent successfully to your email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return
    }
 
  }

}
