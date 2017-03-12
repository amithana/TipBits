//
//  SettingsViewController.swift
//  TipBits
//
//  Created by Amitha Murthy on 3/8/17.
//  Copyright © 2017 Amitha Murthy. All rights reserved.
//

import UIKit

let myNotificationKey="com.codepath.segmentChangeNotificationKey"

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultPercentSegment: UISegmentedControl!
    
    var selectedPercent:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedPercent = UserDefaults.standard.integer(forKey: "defaultPercent")
        defaultPercentSegment.selectedSegmentIndex=selectedPercent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onDefaultPercentChanged(_ sender: Any) {
        
     selectedPercent=defaultPercentSegment.selectedSegmentIndex
        //UserDefaults.standard.set(selectedPercent, forKey:"defaultPercent")
        //UserDefaults.standard.synchronize()
        //NotificationCenter.default.post(name: Notification.Name(rawValue:myNotificationKey), object:self)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(selectedPercent, forKey:"defaultPercent")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name(rawValue:myNotificationKey), object:self)

        
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
