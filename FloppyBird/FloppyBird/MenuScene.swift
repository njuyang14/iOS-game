//
//  MenuScene.swift
//  eatingpig
//
//  Created by mm on 17/1/9.
//  Copyright © 2017年 mm. All rights reserved.
//

import SpriteKit

class MenuScene :SKScene
{
    private let ground = Ground()
    private let hill = Hill()
    var play = SKSpriteNode()
    var sun = SKSpriteNode()
   // private let title = Title()
    //private let playButton = PlayButton()
    
    private var lastUpdateTime:TimeInterval=0.0
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize)
    {
        super.init(size: size)
    }
    
    override func didMove(to view:SKView)
    {
        setup()
        
//        Sound.sharedInstance.playMusic()
    }
    
    private func setup()
    {
        self.backgroundColor = Colors.color(rgb: Colors.sky)
        
        //logo
        let logoTexture = Textures.sharedInstance.textureWith(name: "GameLogo0")
        let logo = SKSpriteNode(texture: logoTexture,color: SKColor.white,size: logoTexture.size())
        let frame0 = Textures.sharedInstance.textureWith(name:"GameLogo0")
        let frame1 =
            Textures.sharedInstance.textureWith(name: "GameLogo1")
        
        let animation = SKAction.animate(with: [frame0, frame1], timePerFrame: 0.1)
        
        logo.run(SKAction.repeatForever(animation))
        logo.position = kScreenCenter
      
        //play button
        let playTexture = Textures.sharedInstance.textureWith(name: "PlayButton")
        play = SKSpriteNode(texture: playTexture,color: SKColor.white,size: playTexture.size())
        play.position = CGPoint(x:logo.position.x, y:logo.position.y+logo.size.height)
        
        //sun button
        let sunTexture = Textures.sharedInstance.textureWith(name: "sun")
        sun = SKSpriteNode(texture: sunTexture,color: SKColor.white,size: sunTexture.size())
        sun.position = CGPoint(x:kViewSize.width-50, y:kViewSize.height-50)
        
        self.addChild(sun)
        self.addChild(ground)
        self.addChild(hill)
        self.addChild(logo)
        self.addChild(play)
        //self.addChild(title)
        //self.addChild(playButton)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        ground.update(delta: delta)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if play.contains(touchLocation)
        {
            //play.tapped()
            loadScene()
        }
        //loadScene()
    }
    
    private func loadScene()
    {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        let transition = SKTransition.fade(with: SKColor.black, duration: 1.0)
        
        self.view?.presentScene(scene, transition:transition)
    }
}
