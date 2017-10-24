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
    
    // MARK: Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
    }
    
    // MARK: Public
    
    
    // MARK: Private
    
}
