//
//  utils.swift
//  DemoMemoryGame
//
//  Created by Manish on 31/01/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit
extension MutableCollectionType where Index == Int {

    mutating func shuffleInPlace() {
 
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

extension CollectionType {
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}
extension UIDevice {
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .Phone
    }
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case unknown
    }
    var screenType: ScreenType {
        guard iPhone else { return .unknown }
        switch UIScreen.mainScreen().nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208:
            return .iPhone6Plus
        default:
            return .unknown
        }
    }
}
