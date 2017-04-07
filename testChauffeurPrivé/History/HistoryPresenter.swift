//
//  HistoryPresenter.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import MapboxGeocoder
import UIKit

/// Class HistoryPresenter
///
/// Will be the Layout Updater for the HistoryViewController
///
class HistoryPresenter: Presenter {
    /// The viewController var will store a reference to the HistoryViewController
    var viewController: HistoryViewController
    
    /**
     We setup the HistoryViewController in the
     HistoryPresenter, because only the Presenter
     can update the viewController
     */
    init(vc: HistoryViewController) {
        viewController = vc
    }
    
    func presentPlacemarks(placemarks: [GeocodedPlacemark]) {
        present(viewModel: HistoryViewModel(placemarks: placemarks))
    }
}
