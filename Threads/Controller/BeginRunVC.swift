//
//  BeginRunVC.swift
//  Threads
//
//  Created by Molnár Csaba on 2019. 08. 03..
//  Copyright © 2019. Molnár Csaba. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        mapView.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

    @IBAction func locationCenterPressed(_ sender: Any) {
        centerMapOnUserLocation()
    }
    
    func centerMapOnUserLocation(){
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 500, 500)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func centerMapOnPrevRout(locations: List<Location>) -> MKCoordinateRegion {
        guard let initialLoc = locations.first else { return MKCoordinateRegion() }
        var minLat = initialLoc.latitude
        var minLon = initialLoc.latitude
        var maxLat = minLat
        var maxLon = minLon
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLon = min(minLon, location.longitude)
            maxLat = max(maxLat, location.latitude)
            maxLon = max(maxLon, location.longitude)
        }
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2), span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat)*1.4, longitudeDelta: (maxLon - minLon)*1.4))
    }
    
    @IBAction func lastRunCloseButtonPressed(_ sender: Any) {
        lastRunStackView.isHidden = true
        lastRunView.isHidden = true
        lastRunCloseBtn.isHidden = true
        mapView.userTrackingMode = .follow
    }
    
    func setupMapView(){
        if let overlay = addLastRunToMap(){
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.add(overlay)
            lastRunStackView.isHidden = false
            lastRunView.isHidden = false
            lastRunCloseBtn.isHidden = false
        } else {
            lastRunStackView.isHidden = true
            lastRunView.isHidden = true
            lastRunCloseBtn.isHidden = true
            mapView.userTrackingMode = .follow
        }
    }
    
    func addLastRunToMap() ->MKPolyline? {
        guard  let lastRun = Run.getAllRuns()?.first else { return nil }
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
        var coordinate = [CLLocationCoordinate2D]()
        for location in lastRun.locations {
            coordinate.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        
        mapView.userTrackingMode = .none
//        guard let locations = Run.getRun(byId: lastRun.id)?.locations else { return MKPolyline()}
        
        mapView.setRegion(centerMapOnPrevRout(locations: lastRun.locations), animated: true)
        
        return MKPolyline(coordinates: coordinate, count: coordinate.count)
    }
    
}

extension BeginRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
}









