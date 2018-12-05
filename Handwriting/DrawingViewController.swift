//
//  DrawingViewController.swift
//  Handwriting
//
//  Created by Bernadett Kiss on 12/5/18.
//  Copyright © 2018 Bernadett Kiss. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var drawingImageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func predictButtonPressed(_ sender: UIButton) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        drawingImageView.image = nil
        if let touch = touches.first {
            lastPoint = touch.location(in: drawingImageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: drawingImageView)
            drawLine(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLine(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    
    private func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(drawingImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        drawingImageView.image?.draw(in: CGRect(x: 0, y: 0, width: drawingImageView.frame.size.width, height: drawingImageView.frame.size.height))
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(.round)
        context?.setLineWidth(10.0)
        context?.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        context?.setBlendMode(.normal)
        context?.strokePath()
        
        drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}

