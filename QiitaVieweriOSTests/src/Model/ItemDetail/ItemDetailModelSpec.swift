//
//  ItemDetailModelSpec.swift
//  QiitaVieweriOSTests
//
//  Created by subta on 2019/04/28.
//  Copyright © 2019 subta90. All rights reserved.
//

import APIKit
import Quick
import Nimble
import OHHTTPStubs
import RxSwift
@testable import QiitaVieweriOS

class ItemDetailModelSpec: QuickSpec {
    
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("fetchItems") {
            beforeEach {
                stub(condition: isHost("qiita.com")) { _ in
                    let stubPath = OHPathForFile("itemDetail.json", type(of: self))
                    return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
                }
            }
            
            afterEach {
                OHHTTPStubs.removeAllStubs()
            }
            
            context("when request to itemDetail.json") {
                it("success to fetch") {
                    waitUntil(timeout: 5) { done  in
                        let model = ItemDetailModel()
                        
                        model.fetchItems(itemId: "4bd431809afb1bb99e4f").subscribe(onNext: {
                            itemDetail in
                            expect(itemDetail.title).to(equal("Example title"))
                            expect(itemDetail.createdAt).to(equal("2000-01-01T00:00:00+00:00"))
                            expect(itemDetail.renderedBody).to(equal("<h1>Example</h1>"))
                            expect(itemDetail.user.id).to(equal("yaotti"))
                            expect(itemDetail.user.profileImageUrl).to(equal("https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg"))
                            expect(itemDetail.tags[0].name).to(equal("Ruby"))
                            expect(itemDetail.tags[0].versions[0]).to(equal("0.0.1"))
                            done()
                        }).disposed(by: self.disposeBag)
                    }
                }
            }
        }
    }
}
