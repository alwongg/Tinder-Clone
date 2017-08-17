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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testObject = PFObject(className: "Testing")
        testObject["foo"] = "bar"
        testObject.saveInBackground { (success, error) in
            print("object has been saved")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

