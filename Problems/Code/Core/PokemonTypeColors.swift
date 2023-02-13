//
//  Type+Color.swift
//  Problems
//
//  Created on 2019-04-30.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import Foundation
import APIClient

func colorForPokemonType(typeIdentifier identifier: String) -> UIColor {
    switch identifier {
    case "grass":
        return .pokemonTypeGrass
    case "normal":
        return .pokemonTypeNormal
    case "fire":
        return .pokemonTypeFire
    case "water":
        return .pokemonTypeWater
    case "electric":
        return .pokemonTypeElectric
    case "ice":
        return .pokemonTypeIce
    case "fighting":
        return .pokemonTypeFighting
    case "poison":
        return .pokemonTypePoison
    case "ground":
        return .pokemonTypeGround
    case "flying":
        return .pokemonTypeFlying
    case "physic":
        return .pokemonTypePhysic
    case "bug":
        return .pokemonTypeBug
    case "rock":
        return .pokemonTypeRock
    case "ghost":
        return .pokemonTypeGhost
    case "dragon":
        return .pokemonTypeDragon
    case "dark":
        return .pokemonTypeDark
    case "steel":
        return .pokemonTypeSteel
    case "fairy":
        return .pokemonTypeFairy
    default:
        return .black
    }
}
