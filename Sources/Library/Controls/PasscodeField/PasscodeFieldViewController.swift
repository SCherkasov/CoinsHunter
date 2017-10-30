//
//  PasscodeFieldViewController.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/24/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class PasscodeFieldViewController: UIViewController, UITextFieldDelegate {

    public var passcodeFieldView: PasscodeFieldView?
    
    // MARK: Accessors
    
    public var digitsCount: UInt = 1 {
        didSet {
            self.passcodeFieldView?.digitsCount = Int(self.digitsCount)
        }
    }
    
    public var spacing: CGFloat = 0 {
        didSet {
            self.passcodeFieldView?.spacing = spacing
        }
    }
    
    public var passcode: String? {
        didSet {
            self.passcodeFieldView?.passcode = self.passcode
        }
    }
    
    // MARK: Public
    
    public func activateFirstDigitBox() -> Bool {
        return self.passcodeFieldView.map {
            $0.activateFirstDigitBox()
            } ?? false
    }
    
    override func loadView() {
        let passcodeFieldView = PasscodeFieldView.init()
        passcodeFieldView.digitsCount = Int(self.digitsCount)
        passcodeFieldView.spacing = self.spacing
        passcodeFieldView.passcode = self.passcode
        
        passcodeFieldView.delegate = self
        
        self.view = passcodeFieldView
        self.passcodeFieldView = passcodeFieldView
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        if let passcodeFieldView = self.passcodeFieldView,
            let digitTextField = textField as? DigitTextField
        {
            passcodeFieldView.populatePasscodeTextField(digitTextField, with: string)
        }
        
        return false;
    }
}
