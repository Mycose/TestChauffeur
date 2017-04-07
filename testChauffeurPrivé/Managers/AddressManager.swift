//
//  AddressManager.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright © 2017 Clément Morissard. All rights reserved.
//

import MapboxGeocoder
import UIKit

class AddressManager: NSObject {
    static let sharedInstance = AddressManager()

    func savePlacemark(placemark: GeocodedPlacemark) {
        var placemarks = loadPlacemarks()

        if placemarks.count >= 15 {
            placemarks.removeFirst(1)
        }

        placemarks.append(placemark)

        let placemarksData = NSKeyedArchiver.archivedData(withRootObject: placemarks)

        UserDefaults.standard.set(placemarksData, forKey: "PlacemarksHistoryData")
        UserDefaults.standard.synchronize()
    }

    func loadPlacemarks() -> [GeocodedPlacemark] {
        guard let decodedData = UserDefaults.standard.object(forKey: "PlacemarksHistoryData") as? Data,
            let placemarks = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [GeocodedPlacemark]
            else {
                return []
        }
        return placemarks
    }
}
