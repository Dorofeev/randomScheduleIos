//
//  Randomizer.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 10.09.2022.
//

import RandomKit

class Randomizer {
    
    static func randomColor() -> UIColor {
        return UIColor.random(using: &Xoroshiro.default)
    }
    
    static func randomNumber(min: Int = 0, max: Int = 100) -> Int {
        return Int.random(in: min...max, using: &Xoroshiro.default)
    }
    
    static func randomRandom() -> Int {
        var count = 0
        while true {
            count += 1
            
            let random = randomNumber(max: 250)
            if (random % 11 == 0 && random < 100) || random % 111 == 0 {
                return count
            }
        }
    }
    
    static func randomFont(size: CGFloat) -> UIFont? {
        let familyNames = UIFont.familyNames
        let randomFamily = familyNames[randomNumber(min: 0, max: familyNames.count - 1)]
        let fontNames = UIFont.fontNames(forFamilyName: randomFamily)
        let randomName = fontNames[randomNumber(min: 0, max: fontNames.count - 1)]
        return UIFont(name: randomName, size: size)
    }
}
