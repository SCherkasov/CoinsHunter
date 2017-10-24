//
//  DigitTextField.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/24/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class DigitTextField: UITextField {
    
    public var onDeleteBackwardStart: ((_ textField: DigitTextField) -> Void)?
    
    public var onDeleteBackwardEnd: ((_ textField: DigitTextField) -> Void)?
    
    override func deleteBackward() {
        if let onDeleteBackwardStart = self.onDeleteBackwardStart {
            onDeleteBackwardStart(self)
        }
        
        super.deleteBackward()
        
        if let onDeleteBackwardEnd = self.onDeleteBackwardEnd {
            onDeleteBackwardEnd(self)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tintColor = UIColor.red
    }
    
    override func becomeFirstResponder() -> Bool {
        self.backgroundColor = UIColor.lightText
        
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        self.backgroundColor = UIColor.white
        
        return super.resignFirstResponder()
    }
}
