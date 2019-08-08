//
//  BeginRunVC.swift
//  Threads
//
//  Created by Molnár Csaba on 2019. 08. 03..
//  Copyright © 2019. Molnár Csaba. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVC {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lastRunView: UIView!
    @IBOutlet weak var lastRunStackView: UIStackView!
    
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var lastRunCloseBtn: UIButton!
    @IBOutlet weak var durationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        getLastRun()
        manager?.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

    @IBAction func locationCenterPressed(_ sender: Any) {
        
    }
    
    @IBAction func lastRunCloseButtonPressed(_ sender: Any) {
        lastRunStackView.isHidden = true
        lastRunView.isHidden = true
        lastRunCloseBtn.isHidden = true
    }
    
    func getLastRun(){
        guard let lastRun = Run.getAllRuns()?.first else {
            lastRunStackView.isHidden = true
            lastRunView.isHidden = true
            lastRunCloseBtn.isHidden = true
            return
        }
        lastRunStackView.isHidden = false
        lastRunView.isHidden = false
        lastRunCloseBtn.isHidden = false
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
    }
    
}

extension BeginRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}
