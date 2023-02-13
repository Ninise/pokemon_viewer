//
//  IndexViewController.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit
import APIClient

enum PokemonListRowType {
    case pokemonRow(viewModel: PokemonCollectionViewCellViewModel)
    case loadingRow
    case errorLoadingRow
}

class PokemonListViewController: ViewController<PokemonListView>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {

    // MARK: - Properties

    private let client = PokemonAPIClient()
    private let searchController = UISearchController(searchResultsController: nil)
    private var pokemon: [Pokemon] = []
    private var filteredPokemon = [Pokemon]()
    private var isLoadingData = false
    private var loadingDataError: Error? = nil

    private var rows: [PokemonListRowType] = [] {
        didSet {
            customView.collectionView.reloadData()
        }
    }

    // MARK: - Life Cycle

    init() {
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Pokédex"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchBarButtonItem(item:)))

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        loadData()
    }

    // MARK: - Methods

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredPokemon = pokemon
        updateRows()
    }

    func updateRows() {

        guard !isLoadingData else {
            rows = [
                .loadingRow
            ]
            return
        }

        guard loadingDataError == nil else {
            rows = [
                .errorLoadingRow
            ]
            return
        }

        let pokemon = (isFiltering() ? filteredPokemon : self.pokemon)
        let pokemonViewModels = pokemon.map { PokemonCollectionViewCellViewModel(pokemon: $0) }
        let pokemonRows = pokemonViewModels.map { PokemonListRowType.pokemonRow(viewModel: $0) }

        rows = pokemonRows
    }

    func loadData() {
        isLoadingData = true
        loadingDataError = nil

        client.fetchPokemon { result in
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon
            case .failure(let error):
                self.loadingDataError = error
                break
            }

            self.isLoadingData = false
            self.updateRows()
        }

        self.updateRows()
    }

    // MARK: - Actions

    @objc
    func didTapSearchBarButtonItem(item: UIBarButtonItem) {
        searchController.searchBar.becomeFirstResponder()
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let row = rows[indexPath.row]

        switch row {
        case .loadingRow:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityIndicatorCollectionViewCell.reuseIdentifier, for: indexPath) as? ActivityIndicatorCollectionViewCell else {
                fatalError("Failed to dequeue ActivityIndicatorCollectionViewCell")
            }

            cell.activityIndicator.startAnimating()

            return cell

        case .errorLoadingRow:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorLoadingCollectionViewCell.reuseIdentifier, for: indexPath) as? ErrorLoadingCollectionViewCell else {
                fatalError("Failed to dequeue ErrorLoadingCollectionViewCell")
            }

            cell.configure(text: "Failed to load Pokémon.\nTap to try again.")

            return cell

        case .pokemonRow(let viewModel):

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
                fatalError("Failed to dequeue PokemonCollectionViewCell")
            }

            cell.configure(with: viewModel)
            return cell

        }
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let row = rows[indexPath.row]

        switch row {
        case .pokemonRow(let viewModel):
            guard let pokemon = (isFiltering() ? filteredPokemon : self.pokemon).first(where: { $0.id == viewModel.pokemonId }) else {
                return
            }
            let viewController = PokemonDetailViewController(with: pokemon, pokemons: self.pokemon)
            navigationController?.pushViewController(viewController, animated: true)

        case .errorLoadingRow:
            loadData()

        default:
            break
        }

    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let sectionInsets: UIEdgeInsets = {
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                return layout.sectionInset
            }
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }()

        let row = rows[indexPath.row]
        switch row {
        case .pokemonRow:

            // Pokemon cells should be 3 per row.
            let itemsPerRow = 3
            let itemPadding = CGFloat.spacing4
            let availableWidth = collectionView.bounds.width
                - sectionInsets.left
                - sectionInsets.right
                - itemPadding * CGFloat(itemsPerRow - 1)

            return CGSize(
                width: (availableWidth / CGFloat(itemsPerRow)),
                height: 138
            )
        default:

            let availableWidth = collectionView.bounds.width
                - sectionInsets.left
                - sectionInsets.right

            return CGSize(
                width: availableWidth,
                height: 138
            )

        }

    }

}
