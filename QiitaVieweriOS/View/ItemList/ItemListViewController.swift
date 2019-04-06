//
//  ItemListViewController.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/02/23.
//  Copyright © 2019 subta90. All rights reserved.
//

import Nuke
import UIKit
import RxCocoa
import RxSwift

class ItemListViewController: UIViewController {

    // MARK: Properties
    @IBOutlet private weak var tableView: UITableView!

    private let cellIdentifier = "ItemListTableCell"

    private lazy var viewModel = ItemListViewModel(page: "1", perPage: "10", query: nil)

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self

        viewModel.reloadData.bind(to: self.reloadData).disposed(by: disposeBag)
    }
}

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ItemListTableCell

        let userId = viewModel.items[indexPath.row].user.id
        cell.userIdLabel.text = userId

        let title = viewModel.items[indexPath.row].title
        cell.titleLabel.text = title

        if let url = URL(string: viewModel.items[indexPath.row].user.profileImageUrl) {
            Nuke.loadImage(with: url, into: cell.profileImageView)
        }

        return cell
    }
}

extension ItemListViewController {

    private var reloadData: Binder<Void> {
        return Binder(self) { me, _ in
            me.tableView.reloadData()
        }
    }
}
