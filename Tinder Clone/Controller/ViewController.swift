//
//  ViewController.swift
//  Tinder Clone
//
//  Created by Alex Wong on 8/17/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var swipeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gestureRecognizer:)))
        swipeLabel.addGestureRecognizer(gesture)
        
    }
    
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer){
        
        print("dragged")

        //move the label
        
        let labelPoint = gestureRecognizer.translation(in: view)
        swipeLabel.center = CGPoint(x: view.bounds.width / 2 + labelPoint.x, y: view.bounds.height  / 2 + labelPoint.y)
        
        //rotate the label as we are swiping
        
        let xFromCenter = view.bounds.width / 2 - swipeLabel.center.x
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter/200)
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        
        var scaledAndRotated = rotation.scaledBy(x: 0.9, y: scale)
        
        swipeLabel.transform = scaledAndRotated
        
        print(swipeLabel.center.x)
        
        if gestureRecognizer.state == .ended {
            
            if swipeLabel.center.x < (view.bounds.width / 2 - 100) {
                
                print("Not interested")
                
            }
            
            
            if swipeLabel.center.x > (view.bounds.width / 2 + 100) {
                
                print("Interested")
                
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            scaledAndRotated = rotation.scaledBy(x: 1, y: 1)
            
            swipeLabel.transform = scaledAndRotated
            
          // bring it back to the center
            swipeLabel.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

