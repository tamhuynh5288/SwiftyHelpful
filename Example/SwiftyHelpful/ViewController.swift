//
//  ViewController.swift
//  SwiftyHelpful
//
//  Created by tamhuynh5288@gmail.com on 07/11/2018.
//  Copyright (c) 2018 tamhuynh5288@gmail.com. All rights reserved.
//

import UIKit
import SwiftyHelpful

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let yellowView = UIView()
        yellowView.backgroundColor = UIColor.yellow
        view.addSubview(yellowView)
        yellowView.scaleEqualSuperView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
