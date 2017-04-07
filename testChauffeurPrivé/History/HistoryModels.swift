//
//  HistoryModels.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import MapboxGeocoder
import UIKit

/// struct HistoryViewModel
///
/// Will be used to transit data to the presenter and the ViewController
///
struct HistoryViewModel {
    var placemarks: [GeocodedPlacemark] = []
}
