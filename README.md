# RxLocation

An RX wrapper for iOS location. It's simple and powerful.

<!---
[![CI Status](https://img.shields.io/travis/ShabanKamell/RxLocation.svg?style=flat)](https://travis-ci.org/ShabanKamell/RxLocation-iOS))
-->
[![Version](https://img.shields.io/cocoapods/v/RxLocation.svg?style=flat)](https://cocoapods.org/pods/RxLocation)
[![License](https://img.shields.io/cocoapods/l/RxLocation.svg?style=flat)](https://cocoapods.org/pods/RxLocation)
[![Platform](https://img.shields.io/cocoapods/p/RxLocation.svg?style=flat)](https://cocoapods.org/pods/RxLocation)

## Usage
#### Choose a persmission

```swift
var rxLocation = RxLocation(authorization: .authorizeAlways)
```

#### Current Location

```swift
var rxLocation = RxLocation(authorization: .authorizeAlways)

   rxLocation.requestCurrentLocation()
      .subscribe(onNext: { location in
          print(location)
       })
```

#### Location Updates

```swift

  rxLocation.requestLocationUpdates()
      .subscribe(onNext: { locations in
          print(locations[0])
       })
```

#### Stop Updates
To stop updates in case of using `rxLocation.requestLocationUpdates()`
```swift
  rxLocation.stopLocationUpdates()

```

#### Location Manager Options
```swift
  rxLocation.locationManager.showsBackgroundLocationIndicator = true

```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

RxLocation is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxLocation'
```

## Author

ShabanKamell, sh3ban.kamel@gmail.com

## License

RxLocation is available under the Apache license v2.0. See the LICENSE file for more info.
