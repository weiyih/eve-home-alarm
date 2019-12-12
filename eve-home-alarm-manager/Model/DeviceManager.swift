//
//  DeviceManager.swift
//  eve-home-alarm-manager
//
//  Created by Kevin Wei on 2019-12-11.
//  Copyright © 2019 Kevin Wei. All rights reserved.
//

import UIKit
import HomeKit

class DeviceManager: NSObject {

    static var shared = DeviceManager()
    
    let deviceManager = HMHomeManager()
    
    var homeDelegates = Set<NSObject>()
    
    var accessoryDelegates = Set<NSObject>()
    
}
