//
//  FirstPageViewController.swift
//  CoinsHunter
//
//  Created by Stanislav Cherkasov on 22.10.17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

extension UILabel {
    func blink() {
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.9, //Time of duration
            delay: 0.0,
            options: [.autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 })
    }
}

class FirstPageViewController: UIViewController {
    
    
    @IBAction func oneEuroStartButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var blinkingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.blinkingLabel.blink()
        
    }
}
