//
//  SnakeHead.swift
//  snake_2
//
//  Created by Andrei Nosov on 27.11.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategory.SnakeHead
        self.physicsBody?.collisionBitMask = CollisionCategory.EdgeBody |
        CollisionCategory.Apple | CollisionCategory.SNake
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
