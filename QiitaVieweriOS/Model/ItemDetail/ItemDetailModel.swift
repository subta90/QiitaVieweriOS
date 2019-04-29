//
//  ItemDetailModel.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/04/28.
//  Copyright © 2019 subta90. All rights reserved.
//

import Foundation
import APIKit
import RxSwift

struct GetItemDetailRequest: Request {

    typealias Response = ItemDetail

    var baseURL: URL {
        return URL(string: "https://qiita.com/api/v2")!
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/items" + "/\(itemId)"
    }

    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> ItemDetail {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(ItemDetail.self, from: data)
    }

    private var itemId: String

    init(itemId: String) {
        self.itemId = itemId
    }
}

protocol ItemDetailModelProtocol {
    func fetchItems(itemId: String) -> Observable<ItemDetail>
}

final class ItemDetailModel: ItemDetailModelProtocol {

    private let session = Session(adapter: URLSessionAdapter(configuration: .default))

    func fetchItems(itemId: String) -> Observable<ItemDetail> {
        return Observable.create { observer in
            let request = GetItemDetailRequest(itemId: itemId)

            let task = Session.send(request) { result in
                switch result {
                case .success(let itemDetail):
                    observer.onNext(itemDetail)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
