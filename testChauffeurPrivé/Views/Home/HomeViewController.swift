//
//  HomeViewController.swift
//  testChauffeurPrivé
//
//  Created by Clément Morissard on 05/04/17.
//  Copyright (c) 2017 Clément Morissard. All rights reserved.
//
//  DRI: Clément Morissard
//

import PGDrawerTransition
import MapboxGeocoder
import Mapbox
import UIKit

class HomeViewController: UIViewController, VIPController, MGLMapViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, DrawerMenuDelegate, HistoryViewControllerDelegate {
    var interactor: HomeInteractor!

    @IBOutlet var mapView: MGLMapView!

    @IBOutlet var addressField: UITextField!
    @IBOutlet var menuButton: UIButton!

    let cellHeight: CGFloat = 30.0
    @IBOutlet var autocompleteTableView: UITableView!
    @IBOutlet var autocompleteTableViewHeightConstraints: NSLayoutConstraint!

    var centerMarker: MGLPointAnnotation = MGLPointAnnotation()

    let geocoder: Geocoder = Geocoder(accessToken: "pk.eyJ1IjoieG15Y29zZSIsImEiOiJjajE0bjZubTYwMDBtMzJwYXV5cXVrN3hvIn0.t0liCEAuW_Ej0KWTQ8tR3A")

    var prevTask: URLSessionDataTask?

    var autoCompleteResults: [GeocodedPlacemark]?

    var customTransition: PGDrawerTransition?

    var currentUserLocation: MGLUserLocation?

    // MARK: Object lifecycle

    /**
     We link the interactor and the presneter for the HomeViewController
     In the awakeFromNib() (Instanciated once by the StoryBoard / IB)
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        interactor = HomeInteractor(presenter: HomePresenter(vc: self))
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.layer.cornerRadius = menuButton.frame.width / 2
        menuButton.layer.masksToBounds = false
        
        mapView.addAnnotation(centerMarker)

        addressField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }


    // MARK: Display logic

    /**
     layout() is called by the presenter AFTER being requested by the interactor
     AKA: Display the result from the Presenter
     */
    func layout(model: HomeViewModel) { }

    // MARK: MGLMapViewDelegate
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }

    func setMapViewPlacemark(placemark: GeocodedPlacemark) {
        centerMarker.coordinate = placemark.location.coordinate
        mapView.centerCoordinate = placemark.location.coordinate
        addressField.text = placemark.qualifiedName
        addressField.resignFirstResponder()
    }

    func setMapViewCoordinate(coordinate: CLLocationCoordinate2D) {
        centerMarker.coordinate = coordinate
        mapView.centerCoordinate = coordinate
    }

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        if let userLoc = mapView.userLocation {
            mapView.centerCoordinate = userLoc.coordinate
            mapView.zoomLevel = 18
        }
    }

    func mapViewDidFinishRenderingMap(_ mapView: MGLMapView, fullyRendered: Bool) {
        if let userLoc = mapView.userLocation {
            if currentUserLocation == nil {
                currentUserLocation = userLoc
                centerMarker.coordinate = userLoc.coordinate
                mapView.centerCoordinate = userLoc.coordinate
                mapView.zoomLevel = 18
            }
        }
    }

    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        if let userLoc = userLocation {
            if currentUserLocation == nil {
                currentUserLocation = userLoc
                centerMarker.coordinate = userLoc.coordinate
                mapView.centerCoordinate = userLoc.coordinate
                mapView.zoomLevel = 18
            }
        }
    }

    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        centerMarker.coordinate = mapView.centerCoordinate
    }

    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        if let pT = prevTask {
            pT.cancel()
        }

        if addressField.isEditing == false {
            let options = ReverseGeocodeOptions(coordinate: centerMarker.coordinate)
            prevTask = geocoder.geocode(options) { (placemarks, attribution, error) in
                if let placemark = placemarks?.first {
                    self.addressField.text = placemark.qualifiedName
                    self.interactor.save(placemark: placemark)
                }
            }
        }
    }

    // MARK: UITextFieldDelegate
    func textFieldDidChange(_ textField: UITextField) {
        if let pT = prevTask {
            pT.cancel()
        }

        let options = ForwardGeocodeOptions(query: textField.text!)
        prevTask = geocoder.geocode(options) { (placemarks, attribution, error) in
            self.autoCompleteResults = placemarks
            self.autocompleteTableView.reloadData()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if autoCompleteResults != nil && autoCompleteResults!.count > 0 {
            self.tableView(autocompleteTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        } else {
            textField.resignFirstResponder()
        }
        return false
    }

    // MARK: UITableViewDelegate UITableViewDatasource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let placemarks = autoCompleteResults {
            setMapViewPlacemark(placemark: placemarks[indexPath.row])
            mapView.zoomLevel = 18

            autoCompleteResults = nil
            autocompleteTableView.reloadData()

            interactor.save(placemark: placemarks[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as? ResultTableViewCell {
            if let placemarks = autoCompleteResults {
                cell.setData(address: placemarks[indexPath.row].qualifiedName)
            }
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = autoCompleteResults?.count ?? 0
        autocompleteTableViewHeightConstraints.constant = CGFloat(count) * cellHeight
        return count
    }

    @IBAction func showDrawerMenu() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DrawerMenuViewController") as? DrawerMenuViewController {
            vc.delegate = self
            customTransition = PGDrawerTransition(targetViewController: self, drawerViewController: vc)
            customTransition?.presentDrawerViewControllerWith(animated: true, completion: nil)
        }
    }

    // MARK: DrawerMenuDelegate
    func showHistoryButtonClicked() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController {
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }

    // MARK: HistoryViewControllerDelegate
    func placemarkClicked(placemark: GeocodedPlacemark) {
        setMapViewPlacemark(placemark: placemark)
        mapView.zoomLevel = 18
    }
}
