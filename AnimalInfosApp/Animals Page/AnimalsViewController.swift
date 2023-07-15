
import UIKit

class AnimalsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    private let animals: [Animals] = [
        Animals(name: "Giraffe", imageName: "elephant"),
        Animals(name: "Elephant", imageName: "lion"),
        Animals(name: "Lion", imageName: "giraffe"),
        Animals(name: "Zebra", imageName: "hippo"),
        Animals(name: "Tiger", imageName: "cheetah"),
        Animals(name: "Monkey", imageName: "gorilla"),
        Animals(name: "Kangaroo", imageName: "ostrich"),
        Animals(name: "Giraffe", imageName: "zebra"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animals"
        setupMyViews()
    }

    private func setupMyViews() {
        let stackView = createStackView()
        contentView.addSubview(stackView)
        positionStackView(stackView)
    }

    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        for _ in 1...4 {
            let subStackView = createSubStackView()
            stackView.addArrangedSubview(subStackView)
        }

        return stackView
    }

    private var animalIndex = 0

    private func createSubStackView() -> UIStackView {
        let subStackView = UIStackView()
        subStackView.axis = .horizontal
        subStackView.alignment = .fill
        subStackView.distribution = .fillEqually
        subStackView.spacing = 10

        for _ in 1...2 {
            let animal = animals[animalIndex]
            let cardView = CardView()
            cardView.imageName = animal.imageName
            subStackView.addArrangedSubview(cardView)

            animalIndex += 1
            if animalIndex >= animals.count {
                animalIndex = 0
            }
        }

        return subStackView
    }


    private func positionStackView(_ stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

