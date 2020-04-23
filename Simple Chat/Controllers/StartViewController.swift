//
//  ViewController.swift
//  Simple Chat
//
//  Created by Cassy on 4/16/20.
//  Copyright © 2020 Cassy. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = C.appName
       
    }
}
