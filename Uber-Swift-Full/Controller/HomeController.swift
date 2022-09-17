//
//  HomeController.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 31.08.2022.
//

import UIKit
import FirebaseAuth
import MapKit

class HomeController: UIViewController {
    // MARK: - Properties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let inputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
    }
}
// MARK: - Helper
extension HomeController{
    func style(){
        view.backgroundColor = .red
        //mapView Style
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        //inputActivationView Style
        inputActivationView.delegate = self
        inputActivationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputActivationView)
    }
    func layout(){
        //inputActivationView Layout
        NSLayoutConstraint.activate([
            inputActivationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputActivationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            inputActivationView.heightAnchor.constraint(equalToConstant: 50),
            inputActivationView.widthAnchor.constraint(equalToConstant: view.frame.size.width - 64)
        ])
    }
    private func configureLocationInputView(){
        locationInputView.delegate = self
        locationInputView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationInputView)
        NSLayoutConstraint.activate([
            locationInputView.topAnchor.constraint(equalTo: view.topAnchor),
            locationInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationInputView.heightAnchor.constraint(equalToConstant: 200)
        ])
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { _ in
            print("present table view...")
        }
        
    }
}
// MARK: - API
extension HomeController{
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }else{
            print("User uid: \(String(describing: Auth.auth().currentUser!.uid))")
            style()
            layout()
            enableLocationservices(locationManager)
        }
    }
    func signOut()  {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error signing out")
        }
    }
}

// MARK: - LocationServices
extension HomeController: CLLocationManagerDelegate{
    func enableLocationservices(_ manager: CLLocationManager){
        manager.delegate = self
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.requestAlwaysAuthorization()
        }
    }
}
// MARK: - LocationInputActivationViewDelegate
extension HomeController: LocationInputActivationViewDelegate{
    func presentLocationInputView() {
        inputActivationView.alpha = 0
        configureLocationInputView()
    }
}
// MARK: - LocationInputViewDelegate
extension HomeController: LocationInputViewDelegate{
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.inputActivationView.alpha = 1
            }
        }
        
    }
}
