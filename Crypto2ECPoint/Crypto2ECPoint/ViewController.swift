//
//  ViewController.swift
//  Crypto2ECPoint
//
//  Created by Denis Sapalov on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var xA: UITextField!
    @IBOutlet weak var yA: UITextField!
    @IBOutlet weak var xB: UITextField!
    @IBOutlet weak var yB: UITextField!
    @IBOutlet weak var skalarMul: UITextField!
    
    @IBOutlet weak var printResultLabel: UILabel!
    @IBOutlet weak var toStringResultLabel: UILabel!
    @IBOutlet weak var isOnCurveResultLabel: UILabel!
    @IBOutlet weak var addResultLabel: UILabel!
    @IBOutlet weak var doubleResultLabel: UILabel!
    @IBOutlet weak var scalarResultLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func testEcpPointAction() {
        
        guard let safeXA = xA.text, let safeYA = yA.text,
        let safeXB = xB.text , let safeYB = yB.text,
        let safeSkalar = skalarMul.text else {
            showAlert()
            return
        }
        
        guard let intXA = Int(safeXA), let intYA = Int(safeYA),
        let intXB = Int(safeXB), let intYB = Int(safeYB),
        let intSkalar = Int(safeSkalar) else {
            showAlert()
            return
        }
        
        let ecpPointA = ECPoint(x: intXA, y: intYA)
        let ecpPointB = ECPoint(x: intXB, y: intYB)
        
        printResultLabel.text = "PrintECPoint: " + ecpPointA.PrintECPoint()
        toStringResultLabel.text = "ECPointToString: " + ecpPointA.ECPointToString()
        isOnCurveResultLabel.text = "IsOnCurveCheck: " + (ecpPointA.IsOnCurveCheck() ? "true" : "false")
        addResultLabel.text = "AddECPoints: " + ecpPointA.AddECPoints(b: ecpPointB).PrintECPoint()
        doubleResultLabel.text = "DoubleECPoints: " + ecpPointA.DoubleECPoints().PrintECPoint()
        scalarResultLabel.text = "ScalarMult: " + ecpPointA.ScalarMult(k: intSkalar).PrintECPoint()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Incorrect input data", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
}
