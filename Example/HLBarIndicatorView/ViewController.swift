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
    
    
    @IBOutlet weak var barScaleFromRightView: UIView!
    @IBOutlet weak var barScaleFromLeftView: UIView!
    @IBOutlet weak var barScalePulseOutView: UIView!
    
    lazy var indicatorView0 = HLBarIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
    lazy var indicatorView1 = HLBarIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
    lazy var indicatorView2 = HLBarIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicatorView0.indicatorType        = .barScaleFromRight
        
        indicatorView1.barsCount            = 7
        indicatorView1.animationDuration    = 1
        indicatorView1.indicatorType        = .barScaleFromLeft
        
        indicatorView2.animationDuration    = 0.6
        
        self.barScaleFromRightView.addSubview(indicatorView0)
        self.barScaleFromLeftView.addSubview(indicatorView1)
        self.barScalePulseOutView.addSubview(indicatorView2)
        
        indicatorView2.barCornerRadius      = 0
        indicatorView2.barsGapWidth         = 5
        
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

