//
//  ErrorLoadingCollectionViewCell.swift
//  Problems
//
//  Created on 2019-04-30.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit

class ErrorLoadingCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .gray80
        label.numberOfLines = 0
        return label
    }()

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

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        isHighlighted = false
        layer.cornerRadius = .spacing2
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(text: String) {
        titleLabel.text = text
    }

}
