//
//  ViewController.swift
//  PKExample
//
//  Created by Scott Newman on 5/11/16.
//  Copyright © 2016 Radius Networks. All rights reserved.
//

import UIKit
import ProximityKit

class ViewController: UIViewController, RPKManagerDelegate {

  var proximityKitManager: RPKManager?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    // WARNING: Use the values from your kit in the configuration
    
    let configDict: [String:Any] = [
      "PKAPIToken": "0000000000000000000000000000000000000000000000000000000000000000",
      "PKGlobalUserIdentifier": 00000,
      "PKKitName": "[ck_0000] Not a Real Kit",
      "PKKitURL": "https://proximitykit.radiusnetworks.com/api/kits/0000",
      "PKUserEmail": "example@example.com",
      "PKUserIdentifier": 0000
    ]

    self.proximityKitManager = RPKManager(delegate:self, andConfig:configDict)
    
    if let proximityKitManager = self.proximityKitManager {
      proximityKitManager.start()
    }
    
  }

  // MARK: Proximity Kit Delegate Methods
  
  func proximityKitDidSync(_ manager : RPKManager) {
    print("Proximity Kit did sync")
  }
  
  func proximityKit(_ manager: RPKManager!, didDetermineState state: RPKRegionState, for region: RPKRegion!) {
    
    var stateDescription: String
    
    switch (state) {
      case .inside:
        stateDescription = "Inside"
      case .outside:
        stateDescription = "Outside"
      case .unknown:
        stateDescription = "Unknown"
    }

    print("State Changed: \(stateDescription) Region \(region.name) (\(region.identifier))")
  }
  
  func proximityKit(_ manager : RPKManager, didEnter region:RPKRegion) {
    print("Entered Region \(region.name), \(region.identifier)");
  }
  
  func proximityKit(_ manager : RPKManager, didExit region:RPKRegion) {
    print("Exited Region \(region.name), \(region.identifier)");
  }
  
  func proximityKit(_ manager: RPKManager!, didRangeBeacons beacons: [Any]!, in region: RPKBeaconRegion!) {
    for beacon in beacons as! [RPKBeacon] {
      print("Major: \(beacon.major), Minor: \(beacon.minor)")
    }
  }

}
