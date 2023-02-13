//
//  DecodingTests.swift
//  APIClientTests
//
//  Created on 2019-05-01.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import XCTest
@testable import APIClient

class DecodingTests: XCTestCase {

    func testPokemonIsDecodeable() {

        guard let pokemonJsonUrl = Bundle(for: DummyBundleClass.self).url(forResource: "pokemon", withExtension: "json") else {
            XCTFail("JSON Not Found")
            return
        }

        do {
            let data = try Data(contentsOf: pokemonJsonUrl)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let pokemons = try decoder.decode([Pokemon].self, from: data)

            XCTAssertEqual(pokemons.count, 3)

        } catch {
            XCTFail(error.localizedDescription)
        }

    }

    func testEvolutionIsDecodeable() {

        guard let evolutionsJsonUrl = Bundle(for: DummyBundleClass.self).url(forResource: "evolutions", withExtension: "json") else {
            XCTFail("JSON Not Found")
            return
        }

        do {
            let data = try Data(contentsOf: evolutionsJsonUrl)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let evolutions = try decoder.decode([Evolution].self, from: data)

            XCTAssertEqual(evolutions.count, 2)

        } catch {
            XCTFail(error.localizedDescription)
        }

    }

}

// Used to dynamically determine the bundle
private class DummyBundleClass {}
