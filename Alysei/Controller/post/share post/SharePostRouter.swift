//
//  SharePostRouter.swift
//  Alysei
//
//  Created by Janu Gandhi on 20/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol SharePostRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SharePostDataPassing {
    var dataStore: SharePostDataStore? { get }
}

class SharePostRouter: NSObject, SharePostRoutingLogic, SharePostDataPassing {
    weak var viewController: SharePostViewController?
    var dataStore: SharePostDataStore?

    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: SharePostViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: SharePostDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
