//
//  BlinkingLabel.swift
//  CoinsHunter
//
//  Created by Gavrysh on 10/23/17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class BlinkingLabel : UILabel {
    func startBlinking() {
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.9, //Time of duration
            delay: 0.0,
            options: [.autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 })
    }
}

