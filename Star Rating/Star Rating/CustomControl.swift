//
//  CustomControl.swift
//  Star Rating
//
//  Created by Kevin Stewart on 2/6/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import UIKit

class CustomControl: UIControl {
    
    var value: Int = 1
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 5
    private let componentActivateColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    private var stars: [UILabel] = []
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setUp()
    }
    
    func updateValue(at touch: UITouch) {
        let touchPoint = touch.location(in: self)
        for label in self.stars {
            if label.frame.contains(touchPoint) {
                self.value = label.tag
                updateStarColor()
                label.performFlare()
            }
        }
    }
    
    func updateStarColor() {
        for label in self.stars {
            if label.tag <= self.value {
                label.backgroundColor = self.componentActivateColor
            } else {
                label.backgroundColor = self.componentInactiveColor
            }
        }
    }
    
    func setUp() {
        
        for n in 0...componentCount { //loop creating labels up to count of 5
            let star = UILabel() //created label
            star.tag = Int(n) //tag is increased by 1 for each label up to 5
            star.text = "⭐️" //label text
            star.font = UIFont.systemFont(ofSize: 32) //label font and size
            star.textAlignment = .center //label alignment
            addSubview(star)
            stars.append(star) //appended labels to array
            
            if n == 0 {
                star.textColor = componentActivateColor
            } else {
                star.textColor = componentInactiveColor
            }
            
            if n == 0 {
                star.frame = CGRect(x: 8, y: 0, width: componentDimension, height: componentDimension)
            } else {
                let firstStarLocation = CGFloat( (componentDimension * CGFloat(n-1) + CGFloat(n * 8)))
                star.frame = CGRect(x: firstStarLocation, y: 0, width: componentDimension, height: componentDimension)
            }
            
        }
   }
    
    override var intrinsicContentSize: CGSize {
      let componentsWidth = CGFloat(componentCount) * componentDimension
      let componentsSpacing = CGFloat(componentCount + 1) * 8.0
      let width = componentsWidth + componentsSpacing
      return CGSize(width: width, height: componentDimension)
    }
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
            updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchDragInside, .touchDragOutside])
        } else {
            sendActions(for: [.touchCancel])
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event) }
        guard let touch = touch else { return }
            
            let touchPoint = touch.location(in: self)
            if bounds.contains(touchPoint) {
                updateValue(at: touch)
                sendActions(for: [.touchUpInside, .touchUpOutside])

            } else {
                sendActions(for: [.touchCancel])
            }
        }
   
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
        }
    }

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}



