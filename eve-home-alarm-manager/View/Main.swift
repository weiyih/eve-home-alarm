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
    
    var devicesList = [HMService]()
    
//    var manager: HMHome? {
//        didSet {
//            manager?.delegate = DeviceManager.shared
//            reloadData()
//        }
//    }
    
    func reloadData() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        DeviceStore.shared.deviceManager.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
