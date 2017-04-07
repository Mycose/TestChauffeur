//
//  CleanSwift.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 30/03/17.
//  Copyright © 2017 Clément Morissard. All rights reserved.
//

import UIKit

/// Protocol Interactor
protocol Interactor {
    associatedtype Presenter
    var presenter: Presenter { get set }
}

/// Protocol Presenter
protocol Presenter {
    associatedtype VC
    var viewController: VC { get set }
}

/// extension Presenter
///
/// Will extend the presenter protocol to add functionnality
///
extension Presenter where VC: VIPController {
    typealias ViewModel = VC.ViewModel
    func present(viewModel: ViewModel) {
        viewController.layout(model: viewModel)
    }

}

/// Protocol VIPController
///
/// Need to be implemented by all scenes
///
protocol VIPController {
    associatedtype Interactor
    associatedtype ViewModel
    var interactor: Interactor { get set }
    func layout(model: ViewModel)
}

/// extension VIP
///
/// Connect interactor, presenter and ViewModel
///
extension VIPController { }
