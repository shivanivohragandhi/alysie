//
//  UserProductListPresenter.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/14/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UserProductListPresentationLogic
{
  func presentSomething(response: UserProductList.Something.Response)
}

class UserProductListPresenter: UserProductListPresentationLogic
{
  weak var viewController: UserProductListDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: UserProductList.Something.Response)
  {
    let viewModel = UserProductList.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}