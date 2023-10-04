//
//  PlayerNode.swift
//  Lab
//
//  Created by kevin marinho on 29/09/23.
//

import Foundation
import SpriteKit

class PlayerNode: SKNode {
    public var player: SKSpriteNode
    
    
    override init() {
        player = .init(imageNamed: "kevin")
        super.init()
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 12)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = .player
        player.physicsBody?.collisionBitMask = .wall
        player.physicsBody?.allowsRotation = false
        
        player.position = CGPoint(x: 20, y: 10)
        self.addChild(player)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
