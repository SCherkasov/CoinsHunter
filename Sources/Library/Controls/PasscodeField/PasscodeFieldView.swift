//
//  PasscodeFieldView.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/24/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class PasscodeFieldView: UIView {
    
    @IBOutlet var passcodeTextFields: [DigitTextField]!
    
    public var digitsCount: UInt = 4
    
    public var spacing: Float = 25
    
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
    
    private let generateDigitTextField = { (frame: CGRect) -> DigitTextField in
        let digitTextField = DigitTextField.init()
        digitTextField.frame = frame
        digitTextField.textAlignment = NSTextAlignment.center
        digitTextField.borderStyle = UITextBorderStyle.roundedRect
        digitTextField.isSecureTextEntry = true
        digitTextField.placeholder = "-"
        digitTextField.textColor = UIColor.red
        
        return digitTextField
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frames = self.rectFramesForDigits(in: self.frame)
        
        for index in 0..<self.digitsCount {
            if let passcodeTextFields = self.passcodeTextFields {
                let idx = Int.init(index)
                
                passcodeTextFields[idx].frame = frames[idx]
            }
        }
    }
    
    // MARK: Private
    private func setup() {
        self.passcodeTextFields = [];
        self.backgroundColor = UIColor.clear
        
        self.setupPasscodeTextFields()
    }
    
    private func setupPasscodeTextFields() {
        /*
        let label = UILabel.init()
        label.text = "Hello"
        label.frame = CGRect.init(x: 0, y: 0, width: 300, height: 100)
        self.addSubview(label)
        */
        _ = self.rectFramesForDigits(in: CGRect.zero).map { frame in
            
            let digitTextField = self.generateDigitTextField(self.frame)
            
            self.passcodeTextFields.append(digitTextField)
            
            self.addSubview(digitTextField)
        }
    }
    
    private func rectFramesForDigits(in frame:CGRect) -> [CGRect] {
        let width = CGFloat.init(frame.width) / CGFloat.init(self.digitsCount) - CGFloat(self.spacing)
        let height = CGFloat.init(frame.height)
        let spacing = CGFloat.init(self.spacing)
        
        var frames: [CGRect] = []
        _ = Array(0..<self.digitsCount).map { i in
            let index = CGFloat(i)
            
            let rect = CGRect.init(x: (width + spacing) * index,
                                   y: 0,
                                   width: width,
                                   height: height)
            
            frames.append(rect)
        }
        
        return frames
    }
}
