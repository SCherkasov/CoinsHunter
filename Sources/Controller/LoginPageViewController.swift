//
//  LoginPageViewController.swift
//  CoinsHunter
//
//  Created by Stanislav Cherkasov on 22.10.17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var firstLoginTextField: UITextField!
    
    @IBOutlet weak var secondLoginTextField: UITextField!
    
    @IBOutlet weak var thirdLoginTextField: UITextField!
    
    @IBOutlet weak var fourthLoginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLoginTextField.addTarget(self, action: #selector(didChange(textField:)), for: UIControlEvents.editingChanged)
        secondLoginTextField.addTarget(self, action: #selector(didChange(textField:)), for: UIControlEvents.editingChanged)
        thirdLoginTextField.addTarget(self, action: #selector(didChange(textField:)), for: UIControlEvents.editingChanged)
        fourthLoginTextField.addTarget(self, action: #selector(didChange(textField:)), for: UIControlEvents.editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstLoginTextField.becomeFirstResponder()
    }
    
    func didChange(textField: UITextField) {
        
        let text = textField.text
        
        if text?.utf16.count == 1 {
            switch textField {
            case firstLoginTextField:
                secondLoginTextField.becomeFirstResponder()
            case secondLoginTextField:
                thirdLoginTextField.becomeFirstResponder()
            case thirdLoginTextField:
                fourthLoginTextField.becomeFirstResponder()
            case fourthLoginTextField:
                fourthLoginTextField.becomeFirstResponder()
            default:
                break
            }
        }        
    }
}
