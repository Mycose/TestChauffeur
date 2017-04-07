//
//  DrawerMenuViewController.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import UIKit

protocol DrawerMenuDelegate {
    func showHistoryButtonClicked()
}

class DrawerMenuViewController: UIViewController, VIPController {
    var interactor: DrawerMenuInteractor!

    var delegate: DrawerMenuDelegate?
    
    // MARK: Object lifecycle
    
    /**
     We link the interactor and the presneter for the DrawerMenuViewController
     In the awakeFromNib() (Instanciated once by the StoryBoard / IB)
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        interactor = DrawerMenuInteractor(presenter: DrawerMenuPresenter(vc: self))
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func showHistory() {
        self.dismiss(animated: false, completion: {
            self.delegate?.showHistoryButtonClicked()
        })
    }

    // MARK: Display logic
    
    /**
     layout() is called by the presenter AFTER being requested by the interactor
     AKA: Display the result from the Presenter
     */
    func layout(model: DrawerMenuViewModel) { }
}
