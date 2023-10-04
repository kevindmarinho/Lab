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
//        joystick.joystickBack.position = CGPoint(x: (self.view?.frame.minX)!, y: (self.view?.frame.midY)!-200)
//        joystick.joystickButton.position = CGPoint(x: (self.view?.frame.minX)!, y: (self.view?.frame.midY)!-200)
//        joystick.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.1)
        sceneNode.addChild(playerNode)
        sceneNode.addChild(joystick)
        
    }
     
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func touchMoved(touch: UITouch) {
        let location = touch.location(in: self)
        if (joystickInUse) {
            let vector = CGVector(dx: location.x - joystick.position.x, dy: location.y - joystick.position.y)
            
            let angle = atan2(vector.dy, vector.dx)
            
            let distanceFromCenter = CGFloat(joystick.frame.size.height/2)
            
            let distanceX = CGFloat(sin(angle - distanceFromCenter))
            let distanceY = CGFloat(cos(angle - distanceFromCenter))
            
            if(joystick.frame.contains(location)) {
                joystick.joystickButton.position = location
            }
            else {
                joystick.joystickButton.position = CGPoint(x: joystick.position.x - distanceX, y: joystick.position.y + distanceY)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if (joystick.joystickButton.frame.contains(location)){
                joystickInUse = true
                
                print("tocou")
            } else {
                joystickInUse = false
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchMoved(touch: touch)
        }
    }
}
