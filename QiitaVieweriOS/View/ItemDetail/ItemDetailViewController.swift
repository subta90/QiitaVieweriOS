//
//  ItemDetailViewController.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/04/18.
//  Copyright © 2019 subta90. All rights reserved.
//

import UIKit
import RxSwift
import Nuke

final class ItemDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!

    var itemId: String = ""

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    deinit {
        print("itemDetailVC deinited.")
    }

    private func bind() {
        let viewModel = ItemDetailViewModel(itemId: itemId)

        viewModel.itemDetailObservable.subscribe { [ unowned self ] itemDetail in
            guard let element = itemDetail.element else {
                return
            }

            self.titleLabel.text = element.title
            self.authorLabel.text = element.user.id
            self.dateLabel.text = element.createdAt

            if let url = URL(string: element.user.profileImageUrl) {
                Nuke.loadImage(with: url, into: self.profileImageView)
            }
            }.disposed(by: disposeBag)
    }

}
