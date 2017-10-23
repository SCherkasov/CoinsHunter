//
//  LoginPageViewController.swift
//  CoinsHunter
//
//  Created by Stanislav Cherkasov on 22.10.17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

// concat (nil, "s") -> "s"
// concat ("d", nil) -> "d"
// concat (nil, nil) -> nil
// concat ("d", "s") -> "ds"

func concat(_ strings:[String?]) -> String? {
    return strings.reduce(nil) { (result, string) in
        return result == nil ? string : result! + (string ?? "")
    }
}

class LoginPageViewController: UIViewController {
    
    @IBOutlet var passcodeTextFields: [UITextField]!
    
    var passcode: String? {
        set {
            var i = 0
            _ = newValue?.characters.map {
                self.passcodeTextFields[i].text = String($0)
                i += 1
            }
        }
        
        get {
            return concat(self.passcodeTextFields.map { $0.text })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.passcodeTextFields[0].becomeFirstResponder()
    }
    
    private func textField(offsetedBy offset:Int, from textField:UITextField)  -> UITextField? {
        return self.passcodeTextFields.index(of: textField)
            .map { $0 + offset }
            .flatMap { $0 < self.passcodeTextFields.count && $0 >= 0 ? self.passcodeTextFields[$0] : nil }
    }
    
    private func nextPasscodeTextField(following textField: UITextField) -> UITextField? {
        return self.textField(offsetedBy: +1, from: textField)
    }

    private func previousPasscodeTextField(preceeding textField: UITextField) -> UITextField? {
        return self.textField(offsetedBy: -1, from: textField)
    }
    
    private func isLastTextField(textField: UITextField) -> Bool {
        return self.nextPasscodeTextField(following: textField) == nil
    }
    
    @IBAction func onEditingDidBegin(_ textField: UITextField) {
    }
    
    @IBAction func onEditingDidChange(_ passcodeTextField: UITextField) {
        passcodeTextField.text.map { passcode in
            if (passcode == "") {
                _ = self.previousPasscodeTextField(preceeding: passcodeTextField).map {
                    $0.becomeFirstResponder()
                }
            } else {
                passcodeTextField.text = passcode.characters.first.map { String($0) }
                
                if let nextPasscodeTextField = self.nextPasscodeTextField(following: passcodeTextField) {
                    nextPasscodeTextField.becomeFirstResponder()
                    
                    let newValue = String(passcode.characters.dropFirst())
                    if (!newValue.isEmpty) {
                        nextPasscodeTextField.text = newValue
                        onEditingDidChange(nextPasscodeTextField)
                    }
                } else {
                    self.view.endEditing(true)
                }
            }
        }
    }
}
