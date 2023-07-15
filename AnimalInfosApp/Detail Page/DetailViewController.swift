//
//  DetailViewController.swift
//  AnimalInfosApp
//
//  Created by Aleyna Aktaş on 15.07.2023.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var urlString: String?

    @IBOutlet weak var detailWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailWebView.load(URLRequest(url: URL(string: urlString!)!))

    }
    

}

