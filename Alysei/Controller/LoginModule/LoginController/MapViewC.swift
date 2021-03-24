//
//  MapViewC.swift
//  Alysei
//
//  Created by CodeAegis on 01/03/21.
//  Copyright © 2020 CodeAegis. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var lblUpdateLocation: UILabel!
  @IBOutlet weak var btnBack: UIButton!
  @IBOutlet weak var viewBottom: UIView!
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var imgViewMarker: UIImageView!
  @IBOutlet weak var btnSearchLocation: UIButton!
  @IBOutlet weak var viewSearchLocation: UIViewExtended!
  
  //MARK: - Properties -
  
  var centerMapCoordinate:CLLocationCoordinate2D!
  var marker = GMSMarker()
  var signUpStepTwoDataModel: SignUpStepTwoDataModel!
  var delegate: SaveAddressCallback?

  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.mapView.addSubview(self.imgViewMarker)
    self.mapView.addSubview(self.viewSearchLocation)
    self.intialGoogleSetup(withLatitude: kSharedUserDefaults.latitude, withLongitude: kSharedUserDefaults.longitude)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapConfirmLocation(_ sender: UIButton) {
    
    let storyboard = UIStoryboard.init(name: StoryBoardConstants.kLogin, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: SaveAddressViewC.id()) as! SaveAddressViewC
    viewController.signUpStepTwoDataModel = self.signUpStepTwoDataModel
    viewController.delegate = self
    viewController.modalPresentationStyle = .overCurrentContext
    self.navigationController?.present(viewController, animated: true, completion: nil)
  }
  
  @IBAction func tapSearchLocation(_ sender: UIButton) {
    
    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self
    self.present(autocompleteController, animated: true, completion: nil)
  }
  
  //MARK: - Private Methods -
 
  private func intialGoogleSetup(withLatitude latitude: Double, withLongitude longitude: Double) {
    
    self.getAddressFromGeoCodeAPI(latitude: latitude, longitude: longitude, handler: { (response: String?) in
      self.lblUpdateLocation.text = response
      kSharedUserDefaults.latitude = latitude
      kSharedUserDefaults.longitude = longitude
      let latitudeDegree = CLLocationDegrees(exactly: latitude)
      let longitudeDegree = CLLocationDegrees(exactly: longitude)
      self.centerMapCoordinate = CLLocationCoordinate2D(latitude: latitudeDegree ?? 0.0, longitude: longitudeDegree ?? 0.0 )
      let camera = GMSCameraPosition.camera(withLatitude: latitudeDegree ?? 0.0 , longitude: longitudeDegree ?? 0.0, zoom: 18.0)
      self.mapView.camera = camera
      self.mapView.delegate = self
    })
  }
}

//MARK: - GMSMapView Methods -

extension MapViewC: GMSMapViewDelegate{

  func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
  
    self.lblUpdateLocation.text = ""
  }
  
  func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    
    let latitude = mapView.camera.target.latitude
    let longitude = mapView.camera.target.longitude
    self.centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.getAddressFromGeoCodeAPI(latitude: latitude, longitude: longitude, handler: { (response: String?) in
      self.lblUpdateLocation.text = response
      kSharedUserDefaults.latitude = latitude
      kSharedUserDefaults.longitude = longitude
    })
  }
}

//MARK: - GMSDelegate Methods -

extension MapViewC: GMSAutocompleteViewControllerDelegate {

  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    
    kSharedUserDefaults.latitude = place.coordinate.latitude
    kSharedUserDefaults.longitude = place.coordinate.longitude
    self.intialGoogleSetup(withLatitude: kSharedUserDefaults.latitude, withLongitude: kSharedUserDefaults.longitude)
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print("Error: ", error.localizedDescription)
  }

  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }
}

extension MapViewC: SaveAddressCallback{
  
  func addressSaved(_ model: SignUpStepTwoDataModel, addressLineOne: String, addressLineTwo: String) {
    
    self.dismiss(animated: true){
      self.delegate?.addressSaved(model, addressLineOne: addressLineOne, addressLineTwo: addressLineTwo)
    }
  }
}