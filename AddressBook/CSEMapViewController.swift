//
//  CSEMapViewController.swift
//  AddressBook
//
//  Created by campstud on 7/13/18.
//  Copyright © 2018 campstud. All rights reserved.
//

import UIKit
import MapKit

class CSEMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var address: String = "Temp Address"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.processAddress(self.address)
    }
    
    func processAddress(_ address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in if placemarks!.count > 0 {
            let placemark = placemarks![0] as CLPlacemark
            let lat = placemark.location?.coordinate.latitude
            let lon = placemark.location?.coordinate.longitude
            self.centerMapAt(lat!,lon: lon!)
            self.setAnnotationAt(lat!, lon: lon!)
            let fromLat = 33.3919224 as CLLocationDegrees
            let fromLon = -111.9281011 as CLLocationDegrees
            let fromCoordinate = CLLocationCoordinate2DMake(fromLat, fromLon)
            let toPlacemark = MKPlacemark(placemark: placemark)
            let fromPlacemark = MKPlacemark(coordinate: fromCoordinate, addressDictionary: nil)
            let fromItem = MKMapItem(placemark: fromPlacemark)
            let toItem = MKMapItem(placemark: toPlacemark)
            
            self.findDirections(fromItem, to: toItem)
            }})
    }
    
    func findDirections(_ from: MKMapItem, to:MKMapItem) {
        let request = MKDirectionsRequest()
        request.source = from
        request.destination = to
        request.requestsAlternateRoutes = true
        request.transportType = MKDirectionsTransportType.automobile
        
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {(response, error) -> Void in
            if (error != nil) {
                print("Error!")
            }
            else {
                let route = response!.routes[0] as MKRoute
                self.mapView.add(route.polyline)
            }
        })
    }
    
    func centerMapAt(_ lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let center = CLLocationCoordinate2DMake(lat, lon)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let visibleRegion = MKCoordinateRegionMake(center, span)
        self.mapView.setRegion(visibleRegion, animated: true)
    }
    
    func setAnnotationAt(_ lat:CLLocationDegrees, lon: CLLocationDegrees) {
        let center = CLLocationCoordinate2DMake(lat, lon)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "generic title"
        annotation.subtitle = "generic subtitle"
        
        self.mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay:MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = UIColor.purple
        return renderer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
