//
//  ActivityIndicatorCollectionViewCell.swift
//  Problems
//
//  Created on 2019-04-30.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: - Properties

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        return activityIndicator
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 35),
            activityIndicator.heightAnchor.constraint(equalToConstant: 35)
            ])

        activityIndicator.startAnimating()

    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
