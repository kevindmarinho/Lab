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
    
    override func sceneDidLoad() {
        scene?.addChild(sceneNode)
    }
    override func didMove(to view: SKView) {
        for node in self.children {
            if(node.name == "tileMap") {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    tileMapPhysicsBody(map: someTileMap)
                    //                    someTileMap.removeFromParent()
                    //                    sceneNode.addChild(someTileMap)
                }
            }
        }
        joystick.joystickBack.isHidden = true
        joystick.joystickButton.isHidden = true
        sceneNode.addChild(playerNode)
        sceneNode.addChild(joystick)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func touchMoved(touch: UITouch) {
        
        
        if (joystickInUse) {
            let location = touch.location(in: self)
            let vector = CGVector(dx: location.x - joystick.joystickBack.position.x, dy: location.y - joystick.joystickBack.position.y)
            
            let angle = atan2(vector.dy, vector.dx)
            
            let distanceFromCenter = CGFloat(joystick.joystickBack.frame.size.height/2)
            
            let distanceX = CGFloat(sin(angle - distanceFromCenter))
            let distanceY = CGFloat(cos(angle - distanceFromCenter))
            
            if(joystick.joystickBack.frame.contains(location)) {
                joystick.joystickButton.position = location
            }
            else {
                joystick.joystickButton.position = CGPoint(x: joystick.joystickBack.position.x - distanceX, y: joystick.joystickBack.position.y + distanceY)
                
            }
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
                print("tocou")
            } else {
                joystickInUse = false
                joystick.joystickButton.isHidden = true
                joystick.joystickBack.isHidden = true
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
        for _ in touches {
            joystickInUse = false
            joystick.joystickButton.isHidden = true
            joystick.joystickBack.isHidden = true
        }
    }
}
