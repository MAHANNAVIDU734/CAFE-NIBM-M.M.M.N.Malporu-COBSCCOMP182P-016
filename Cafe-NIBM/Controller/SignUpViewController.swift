//
//  SignUpViewController.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobilenumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnSignup(_ sender: Any) {
        Signup()
    
    }
    
    
func emailValidate(_ email: String)-> Bool
{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
           
func passwordValidate(_ spassword: String) -> Bool
{
    let minLength = 6
    return spassword.count >= minLength
    
}
    
    
    func Signup()
        
    {
       if !emailValidate(email.text!)
        {
            let alert = UIAlertController(title: "Error", message: "Enter a valid Email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if email.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Error", message: "Email field cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if !passwordValidate(password.text!)
        {
            let alert = UIAlertController(title: "Error", message: "Enter a strong password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if password.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Error", message: "Password cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if (confirmpassword.text != password.text)
        {
            let alert = UIAlertController(title: "Error", message: "Password mismatch", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if confirmpassword.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Error", message: "Please confirm your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if mobilenumber.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Error", message: "Please Enter Correct Phone Number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        
       Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
        
            if let error = error as NSError?
            {
                
            switch AuthErrorCode(rawValue: error.code)
            {
            
            case .operationNotAllowed:
                
                let alert = UIAlertController(title: "Error", message: "Email is not allowed..!", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                break
                
            case .emailAlreadyInUse:
                let alert = UIAlertController(title: "Error", message: "The email address is already in use by another account.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                break
              
            case .invalidEmail:
                let alert = UIAlertController(title: "Error", message: "The email address is badly formatted. ", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                break
                
            case .weakPassword:
                let alert = UIAlertController(title: "Error", message: "Password must be greater than 6 characters", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                break
                
            default:
                let alert = UIAlertController(title: "Error", message: "An error occured while performing this action", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
            }
        }
        
        else
        {
          let newUser = Auth.auth().currentUser
            _ = newUser?.email
            
          let alert = UIAlertController(title: "Success", message: "User Registered Sucess", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                      self.present(alert, animated: true, completion: nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Thankyou")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        }
          return

    }
    
  }
    
}
