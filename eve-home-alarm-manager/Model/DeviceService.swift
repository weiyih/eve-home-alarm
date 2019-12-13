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
    
    /// The primary characteristic type to be controlled, given the service type.
    var primaryControlCharacteristicType: String? {
        switch deviceServiceType {
        case .contact: return HMCharacteristicTypeContactState
        case .motion: return HMCharacteristicTypeMotionDetected
        case .unknown: return nil
        }
    }
    
    // Main display characteristic of the service
    var primaryDisplayCharacteristic: HMCharacteristic? {
        return characteristics.first { $0.characteristicType == primaryControlCharacteristicType }
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
                
            } else {
                return ("Unknown")
            }
        case .motion:
            if let value = primaryDisplayCharacteristic?.value as? Int,
                let motionState = HMCharacteristicValueOccupancyStatus(rawValue: value) {
                switch motionState {
                case .occupied: return ("Motion Detected")
                case .notOccupied: return ("No Motion Detected")
                @unknown default: return ("Unknown")
                }
            } else {
                return ("Unknown")
            }
        case .unknown:
            return ("Unknown")
        }
    }
    
}
