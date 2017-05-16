//
//  MemoryDelegates.swift
//  DemoMemoryGame
//
//  Created by Manish on 31/01/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit
protocol memoryGameDelegate:class {
    func updateScore(value:Int)-> Void
    //must required every game needed to be over
    func gameOver() -> Void ;
}
//cardFlipDelegate sendCardTag is not nessary to implement
extension memoryGameDelegate
{
    func updateScore(value:Int) -> Void
    {
        
    }
}