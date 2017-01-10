//
//  GameScene.swift
//  FloppyBird
//
//  Created by Jeremy Novak on 9/24/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Private class constants
    private let label = SKLabelNode()
    
    private var lastUpdateTime: TimeInterval = 0
    
    private let bird = Bird()
    private let cloudController = CloudController()
    
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
        
        label.fontName = "Arial"
        label.fontColor = SKColor.white
        label.fontSize = 44.0
        label.text = "GameScene"
        label.position = kScreenCenter
        
        //add enemy
        let appear = SKAction.run ({() in self.enemyAppear()})
        let delay = SKAction.wait(forDuration: (2.0))
        self.run(SKAction.repeatForever(SKAction.sequence([appear,delay])))
        
        self.addChild(label)
        self.addChild(bird)
       //self.addChild(cloudController)
    }
    
    func enemyAppear(){
        let cloud = Clouds()
        cloud.setInitPos(pos: CGPoint(x:frame.size.width,y:frame.size.height*random(min:0.3,max:0.8)))//init appear pos
        self.addChild(cloud)
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
        let scene = GameOverScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
}
