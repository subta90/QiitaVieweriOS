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

    private lazy var viewModel = ItemListViewModel()

    private let disposeBag = DisposeBag()

    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.refreshControl = refreshControl

        // 初期値取得
        self.viewModel.fetchItems(page: "1", perPage: "10", query: nil)
        bind()
    }
    
    private func bind() {
        refreshControl.rx.controlEvent(.valueChanged).asDriver().drive(onNext: { [unowned self] _ in
            self.viewModel.fetchItems(page: "2", perPage: "10", query: nil)
        }).disposed(by: disposeBag)
        
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
            self.refreshControl.endRefreshing()
        }
    }
}
