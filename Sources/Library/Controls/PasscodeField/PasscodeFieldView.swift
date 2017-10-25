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
        self.backgroundColor = UIColor.clear
        
        self.setupPasscodeTextFields()
    }
    
    private func setupPasscodeTextFields() {
        let stackView = UIStackView.init()
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.spacing = CGFloat.init(self.spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.frame = CGRect.zero
 
        self.stackView = stackView
        self.addSubview(self.stackView)
        
        let viewsDict = ["view": stackView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: viewsDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: viewsDict))
        
        _ = Array(0..<self.digitsCount).map { _ in
            let digitTextField = DigitTextField.init()
            digitTextField.frame = CGRect.zero
            
            digitTextField.backgroundColor = UIColor.green
            
            self.passcodeTextFields.append(digitTextField)
            
            stackView.addArrangedSubview(digitTextField)
        }
    }
}
