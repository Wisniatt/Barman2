//
//  Menu.swift
//  Barman2
//
//  Created by Wisnia on 15.06.2015.
//  Copyright © 2015 Wisnia. All rights reserved.
//

import Foundation
import CoreBluetooth


class Menu: UIViewController{
    
    

    
    
    @IBOutlet var NazwaTool: UIBarButtonItem!

    @IBAction func Nazwa(sender: UIButton) {
        let nazwa = sender.currentTitle
        NazwaTool.title = nazwa
        print("nazwa = \(nazwa)")
        
        
    }
 
    
    
    
    
    @IBAction func make(sender: UIBarButtonItem) {
        
       // let ble = Bluetooth()
       // ble.sendText("coś")
        
    }

    @IBOutlet var Scrolling: UIScrollView!

    override func viewDidLoad() {
        Scrolling.contentSize.height = 3800
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
}