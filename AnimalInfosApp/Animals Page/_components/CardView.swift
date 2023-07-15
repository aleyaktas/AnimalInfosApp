//
//  CardView.swift
//  AnimalInfosApp
//
//  Created by Aleyna Aktaş on 14.07.2023.
//
import UIKit

class CardView: UIView {

    var imageName: String? {
        didSet {
            updateImageViewWithImage()
        }
    }

    @IBOutlet weak var imgView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
//        print(imageName!)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        if let imageName = imageName {
            print(imageName)
            imgView.image = UIImage(named: imageName)
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


}
