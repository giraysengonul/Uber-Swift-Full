//
//  HomeController.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 31.08.2022.
//

import UIKit
import FirebaseAuth
import MapKit
private let reuseIdentifier = "LocationInputCell"
class HomeController: UIViewController {
    // MARK: - Properties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let inputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    private final let locationInputViewHeight: CGFloat = 200
    private var user: User? {
        didSet{ locationInputView.user = user }
    }
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUserData()
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
        configureTableView()
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
            locationInputView.heightAnchor.constraint(equalToConstant: locationInputViewHeight)
        ])
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            } completion: { _ in
                
            }
            
        }
    }
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationInputCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height)
        //        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
}
// MARK: - API
extension HomeController{
    
    func fetchUserData() {
        Service.fetchUserData { user in
            self.user = user
        }
    }
    
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
        locationInputView.removeFromSuperview()
        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        } completion: { _ in
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3) {
                self.inputActivationView.alpha = 1
            }
        }
        
    }
}
// MARK: - UITableViewDelegate/DataSource
extension HomeController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath) as! LocationInputCell
        
        return cell
    }
}
