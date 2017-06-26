//
//  ViewController.swift
//  HLBarIndicatorView
//
//  Created by PandaApe on 06/16/2017.
//  Copyright (c) 2017 PandaApe. All rights reserved.
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
        
        indicatorView0.backgroundColor  = UIColor.clear
        indicatorView0.indicatorType    = .barScaleFromRight
        
        indicatorView1.backgroundColor      = UIColor.clear
        indicatorView1.barsCount            = 7
        indicatorView1.animationDuration    = 1
        indicatorView1.indicatorType        = .barScaleFromLeft
        
        indicatorView2.animationDuration = 0.6
        
        self.view.addSubview(indicatorView2)
        self.view.addSubview(indicatorView1)
        self.view.addSubview(indicatorView0)
        
        indicatorView2.barCornerRadius = 0
        indicatorView2.barsGapWidth = 5
        
    }
    
    @IBAction func switcherValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            
            indicatorView0.startAnimating()
            indicatorView1.startAnimating()
            indicatorView2.startAnimating()
        }else{
            
            indicatorView1.pauseAnimating()
            indicatorView0.pauseAnimating()
            indicatorView2.pauseAnimating()
        }
        
    }
}

