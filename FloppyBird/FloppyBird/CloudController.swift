//
//  CloudController.swift
//  FloppyBird
//
//  Created by yang on 17/1/10.
//  Copyright © 2017年 SpriteKit Book. All rights reserved.
//

import Foundation
import SpriteKit

class CloudController:SKNode {
    private let animationName = "cloudController"
    private let moveSpeed:CGFloat = 5
    private var cloudArray = [Clouds]()
    private var appearTime:TimeInterval = 0
    
    override init() {
        super.init()
        initCloudArray()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCloudArray(){
        
        self.run(SKAction.wait(forDuration: 0.25), completion: {
            [weak self] in
            self?.appearFirst()
        })
    }
    
    func appearFirst(){
        let cloud = Clouds()
        cloud.position = CGPoint(x:200, y:200)
        self.addChild(cloud)
    }
    
    func appear(){
        let cloud = Clouds()
        cloud.setInitPos(pos: CGPoint(x:kViewSize.width,y:kViewSize.height*random(min:0.3,max:0.8)))
        self.addChild(cloud)
    }
    
    func update(delta: TimeInterval) {
       appearTime += delta
        if(appearTime >= 5){
            print(appearTime)
            appearTime = 0
            self.appear()
        }
        
        for one in self.children{
            if let cloud = one as? Clouds{
                cloud.update(delta: delta)
            }
        }
    }
    
}
