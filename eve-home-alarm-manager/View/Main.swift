//
//  Main.swift
//  eve-home-alarm-manager
//
//  Created by Kevin Wei on 2019-12-11.
//  Copyright © 2019 Kevin Wei. All rights reserved.
//

import UIKit
import HomeKit

class Main: UITableViewController {
    
    //Register list of devices
    var deviceList = [HMService]()
    
    var home: HMHome? {
        didSet {
            home?.delegate = DeviceStore.shared
            loadAccessories()
        }
    }
    
    func loadAccessories() {
        deviceList = []
        
        guard let home = home else { return }
        
        for accessory in home.accessories {

            accessory.delegate = DeviceStore.shared
            print(accessory)
            
            for service in accessory.services.filter({ $0.isPrimaryService }) {
                print(service)
                deviceList.append(service)
                // Ask for notifications from any characteristics that support them.
                for characteristic in service.characteristics.filter({
                    $0.properties.contains(HMCharacteristicPropertySupportsEventNotification)
                }) {
                    characteristic.enableNotification(true) { _ in }
                }
            }
        }
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        DeviceStore.shared.deviceManager.delegate = self
        DeviceStore.shared.addHomeDelegate(self)
        DeviceStore.shared.addAccessoryDelegate(self)
        
        loadAccessories()
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
                self.loadAccessories()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceCell
        
        let device = deviceList[indexPath.row]
        //        print("DEVICE", device)
        
        cell.sensorLabel.text = device.name
        cell.idLabel.text = device.uniqueIdentifier.uuidString
        cell.stateLabel.text = "Updating..."
        
        return cell
    }
    
    
    
}
