//
//  Bird.swift
//  FloppyBird
//
//  Created by yang on 17/1/9.
//  Copyright © 2017年 SpriteKit Book. All rights reserved.
//

import Foundation
import SpriteKit

class Bird:SKSpriteNode {
    private let animationName = "flap"
    public var score = 0//my score
    
    /*override init(texture: SKTexture?, color:UIColor, size:CGSize){
        super.init(texture: <#T##SKTexture?#>, color: <#T##UIColor#>, size: <#T##CGSize#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: "player0")
        self.init(texture: texture,color: SKColor.white,size: texture.size())
        
        // Create the frames of the animation
        let frame0 = Textures.sharedInstance.textureWith(name:"player0")
        let frame1 = Textures.sharedInstance.textureWith(name: "player1")
        
        // Create the animation using the frames
        let animation = SKAction.animate(with: [frame0, frame1], timePerFrame: 0.1)
        
        // Run the animation forever
        self.run(SKAction.repeatForever(animation), withKey: animationName)
        
        // Position Floppy 30% into the screen from left on the X axis and 80% up the Y axis
        self.position = CGPoint(x: kViewSize.width * 0.3, y: kViewSize.height * 0.8)
        
        setupPhysics()
    }
    
    private func setupPhysics() {
        // Make the physics body circle a little tighter because the sprite is egg shaped.
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 3, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.floppy
        self.physicsBody?.collisionBitMask = Contact.scene
        self.physicsBody?.contactTestBitMask = Contact.scene | Contact.log | Contact.score
    }
    
    func fly(){
         self.physicsBody!.velocity = CGVector.zero
        let impulse = CGVector(dx:0,dy:25)
        self.physicsBody?.applyImpulse(impulse)
    }
}
