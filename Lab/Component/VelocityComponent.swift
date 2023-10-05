//
//  VelocityComponent.swift
//  Lab
//
//  Created by Letícia Victoria das Neves Sales on 05/10/23.
//

import GameplayKit

class VelocityComponent: GKComponent {
    var velocity: CGVector

    init(velocity: CGVector) {
        self.velocity = velocity
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
