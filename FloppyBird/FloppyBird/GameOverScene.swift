//
//  GameOverScene.swift
//  eatingpig
//
//  Created by mm on 17/1/9.
//  Copyright © 2017年 mm. All rights reserved.
//


import Social
import SpriteKit

class GameOverScene: SKScene {
    
    // MARK: - Private class constants
    private var myScore: Int = 0
    private let label = SKLabelNode()
    private let myBird = SKSpriteNode(imageNamed:"")
    private  var retry = SKNode()
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, score: Int) {
        self.init(size: size)
        myScore = score
    }
    
    override func didMove(to view: SKView) {
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.backgroundColor = Colors.color(rgb: Colors.sky)
        
        let reTexture = Textures.sharedInstance.textureWith(name: "RetryButton")
        retry = SKSpriteNode(texture: reTexture,color: SKColor.white,size: reTexture.size())
        retry.position = kScreenCenter
        
        label.fontName = "Arial"
        label.fontColor = SKColor.white
        label.fontSize = 44.0
        label.text = "Your Score: "+String(myScore)
        label.position = CGPoint(x: kScreenCenter.x, y: (kScreenCenter.y+30))
        
        self.addChild(label)
        self.addChild(retry)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if retry.contains(touchLocation) {
            loadScene()
        }
        else if label.contains(touchLocation){
        }
    }
    
    // MARK: - Load Scene
    private func loadScene() {
        let scene = MenuScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
}

