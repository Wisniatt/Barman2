//
//  Bluetooth.swift
//  Barman2
//
//  Created by Wisnia on 16.06.2015.
//  Copyright © 2015 Wisnia. All rights reserved.
//

import Foundation
import CoreBluetooth


class Bluetooth: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    var manager:CBCentralManager!
    var peripheral: CBPeripheral?
    var terminalChar:CBCharacteristic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        }
    
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("Discovered \(peripheral.name)")
        
        manager.stopScan()
        self.peripheral = peripheral
        peripheral.delegate = self
        manager.connectPeripheral(peripheral, options: nil)
    }
    
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: "DFB0")])
        let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
        print("Connected:\(state)")

    }
    

    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        
        
        var svc:CBService
        
        for svc in peripheral.services! {
            print("Service \(svc)\n")
            print("Discovering Characteristics for Service : \(svc)")
            peripheral.discoverCharacteristics([CBUUID(string: "DFB1")],forService: svc as CBService)
       }

    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        
        if (error != nil) {
            return
        }
        
        for characteristic in service.characteristics! {
            if characteristic.UUID == CBUUID(string: "DFB1") {
                self.terminalChar = (characteristic as CBCharacteristic)
                peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                
                // Send notification that Bluetooth is connected and all required characteristics are discovered
                print("Found characteristic we were looking for!")
                print(peripheral.readValueForCharacteristic(characteristic as CBCharacteristic))
                
            }
        }
    }
    
    
    

    
    
    
    func sendText(data : String){

        let data = (data as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        if let peripheral = peripheral{
            if let characteristic = terminalChar{
        
        peripheral.writeValue(data!,  forCharacteristic: characteristic , type: CBCharacteristicWriteType.WithoutResponse)
        
                     }
                }
            }
    
    
    
    
    
    
    
    
    
    @IBAction func Send(sender: UIButton) {
      
      sendText("coś")
        
    }



    

    
    
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        
        switch (central.state) {
        case .PoweredOff:
            print("CoreBluetooth BLE hardware is powered off")
            
        case .PoweredOn:
            print("CoreBluetooth BLE hardware is powered on and ready")
            manager.scanForPeripheralsWithServices(nil, options: nil)
            
        case .Resetting:
            print("CoreBluetooth BLE hardware is resetting")
            
        case .Unauthorized:
            print("CoreBluetooth BLE state is unauthorized")
            
        case .Unknown:
            print("CoreBluetooth BLE state is unknown");
            
        case .Unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform");
            
        }
       
        }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}