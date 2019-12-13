//
//  DeviceService.swift
//  eve-home-alarm-manager
//
//  Created by Kevin Wei on 2019-12-13.
//  Copyright © 2019 Kevin Wei. All rights reserved.
//

import UIKit
import HomeKit

extension HMService {
    
    // App supported  service types
    enum AlarmServiceType {
        case contact, motion, unknown
    }
    
    // Convert system service type into enum
    var deviceServiceType: AlarmServiceType {
        switch serviceType {
        case HMServiceTypeMotionSensor: return .motion
//        case HMServiceTypeWindow, HMServiceTypeDoor: return .door
        case HMServiceTypeContactSensor: return .contact
        default: return .unknown
        }
    }
    

    //Returns string of the current state of service
    private var state: String {
        switch deviceServiceType {
        case .contact:
            if let value = primaryDisplayCharacteristic?.value as? Int,
                let doorState = HMCharacteristicValueContactState(rawValue: value) {
                switch doorState {
                    //                case .open: return ("Open")
                    //                case .closed: return ("Closed")
                    //                case .opening: return ("Opening")
                    //                case .closing: return ("Closing")
                //                case .stopped: return ("Stopped")
                case .detected: return ("Closed")
                case .none: return ("Open")
                @unknown default: return ("Unknown")
                }
            }
        case .motion:
            if let value = primaryDisplayCharacteristic?.value as? Int,
                let motionState = HMCharacteristicValueContactState(rawValue: value) {
                switch motionState {
                case .detected: return ("Motion Detected")
                case .none: return ("No Motion Detected")
                @unknown default: return ("Unknown")
                }
            }
            return ("Unknown")
            
        case .unknown:
            return ("Unknown")
        }
    }

}
