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
    }
    func layout(){
        
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
