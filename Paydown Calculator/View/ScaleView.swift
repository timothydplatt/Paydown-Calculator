//
//  ScaleView.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 14/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

enum TickStyle {
    case short
    case long
}

class ScaleView: UIView {
    
//    var minScaleValue: CGFloat
//    var maxScaleValue: CGFloat
    var scaleStartPosition: CGPoint
    var scaleEndPosition: CGPoint
    var scaleDirection: String
//    var scaleMiddlePosition: CGPoint
    var shortDash: CGFloat = 10
    var longDash: CGFloat = 40

    
    
    init(frame: CGRect, scaleStartPosition: CGPoint, scaleEndPosition: CGPoint, scaleDirection: String) {
        self.scaleStartPosition = scaleStartPosition
        self.scaleEndPosition = scaleEndPosition
        self.scaleDirection = scaleDirection
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: scaleStartPosition.x, y: scaleStartPosition.y))
        path.addLine(to: CGPoint(x: scaleEndPosition.x, y: scaleEndPosition.y))

//        let startTick = ceil(scaleStartPosition.y / 10.0) * 10.0
//        let endTick = floor(scaleEndPosition.y / 10.0) * 10.0
        
        let startTick = scaleStartPosition.y
        let endTick = scaleEndPosition.y

        // add tick marks every 2.5 units
        for value in stride(from: startTick, through: endTick, by: 10.0) {
            let style: TickStyle = value.truncatingRemainder(dividingBy: scaleStartPosition.y) == 0 ? .long : .short
            addTick(at: value, style: style, to: path)
        }

        // stroke the path
        UIColor.red.setStroke()
        path.lineWidth = 1.5
        path.stroke()
        
    }
    
    // add a tick mark at value with style to path
    func addTick(at value: CGFloat, style: TickStyle, to path: UIBezierPath) {
        
        let p1 = CGPoint(x: scaleStartPosition.x, y: scaleStartPosition.y + value)
        var p2 = CGPoint(x: p1.x, y: p1.y)
        
        if style == .short {
            if scaleDirection == "Left" {
                p2.x -= shortDash
            } else if scaleDirection == "Right" {
                p2.x += shortDash
            }
            
        } else if style == .long {
            if scaleDirection == "Left" {
                p2.x -= longDash
            } else if scaleDirection == "Right" {
                p2.x += longDash
            }
        }
        
        path.move(to: p1)
        path.addLine(to: p2)

    }

}

