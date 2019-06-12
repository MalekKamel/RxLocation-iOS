//
// Created by mac on 2019-05-28.
// Copyright (c) 2019 A. All rights reserved.
//

import CoreLocation
import UIKit
import RxSwift

typealias BackgroundDelegate = (([CLLocation]) -> Void)?
typealias ForegroundDelegate = (([CLLocation]) -> Void)?

public enum Authorization {
    case authorizeWhenInUse
    case authorizeAlways
}

private enum RequestType {
    case currentLocation
    case updates
    case none
}

public class RxLocation: NSObject {
    public lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    private var backgroundDelegate: BackgroundDelegate = nil
    private var foregroundDelegate: ForegroundDelegate = nil
    private var authorization: Authorization
    private var requestType: RequestType = .none
    
    let ps = PublishSubject<[CLLocation]>()
    
    public init(authorization: Authorization) {
        self.authorization = authorization
        super.init()
        retainMe()
    }
    
    public func requestLocationUpdates() -> Observable<[CLLocation]> {
        requestType = .updates
        setupLocationManager()
        return ps;
    }
    
    @discardableResult
    public func requestCurrentLocation() -> Observable<CLLocation> {
        let publishSubject = PublishSubject<CLLocation>()
        requestType = .currentLocation
        setupLocationManager()
        
       _ = ps.subscribe(onNext: { locations in
            publishSubject.onNext(locations.last!)
            publishSubject.onCompleted()
            self.ps.dispose()
        })
        
        return publishSubject;
    }
    
    public func stopLocationUpdates(){
        locationManager.stopUpdatingLocation()
        releaseMe()
    }
    
    private func setupLocationManager(){
        locationManager.delegate = self
        
        switch authorization{
        case .authorizeAlways:
            locationManager.requestAlwaysAuthorization()
            
        case .authorizeWhenInUse:
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
}

// MARK: - CLLocationManagerDelegate
extension RxLocation: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch authorization {
        case .authorizeAlways:
            if status != .authorizedAlways {
                return
            }

        case .authorizeWhenInUse:
            if status != .authorizedWhenInUse {
                return
            }
        }

        locationManager.startUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        switch requestType{
        case .currentLocation:
            stopLocationUpdates()
            ps.onNext(locations)
            ps.onCompleted()

        case .updates:
            ps.onNext(locations)

        case .none:
            return
        }
    }

}
