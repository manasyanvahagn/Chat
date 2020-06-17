//
//  FirstViewController.swift
//  Chat
//
//  Created by Vahagn Manasyan on 5/13/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit
import FirebaseDatabase


class FirstViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setup() {
        loginButton.layer.cornerRadius = 0.05 * loginButton.bounds.size.width
        signUpButton.layer.cornerRadius = 0.05 * signUpButton.bounds.size.width
    }
    
}
