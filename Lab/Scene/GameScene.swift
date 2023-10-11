//
//  GameScene.swift
//  Lab
//
//  Created by kevin marinho on 28/09/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let sceneNode = SKNode()
    let playerNode = PlayerNode()
    let joystick = JoystickNode()
    var playerEntity: PlayerEntity?
    var joystickInUse = false
    var entities: [GKEntity] = []
    
    override func sceneDidLoad() {
        scene?.addChild(sceneNode)
    }
    override func didMove(to view: SKView) {
        
        for node in self.children {
            if(node.name == "tileMap") {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    tileMapPhysicsBody(map: someTileMap)
                    someTileMap.zPosition = 0
                }
            }
            
            if(node.name == "backgroundMap"){
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    someTileMap.zPosition = 1
                }
            }
        }
       
        creatingPlayer(at: CGPoint(x: 100, y: -50))
       
        joystick.joystickBack.isHidden = true
        joystick.joystickButton.isHidden = true
        sceneNode.addChild(joystick)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        for entity in entities {
            entity.update(deltaTime: currentTime)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            joystick.joystickBack.position = location
            joystick.joystickButton.position = location
            
            if (joystick.joystickButton.frame.contains(location)){
                joystickInUse = true
                joystick.joystickButton.isHidden = false
                joystick.joystickBack.isHidden = false
            } else {
                joystickInUse = false
                joystick.joystickButton.isHidden = true
                joystick.joystickBack.isHidden = true
            }
        }
    }
    
    
    func touchMoved(touch: UITouch) {
        if (joystickInUse) {
            var direction = CGVector(dx: 0, dy: 0)
            let location = touch.location(in: self)
            let vector = CGVector(dx: location.x - joystick.joystickBack.position.x, dy: location.y - joystick.joystickBack.position.y)
            
            let distanceFromCenter = hypot(vector.dx, vector.dy)
            let maxDistance = joystick.joystickBack.frame.size.width / 2
            
            if distanceFromCenter > maxDistance {
                let scaleFactor = maxDistance / distanceFromCenter
                let limitedVector = CGVector(dx: vector.dx * scaleFactor, dy: vector.dy * scaleFactor)
                joystick.joystickButton.position = CGPoint(x: joystick.joystickBack.position.x + limitedVector.dx, y: joystick.joystickBack.position.y + limitedVector.dy)
                
                direction = CGVector(dx: limitedVector.dx / maxDistance, dy: limitedVector.dy / maxDistance)
            } else {
                joystick.joystickButton.position = location
                direction = CGVector(dx: vector.dx / maxDistance, dy: vector.dy / maxDistance)
            }
            
            if let playerEntity = playerEntity {
                if let movementComponent = playerEntity.component(ofType: MovementComponent.self) {
                    movementComponent.changeDirection(direction)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchMoved(touch: touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            joystickInUse = false
            joystick.joystickButton.isHidden = true
            joystick.joystickBack.isHidden = true
        }
    }
}

