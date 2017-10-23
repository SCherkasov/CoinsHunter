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
    
    @IBAction func onEditingDidChange(_ textField: UITextField) {
        self.passcodeTextFields.index(of: textField).map { i in
            var nextIndex: Int?
            
            if (textField.text == nil || textField.text == "") {
                nextIndex = i - 1 < 0 ? 0 : i - 1
            } else {
                nextIndex = (i < self.passcodeTextFields.count - 1) ? i + 1 : nil
            }
            
            _ = nextIndex.map {
                self.passcodeTextFields[$0].becomeFirstResponder()
            }
        }
    }
}
