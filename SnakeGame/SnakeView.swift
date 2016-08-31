//
//  SnakeView.swift
//  SnakeGame
//
//  Created by Yoorian Shin on 8/31/16.
//  Copyright © 2016 Yoorian Shin. All rights reserved.
//

import UIKit

protocol SnakeViewDelegate {
    func snakeForSnakeView(view:SnakeView) -> Snake?
    func pointOfFruitForSnakeView(view:SnakeView) -> Point?
}

class SnakeView : UIView {
    var delegate:SnakeViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if let snake:Snake = delegate?.snakeForSnakeView(self) {
            let worldSize = snake.worldSize
            if worldSize.width <= 0 || worldSize.height <= 0 {
                return
            }
            let w = Int(Float(self.bounds.size.width) / Float(worldSize.width))
            let h = Int(Float(self.bounds.size.height) / Float(worldSize.height))
            
            UIColor.blackColor().set()
            let points = snake.points
            for point in points {
                let rect = CGRect(x: point.x * w, y: point.y * h, width: w, height: h)
                UIBezierPath(rect: rect).fill()
            }
            
            if let fruit = delegate?.pointOfFruitForSnakeView(self) {
                UIColor.blueColor().set()
                let rect = CGRect(x: fruit.x * w, y: fruit.y * h, width: w, height: h)
                UIBezierPath(ovalInRect: rect).fill()
            }
        }
    }
}
