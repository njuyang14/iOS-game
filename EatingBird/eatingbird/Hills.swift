//
//  Hills.swift
//  EatingBird
//
//  Created by yang on 17/1.
//  Copyright © 2017年 SpriteKit Book. All rights reserved.
//

import Foundation
import SpriteKit

class Hill:SKSpriteNode
{
    private let animationName = "hill"
    private let moveSpeed:CGFloat = 15
    convenience init()
    {
        let texture = Textures.sharedInstance.textureWith(name: "Hills")
        self.init(texture: texture,color: SKColor.white,size: texture.size())
        
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint(x:0, y:Ground().size.height)
        
        let child = Textures.sharedInstance.spriteWith(name: "Hills")
        child.anchorPoint = CGPoint.zero
        child.position = CGPoint(x:self.size.width, y:0)
        self.addChild(child)
        //setupPhysics()
    }
    
    private func setupPhysics()
    {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Contact.scene
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    public func setInitPos(pos:CGPoint)
    {
        self.position = pos
    }
    
    func update(delta: TimeInterval)
    {
        //let moveAmount = CGFloat(delta) * 60 * 0.25
        let moveAmount = CGFloat(delta) * moveSpeed * 2
        if self.position.x < 0 - self.size.width / 2
        {
            self.position = CGPoint.zero
        }
        else
        {
            let newX = self.position.x - moveAmount
            self.position = CGPoint(x: newX, y: self.position.y)
        }
    }
    
}
