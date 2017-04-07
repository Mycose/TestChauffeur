//
//  HistoryInteractor.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import MapboxGeocoder
import UIKit

/// Class HistoryInteractor
///
/// Will handle all (inter)actions from the HistoryViewController
///
class HistoryInteractor: Interactor {
    /// The presenter var will store a reference to the HistoryPresenter
    var presenter: HistoryPresenter
    
    /**
     We setup the HistoryPresenter in the
     HistoryInteractor, because only the interactor
     is allowed to call the presenter
     */
    init(presenter: HistoryPresenter) {
        self.presenter = presenter
    }

    func fetchHistory() {
        let placemarks = AddressManager().loadPlacemarks()

        presenter.presentPlacemarks(placemarks: placemarks)
    }
}
