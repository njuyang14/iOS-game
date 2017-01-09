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
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: "cloud")
        self.init(texture: texture,color: SKColor.white,size: texture.size())
        self.setScale(0.5)
    }
    
    public func setInitPos(pos:CGPoint){
        self.position = pos
    }
    
}
