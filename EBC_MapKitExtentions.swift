//
//  EBC_MapKitExtentions.swift
//
//
//  Created by Mike Anelli on 6/2/15.
//  Copyright (c) 2015 8BitCode. All rights reserved.
//
//  This is a translation to swift of an extention created by Troy Bryant.
//  http://troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/
//


import Foundation
import MapKit

extension MKMapView {

    private var MERCATOR_OFFSET: Double {
        get {
            return 268435456
        }
    }
    private var MERCATOR_RADIUS: Double {
        get {
            return 85445659.44705395
        }
    }
    
    
    // MARK: -  Private functions
    private func longitudeToPixelSpaceX (longitude: Double) -> Double {
        return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0)
    }
    
    private func latitudeToPixelSpaceY (latitude: Double) -> Double {
        
        let a = 1 + sinf(Float(latitude * M_PI) / 180.0)
        let b = 1.0 - sinf(Float(latitude * M_PI / 180.0)) / 2.0
        
        return round(MERCATOR_OFFSET - MERCATOR_RADIUS * Double(logf(a / b)))
    }
    
    private func pixelSpaceXToLongitude (pixelX: Double) -> Double {
        return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI
    }
    
    private func pixelSpaceYToLatitude (pixelY: Double) -> Double {
        return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI
    }

    private func coordinateSpanWithMapView(mapView: MKMapView, centerCoordinate: CLLocationCoordinate2D, andZoomLevel zoomLevel:Int) -> MKCoordinateSpan {
    
        // convert center coordiate to pixel space
        let centerPixelX = self.longitudeToPixelSpaceX(centerCoordinate.longitude)
        let centerPixelY = self.latitudeToPixelSpaceY(centerCoordinate.latitude)
        
        // determine the scale value from the zoom level
        let zoomExponent = 20 - zoomLevel
        let zoomScale = CGFloat(pow(Double(2), Double(zoomExponent)))
        
        // scale the map’s size in pixel space
        let mapSizeInPixels = mapView.bounds.size
        let scaledMapWidth = mapSizeInPixels.width * zoomScale
        let scaledMapHeight = mapSizeInPixels.height * zoomScale
        
        // figure out the position of the top-left pixel
        let topLeftPixelX = CGFloat(centerPixelX) - (scaledMapWidth / 2)
        let topLeftPixelY = CGFloat(centerPixelY) - (scaledMapHeight / 2)
        
        // find delta between left and right longitudes
        let minLng: CLLocationDegrees = self.pixelSpaceXToLongitude(Double(topLeftPixelX))
        let maxLng: CLLocationDegrees = self.pixelSpaceXToLongitude(Double(topLeftPixelX + scaledMapWidth))
        let longitudeDelta: CLLocationDegrees = maxLng - minLng
        
        // find delta between top and bottom latitudes
        let minLat: CLLocationDegrees = self.pixelSpaceYToLatitude(Double(topLeftPixelY))
        let maxLat: CLLocationDegrees = self.pixelSpaceYToLatitude(Double(topLeftPixelY + scaledMapHeight))
        let latitudeDelta: CLLocationDegrees = -1 * (maxLat - minLat)
        
        // create and return the lat/lng span
        let span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        
        return span
    
    }
    
    // MARK: - Public Functions
    
    func setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D, zoomLevel: Int, animated: Bool) {
    
        // clamp large numbers to 28
        let zoom = min(zoomLevel, 28)
        
        // use the zoom level to compute the region
        let span = self.coordinateSpanWithMapView(self, centerCoordinate:centerCoordinate, andZoomLevel:zoom)
        let region = MKCoordinateRegionMake(centerCoordinate, span)
        
        // set the region like normal
        self.setRegion(region, animated:animated)

    }
    
    
}
