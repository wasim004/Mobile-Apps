//
//  MapViewController.swift
//  MapKitDirection
//
//  Created by Simon Ng on 6/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  @IBOutlet var segmentedControl:UISegmentedControl!
   
    @IBOutlet var mapView: MKMapView!
  
    var currentTransportType = MKDirectionsTransportType.automobile
    var restaurant:Restaurant!
    let locationManager = CLLocationManager()
    var currentPlacemark:CLPlacemark?

    @IBAction func showDirection(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: currentTransportType = MKDirectionsTransportType.automobile case 1: currentTransportType = MKDirectionsTransportType.walking default: break
        }
        segmentedControl.isHidden = false

        guard let currentPlacemark = currentPlacemark else { return
        }
        let directionRequest = MKDirectionsRequest()
        // Set the source and destination of the route
        directionRequest.source = MKMapItem.forCurrentLocation()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = currentTransportType
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (routeResponse, routeError) -> Void in
            guard let routeResponse = routeResponse else {
            if let routeError = routeError {
                print("Error: \(routeError)")
            }
            return
            }
            let route = routeResponse.routes[0]
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        

        } }

    @IBAction func showNearby(sender: UIButton) {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = restaurant.type
        searchRequest.region = mapView.region
        
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print(error)
                }
                
                return
            }
            
            let mapItems = response.mapItems
            var nearbyAnnotations: [MKAnnotation] = []
            if mapItems.count > 0 {
                for item in mapItems {
                    // Add annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    if let location = item.placemark.location {
                        annotation.coordinate = location.coordinate
                    }
                    nearbyAnnotations.append(annotation)
                }
            }
            
            self.mapView.showAnnotations(nearbyAnnotations, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        segmentedControl.isHidden = false
        
        mapView.showsUserLocation = true
      
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true }
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                self.currentPlacemark = placemark
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            
        })
        
        mapView.delegate = self
        if #available(iOS 9.0, *) {
            mapView.showsCompass = true
            mapView.showsScale = true
            mapView.showsTraffic = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
       renderer.strokeColor = (currentTransportType == .automobile) ? UIColor.blue : UIColor.orange
        renderer.lineWidth = 3.0
        return renderer
    }
    
    // MARK: - MKMapViewDelegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation.isKind(of: MKUserLocation.self) { return nil
        }
        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation,
                                                 reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        if let currentPlacemarkCoordinate = currentPlacemark?.location?.coordinate { if currentPlacemarkCoordinate.latitude == annotation.coordinate.latitude &&
            currentPlacemarkCoordinate.longitude == annotation.coordinate.longitude { let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53,
                                                                                                                                        height: 53))
            leftIconView.image = UIImage(named: restaurant.image)
            annotationView?.leftCalloutAccessoryView = leftIconView
            // Pin color customization
            if #available(iOS 9.0, *) { annotationView?.pinTintColor = UIColor.orange
            } } else {
            // Pin color customization
            if #available(iOS 9.0, *) { annotationView?.pinTintColor = UIColor.red
            } }
        }
        annotationView?.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
        return annotationView }}
