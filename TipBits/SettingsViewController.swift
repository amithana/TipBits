//
//  SettingsViewController.swift
//  TipBits
//
//  Created by Amitha Murthy on 3/8/17.
//  Copyright © 2017 Amitha Murthy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultPercentSegment: UISegmentedControl!
    
    var selectedPercent:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

                // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaultPercent = UserDefaults.standard.integer(forKey: "defaultPercent")
        defaultPercentSegment.selectedSegmentIndex=defaultPercent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onDefaultPercentChanged(_ sender: Any) {
     selectedPercent=defaultPercentSegment.selectedSegmentIndex
        UserDefaults.standard.set(selectedPercent, forKey:"defaultPercent")
        UserDefaults.standard.synchronize()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
