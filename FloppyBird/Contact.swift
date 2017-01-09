//
//  Contact.swift
//  FloppyBird
//
//  Created by yang on 17/1/9.
//  Copyright © 2017年 SpriteKit Book. All rights reserved.
//

import Foundation

class Contact {
    class var scene:UInt32      { return 1 << 0 }
    class var log:UInt32        { return 1 << 1 }
    class var floppy:UInt32     { return 1 << 2 }
    class var score:UInt32      { return 1 << 3 }
}
