//
//  PokemonCollectionViewCell.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import UIKit
import APIClient

struct PokemonCollectionViewCellViewModel {
    let pokemonId: Int
    let prettyPokemonId: String
    let pokemonName: String
    let imageUrl: URL
}

extension PokemonCollectionViewCellViewModel {
    init(pokemon: Pokemon) {
        pokemonId = pokemon.id
        prettyPokemonId = pokemon.prettyPrintedId
        pokemonName = pokemon.identifier.capitalizingFirstLetter()
        imageUrl = pokemon.imageUrl
    }
}

class PokemonCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: - Properties

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray40
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray80
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(
            top: 16,
            left: 0,
            bottom: 0,
            right: 8
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private var defaultBackgroundColor: UIColor = .gray5
    private var highlightedBackgroundColor: UIColor = .gray20

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(with viewModel: PokemonCollectionViewCellViewModel) {
        numberLabel.text = viewModel.prettyPokemonId
        titleLabel.text = viewModel.pokemonName
        
        // Set image from url
        imageView.setImage(from: viewModel.imageUrl)
    }

}
