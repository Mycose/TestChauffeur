//
//  DrawerMenuPresenter.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import UIKit

/// Class DrawerMenuPresenter
///
/// Will be the Layout Updater for the DrawerMenuViewController
///
class DrawerMenuPresenter: Presenter {
    /// The viewController var will store a reference to the DrawerMenuViewController
    var viewController: DrawerMenuViewController
    
    /**
     We setup the DrawerMenuViewController in the
     DrawerMenuPresenter, because only the Presenter
     can update the viewController
     */
    init(vc: DrawerMenuViewController) {
        viewController = vc
    }
    
    /**
     This method will call the presenter to display the result of your doSomething() func
     Don't forget to write the corresponding XCTest
     */
    func presentSomething() {
        /// This will be called in the DrawerMenuViewController
        present(viewModel: DrawerMenuViewModel())
    }
}
