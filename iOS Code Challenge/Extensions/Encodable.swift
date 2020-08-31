//
//  Encodable.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 31/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
