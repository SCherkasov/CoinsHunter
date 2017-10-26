//
//  PasscodeFieldView.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/24/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

func concat(_ strings:[String?]) -> String? {
    return strings.reduce(nil) { (result, string) in
        return result == nil ? string : result! + (string ?? "")
    }
}

class PasscodeFieldView: UIView {
    
    @IBOutlet var passcodeTextFields: [DigitTextField]!
    
    // MARK: Accessors
    
    public var delegate: UITextFieldDelegate? {
        didSet {
            self.updateDelegate()
        }
    }
    
    public var digitsCount: UInt = 1 {
        didSet {
            self.setup()
        }
    }
    
    public var spacing: CGFloat = 0 {
        didSet {
            self.setup()
        }
    }
    
    public var passcode: String? {
        set {
            var i = 0
            _ = newValue?.characters.map {
                if i >= 0 && i < self.passcodeTextFields.count {
                     self.passcodeTextFields[i].text = String($0)
                }
               
                i += 1
            }
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
    
    public func textField(offsetedBy offset:Int, from textField:DigitTextField)  -> DigitTextField? {
        return self.passcodeTextFields.index(of: textField)
            .map { $0 + offset }
            .flatMap { $0 < self.passcodeTextFields.count && $0 >= 0 ? self.passcodeTextFields[$0] : nil }
    }
    
    public func nextPasscodeTextField(following textField: DigitTextField) -> DigitTextField? {
        return self.textField(offsetedBy: +1, from: textField)
    }
    
    public func previousPasscodeTextField(preceeding textField: DigitTextField) -> DigitTextField? {
        return self.textField(offsetedBy: -1, from: textField)
    }
    
    public func isLastTextField(textField: DigitTextField) -> Bool {
        return self.nextPasscodeTextField(following: textField) == nil
    }
    
    // MARK: Initializations and Deallocations
    
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
    
    // MARK: Publlic
    
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
    
    public func activateFirstDigitBox() -> Bool {
        return self.passcodeTextFields.count > 0 ? self.passcodeTextFields[0].becomeFirstResponder() : false
    }
    
    public func populatePasscodeTextField(_ passcodeTextField: DigitTextField, with text: String) -> Void {
        passcodeTextField.text = text.characters.first.map { String($0) }
        if let nextPasscodeTextField = self.nextPasscodeTextField(following: passcodeTextField) {
            _ = nextPasscodeTextField.becomeFirstResponder()
            
            let remainderText = String(text.characters.dropFirst())
            if !remainderText.isEmpty {
                self.populatePasscodeTextField(nextPasscodeTextField, with: remainderText)
            }
        } else {
            _ = passcodeTextField.resignFirstResponder()
        }
        
        if text == "" {
            _ = passcodeTextField.becomeFirstResponder()
        }
    }
    
    // MARK: Private
    
    private func setup() {
        if self.passcodeTextFields != nil {
            _ = self.passcodeTextFields.map {
                $0.removeFromSuperview()
            }
        }
        
        self.passcodeTextFields = [];
        self.backgroundColor = UIColor.clear
        
        self.setupPasscodeTextFields()
        
        self.updateDelegate()
    }
    
    private func updateDelegate() {
        _ = self.passcodeTextFields.map {
            $0.delegate = self.delegate
        }
    }
    
    private func setupPasscodeTextFields() {
        _ = self.rectFramesForDigits(in: CGRect.zero).map { frame in
            
            let digitTextField = self.generateDigitTextField(self.frame)
            
            digitTextField.onDeleteBackwardStart = { textField in
                textField.text = ""
                
                _ = self.previousPasscodeTextField(preceeding: textField).map {
                    $0.becomeFirstResponder()
                }
            }
            
            self.passcodeTextFields.append(digitTextField)
            
            self.addSubview(digitTextField)
        }
    }
    
    private func rectFramesForDigits(in frame:CGRect) -> [CGRect] {
        let digitsCount = CGFloat.init(self.digitsCount)
        
        let width = frame.width / digitsCount - (1 - 1 / digitsCount) * self.spacing
        let height = frame.height
        let spacing = self.spacing
        
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
