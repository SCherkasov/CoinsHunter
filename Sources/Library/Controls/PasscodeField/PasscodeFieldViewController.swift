//
//  PasscodeFieldViewController.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/24/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class PasscodeFieldViewController: UIViewController {
    
    override func loadView() {
        self.view = PasscodeFieldView.init()
    }
}
