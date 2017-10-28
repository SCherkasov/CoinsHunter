//
//  SecondPageViewController.swift
//  CoinsHunter
//
//  Created by Stanislav Cherkasov on 22.10.17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate {
    
   
    @IBOutlet weak var mainScrollView: UIScrollView!
   
    
 
    @IBOutlet weak var pageControlS: UIPageControl!
    

    
    
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        mainScrollView.frame = view.frame
        imageArray = [#imageLiteral(resourceName: "firstImage"), #imageLiteral(resourceName: "secondImage"), #imageLiteral(resourceName: "thirdImage")]
        
        for i in 0..<imageArray.count {
            
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleToFill
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            mainScrollView.addSubview(imageView)
        }
        
        pageControlS.numberOfPages = imageArray.count
        pageControlS.currentPage = 0
        view.bringSubview(toFront: pageControlS)
        
        tanslucentNC()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControlS.currentPage = Int(pageIndex)
    }

    
    func tanslucentNC() {
        
        // tanslucent navigationController
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    
}


