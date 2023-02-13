//
//  APIClientTests.swift
//  APIClientTests
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import XCTest
@testable import APIClient

class APIClientTests: XCTestCase {

    func testPokemonPrettyPrintsId_SingleDigit() {

        let pokemon = Pokemon(
            id: 1,
            identifier: "test pokemon",
            imageUrl: URL(string: "https://")!,
            types: [
                Type(id: 1, identifier: "fire")
            ]
        )

        XCTAssertEqual(pokemon.prettyPrintedId, "#001")

    }

    func testPokemonPrettyPrintsId_MultipleDigit() {

        let pokemon = Pokemon(
            id: 123,
            identifier: "test pokemon",
            imageUrl: URL(string: "https://")!,
            types: [
                Type(id: 1, identifier: "fire")
            ]
        )

        XCTAssertEqual(pokemon.prettyPrintedId, "#123")

    }

}
