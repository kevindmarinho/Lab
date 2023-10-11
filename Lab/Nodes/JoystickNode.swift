//
//  JoystickNode.swift
//  Lab
//
//  Created by kevin marinho on 29/09/23.
//

import Foundation
import SpriteKit

class JoystickNode: SKNode {
    public var joystickBack: SKSpriteNode
    public var joystickButton: SKSpriteNode
    
    override init() {
        joystickBack = .init(imageNamed: "JoystickBack")
        joystickButton = .init(imageNamed: "JoystickButton")

        super.init()
        joystickBack.position = CGPoint(x: -80, y: -30)
        joystickButton.position = CGPoint(x: -80, y: -30)
        joystickBack.setScale(1/10)
        joystickButton.setScale(1/10)
        
        self.addChild(joystickBack)
        self.addChild(joystickButton)
        self.zPosition = 50
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
