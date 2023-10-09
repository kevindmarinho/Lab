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
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 24)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = .player
        player.physicsBody?.collisionBitMask = .wall
        
        player.position = CGPoint(x: 0, y: -50)
        self.addChild(player)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
