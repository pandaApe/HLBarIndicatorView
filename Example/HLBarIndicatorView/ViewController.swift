//
//  ViewController.swift
//  HLBarIndicatorView
//
//  Created by Hai Long on 06/16/2017.
//  Copyright (c) 2017 Hai Long. All rights reserved.
//

import UIKit
import HLBarIndicatorView

class ViewController: UIViewController {
    
    let indicatorView0 = HLBarIndicatorView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 80))
    
    let indicatorView1 = HLBarIndicatorView(frame: CGRect(x: 0, y: 130, width: UIScreen.main.bounds.width, height: 80))
    
    let indicatorView2 = HLBarIndicatorView(frame: CGRect(x: 0, y: 220, width: UIScreen.main.bounds.width, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        
        indicatorView0.backgroundColor = UIColor.clear
        indicatorView0.indicatorType = .barScaleFromRight
        indicatorView0.refresh()
        
        
        indicatorView1.backgroundColor = UIColor.clear
        indicatorView1.barsCount = 7
        indicatorView1.animationDuration = 1
        indicatorView1.indicatorType = .barScaleFromLeft
        indicatorView1.refresh()
        
        indicatorView2.animationDuration = 0.6
        indicatorView2.barColor = UIColor(white: 200/255, alpha: 1)
        indicatorView2.refresh()
        
        self.view.addSubview(indicatorView2)
        self.view.addSubview(indicatorView1)
        self.view.addSubview(indicatorView0)
        
    }
    
    @IBAction func switcherValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            
            indicatorView0.startAnimating()
            indicatorView1.startAnimating()
            indicatorView2.startAnimating()
        }else{
            
            indicatorView1.stopAnimating()
            indicatorView0.stopAnimating()
            indicatorView2.stopAnimating()
        }
        
    }
}

