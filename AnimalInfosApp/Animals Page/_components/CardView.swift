//
//  CardView.swift
//  AnimalInfosApp
//
//  Created by Aleyna Aktaş on 14.07.2023.
//
import UIKit
import AVKit
import AVFoundation


class CardView: UIView {

    var imageName: String? {
        didSet {
            updateImageViewWithImage()
        }
    }
    var title: String? {
        didSet {
            updateImageTitle()
        }
    }
    var detailLink: String?
    var videoLink: String?
    
    var openWebAction: ((_ urlString: String) -> ())?
    var openVideoAction: ((_ videoLink: String) -> Void)?

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }


    @IBAction func detailButtonAct(_ sender: UIButton) {
        if let detailLink = detailLink {
            openWebAction?(detailLink)
          }
    }
    
  
    @IBAction func videoButtonAct(_ sender: UIButton) {
        if let videoLink = videoLink {
            openVideoAction?(videoLink)
        }
        
    }
    private func setupView() {
        if let viewForXib = Bundle.main.loadNibNamed("CardView", owner: self)?[0] as? UIView {
            viewForXib.frame = self.bounds
            viewForXib.layer.cornerRadius = 16
            addSubview(viewForXib)
        }
    }

    private func updateImageViewWithImage() {
        if let imageName = imageName {
            imgView.image = UIImage(named: imageName)
        }
    }

    private func updateImageTitle() {
        if let title = title {
            imageTitle.text = title
        }
    }
}
