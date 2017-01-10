  //
//  Clouds.swift
//  FloppyBird
//
//  Created by yang on 17/1/9.
//  Copyright © 2017年 SpriteKit Book. All rights reserved.
//

import Foundation
import SpriteKit

class Clouds:SKSpriteNode {
    private let animationName = "clouds"
    private let moveSpeed:CGFloat = 5
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: "cloud")
        self.init(texture: texture,color: SKColor.white,size: texture.size())
        self.setScale(0.5)
    }
    
    public func setInitPos(pos:CGPoint){
        self.position = pos
    }
    
    func update(delta: TimeInterval) {
        let speedX = CGFloat(delta) * moveSpeed * 2
        
        self.position.x = self.position.x - speedX
        
        // Remove the cloud if completely offscreen left
        if self.position.x < (0 - self.size.width) {
            self.removeFromParent()
        }
    }
    
}
