//
//  PasscodeField.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/24/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

@IBDesignable
class PasscodeField : UIView {
    @IBInspectable
    public var digitsCount: UInt = 4
    
    @IBInspectable
    public var passcode: String? 
    
    var passcodeFieldViewController: PasscodeFieldViewController? {
        didSet {
            if let passcodeFieldViewController = passcodeFieldViewController,
                let passcodeFieldView = passcodeFieldViewController.view
            {
                passcodeFieldView.frame = self.bounds
                
                self.addSubview(passcodeFieldView)
            }
        }
    }

    // MARK: Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
    }
    
    // MARK: Public
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    // MARK: Private
    
    func setup() {
        self.passcodeFieldViewController = PasscodeFieldViewController.init()
    }
}
