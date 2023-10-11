//
//  GameScene+Tools.swift
//  Lab
//
//  Created by kevin marinho on 29/09/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    func tileMapPhysicsBody(map: SKTileMapNode) {
        let tileMap = map
        let tileSize = tileMap.tileSize
        let startLocation: CGPoint = tileMap.position
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
        
        for columnIndex in 0..<tileMap.numberOfColumns {
            for rowIndex in 0..<tileMap.numberOfRows {
                if let tileDefinition = tileMap.tileDefinition(atColumn: columnIndex, row: rowIndex) {
                    let tileArray = tileDefinition.textures
                    let tileTextures = tileArray[0]
                    let x = CGFloat(columnIndex) * tileSize.width - halfWidth + (tileSize.width/2)
                    let y = CGFloat(rowIndex) * tileSize.height - halfHeight + (tileSize.height/2)
                    
                    let tileNode = SKSpriteNode(texture: tileTextures)
                    tileNode.position = CGPoint(x: x, y: y)
                    tileNode.physicsBody = SKPhysicsBody(texture: tileTextures, size: CGSize(width: tileTextures.size().width, height: tileTextures.size().height))
                    tileNode.physicsBody?.categoryBitMask = .wall
                    tileNode.physicsBody?.collisionBitMask = .player
                    tileNode.physicsBody?.contactTestBitMask = .player
                    tileNode.physicsBody?.affectedByGravity = false
                    tileNode.physicsBody?.allowsRotation = false
                    tileNode.physicsBody?.isDynamic = false
                    tileNode.physicsBody?.friction = 1
                    tileNode.zPosition = 0
                    tileNode.position = CGPoint(x: tileNode.position.x + startLocation.x, y: tileNode.position.y + startLocation.y)
                    
                    self.addChild(tileNode)
                }
            }
        }
        
    }
    
    func creatingPlayer(at position: CGPoint) {
        
        let auxEntity =  PlayerEntity(scene: self)
        if let node = auxEntity.component(ofType: GKSKNodeComponent.self)?.node {
            self.addChild(node)
            node.position = position
        }
        entities.append(auxEntity)
        playerEntity = auxEntity
    }
    
    func setupCameraConstraint() {
        let cameraBoundsWidth = self.frame.width / 2
        let boundsWidth = self.calculateAccumulatedFrame().width/2 - cameraBoundsWidth
        
        let cameraBoundsHeight = self.frame.height/2 - 30
        let boundsHeight = self.calculateAccumulatedFrame().height/2 - cameraBoundsHeight
        
        let cameraConstraintX = SKConstraint.positionX(.init(lowerLimit: -boundsWidth, upperLimit: boundsWidth))
        let cameraConstraintY = SKConstraint.positionY(.init(lowerLimit: -boundsHeight, upperLimit: boundsHeight))
        
        self.camera?.constraints = [cameraConstraintX, cameraConstraintY]
    }
}
