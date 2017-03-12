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
    
    @IBOutlet weak var totalView: UIView!
    var indexChangedFlag: Bool = false
    
    //2 mins
    static let ttl = TimeInterval(120)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
       
        NotificationCenter.default.addObserver(self, selector: #selector(actOnDefaultPercentChanged), name: NSNotification.Name(rawValue:myNotificationKey), object: nil)
        if(!indexChangedFlag){
            animateWhenTextEmpty()
        recalculateTip()
        }
    }
    
    func actOnDefaultPercentChanged(){
    
        let defaults = UserDefaults.standard;
        let defaultPercent = defaults.integer(forKey: "defaultPercent")
        tipPercentSegment.selectedSegmentIndex=defaultPercent
        indexChangedFlag = true
        self.calculateTip(self)
        
    }
    func animateWhenTextEmpty(){
       
        UIView.animate(withDuration: 0.1 , animations: {
            self.totalView.alpha=0;
            self.tipPercentSegment.alpha=0;
        self.billField.frame = self.billField.frame.offsetBy(dx: 0.0, dy: 120.0)
        self.tipPercentSegment.frame = self.tipPercentSegment.frame.offsetBy(dx: 0.0, dy: 400.0)

        self.totalView.frame = self.totalView.frame.offsetBy(dx: 0.0, dy: 400.0)
        
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = self.billField.becomeFirstResponder()
    }
    
    func recalculateTip(){
        
        let defaults = UserDefaults.standard;
        let defaultPercent = defaults.integer(forKey: "defaultPercent")
        
        let lastBilldate = defaults.object(forKey: "lastBillDate") as! Date?
        
        if(lastBilldate != nil && NSDate().timeIntervalSince(lastBilldate!) <= ViewController.ttl){
            let lastTipIndex = defaults.integer(forKey: "lastTipIndex")
            let lastBill = defaults.double(forKey: "lastBill")
            if(lastBill != 0){
            billField.text = String(format:"%.2f",lastBill)
                    }
            tipPercentSegment.selectedSegmentIndex=lastTipIndex
        
        }
        else{
        tipPercentSegment.selectedSegmentIndex=defaultPercent
        }
        self.calculateTip(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercents=[0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = tipPercents[tipPercentSegment.selectedSegmentIndex]*bill
        let total = tip+bill
        
        saveBill(bill:bill, tip:tipPercentSegment.selectedSegmentIndex)
        
        tipLabel.text = String(format:"$%.2f",tip)
        totalLabel.text=String(format:"$%.2f",total)
        
        if(bill != 0 && totalView.alpha == 0 && tipPercentSegment.alpha == 0
            ){
        animateWhenTextEntered()
        }else if(bill == 0 && totalView.alpha == 1 && tipPercentSegment.alpha == 1){
            animateWhenTextEmpty()
        }
       
        }
    
    
    func saveBill(bill:Double, tip:Int){

        UserDefaults.standard.set(bill, forKey:"lastBill")

        UserDefaults.standard.set(tip, forKey:"lastTipIndex")
    
        UserDefaults.standard.set(Date(), forKey:"lastBillDate")
               UserDefaults.standard.synchronize()
    }
    
    func animateWhenTextEntered(){
        
        UIView.animate(withDuration: 0.5, animations: {
        self.billField.frame = self.billField.frame.offsetBy(dx: 0.0, dy: -120.0)
        self.tipPercentSegment.frame = self.tipPercentSegment.frame.offsetBy(dx: 0.0, dy: -400.0)
        
        self.totalView.frame = self.totalView.frame.offsetBy(dx: 0.0, dy: -400.0)
        self.totalView.alpha=1
        self.tipPercentSegment.alpha=1
        })
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

