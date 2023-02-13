//
//  Evolution.swift
//  APIClient
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation

public struct Evolution: Decodable {
    public let evolvesFromId: Int?
    public let evolvesIntoId: Int?

    public let trigger: String

    enum CodingKeys: String, CodingKey {
        case evolvesFromId = "evolvesFrom"
        case evolvesIntoId = "evolvesInto"
        case trigger
    }
}
