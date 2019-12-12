//
//  Main.swift
//  eve-home-alarm-manager
//
//  Created by Kevin Wei on 2019-12-11.
//  Copyright © 2019 Kevin Wei. All rights reserved.
//

import UIKit
import HomeKit

class Main: UIViewController {
    
    // Filtered list of devices
    var devicesList = [HMService]()

       
    var home: HMHome? {
        didSet {
            home?.delegate = DeviceStore.shared
            reloadData()
        }
    }
    
    func reloadData() {
        
//        deviceLists = []
        
        guard let home = home else { return }
        
        for accessory in home.accessories {
            accessory.delegate = DeviceStore.shared
            print(accessory)
            
//            for service in accessory.services.filter({ $0.isUserInteractive })
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DeviceStore.shared.deviceManager.delegate = self
        DeviceStore.shared.addHomeDelegate(self)
        DeviceStore.shared.addAccessoryDelegate(self)
    }
    
    /// Deregisters this view controller as various kinds of delegate.
    deinit {
        DeviceStore.shared.deviceManager.delegate = nil
        DeviceStore.shared.removeHomeDelegate(self)
        DeviceStore.shared.removeAccessoryDelegate(self)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addDevices(_ sender: Any) {
        // Consistent user experience for HomeKit apps
        // replaces HMAccessoryBrowser
        home?.addAndSetupAccessories(completionHandler: { error in
            if let error = error {
                print(error)
            } else {
                // Make no assumption about changes; just reload everything.
                self.reloadData()
            }
        })
    }


}
