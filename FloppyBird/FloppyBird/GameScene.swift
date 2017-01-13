//
//  GameScene.swift
//  BBbird
//
//  Created by Jeremy Novak on 9/24/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene,  SKPhysicsContactDelegate{
    
    // MARK: - Private class constants
    private let label = SKLabelNode()
    
    private var lastUpdateTime: TimeInterval = 0
    var gameContinue = true
    
    private let bird = Bird()
    private let cloudController = CloudController()
    private let hill = Hill()
    private let ground = Ground()
    var sun = SKSpriteNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        
        setup()
    }
    
    func random()->CGFloat{
        return CGFloat(Float(arc4random())/0xffffffff)
    }
    
    func random(min:CGFloat,max:CGFloat)->CGFloat{
        return random()*(max-min)+min
    }
    
    // MARK: - Setup
    private func setup() {
        self.backgroundColor = Colors.color(rgb: Colors.sky)
        
        label.fontName = "editundo"
        label.fontColor = SKColor.white
        label.fontSize = 24.0
        label.text = "SCORE: 0"
        label.position = CGPoint(x:60, y:kViewSize.height-30)
        
        //add enemy
        let appear = SKAction.run ({() in self.cloudAppear()})
        let delay = SKAction.wait(forDuration: (3.0))
        self.run(SKAction.repeatForever(SKAction.sequence([appear,delay])))
        
        //add enemy
        let appearEnemy = SKAction.run ({() in self.enemyAppear()})
        let delayEnemy = SKAction.wait(forDuration: (5.0))
        self.run(SKAction.repeatForever(SKAction.sequence([appearEnemy,delayEnemy])))

        //add hill
        //add ground
        
        //sun button
        let sunTexture = Textures.sharedInstance.textureWith(name: "sun")
        sun = SKSpriteNode(texture: sunTexture,color: SKColor.white,size: sunTexture.size())
        sun.position = CGPoint(x:kViewSize.width-50, y:kViewSize.height-50)
        
        physicsWorld.contactDelegate = self
        
        self.addChild(sun)
        self.addChild(label)
        self.addChild(bird)
       self.addChild(hill)
        self.addChild(ground)
    }
    
    func cloudAppear(){
        let cloud = Clouds()
        cloud.setInitPos(pos: CGPoint(x:frame.size.width,y:frame.size.height*random(min:0.3,max:0.8)))//init appear pos
        self.addChild(cloud)
    }
    
    func enemyAppear(){
        let enemy = Enemy()
        enemy.setInitPos(pos: CGPoint(x:frame.size.width,y:frame.size.height*random(min:0.3,max:0.8)))//init appear pos
        self.addChild(enemy)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        cloudController.update(delta: delta)
        //add cloud per 5 sec
        /*if(delta>5){
            let cloud = Clouds()
            cloud.setInitPos(pos: CGPoint(x:frame.size.width,y:frame.size.height*random(min:0.3,max:0.8)))//init appear pos
            self.addChild(cloud)
            allCloud.append(cloud)
        }*/
        
        for one in self.children{
            if let cloud = one as? Clouds{
                cloud.update(delta: delta)
            }
        }
        for one in self.children{
            if let enemy = one as? Enemy{
                enemy.update(delta: delta)
            }
        }
        //hill.update(delta: delta)
        ground.update(delta: delta)
        
        //gameover
        if(!gameContinue){
            loadScene()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch(contactMask){
        case Contact.floppy|Contact.cloud:
            bird.score += 1
            label.text = "SCORE: " + String(bird.score)
            let cloud = contact.bodyA.node
            cloud?.removeFromParent()
        case Contact.enemy|Contact.floppy:
            let enemy = contact.bodyA.node
            enemy?.removeFromParent()
            let mybird = contact.bodyB.node
            mybird?.removeFromParent()
            gameContinue = false
        default:
            return
        }
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        bird.fly()//when touch, bird will fly
        
        if label.contains(touchLocation) {
            loadScene()
        }
    }
    
    // MARK: - Load Scene
    private func loadScene() {
        let scene = GameOverScene(size: kViewSize,score: bird.score)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
}
