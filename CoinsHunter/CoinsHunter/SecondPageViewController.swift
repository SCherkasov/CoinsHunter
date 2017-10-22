//
//  SecondPageViewController.swift
//  CoinsHunter
//
//  Created by Stanislav Cherkasov on 22.10.17.
//  Copyright © 2017 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var slideScrollView: UIScrollView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideScrollView.delegate = self
        
        let slides: [Slide] = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
        
        tanslucentNC()
    }
    
    func createSlides() -> [Slide] {
        
        let firstSlide: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        firstSlide.image.image = #imageLiteral(resourceName: "firstImage")
        
        let secondSlide: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        secondSlide.image.image = #imageLiteral(resourceName: "secondImage")
        
        let thirdSlide: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        thirdSlide.image.image = #imageLiteral(resourceName: "thirdImage")
        
        return [firstSlide, secondSlide, thirdSlide]
    }
    
    func setupSlideScrollView(slides: [Slide]) {
        
        slideScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        slideScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            
            slideScrollView.addSubview(slides[i])
            
            slideScrollView.isPagingEnabled = true
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func tanslucentNC() {
        
        // tanslucent navigationController
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    
}
