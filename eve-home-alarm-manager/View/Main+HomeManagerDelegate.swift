//
//  Main+HomeManagerDelegate.swift
//  eve-home-alarm-manager
//
//  Based on Apple's AccessoryUI sample code.
//


import HomeKit

/// Handle the home manager delegate callbacks.
extension Main: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        setOrAddHome(manager: manager)
    }
    
    func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        setOrAddHome(manager: manager)
    }
    
    /// Sets the home to either the primary home, or the first home, or a home that the user creates.
    func setOrAddHome(manager: HMHomeManager) {
        if manager.primaryHome != nil {
            home = manager.primaryHome
        } else if let firstHome = manager.homes.first {
            home = firstHome
        } else {
            let alert = UIAlertController(title: "Add a Home",
                                          message: "There aren’t any homes in the database. Create a home to work with.",
                                          preferredStyle: .alert)
            alert.addTextField { $0.placeholder = "Name" }
            alert.addAction(UIAlertAction(title: "Create", style: .default) { _ in
                if let name = alert.textFields?[0].text {
                    manager.addHome(withName: name) { home, error in
                        if let error = error {
                            print("Error adding home: \(error)")
                        } else {
                            self.home = home
                        }
                    }
                }
            })
            present(alert, animated: true)
        }
    }
}
