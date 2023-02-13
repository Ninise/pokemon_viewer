//
//  Pokemon.swift
//  APIClient
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation

public struct Pokemon: Decodable {
    public let id: Int
    public let identifier: String
    public let imageUrl: URL
    public let types: [Type]

    public var prettyPrintedId: String {
        return "\(id)"
    }

}
