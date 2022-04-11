//
//  OnboardingViewController.swift
//  newApp
//
//  Created by Mina Namlı on 22.03.2022.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    var collectionView: UICollectionView!
    
    let pageControl : UIPageControl = {
        let pg = UIPageControl()
        pg.pageIndicatorTintColor = .red
        return pg
    }()
    
    let skipBtnClicked : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.backgroundColor = .blue
        btn.setTitle("SKIP", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
//    let myLabel : UILabel = {
//        let lbl = UILabel()
//        lbl.backgroundColor = .lightGray
//        return lbl}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        super.view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 650, left: 120, bottom: 250, right: 200))
        }
        
        super.view.addSubview(skipBtnClicked)
        skipBtnClicked.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 700, left: 20, bottom: 200, right: 200))
        }
    }
    
}
