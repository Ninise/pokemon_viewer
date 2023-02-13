//
//  PokemonDetailView.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit
import APIClient

class PokemonDetailView: UIView {

    // MARK: - Properties

    private let pokemonHeaderView = PokemonDetailHeaderView()
    private var evolutionButtons = [PokemonDetailEvolutionButton]()

    private let noEvolutionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray80
        return label
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = false
        activityIndicator.color = .gray
        return activityIndicator
    }()

    private let evolutionLabel: UILabel = {
        let label = UILabel()
        label.text = "Evolution"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .gray80
        return label
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error loading evolutions"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray80
        label.textAlignment = .center
        return label
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = .spacing5
        stackView.layoutMargins = UIEdgeInsets(
            top: 20,
            left: 20,
            bottom: 20,
            right: 20
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            activityIndicator.heightAnchor.constraint(equalToConstant: 35)
            ])

        stackView.addArrangedSubview(pokemonHeaderView)
        stackView.addArrangedSubview(evolutionLabel)
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(noEvolutionsLabel)

        backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configureWith(pokemon: Pokemon, evolutions: [EvolutionViewModel]?) {
        pokemonHeaderView.configureWith(pokemon: pokemon)

        activityIndicator.isHidden = true
        errorLabel.isHidden = true
        noEvolutionsLabel.isHidden = true
        evolutionButtons.forEach { $0.removeFromSuperview() }

        if let evolutions = evolutions {
            if evolutions.count == 0 {
                noEvolutionsLabel.text = "\(pokemon.identifier.capitalizingFirstLetter()) does not evolve"
                noEvolutionsLabel.isHidden = false
            } else {
                evolutions.forEach({ viewModel in
                    let evolutionButton = PokemonDetailEvolutionButton()
                    evolutionButton.configure(viewModel: viewModel)
                    evolutionButtons.append(evolutionButton)
                    stackView.addArrangedSubview(evolutionButton)
                })
            }

        } else {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }

    func showError() {
        activityIndicator.isHidden = true
        errorLabel.isHidden = false
        evolutionButtons.forEach { $0.isHidden = true }
        noEvolutionsLabel.isHidden = true
    }

}
