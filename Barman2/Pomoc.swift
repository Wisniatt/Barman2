//
//  Pomoc.swift
//  Barman
//
//  Created by Wisnia on 13.06.2015.
//  Copyright (c) 2015 Wisnia. All rights reserved.
//

import Foundation
class Pomoc: UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}