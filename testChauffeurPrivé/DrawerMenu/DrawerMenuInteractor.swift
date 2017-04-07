//
//  DrawerMenuInteractor.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import UIKit

/// Class DrawerMenuInteractor
///
/// Will handle all (inter)actions from the DrawerMenuViewController
///
class DrawerMenuInteractor: Interactor {
    /// The presenter var will store a reference to the DrawerMenuPresenter
    var presenter: DrawerMenuPresenter
    
    /**
     We setup the DrawerMenuPresenter in the
     DrawerMenuInteractor, because only the interactor
     is allowed to call the presenter
     */
    init(presenter: DrawerMenuPresenter) {
        self.presenter = presenter
    }
    
    /**
     This method will preform an action
     You may create another func if your interactor needs to do multiple actions
     Remember the single responsability principle: one function = one action
     Don't forget to write the corresponding XCTest
     */
    func doSomething() {
        // If your action needs complex computation, you may considerate to create a DrawerMenuworker
        let worker = DrawerMenuWorker()
        worker.doSomeWork()
    }
    
    /**
     This method will call the presenter to display the result of your doSomething() func
     Don't forget to write the corresponding XCTest
     */
    func presentSomething() {
        /// This will be called in the DrawerMenuPresenter
        presenter.presentSomething()
    }
}
