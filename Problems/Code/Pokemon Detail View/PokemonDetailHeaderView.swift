//
//  PokemonHeaderView.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit
import APIClient

class PokemonDetailHeaderView: UIView {

    // MARK: - Properties

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray40
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .gray80
        return label
    }()

    private let typesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .spacing2
        return stackView
    }()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .spacing2
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = .spacing5
        return stackView
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        imageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        stackView.addArrangedSubview(imageView)

        verticalStackView.addArrangedSubview(numberLabel)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(typesStackView)
        stackView.addArrangedSubview(verticalStackView)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configureWith(pokemon: Pokemon) {
        numberLabel.text = pokemon.prettyPrintedId
        titleLabel.text = pokemon.identifier.capitalizingFirstLetter()
        imageView.setImage(from: pokemon.imageUrl)

        typesStackView.subviews.forEach({ $0.removeFromSuperview() })

        pokemon.types
            .map({ type in
                let pillView = PillView()
                pillView.title = type.identifier
                pillView.color = colorForPokemonType(typeIdentifier: type.identifier)
                return pillView
            })
            .forEach({ typesStackView.addArrangedSubview($0) })
    }

}
