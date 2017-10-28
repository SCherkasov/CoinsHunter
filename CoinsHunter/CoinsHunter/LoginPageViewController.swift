//
//  LoginPageViewController.swift
//  CoinsHunter
//
//  Created by Stanislav Cherkasov on 22.10.17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstLoginTextField: UITextField!
    
    @IBOutlet weak var secondLoginTextField: UITextField!
    
    @IBOutlet weak var thirdLoginTextField: UITextField!
    
    @IBOutlet weak var fourthLoginTextField: UITextField!
    
    @IBOutlet weak var confirmYourPasscodeLabel: UILabel!
    
    
    var passcode1: String = ""
    var passcode2: String = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmYourPasscodeLabel.isHidden = true
        
        firstLoginTextField.addTarget(self, action: #selector(didChange(textField:)), for: UIControlEvents.editingChanged)
        secondLoginTextField.addTarget(self, action: #selector(didChange(textField:)), for: UIControlEvents.editingChanged)
        thirdLoginTextField.addTarget(self, action: #selector(didChange(textField:)), for: UIControlEvents.editingChanged)
        fourthLoginTextField.addTarget(self, action: #selector(didChange(textField:)), for: UIControlEvents.editingChanged)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstLoginTextField.becomeFirstResponder()
    }
    //////////
    
    
    
    func pw1(passcode: Any?) {
      
            passcode1 = (firstLoginTextField.text! + secondLoginTextField.text! + thirdLoginTextField.text! + fourthLoginTextField.text!)
            print("passcode1 \(passcode1)")
            
            firstLoginTextField.text = ""
            secondLoginTextField.text = ""
            thirdLoginTextField.text = ""
            fourthLoginTextField.text = ""
            confirmYourPasscodeLabel.isHidden = false
        
        }
    
    
    
    func pw2(passcode: Any?) {
        passcode2 = (firstLoginTextField.text! + secondLoginTextField.text! + thirdLoginTextField.text! + fourthLoginTextField.text!)
        print("passcode2 \(passcode2)")
        firstLoginTextField.text = ""
        secondLoginTextField.text = ""
        thirdLoginTextField.text = ""
        fourthLoginTextField.text = ""
        fourthLoginTextField.resignFirstResponder()
    }
    
    
    func sss(){
        if passcode1 == passcode2{
            
            performSegue(withIdentifier: "segue", sender: nil)
            print("Equal")
        }else{
            print("Different")
            confirmYourPasscodeLabel.text! = "try again.."
        isLoggedIn()
            
        }
    }
    
   
    
    
    func didChange(textField: UITextField) {
        
        let text = textField.text
        
        if text?.utf16.count == 1 {
            
                switch textField {
                case firstLoginTextField:
                secondLoginTextField.becomeFirstResponder()
                print(firstLoginTextField)
                case secondLoginTextField:
                thirdLoginTextField.becomeFirstResponder()
                case thirdLoginTextField:
                fourthLoginTextField.becomeFirstResponder()
                case fourthLoginTextField:
                fourthLoginTextField.becomeFirstResponder()
                
                firstLoginTextField.becomeFirstResponder()
                
                let pass: String = ""
                switch pass {
                case passcode1:
                    pw1(passcode: passcode1)
                case passcode2:
                    pw2(passcode: passcode2)
                 sss()
                default:
                    break
                }
            
                default: break
          
            }
            
        }
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        }
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    }


    


