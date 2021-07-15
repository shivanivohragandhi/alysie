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

        self.tableView.register(UINib(nibName: "PostCommentsCell", bundle: nil), forCellReuseIdentifier: "cell")

        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
    }

    // MARK:- IBOutlets
    @IBOutlet weak var backButton: UIButtonExtended!
    @IBOutlet weak var titleLabel: UILabelExtended!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var bottomViewForCommentTextField: UIView!
    @IBOutlet weak var commentTextfield: UITextFieldBorderWidthAndColor!
    @IBOutlet weak var profilePhotoButton: UIButtonExtended!
    @IBOutlet weak var sendCommentButton: UIButtonExtended!

    // MARK:- protocol methods

    // MARK:- IBAction methods
    @IBAction func backButtonTapped(_ sender: UIButtonExtended) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func profilePhotoButtonTapped(_ sender: UIButtonExtended) {

    }

    @IBAction func sendCommentButtonTapped(_ sender: UIButtonExtended) {

    }

}

extension PostCommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelfPostCommentsCell else {
            return UITableViewCell()
        }

        cell.descriptionLabel.text = "Description"
        cell.userNameLabel.text = "Username"
        cell.timeLabel.text = "10 h"
        cell.userImageView.setImage(withString: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=400")
        return cell
    }
}