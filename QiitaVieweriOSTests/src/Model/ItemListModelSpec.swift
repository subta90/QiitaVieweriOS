//
//  ItemListModelSpec.swift
//  QiitaVieweriOSTests
//
//  Created by subta on 2019/02/24.
//  Copyright © 2019 subta90. All rights reserved.
//

import APIKit
import Quick
import Nimble
import OHHTTPStubs
import RxSwift
@testable import QiitaVieweriOS

class ItemListModelSpec: QuickSpec {
    
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("fetchItems") {
            beforeEach {
                stub(condition: isHost("qiita.com")) { _ in
                    let stubPath = OHPathForFile("items.json", type(of: self))
                    return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
                }
            }
            afterEach {
                OHHTTPStubs.removeAllStubs()
            }
            
            context("when request to items.json") {
                it("success to fetch") {
                    waitUntil(timeout: 5) { done in
                        let model = ItemListModel()
                        model.fetchItems(page: "1", perPage: "20", query: nil).subscribe( onNext: {
                            items in
                            expect(items[0].id).to(equal("4bd431809afb1bb99e4f"))
                            expect(items[1].id).to(equal("4bd431809afb1bb99e4a"))
                            done()
                            }).disposed(by: self.disposeBag)
                    }
                }
            }
        }
    }
    
}
