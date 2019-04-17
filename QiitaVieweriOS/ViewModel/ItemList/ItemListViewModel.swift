//
//  ItemListViewModel.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/02/24.
//  Copyright © 2019 subta90. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class ItemListViewModel {
    private let itemListModel: ItemListModelProtocol

    private var itemsRelay = BehaviorRelay<[Item]>(value: [])

    private let disposeBag = DisposeBag()

    var items: [Item] {
        return itemsRelay.value
    }

    var itemsObservable: Observable<[Item]> {
        return itemsRelay.asObservable()
    }

    let reloadData: Observable<Void>

    // MARK: Life Cycle
    init(itemListModel: ItemListModelProtocol = ItemListModel()) {
        self.itemListModel = itemListModel

        self.reloadData = itemsRelay.map { _ in }
    }

    func fetchItems(page: String, perPage: String, query: String?) {
        self.itemListModel.fetchItems(page: page, perPage: perPage, query: query)
            .bind(to: itemsRelay).disposed(by: disposeBag)
    }
}
