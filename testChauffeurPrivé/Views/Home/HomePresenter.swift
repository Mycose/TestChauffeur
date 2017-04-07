//
//  HomePresenter.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 05/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import UIKit

/// Class HomePresenter
///
/// Will be the Layout Updater for the HomeViewController
///
class HomePresenter: Presenter {
    /// The viewController var will store a reference to the HomeViewController
    var viewController: HomeViewController
    
    /**
     We setup the HomeViewController in the
     HomePresenter, because only the Presenter
     can update the viewController
     */
    init(vc: HomeViewController) {
        viewController = vc
    }
    
    /**
     This method will call the presenter to display the result of your doSomething() func
     Don't forget to write the corresponding XCTest
     */
    func presentSomething() {
        /// This will be called in the HomeViewController
        present(viewModel: HomeViewModel())
    }
}
