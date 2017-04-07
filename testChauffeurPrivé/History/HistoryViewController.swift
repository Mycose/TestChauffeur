//
//  HistoryViewController.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 07/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import MapboxGeocoder
import UIKit

protocol HistoryViewControllerDelegate {
    func placemarkClicked(placemark: GeocodedPlacemark)
}

class HistoryViewController: UIViewController, VIPController, UITableViewDelegate, UITableViewDataSource {
    var interactor: HistoryInteractor!

    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonClose: UIButton!

    var delegate: HistoryViewControllerDelegate?

    var viewModel: HistoryViewModel?
    
    // MARK: Object lifecycle
    
    /**
     We link the interactor and the presneter for the HistoryViewController
     In the awakeFromNib() (Instanciated once by the StoryBoard / IB)
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        interactor = HistoryInteractor(presenter: HistoryPresenter(vc: self))
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchHistory()

        buttonClose.layer.cornerRadius = buttonClose.frame.width / 2
        buttonClose.layer.masksToBounds = false
    }
    
    // MARK: Display logic
    
    /**
     layout() is called by the presenter AFTER being requested by the interactor
     AKA: Display the result from the Presenter
     */
    func layout(model: HistoryViewModel) {
        viewModel = model
        tableView.reloadData()
    }

    @IBAction func buttonCloseClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: UITableViewDelegate, UITableViewDatasource

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vModel = viewModel {
            delegate?.placemarkClicked(placemark: vModel.placemarks[indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.placemarks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as? HistoryTableViewCell, let vModel = viewModel {
            cell.setData(address: vModel.placemarks[indexPath.row].qualifiedName ?? vModel.placemarks[indexPath.row].name)
            return cell
        }
        return UITableViewCell()
    }
}
