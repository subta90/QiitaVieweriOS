//
//  MainTabBarController.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/02/23.
//  Copyright © 2019 subta90. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainTabBarController: UIViewController {

    // MARK: Properties

    @IBOutlet private weak var tabBar: UITabBar!

    @IBOutlet private weak var contentView: UIView!

    private var contentViewController: UIViewController? {
        didSet {
            guard contentViewController != nil else {
                return
            }

            oldValue?.willMove(toParent: nil)
            oldValue?.view.removeFromSuperview()
            oldValue?.removeFromParent()
            addChild(contentViewController!)
            contentViewController?.didMove(toParent: self)
        }
    }

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {

        let storyboard = UIStoryboard(name: "ItemListViewController",
                                      bundle: Bundle(for: ItemListViewController.self))
        let itemListViewController = storyboard.instantiateViewController(withIdentifier: "itemList") as! ItemListViewController
        contentViewController = itemListViewController
        itemListViewController.view.frame = contentView.bounds
        contentView.addSubview(itemListViewController.view)

    }

}
