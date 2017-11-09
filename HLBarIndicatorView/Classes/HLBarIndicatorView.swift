//
//  HLBarIndicatorView.swift
//  HLBarIndicatorView
//
//  Created by PandaApe on 16/06/2017.
//  Author Email: whailong2010@gmail.com
//  Copyright © 2017 iLabs. All rights reserved.
//

import UIKit

public enum HLBarIndicatorType: Int {

    case barScalePulseOut
    case barScaleFromLeft
    case barScaleFromRight
}

open class HLBarIndicatorView: UIView {
    
    fileprivate var barArray            = [CALayer]()
    fileprivate var _barColor           = UIColor.white.cgColor
    
    // MARK: Public settings options and methods
    /// bars Count
    open var barsCount:Int              = 5 {
        willSet{
            if newValue < 0 {
                fatalError("barsCount must be UInt")
            }
            
            if newValue%2 != 1 {
                fatalError("barsCount must be an odd number")
            }
        }
    }
    
    /// indicator Type, actually it's the bars animation style. Its value can be one enum value of HLBarIndicatorType.
    open var indicatorType: HLBarIndicatorType  = .barScalePulseOut
    
    /// max bar height, 40.0 by default
    open var maxBarHeight: CGFloat              = 40.0
    
    /// min bar height, 10.0 by default
    open var minBarHeight: CGFloat              = 10.0
    
    /// bar width, 5.0 by default
    open var barWidth: CGFloat                  = 5.0
    
    /// The width of the gap between bars, 3.0 by default
    open var barsGapWidth: CGFloat              = 3.0
    
    /// bar corner radius, 5.0 by default
    open var barCornerRadius: CGFloat           = 5.0
    
    /// Specifies the basic duration of the animation, in seconds. Defaults to 0.8
    open var animationDuration: CFTimeInterval  = 0.8
    
    
    /// bar's color, defaults to UIColor.white
    open var barColor: UIColor {
        
        set{
            
            _barColor = newValue.cgColor
        }
        
        get{
            return UIColor(cgColor: _barColor)
        }
        
    }
    
    /// Make bars starting animation
    open func startAnimating() {
        
        for layer in barArray {
            
            guard layer.speed != 1.0 else {
                continue
            }
            
            let pausedTime      = layer.timeOffset
            layer.speed         = 1.0
            layer.timeOffset    = 0
            let timeSincePause  = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            layer.beginTime     = timeSincePause
        }
        
    }
    
    /// Bars animation will pause
    open func pauseAnimating() {
        
        for layer in barArray {
            
            let pausedTime      = layer.convertTime(CACurrentMediaTime(), from: nil)
            layer.speed         = 0
            layer.timeOffset    = pausedTime
        }
    }
    
    
    // MARK: initialization
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor      = UIColor.clear

        refresh()
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        refresh()
    }
    
    private func refresh() {
        
        setupLayers()
        
        addAnimations()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        refresh()
    }
    
    // MARK: privete methods
    fileprivate func addAnimations() {
        
        let step = CGFloat(animationDuration)/minBarHeight
        
        var beginTiles = [Double]()
        
        switch indicatorType {
        case .barScaleFromLeft:
            
            for i in 0..<barsCount {
                
                beginTiles.append(CACurrentMediaTime() - Double(step*CGFloat(barsCount/2 - i)))
            }
            
        case .barScalePulseOut:
            
            
            for i in 0..<barsCount {
                
                beginTiles.append(CACurrentMediaTime() - Double(step*CGFloat(abs(barsCount/2 - i))))
            }
            
        case .barScaleFromRight:
            
            for i in 0..<barsCount {
                
                beginTiles.append(CACurrentMediaTime() + Double(step*CGFloat(barsCount/2 - i)))
            }
            
        }
        
        for i in 0..<barsCount {
            
            let layerAnimation              = CAKeyframeAnimation(keyPath: "transform.scale.y")
            
            layerAnimation.beginTime        = beginTiles[i]
            layerAnimation.values           = [1.0, minBarHeight/maxBarHeight, 1.0];
            layerAnimation.duration         = animationDuration
            layerAnimation.repeatCount      = .infinity
            layerAnimation.timingFunction   = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            layerAnimation.isRemovedOnCompletion = false
            barArray[i].add(layerAnimation, forKey: "heightAnimation")
            
        }
    }
    
    fileprivate func setupLayers() {
        
        let contentViewCenter   = CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        
        // reset
        for layer in barArray {
            
            layer.removeFromSuperlayer()
        }
        
        barArray.removeAll()
        
        for i in 0 ..< barsCount {
            
            let layer               = CALayer()
            
            layer.position          = contentViewCenter
            layer.backgroundColor   = _barColor
            layer.cornerRadius      = barCornerRadius
            layer.bounds            = CGRect(x: 0, y: 0, width: barWidth, height: maxBarHeight)
            layer.position          = CGPoint(x: contentViewCenter.x - (barsGapWidth + barWidth)*CGFloat( barsCount/2 - i), y: contentViewCenter.y)
            self.layer.addSublayer(layer)
            barArray.append(layer)
        }
    }
}
