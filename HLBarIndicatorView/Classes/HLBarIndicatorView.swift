//
//  HLBarIndicatorView.swift
//  LoadingProgress
//
//  Created by PandaApe on 16/06/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

import UIKit

open class HLBarIndicatorView: UIView {
    
    fileprivate var barArray            = [CALayer]()
    fileprivate var contentViewCenter   = CGPoint.zero
    fileprivate var heightStep:CGFloat  = 0.0
    fileprivate var _barColor           = UIColor.gray.cgColor

    open var barsCount:Int           = 5 {
        willSet{
            if newValue < 0 {
                fatalError("barsCount must be UInt")
            }
            
            if newValue%2 != 1 {
                fatalError("barsCount must be an odd number")
            }
            
        }
    }
    
    open var maxBarHeight:CGFloat    = 50
    
    open var minBarHeight:CGFloat    = 10
    
    open var barWidth:CGFloat        = 7
    open var barsGapWidth:CGFloat    = 3
    open var barCornerRadius:CGFloat = 3.0
    open var animationDuration:CFTimeInterval  = 0.6
    
    open var barColor:UIColor {
        
        set{
            
         _barColor = newValue.cgColor
        }
        
        get{
            return UIColor(cgColor: _barColor)
        }
        
    }
    
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
    
    open func stopAnimating() {
        
        for layer in barArray {
            
            let pausedTime      = layer.convertTime(CACurrentMediaTime(), from: nil)
            layer.speed         = 0
            layer.timeOffset    = pausedTime
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()

        refresh()
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        refresh()
    }
    
    open func refresh() {
        
        setupLayers()
        
        resizeLayers()
        
        addAnimations()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func resizeLayers() {
        
        let midIndex = barsCount/2
        
        for i in 0...midIndex {
            
            let leftIndex   = midIndex - i
            let rightIndex  = midIndex + i
            
            let leftLayer   = barArray[leftIndex]
            let rightLayer  = barArray[rightIndex]
            
            let floatI = CGFloat(i)
            
            leftLayer.position  = CGPoint(x: contentViewCenter.x - (barsGapWidth + barWidth)*floatI, y: contentViewCenter.y)
            rightLayer.position = CGPoint(x: contentViewCenter.x + (barsGapWidth + barWidth)*floatI, y: contentViewCenter.y)
            
            leftLayer.bounds    = CGRect(x: 0, y: 0, width: barWidth, height: maxBarHeight-heightStep*floatI)
            rightLayer.bounds   = CGRect(x: 0, y: 0, width: barWidth, height: maxBarHeight-heightStep*floatI)
        }
        
    }
    
    fileprivate func addAnimations() {
        
        let midIndex = barsCount/2
        
        for i in 0...midIndex {
            
            let leftIndex   = midIndex - i
            let rightIndex  = midIndex + i
            
            let leftLayer   = barArray[leftIndex]
            let rightLayer  = barArray[rightIndex]
            
            let layerAnimation = CAKeyframeAnimation(keyPath: "bounds")
            
            var values = [CGRect]()
            
            for index in 0..<barsCount*2+1 {
                
                var resHeight = leftLayer.bounds.height - heightStep * CGFloat(index)
                
                if resHeight < minBarHeight {
                    resHeight = minBarHeight*2.0 - resHeight
                    
                    if resHeight > maxBarHeight {
                        resHeight = maxBarHeight*2.0 - resHeight
                    }
                }
                
                values.append(CGRect(x: 0, y: 0, width: barWidth, height: resHeight))
            }
            
            layerAnimation.values         = values;
            layerAnimation.duration       = animationDuration
            layerAnimation.repeatCount    = .infinity
            layerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            layerAnimation.isRemovedOnCompletion = false
            
            leftLayer.add(layerAnimation, forKey: "heightAnimation")
            rightLayer.add(layerAnimation, forKey: "heightAnimation")
        }
    }
    
    fileprivate func setupLayers() {
        
        contentViewCenter   = CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        heightStep          = (maxBarHeight - minBarHeight)/CGFloat(barsCount)
        
        // reset
        for layer in barArray {
            layer.removeFromSuperlayer()
        }
        barArray.removeAll()
        
        for _ in 0 ..< barsCount {
            
            let layer               = CALayer()
            
            layer.position          = contentViewCenter
            layer.backgroundColor   = _barColor
            layer.cornerRadius      = barCornerRadius
            
            self.layer.addSublayer(layer)
            barArray.append(layer)
        }
    }
}
