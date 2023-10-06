//
//  PlayerEntity.swift
//  Lab
//
//  Created by Letícia Victoria das Neves Sales on 05/10/23.
//

import SpriteKit
import GameplayKit
//
class PlayerEntity: GKEntity {
    
    var position: CGPoint?
    
    init(scene: GameScene) {
        super.init()
        
        let playerNode = PlayerNode()
        
        let movementComponent = MovementComponent()
        movementComponent.node = playerNode
        
        if let cameraComponent = scene.camera {
            self.addComponent(CameraComponent(camera: cameraComponent))
            
        }
        
        self.addComponent(GKSKNodeComponent(node: playerNode))
        self.addComponent(movementComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.component(ofType: GKSKNodeComponent.self)?.node.removeFromParent()
    }
}
