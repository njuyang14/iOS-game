//
//  Enemy.swift
//  EatingBird
//
//  Created by yang on 17/1.
//  Copyright © 2017年 SpriteKit Book. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy:SKSpriteNode
{
    private let animationName = "enemy"
    private let moveSpeed:CGFloat = 15
    convenience init()
    {
        let texture = Textures.sharedInstance.textureWith(name: "Vader")
        self.init(texture: texture,color: SKColor.white,size: texture.size())
        self.setScale(0.5)
        setupPhysics()
    }
    
    private func setupPhysics()
    {
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Contact.enemy
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    public func setInitPos(pos:CGPoint)
    {
        self.position = pos
    }
    
    func update(delta: TimeInterval)
    {
        let speedX = CGFloat(delta) * moveSpeed * 3
        
        self.position.x = self.position.x - speedX
        
        // Remove the cloud if completely offscreen left
        if self.position.x < (0 - self.size.width)
        {
            self.removeFromParent()
        }
    }
    
}
