//
//  MovementComponent.swift
//  Lab
//
//  Created by Letícia Victoria das Neves Sales on 05/10/23.
//

import GameplayKit
import SpriteKit

class MovementComponent: GKComponent {
    var node: SKNode?
    var moveSpeed: CGFloat = 1.0
    var currentDirection: CGVector = CGVector(dx: 0, dy: 0)

    public func changeDirection(_ direction: CGVector) {
        currentDirection = direction
    }

    func move() {
        guard let nodeComponent = entity?.component(ofType: GKSKNodeComponent.self) else {
            return
        }

        let delta = CGPoint(x: currentDirection.dx * moveSpeed, y: currentDirection.dy * moveSpeed)
        let newPosition = CGPoint(x: nodeComponent.node.position.x + delta.x, y: nodeComponent.node.position.y + delta.y)

        nodeComponent.node.position = newPosition
    }
}


