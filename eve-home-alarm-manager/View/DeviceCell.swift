//
//  DeviceCell.swift
//  eve-home-alarm-manager
//
//  Created by Kevin Wei on 2019-12-13.
//  Copyright © 2019 Kevin Wei. All rights reserved.
//

import UIKit
import HomeKit

class DeviceCell: UITableViewCell {
    
    @IBOutlet weak var sensorLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
        
    /// The service that this cell represents.
    var service: HMService? {
        didSet {
            
            sensorLabel.text = service?.name
            idLabel.text = service?.accessory?.uniqueIdentifier.uuidString
            stateLabel.text = "Updating..."
            
//            readAndRedraw(characteristic: service?.primaryDisplayCharacteristic, animated: true)
            readAndRedraw(characteristic: nil, animated: true)
        }
    }
    
    /// Reads the characteristic value from the HomeKit database, and updates the UI.
    func readAndRedraw(characteristic: HMCharacteristic?, animated: Bool) {
        guard
            let characteristic = characteristic,
            characteristic.properties.contains(HMCharacteristicPropertyReadable),
            let accessory = characteristic.service?.accessory,
            accessory.isReachable else {
                stateLabel.text = "Unreachable"
                return
        }
        
        characteristic.readValue { error in
            self.redrawState(error: error)
        }
    }
    
    /// Updates the UI to reflect the given state.
    func redrawState(error: Error? = nil) {
        if let error = error {
            print(error.localizedDescription)
            stateLabel.text = "Update error!"
        } else {
//            stateLabel.text = service?
            stateLabel.text = "TODO"
        }
    }
}
