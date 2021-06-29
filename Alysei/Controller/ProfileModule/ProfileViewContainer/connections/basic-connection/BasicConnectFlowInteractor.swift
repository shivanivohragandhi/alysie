//
//  BasicConnectFlowInteractor.swift
//  Alysei
//
//  Created by Janu Gandhi on 11/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BasicConnectFlowBusinessLogic {
    func sendConnectionRequest(_ model: BasicConnectFlow.Connection.request)
}

protocol BasicConnectFlowDataStore {
    //var name: String { get set }
}

class BasicConnectFlowInteractor: BasicConnectFlowBusinessLogic, BasicConnectFlowDataStore {
    var presenter: BasicConnectFlowPresentationLogic?
    var worker: BasicConnectFlowWorker?
    //var name: String = ""

    // MARK:- protocol methods
    func sendConnectionRequest(_ model: BasicConnectFlow.Connection.request) {
        do {
            let urlString = APIUrl.Connection.sendRequest

            let body = try JSONEncoder().encode(model)

            guard var request = WebServices.shared.buildURLRequest(urlString, method: .POST) else {
                return
            }
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = model.urlEncoded()

//            request.httpBody = body

            WebServices.shared.request(request) { data, URLResponse, statusCode, error in
               print("Success---------------------------Successssss")
                self.presenter?.showConnectionConfirmScreen()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
  
}
