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
    var moveSpeed: CGFloat = 100.0 // Velocidade de movimento do jogador
    
    func move(withDirection direction: CGVector) {
        guard let nodeComponent = entity?.component(ofType: GKSKNodeComponent.self) else {
            return
        }
        
        let delta = CGPoint(x: direction.dx * moveSpeed, y: direction.dy * moveSpeed)
        let newPosition = CGPoint(x: nodeComponent.node.position.x + delta.x, y: nodeComponent.node.position.y + delta.y)
        
        nodeComponent.node.position = newPosition
    }
    
    public func changeDirection(_ direction: CGVector) {
        if direction == CGVector(dx: 0, dy: 0) {
            print(direction)
            //            stateMachinComp?.stateMachine.enter(ChickenAnimationsStates.Idle.self)
        } else {
            node?.xScale = direction.dx > 0 ? 1.0 : -1.0
            node?.position.x += moveSpeed * direction.dx
            node?.position.y += moveSpeed * direction.dy
            //            stateMachinComp?.stateMachine.enter(ChickenAnimationsStates.Walk.self)
        }
    }
    
    
}

