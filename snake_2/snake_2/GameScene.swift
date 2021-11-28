//
//  GameScene.swift
//  snake_2
//
//  Created by Andrei Nosov on 26.11.2021.
//

import SpriteKit
import GameplayKit

struct CollisionCategory{
    static let SNake: UInt32 = 0x1 << 0  //ноль-икс-один со смещением 0 (смещение влево на 1 -умножение 2) вправо - деление
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let EdgeBody: UInt32 = 0x1 << 3
}




class GameScene: SKScene {
    
    var snake : Snake?
    var gameFrame: SKShapeNode!
    

    override func didMove(to view: SKView) {
        
        let backgroundColorCustom = UIColor(red: 0.56, green: 0.31, blue: 0.61, alpha: 1)
        self.backgroundColor = backgroundColorCustom
      
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0) //началр чичт координат
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)// объекты которые движутсч
        self.physicsBody?.allowsRotation = false
        
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = true
        

        
        
        
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y:
                                                    view.scene!.frame.minY + 30)
        counterClockwiseButton.fillColor = UIColor.orange
        counterClockwiseButton.strokeColor = UIColor.orange
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        
        self.addChild(counterClockwiseButton)
        
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 75, y: view.scene!.frame.minY + 30)
        clockwiseButton.fillColor = UIColor.orange
        clockwiseButton.strokeColor = UIColor.orange
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        

        self.addChild(clockwiseButton)
        
        createApple()  //кидаем яблоко на загрузку
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        
        self.addChild(snake!)
        self.physicsBody?.categoryBitMask = CollisionCategory.EdgeBody // определили это физическое тело в edgeBody categories
        self.physicsBody?.collisionBitMask = CollisionCategory.SNake | CollisionCategory.SnakeHead //определили какие с телом могут сталкиваться категории
        
//
//        let borders = SKShapeNode(rect: CGRect(x: 0, y: 0, width: view.scene!.frame.width, height: view.scene!.frame.height))
//        borders.fillColor = .orange
//        self.addChild(borders)
//
        
    }  //ЗАГружаем 
    
    

    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchNode.name == "counterClockwiseButton" || touchNode.name ==
                    "clockwiseButton" else {
                        return
                    }
            
            touchNode.fillColor = .blue
            
            if touchNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            } 
        }
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchNode.name == "counterClockwiseButton" || touchNode.name ==
                    "clockwiseButton" else {
                        return
                    }
            
            touchNode.fillColor = .orange
        }
        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake!.move()
    }

    
    func reset() {
        scene!.removeAllChildren()
        let newScene = GameScene(size: self.view!.bounds.size)
        self.view!.presentScene(newScene)
    }
    

    


func createApple () {
    
    let randomX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 30)))
    let randomY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 100)))
    let apple = Apple(position: CGPoint(x: randomX, y: randomY))
    
    self.addChild(apple)
    
}
    
    
    deinit{
        
    }
    
    
    
    
}






extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategory.SnakeHead
        switch collisionObject {
        case CollisionCategory.Apple:
            let apple =  contact.bodyA.node is Apple ? contact.bodyA.node :
            contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
            
        case CollisionCategory.EdgeBody:

            reset()
//            snake!.moveCounterClockwise()
//            snake!.moveCounterClockwise()
        default: break
            
        }
    }
    
    
    
    
    

}


