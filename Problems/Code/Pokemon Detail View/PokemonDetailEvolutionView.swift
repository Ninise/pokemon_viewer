//
//  EvolutionView.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit
import APIClient

enum EvolutionType {
    case from
    case into

    var title: String {
        switch self {
        case .from:
            return "Evolves from"
        case .into:
            return "Evolves into"
        }
    }
}

struct EvolutionViewModel {

    typealias EvolutionViewModelOnTapCallback = ((_ pokemon: Pokemon) -> Void)

    let type: EvolutionType
    let pokemon: Pokemon
    let trigger: String
    let onTapCallback: EvolutionViewModelOnTapCallback?

    init(type: EvolutionType, pokemon: Pokemon, trigger: String, onTapCallback: EvolutionViewModelOnTapCallback? = nil) {
        self.type = type
        self.pokemon = pokemon
        self.trigger = trigger
        self.onTapCallback = onTapCallback
    }
}

class PokemonDetailEvolutionButton: UIControl {

    // MARK: - Properties

    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .gray80
        label.numberOfLines = 0
        return label
    }()

    private let evolutionTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .gray80
        return label
    }()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .spacing2
        stackView.distribution = .equalSpacing
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
        stackView.alignment = .center
        stackView.spacing = .spacing5
        stackView.layoutMargins = UIEdgeInsets(
            top: .spacing2,
            left: 20,
            bottom: .spacing2,
            right: 20
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private var viewModel: EvolutionViewModel?

    private var defaultBackgroundColor: UIColor = .gray5
    private var selectedBackgroundColor: UIColor = .gray20

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? selectedBackgroundColor : defaultBackgroundColor
        }
    }

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.isUserInteractionEnabled = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        verticalStackView.addArrangedSubview(evolutionTypeLabel)
        verticalStackView.addArrangedSubview(levelLabel)
        stackView.addArrangedSubview(verticalStackView)

        imageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        stackView.addArrangedSubview(imageView)

        isHighlighted = false
        layer.cornerRadius = .spacing2

        addTarget(self, action: #selector(didTapControl), for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(viewModel: EvolutionViewModel) {
        self.viewModel = viewModel
        evolutionTypeLabel.text = viewModel.type.title
        imageView.setImage(from: viewModel.pokemon.imageUrl)
    }

    @objc func didTapControl() {
        guard let viewModel = viewModel else { return }
        viewModel.onTapCallback?(viewModel.pokemon)
    }

}
