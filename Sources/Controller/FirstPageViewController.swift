//
//  FirstPageViewController.swift
//  CoinsHunter
//
//  Created by Stanislav Cherkasov on 22.10.17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    @IBAction func oneEuroStartButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var blinkingLabel: BlinkingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.blinkingLabel.blink()
        
    }
}
