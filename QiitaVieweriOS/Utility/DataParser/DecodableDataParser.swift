//
//  DecodableDataParser.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/03/02.
//  Copyright © 2019 subta90. All rights reserved.
//

import Foundation
import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
}
