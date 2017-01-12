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
//    private let title = Title()
//    private let playButton = PlayButton()
    
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
        self.backgroundColor = SKColor(red: CGFloat(0x4b), green: CGFloat(0xa3), blue: CGFloat(0xff), alpha: 1.0)
    
        self.addChild(ground)
//        self.addChild(title)
//        self.addChild(playButton)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
/*        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if playButton.contains(touchLocation)
        {
            playButton.tapped()
            loadScene()
        }
*/
    }
    
    private func loadScene()
    {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        let transition = SKTransition.fade(with: SKColor.black, duration: 1.0)
        
        self.view?.presentScene(scene, transition:transition)
    }
}
