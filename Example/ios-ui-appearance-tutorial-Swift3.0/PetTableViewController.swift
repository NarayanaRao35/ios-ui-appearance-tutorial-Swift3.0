//
//  PetTableViewController.swift
//  Pet Finder
//
//  Created by Essan Parto on 5/16/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

struct Pet {
  var name = ""
  var type = ""
}

let pets = [
  Pet(name: "Rusty", type: "Golder Retriever"),
  Pet(name: "Max", type: "Mixed Terrier"),
  Pet(name: "Lucifer", type: "Freaked Out"),
  Pet(name: "Tiger", type: "Sensitive Whiskers"),
  Pet(name: "Widget", type: "Mouse Catcher"),
  Pet(name: "Wiggles", type: "Border Collie"),
  Pet(name: "Clover", type: "Mixed Breed"),
  Pet(name: "Snow White", type: "Black Cat"),
]

class PetTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let titleImageView = UIImageView(image: UIImage(named: "catdog"))
    titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    titleImageView.contentMode = UIViewContentMode.scaleAspectFit
    
    navigationItem.titleView = titleImageView
    
    let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(PetTableViewController.search))
    navigationItem.rightBarButtonItem = searchButton
    
    let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(PetTableViewController.settings))
    navigationItem.leftBarButtonItem = settingsButton
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    

    view.backgroundColor = ThemeManager.currentTheme().backgroundColor
    tableView.separatorColor = ThemeManager.currentTheme().secondaryColor
  }
  
  
  // MARK: - Search

  func search() {
    let searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchTableViewController")
    
    searchViewController?.modalPresentationStyle = .popover
    searchViewController?.modalTransitionStyle = .coverVertical
    searchViewController?.popoverPresentationController?.delegate = self
    present(searchViewController!, animated: true, completion: nil)
  }

  // MARK: - Settings
  
  func settings() {
    let settingsViewController = storyboard?.instantiateViewController(withIdentifier: "SettingsTableViewController")
    
    settingsViewController?.modalPresentationStyle = .popover
    settingsViewController?.modalTransitionStyle = .coverVertical
    settingsViewController?.popoverPresentationController?.delegate = self
    present(settingsViewController!, animated: true, completion: nil)
  }

  // MARK: - Popover
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
    return UIModalPresentationStyle.overCurrentContext
  }
  
  func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
    let navController = UINavigationController(rootViewController: controller.presentedViewController)
    
    return navController
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pets.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath as IndexPath)

      cell.imageView!.image = UIImage(named: "pet\(indexPath.row)")
      cell.imageView!.layer.masksToBounds = true
      cell.imageView!.layer.cornerRadius = 5

      cell.detailTextLabel!.text = pets[indexPath.row].type

      cell.textLabel!.text = pets[indexPath.row].name
      
      return cell
  }


  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowPet" {
        let selectedPetIndex = tableView.indexPath(for: sender as! UITableViewCell)!.row
        (segue.destination as! PetViewController).petIndex = selectedPetIndex
      }
  }
}
