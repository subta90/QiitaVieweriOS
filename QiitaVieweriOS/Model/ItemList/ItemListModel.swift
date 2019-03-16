//
//  ItemListModel.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/02/24.
//  Copyright © 2019 subta90. All rights reserved.
//

import Foundation
import APIKit
import RxSwift

struct Item: Codable {
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
    
    init(id: String) {
        self.id = id
    }
}

struct GetItemsRequest: Request {
    
    typealias Response = [Item]
    
    var baseURL: URL {
        return URL(string: "https://qiita.com/api/v2")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/items"
    }
    
    var queryParameters: [String : Any]? {
        var parameters = ["page": page,
                          "per_page": perPage]
        
        if let query = query {
            parameters["query"] = query
        }
        
        return parameters
    }
    
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [Item] {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode([Item].self, from: data)
    }
    
    private let page: String
    private let perPage: String
    private let query: String?
    
    init(page: String, perPage: String, query: String?) {
        self.page = page
        self.perPage = perPage
        self.query = query
    }
    
}

protocol ItemListModelProtocol {
    func fetchItems(page: String, perPage: String, query: String?) -> Observable<[Item]>
}

class ItemListModel: ItemListModelProtocol {
    
    private let session = Session(adapter: URLSessionAdapter(configuration: .default))
    
    func fetchItems(page: String, perPage: String, query: String?) -> Observable<[Item]> {
        return Observable.create { observer in
            let request = GetItemsRequest(page: page, perPage: perPage, query: query)
            
            let task = Session.send(request) { result in
                switch result {
                case .success(let items):
                    observer.onNext(items)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create() {
                task?.cancel()
            }
        }
    }
}
