//
//  PasscodeFieldView.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/24/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class PasscodeFieldView: UIView {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var passcodeTextFields: [DigitTextField]!
    
    public var passcode: String? {
        set {
            var i = 0
            _ = newValue?.characters.map {
                self.passcodeTextFields[i].text = String($0)
                i += 1
            }
            
            self.setNeedsLayout()
        }
        
        get {
            return concat(self.passcodeTextFields.map { $0.text })
        }
    }
}
