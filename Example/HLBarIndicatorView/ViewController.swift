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
  
    let indicatorView = HLBarIndicatorView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 80))
    
    let indicatorView1 = HLBarIndicatorView(frame: CGRect(x: 0, y: 140, width: UIScreen.main.bounds.width, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.backgroundColor = UIColor.white
        indicatorView1.backgroundColor = UIColor.white
        
        indicatorView1.barsCount = 11
        indicatorView1.barColor = UIColor.orange
        indicatorView1.barWidth = 10
        indicatorView1.barsGapWidth = 8
        indicatorView1.animationDuration = 1
        indicatorView1.refresh()
        
        self.view.addSubview(indicatorView1)
        self.view.addSubview(indicatorView)
        
    }

    @IBAction func switcherValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            
            indicatorView.startAnimating()
            indicatorView1.startAnimating()
        }else{
            
            indicatorView1.stopAnimating()
            indicatorView.stopAnimating()
        }
    
    }
}

