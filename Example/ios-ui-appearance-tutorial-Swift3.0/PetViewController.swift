//
//  PetViewController.swift
//  Pet Finder
//
//  Created by Essan Parto on 5/16/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class PetViewController: UIViewController {
  @IBOutlet weak var petImageView: UIImageView!
  var petIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Adopt", style: .plain, target: self, action: #selector(PetViewController.adopt))
    title = pets[petIndex].name
    
    petImageView.image = UIImage(named: "pet\(petIndex)")
  }
  
  func adopt() {
    performSegue(withIdentifier: "ShowAdopt", sender: self)
  }
}
