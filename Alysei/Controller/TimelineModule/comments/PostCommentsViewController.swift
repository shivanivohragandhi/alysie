//
//  PostCommentsViewController.swift
//  Alysei
//
//  Created by Shivani Vohra Gandhi on 11/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PostCommentsDisplayLogic: class {
}

class PostCommentsViewController: UIViewController, PostCommentsDisplayLogic {
    var interactor: PostCommentsBusinessLogic?
    var router: (NSObjectProtocol & PostCommentsRoutingLogic & PostCommentsDataPassing)?

    // MARK:- Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    var postID: Int!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK:- Setup

    private func setup() {
        let viewController = self
        let interactor = PostCommentsInteractor()
        let presenter = PostCommentsPresenter()
        let router = PostCommentsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK:- View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK:- IBOutlets
    //@IBOutlet weak var nameTextField: UITextField!

    // MARK:- protocol methods
    
}
