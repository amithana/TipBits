//
//  ViewController.swift
//  TipBits
//
//  Created by Amitha Murthy on 3/7/17.
//  Copyright © 2017 Amitha Murthy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipPercentSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        let defaultPercent = UserDefaults.standard.integer(forKey: "defaultPercent")
        tipPercentSegment.selectedSegmentIndex=defaultPercent
        self.CalculateTip(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func CalculateTip(_ sender: AnyObject) {
        let tipPercents=[0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = tipPercents[tipPercentSegment.selectedSegmentIndex]*bill
        let total = tip+bill
        tipLabel.text = String(format:"$%.2f",tip)
        totalLabel.text=String(format:"$%.2f",total)
           }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

