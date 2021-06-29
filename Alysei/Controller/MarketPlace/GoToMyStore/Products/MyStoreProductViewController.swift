//
//  MyStoreProductViewController.swift
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

protocol MyStoreProductDisplayLogic: class
{
  func displaySomething(viewModel: MyStoreProduct.Something.ViewModel)
    func displayProductListData(_ productArr: [MyStoreProductDetail]?)
}

class MyStoreProductViewController: AlysieBaseViewC, MyStoreProductDisplayLogic
{
    func displayProductListData(_ productArr: [MyStoreProductDetail]?) {
        print("------------------------Show Data----------------------------------------------")
        self.productList = productArr
        self.myTotalProducts.text = "My product (\(productArr?.count ?? 0))"
        collectionView.reloadData()
    }
    
    
  var interactor: MyStoreProductBusinessLogic?
  var router: (NSObjectProtocol & MyStoreProductRoutingLogic & MyStoreProductDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = MyStoreProductInteractor()
    let presenter = MyStoreProductPresenter()
    let router = MyStoreProductRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    self.interactor?.callMyStoreProductApi()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var myTotalProducts: UILabel!
    var productList: [MyStoreProductDetail]?
  
  func doSomething()
  {
    let request = MyStoreProduct.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: MyStoreProduct.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    
    @IBAction func addProductAction(_ sender: UIButton){
        let controller = self.pushViewController(withName: AddProductMarketplaceVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddProductMarketplaceVC
       
    }
}

extension MyStoreProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 15
        return productList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyStoreProductCVCell", for: indexPath) as? MyStoreProductCVCell else {return UICollectionViewCell()}
        cell.configCell(productList?[indexPath.row] ?? MyStoreProductDetail(with: [:]))
        cell.deleteCallBack = { deleteProductId in
            self.interactor?.callDeleteProductApi(deleteProductId)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 2, height: 250)
    }
}
