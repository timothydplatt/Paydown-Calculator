//
//  Scale View.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 14/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import Foundation

class ScaleView: UIView {
    // ScaleView properties.  If any are changed, redraw the view
    var radius: CGFloat = 40           { didSet { self.setNeedsDisplay() } }
    var dashLong: CGFloat = 10         { didSet { self.setNeedsDisplay() } }
    var dashShort: CGFloat = 5         { didSet { self.setNeedsDisplay() } }
    var middle = CGPoint(x: 50, y: 50) { didSet { self.setNeedsDisplay() } }
    var leftAngle: CGFloat = .pi       { didSet { self.setNeedsDisplay() } }
    var rightAngle: CGFloat = 0        { didSet { self.setNeedsDisplay() } }
    var min: CGFloat = 45              { didSet { self.setNeedsDisplay() } }
    var max: CGFloat = 117             { didSet { self.setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        // draw the arc
        path.move(to: CGPoint(x: middle.x - radius, y: middle.y))
        path.addArc(withCenter: middle, radius: radius, startAngle: leftAngle, endAngle: rightAngle, clockwise: true)
        
        let startTick = ceil(min / 2.5) * 2.5
        let endTick = floor(max / 2.5) * 2.5
        
        // add tick marks every 2.5 units
        for value in stride(from: startTick, through: endTick, by: 2.5) {
            let style: TickStyle = value.truncatingRemainder(dividingBy: 10) == 0 ? .long : .short
            addTick(at: value, style: style, to: path)
        }
        
        // stroke the path
        UIColor.black.setStroke()
        path.stroke()
    }
    
    // add a tick mark at value with style to path
    func addTick(at value: CGFloat, style: TickStyle, to path: UIBezierPath) {
        let angle = (max - value)/(max - min) * .pi
        
        let p1 = CGPoint(x: middle.x + cos(angle) * radius,
                         y: middle.y - sin(angle) * radius)
        
        var radius2 = radius
        if style == .short {
            radius2 += dashShort
        } else if style == .long {
            radius2 += dashLong
        }
        
        let p2 = CGPoint(x: middle.x + cos(angle) * radius2,
                         y: middle.y - sin(angle) * radius2)
        
        path.move(to: p1)
        path.addLine(to: p2)
    }
}
