//
//  Menuable.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright © 2017 Clément Morissard. All rights reserved.
//

import UIKit
import PGDrawerTransition

protocol Menuable {
    func addBurgerMenuButton()
    func showDrawerMenu()
}

extension Menuable where Self: UIViewController  {

    func addBurgerMenuButton() {

        let sel = Selector(("showDrawerMenu"))
        let menuBtn = UIBarButtonItem(title: "menu", style: .done, target: self, action: sel)


        self.navigationItem.leftBarButtonItem = menuBtn
    }

    func showDrawerMenu() {

    }
}
