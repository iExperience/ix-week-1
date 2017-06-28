//
//  PlayViewController.swift
//  Sounds
//
//  Created by Miki von Ketelhodt on 2017/06/28.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    var soundFileURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //soundFileURL is not nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
