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

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
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
                textField.text = ""
                
                _ = self.previousPasscodeTextField(preceeding: textField).map {
                    $0.becomeFirstResponder()
                }
            }
            
            $0.delegate = self
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
    
    private func populatePasscodeTextField(_ passcodeTextField: DigitTextField, with text: String) -> Void {
        passcodeTextField.text = text.characters.first.map { String($0) }
        if let nextPasscodeTextField = self.nextPasscodeTextField(following: passcodeTextField) {
            _ = nextPasscodeTextField.becomeFirstResponder()
            
            let remainderText = String(text.characters.dropFirst())
            if !remainderText.isEmpty {
                self.populatePasscodeTextField(nextPasscodeTextField, with: remainderText)
            }
        } else {
            _ = passcodeTextField.resignFirstResponder()
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        (textField as? DigitTextField).map {[weak self] textField in
            self.map {
                $0.populatePasscodeTextField(textField, with: string)
            }
        }
        
        if string == "" {
            textField.becomeFirstResponder()
        }
        
        return false;
    }
}
