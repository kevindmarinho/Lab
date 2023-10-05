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
    var joystickInUse = false
    
    var velocityX: CGFloat = 0.0
    var velocityY: CGFloat = 0.0
    
    
    override func sceneDidLoad() {
        scene?.addChild(sceneNode)
    }
    override func didMove(to view: SKView) {
        for node in self.children {
            if(node.name == "tileMap") {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    tileMapPhysicsBody(map: someTileMap)
                }
            }
        }
        joystick.isHidden = true
        sceneNode.addChild(playerNode)
        sceneNode.addChild(joystick)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode.position.x += velocityX
        self.playerNode.position.y += velocityY
    }
    
    func touchMoved(touch: UITouch) {
        if (joystickInUse) {
            let location = touch.location(in: self)
            
            let vector = CGVector(dx: location.x - joystick.joystickBack.position.x, dy: location.y - joystick.joystickBack.position.y)
            
            let distanceFromCenter = hypot(vector.dx, vector.dy)
            
            let maxDistance = joystick.joystickBack.frame.size.width / 2
            
            if distanceFromCenter > maxDistance {
                let scaleFactor = maxDistance / distanceFromCenter
                let limitedVector = CGVector(dx: vector.dx * scaleFactor, dy: vector.dy * scaleFactor)
                joystick.joystickButton.position = CGPoint(x: joystick.joystickBack.position.x + limitedVector.dx, y: joystick.joystickBack.position.y + limitedVector.dy)
            } else {
                joystick.joystickButton.position = location
            }
            
            velocityX = (joystick.joystickButton.position.x - joystick.joystickBack.position.x) / 5
            velocityY = (joystick.joystickButton.position.y - joystick.joystickBack.position.y) / 5
        }
    }


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            joystick.joystickBack.position = location
            joystick.joystickButton.position = location
            
            if (joystick.joystickButton.frame.contains(location)){
                joystickInUse = true
                joystick.isHidden = false

                print("tocou")
            } else {
                joystickInUse = false
                joystick.isHidden = true

                print("soltou ")
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchMoved(touch: touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(joystickInUse) {
            movimentOver()
        }
        
        for _ in touches {
            joystickInUse = false
            joystick.isHidden = true
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (joystickInUse) {
            movimentOver()
        }
    }
    
    func movimentOver() {
        velocityX = 0
        velocityY = 0
    }
}
