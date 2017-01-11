//
//  Constants.swift
//  FloppyBird
//


import SpriteKit

let kDebug = true

let kViewSize = UIScreen.main.bounds.size

let kScreenCenter = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)

func random()->CGFloat{
    return CGFloat(Float(arc4random())/0xffffffff)
}

func random(min:CGFloat,max:CGFloat)->CGFloat{
    return random()*(max-min)+min
}


