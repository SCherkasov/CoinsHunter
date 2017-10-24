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
    
    @IBOutlet var passcodeTextFields: [DigitTextField]!
    
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
    
    override func viewDidLoad() {
        _ = self.passcodeTextFields.map {
            $0.onDeleteBackwardStart = { textField in
                if textField.text == nil || textField.text == "" {
                    _ = self.previousPasscodeTextField(preceeding: textField).map {
                        $0.becomeFirstResponder()
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = self.passcodeTextFields[0].becomeFirstResponder()
    }
    
    private func textField(offsetedBy offset:Int, from textField:DigitTextField)  -> DigitTextField? {
        return self.passcodeTextFields.index(of: textField)
            .map { $0 + offset }
            .flatMap { $0 < self.passcodeTextFields.count && $0 >= 0 ? self.passcodeTextFields[$0] : nil }
    }
    
    private func nextPasscodeTextField(following textField: DigitTextField) -> DigitTextField? {
        return self.textField(offsetedBy: +1, from: textField)
    }

    private func previousPasscodeTextField(preceeding textField: DigitTextField) -> DigitTextField? {
        return self.textField(offsetedBy: -1, from: textField)
    }
    
    private func isLastTextField(textField: DigitTextField) -> Bool {
        return self.nextPasscodeTextField(following: textField) == nil
    }
    
    @IBAction func onEditingDidBegin(_ textField: DigitTextField) {
    }

    @IBAction func onEditingDidChange(_ passcodeTextField: DigitTextField) {
        passcodeTextField.text.map { passcode in
            if (passcode == "") {
                _ = self.previousPasscodeTextField(preceeding: passcodeTextField).map {
                    $0.becomeFirstResponder()
                }
            } else {
                passcodeTextField.text = passcode.characters.first.map { String($0) }
                
                if let nextPasscodeTextField = self.nextPasscodeTextField(following: passcodeTextField) {
                    _ = nextPasscodeTextField.becomeFirstResponder()
                    
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
