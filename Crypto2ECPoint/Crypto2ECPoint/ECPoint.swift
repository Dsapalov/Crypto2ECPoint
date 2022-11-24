//
//  ECPoint.swift
//  Crypto2ECPoint
//
//  Created by Denis Sapalov on 22.11.2022.
//

import Foundation

class ECPoint {
    let x: Int
    let y: Int
    
    // func ECPointGen(x, y *big.Int) (point ECPoint) {}         // ECPoint creation with pre-defined parameters
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}


extension ECPoint {
    
    func AddECPoints(b:ECPoint) -> ECPoint {
        
        let m = (b.y - self.y) / (b.x - self.x)

        let x = m * m - self.x - b.x
        let y = b.y + m * (self.x - x)

        return ECPoint(x: x, y: y)
    }
    
    func DoubleECPoints() -> ECPoint {
        // ??
        let aFromFormula = 1
        
        let lambda = ((3 * (self.x ^ 2) + aFromFormula) / 2 * self.y) ^ 2
        
        let x = lambda - 2 * self.x
        let y = (-self.y + lambda) * (self.x - x)
        
        return ECPoint(x: x, y: y)
        
    }
    
    func ScalarMult(k: Int) -> ECPoint {
        var result = ECPoint(x: 0, y: 0)
        
        var coefficient = k
        let bitLength = coefficient.bitWidth - coefficient.leadingZeroBitCount
        var partialCoefficient = 1
        var partialResult = self
        var trail: [(Int, ECPoint)] = []
        
        for _ in 0..<bitLength {
            trail.append((partialCoefficient, partialResult))
            partialCoefficient <<= 1
            partialResult = AddECPoints(b: partialResult)
        }
        
        for (coef, res) in trail.reversed() {
            if coefficient >= coef {
                coefficient = coefficient - coef
                result = AddECPoints(b: res)
            }
        }
        
        return result
    }
    
    // changed for using on UI
    func PrintECPoint() -> String {
        return "ECPoint:!!!!! " //point
    }
    
    func ECPointToString() -> String {
        return "ECPoint: x: \(self.x), y:\(self.y) "
    }
    
    func IsOnCurveCheck() -> Bool {
        let lhs = self.y * self.y
        let rhs = self.x * self.x * self.x + self.x * self.x + self.y

        return lhs == rhs
    }
}
