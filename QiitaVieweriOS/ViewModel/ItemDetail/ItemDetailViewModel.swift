//
//  ItemDetailViewModel.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/04/28.
//  Copyright © 2019 subta90. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class ItemDetailViewModel {
    private let itemDetailModel: ItemDetailModelProtocol

    private var itemDetailRelay = PublishRelay<ItemDetail>()

    private let itemId: String

    private let disposeBag = DisposeBag()

    var itemDetailObservable: Observable<ItemDetail> {
        return itemDetailRelay.asObservable()
    }

    init(itemId: String, itemDetailModel: ItemDetailModelProtocol = ItemDetailModel()) {
        self.itemId = itemId
        self.itemDetailModel = itemDetailModel

        self.itemDetailModel.fetchItems(itemId: itemId).bind(to: itemDetailRelay).disposed(by: disposeBag)
    }

}
