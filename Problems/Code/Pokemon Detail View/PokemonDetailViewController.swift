//
//  DetailViewController.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit
import APIClient

class PokemonDetailViewController: ViewController<PokemonDetailView> {
    
    // MARK: - Properties

    private let pokemons: [Pokemon]
    private let selectedPokemon: Pokemon

    private let apiClient = PokemonAPIClient()

    // MARK: - Life Cycle

    init(with selectedPokemon: Pokemon, pokemons: [Pokemon]) {
        self.selectedPokemon = selectedPokemon
        self.pokemons = pokemons

        super.init(nibName: nil, bundle: nil)

        navigationItem.title = nil
        navigationItem.largeTitleDisplayMode = .never
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.configureWith(pokemon: selectedPokemon, evolutions: nil)
        loadData()
    }

    // MARK: - Methods

    func loadData() {
        apiClient.fetchPokemonEvolutions(pokemonId: selectedPokemon.id, completion: { result in

            switch result {
            case .failure:
                self.customView.showError()
                break
            case .success(let evolutions):
                let viewModels = evolutions.compactMap({ evolution -> EvolutionViewModel? in

                    if let intoId = evolution.evolvesIntoId {
                        let pokemon = self.pokemons.first(where: { $0.id == intoId})!

                        return EvolutionViewModel.init(
                            type: .into,
                            pokemon: pokemon,
                            trigger: evolution.trigger
                        )
                    } else if let fromId = evolution.evolvesFromId {

                        let pokemon = self.pokemons.first(where: { $0.id == fromId})!

                        return EvolutionViewModel.init(
                            type: .from,
                            pokemon: pokemon,
                            trigger: evolution.trigger
                        )
                    }
                    return nil

                })

                self.customView.configureWith(pokemon: self.selectedPokemon, evolutions: viewModels)
            }

        })
    }

    // MARK: - Actions

}
