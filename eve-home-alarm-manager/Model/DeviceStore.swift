//
//  DeviceManager.swift
//  eve-home-alarm-manager
//
//  Created by Kevin Wei on 2019-12-11.
//  Copyright © 2019 Kevin Wei. All rights reserved.
//

import UIKit
import HomeKit

class DeviceStore: NSObject {

    static var shared = DeviceStore()
    
    let deviceManager = HMHomeManager()
    
    var homeDelegates = Set<NSObject>()
    
    var accessoryDelegates = Set<NSObject>()
    
}

extension DeviceStore {
    
}
