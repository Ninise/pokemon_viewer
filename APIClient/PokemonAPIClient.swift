//
//  PokemonAPIClient.swift
//  APIClient
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public class PokemonAPIClient {

    // MARK: - Properties

    private let endpointURL = URL(string: "https://raw.githubusercontent.com/rafaelnobrekz/poke-api/master/")!

    private let session: URLSession

    // MARK: - Life Cycle

    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Methods

    /// Fetch the array of Pokemon
    ///
    /// - Parameters:
    ///   - completion: The completion block to call when the request returns a result
    ///   - result: The result of the request
    public func fetchPokemon(completion: @escaping (_ result: Result<[Pokemon]>) -> Void) {

        guard let requestURL = URL(string: "pokemons", relativeTo: endpointURL) else {
            return
        }

        let request = URLRequest(url: requestURL)

        let task = session.dataTask(with: request) { data, response, error in

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let pokemon = try decoder.decode([Pokemon].self, from: data)

                    DispatchQueue.main.async {
                        completion(.success(pokemon))
                    }

                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    /// Fetch the Evolutions for the specific Pokemon ID
    ///
    /// - Parameters:
    ///   - id: The ID of the pokemon
    ///   - completion: The completion block to call when the request returns a result
    ///   - result: The result of the request
    public func fetchPokemonEvolutions(pokemonId id: Int, completion: @escaping (_ result: Result<[Evolution]>) -> Void) {

        // TODO: Add the real api call

        completion(.success([]))
    }

}
