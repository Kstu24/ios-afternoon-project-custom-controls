//
//  ViewController.swift
//  Star Rating
//
//  Created by Kevin Stewart on 2/6/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func updateRating(_ ratingControl: CustomControl) {
        if ratingControl.value == 0 {
            self.title = "User Rating: 1 star"
        } else {
             self.title = "User Rating: \(ratingControl.value) stars"
        }
       
}

}
