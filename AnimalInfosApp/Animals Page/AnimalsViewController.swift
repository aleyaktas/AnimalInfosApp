//
//  AnimalsViewController.swift
//  AnimalInfosApp
//
//  Created by Aleyna Aktaş on 14.07.2023.
//

import UIKit

class AnimalsViewController:UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animals"
        setupMyViews()
    }
    private func setupMyViews() {
        cardView.imageName = "Bear"
    }
}
