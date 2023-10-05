//
//  MoveComponent.swift
//  Lab
//
//  Created by Letícia Victoria das Neves Sales on 05/10/23.
//

import GameplayKit
import SpriteKit

class PositionComponent: GKComponent {
    var position: CGPoint

    init(position: CGPoint) {
        self.position = position
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
