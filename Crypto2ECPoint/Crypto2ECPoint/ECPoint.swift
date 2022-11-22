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
    
    func AddECPoints(a: ECPoint, b:ECPoint) -> ECPoint {
        
        let m = (b.y - a.y) / (b.x - a.x)

        let x = m * m - a.x - b.x
        let y = b.y + m * (a.x - x)

        return ECPoint(x: x, y: y)
    }
    
    func DoubleECPoints(a: ECPoint) -> ECPoint {
        // ??
        var aFromFormula = 1
        
        var lambda = ((3 * (a.x ^ 2) + aFromFormula) / 2 * a.y) ^ 2
        
        var x =  lambda - 2 * a.x
        var y =  (-a.y + lambda) * (a.x - x)
        
        return ECPoint(x: x, y: y)
        
    }
    
    func ScalarMult(a: ECPoint, k: Int) -> ECPoint {
        var result = ECPoint(x: 0, y: 0)
        
        var coefficient = k
        let bitLength = coefficient.bitWidth - coefficient.leadingZeroBitCount
        var partialCoefficient = 1
        var partialResult = a
        var trail: [(Int, ECPoint)] = []
        
        for _ in 0..<bitLength {
            trail.append((partialCoefficient, partialResult))
            partialCoefficient <<= 1
            partialResult = AddECPoints(a: partialResult, b: partialResult)
        }
        
        for (coef, res) in trail.reversed() {
            if coefficient >= coef {
                coefficient = coefficient - coef
                result = AddECPoints(a: result, b: res)
            }
        }
        
        return result
    }
    
    func PrintECPoint(point: ECPoint) {
        print("ECPoint: ", point)
    }
    
    func ECPointToString(point: ECPoint) -> String {
        return "ECPoint: x: \(point.x), y:\(point.y) "
    }
    
    func IsOnCurveCheck(a: ECPoint) -> Bool {
        let lhs = a.y * a.y
        let rhs = a.x * a.x * a.x + self.x * a.x + self.y

        return lhs == rhs
    }
}
