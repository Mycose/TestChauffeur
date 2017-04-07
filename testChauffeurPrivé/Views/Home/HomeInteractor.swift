//
//  HomeInteractor.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 05/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import MapboxGeocoder
import UIKit

/// Class HomeInteractor
///
/// Will handle all (inter)actions from the HomeViewController
///
class HomeInteractor: Interactor {
    /// The presenter var will store a reference to the HomePresenter
    var presenter: HomePresenter
    
    /**
     We setup the HomePresenter in the
     HomeInteractor, because only the interactor
     is allowed to call the presenter
     */
    init(presenter: HomePresenter) {
        self.presenter = presenter
    }
    
    func save(placemark: GeocodedPlacemark) {
        AddressManager().savePlacemark(placemark: placemark)
    }
}
