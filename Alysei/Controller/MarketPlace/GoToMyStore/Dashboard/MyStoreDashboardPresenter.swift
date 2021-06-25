           //
//  MyStoreDashboardPresenter.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/24/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MyStoreDashboardPresentationLogic
{
  func presentSomething(response: MyStoreDashboard.Something.Response)
}

class MyStoreDashboardPresenter: MyStoreDashboardPresentationLogic
{
  weak var viewController: MyStoreDashboardDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: MyStoreDashboard.Something.Response)
  {
    let viewModel = MyStoreDashboard.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}