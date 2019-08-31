//
//  ViewController.swift
//  IBeacon
//
//  Created by Mr Uy Nguyen Long Uy on 8/17/18.
//  Copyright © 2018 fossil. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    var peripheralManager : CBPeripheralManager?
    let uuid = UUID(uuidString: "086704EE-9611-4ACC-91DB-F983ABAC9153")
    let identifier = "uynguyen"
    let major: CLBeaconMajorValue = 1
    let minor: CLBeaconMinorValue = 0
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
    }
    

    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error == nil {
            print("Successfully started advertising our beacon data.")
            let message = "Successfully set up your beacon. " +
            "The unique identifier of our service is: \(String(describing: uuid?.uuidString))"
            let controller = UIAlertController(title: "iBeacon", message: message,
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK",
                                               style: .default,
                                               handler: nil))
            present(controller, animated: true, completion: nil)
        } else {
            print("Failed to advertise our beacon. Error = \(String(describing: error))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnStopTouchUpInside(_ sender: Any) {
        peripheralManager?.stopAdvertising()
    }
    
    @IBAction func btnStartTouchUpInside(_ sender: Any) {
        if peripheralManager!.state == .poweredOn {
            let region = CLBeaconRegion(proximityUUID: self.uuid!,
                                        major: self.major,
                                        minor: self.minor,
                                        identifier: self.identifier)
            let peripheralData = region.peripheralData(withMeasuredPower: nil)
            peripheralManager!.startAdvertising(((peripheralData as NSDictionary) as! [String : Any]))
        }
    }
}

