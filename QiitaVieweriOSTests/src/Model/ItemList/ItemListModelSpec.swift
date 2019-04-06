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
                            expect(items[0].title).to(equal("Example title"))
                            expect(items[0].user.id).to(equal("yaotti"))
                            expect(items[0].user.profileImageUrl).to(equal("https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg"))
                            expect(items[1].title).to(equal("Example title 2"))
                            expect(items[1].user.id).to(equal("yaotti2"))
                            expect(items[1].user.profileImageUrl).to(equal("https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal2.jpeg"))
                            done()
                        }).disposed(by: self.disposeBag)
                    }
                }
            }
        }
    }

}
