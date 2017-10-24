//
//  FirstPageViewController.swift
//  CoinsHunter
//
//  Created by Stanislav Cherkasov on 22.10.17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    @IBOutlet weak var blinkingLabel: BlinkingLabel!
    
    @IBAction func oneEuroStartButton(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.blinkingLabel.startBlinking()
    }
}
