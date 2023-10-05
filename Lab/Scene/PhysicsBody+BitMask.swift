//
//  PhysicsBody+BitMask.swift
//  Lab
//
//  Created by Letícia Victoria das Neves Sales on 29/09/23.
//

import Foundation
import SpriteKit

extension UInt32 {
    static let base: UInt32 = 0b1
    static let player = UInt32.base << 0
    static let wall = UInt32.base << 1
    
    static let allMasks: [UInt32] = [
        .player,
        .wall
    ]
    
    static func contactWithAllCategories(less: [UInt32] = []) -> UInt32 {
        var result: UInt32 = 0b00
        
        for category in UInt32.allMasks {
            if !less.contains(category) {
                result |= category
            }
        }
        
        return result
    }
}
