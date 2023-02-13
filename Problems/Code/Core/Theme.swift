//
//  Theme.swift
//  Problems
//
//  Created on 2019-04-30.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import UIKit

enum Theme {

    static func applyAppearance() {
        let navigationBarProxy = UINavigationBar.appearance()
        navigationBarProxy.barTintColor = .pokedexRed
        navigationBarProxy.isTranslucent = false
        navigationBarProxy.tintColor = .white

        navigationBarProxy.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        navigationBarProxy.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        let searchBarProxy = UISearchBar.appearance()
        searchBarProxy.tintColor = .white
        searchBarProxy.setImage(
            UIImage(named: "icon-search")?.withRenderingMode(.alwaysTemplate),
            for: .search,
            state: .normal
        )
        searchBarProxy.setImage(
            UIImage(named: "icon-clear")?.withRenderingMode(.alwaysTemplate),
            for: .clear,
            state: .normal
        )

        let textFieldSearchBarProxy = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        textFieldSearchBarProxy.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [
                .foregroundColor: UIColor(white: 1.0, alpha: 0.6)
            ]
        )
        textFieldSearchBarProxy.defaultTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        textFieldSearchBarProxy.tintColor = .white
    }

}

public extension UIColor {

    static let pokedexRed = UIColor(hexString: "E73D0A")

    static let gray90 = UIColor(hexString: "16161F")
    static let gray80 = UIColor(hexString: "35353F")
    static let gray70 = UIColor(hexString: "61616A")
    static let gray60 = UIColor(hexString: "8E8E93")
    static let gray40 = UIColor(hexString: "C7C7CC")
    static let gray30 = UIColor(hexString: "D1D1D6")
    static let gray20 = UIColor(hexString: "E5E5EA")
    static let gray5 = UIColor(hexString: "F7F7F7")

    static let pokemonTypeGrass = UIColor(hexString: "7AC74C")
    static let pokemonTypeNormal = UIColor(hexString: "A8A77A")
    static let pokemonTypeFire = UIColor(hexString: "EE8130")
    static let pokemonTypeWater = UIColor(hexString: "6390F0")
    static let pokemonTypeElectric = UIColor(hexString: "F7D02C")
    static let pokemonTypeIce = UIColor(hexString: "96D9D6")
    static let pokemonTypeFighting = UIColor(hexString: "C22E28")
    static let pokemonTypePoison = UIColor(hexString: "A33EA1")
    static let pokemonTypeGround = UIColor(hexString: "E2BF65")
    static let pokemonTypeFlying = UIColor(hexString: "A98FF3")
    static let pokemonTypePhysic = UIColor(hexString: "F95587")
    static let pokemonTypeBug = UIColor(hexString: "A6B91A")
    static let pokemonTypeRock = UIColor(hexString: "B6A136")
    static let pokemonTypeGhost = UIColor(hexString: "735797")
    static let pokemonTypeDragon = UIColor(hexString: "6F35FC")
    static let pokemonTypeDark = UIColor(hexString: "705746")
    static let pokemonTypeSteel = UIColor(hexString: "B7B7CE")
    static let pokemonTypeFairy = UIColor(hexString: "D685AD")

}

private extension UIColor {

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
    }

}
