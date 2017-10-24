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
    
    public var digitsCount: UInt = 4 {
        didSet {
            
        }
    }
    
    public var spacing: Float = 0
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    // MARK: Private
    private func setup() {
        self.stackView = UIStackView.init()
        self.passcodeTextFields = [];
    }
    
    private func setupPasscodeTextFields() {
        _ = self.passcodeTextFields.map { textField in
            textField.removeFromSuperview()
        }
        
        self.stackView.removeFromSuperview()
        
        let stackView = UIStackView.init()
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = CGFloat.init(self.spacing)
        
        self.passcodeTextFields = []
       
        /*
        _ = [0...count-1].map { _ in
            var digitTextField = DigitTextField.init()
            
            self.passcodeTextFields.append(DigitTextField)
        }
         */
        
    }
}
