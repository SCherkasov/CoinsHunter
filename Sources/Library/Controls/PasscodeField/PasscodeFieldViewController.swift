//
//  PasscodeFieldViewController.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/24/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class PasscodeFieldViewController: UIViewController {

    private var passcodeFieldView: PasscodeFieldView?
    
    public var digitsCount: UInt = 1 {
        didSet {
            self.passcodeFieldView?.digitsCount = self.digitsCount
        }
    }
    
    public var spacing: Float = 0 {
        didSet {
            self.passcodeFieldView?.digitsCount = self.digitsCount
        }
    }
    
    public var passcode: String? {
        didSet {
            self.passcodeFieldView?.passcode = self.passcode
        }
    }
    
    override func loadView() {
        let passcodeFieldView = PasscodeFieldView.init()
        passcodeFieldView.digitsCount = self.digitsCount
        passcodeFieldView.spacing = self.spacing
        passcodeFieldView.passcode = self.passcode
        
        self.view = passcodeFieldView
        self.passcodeFieldView = passcodeFieldView
    }
}
