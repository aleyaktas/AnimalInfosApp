
import UIKit

class AnimalsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    private let animals: [Animals] = [
        Animals(name: "Elephant", imageName: "elephant", link: "https://en.wikipedia.org/wiki/Elephant"),
        Animals(name: "Lion", imageName: "lion", link:"https://en.wikipedia.org/wiki/Lion"),
        Animals(name: "Giraffe", imageName: "giraffe",link:"https://en.wikipedia.org/wiki/Giraffe"),
        Animals(name: "Hippo", imageName: "hippo",link:"https://en.wikipedia.org/wiki/Hippopotamus"),
        Animals(name: "Cheetah", imageName: "cheetah", link:"https://en.wikipedia.org/wiki/Cheetah"),
        Animals(name: "Gorilla", imageName: "gorilla",link:"https://en.wikipedia.org/wiki/Gorilla"),
        Animals(name: "Ostrich", imageName: "ostrich", link:"https://en.wikipedia.org/wiki/Common_ostrich."),
        Animals(name: "Zebra", imageName: "zebra", link:"https://en.wikipedia.org/wiki/Zebra."),
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
        stackView.spacing = 16

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
        subStackView.spacing = 16

        for _ in 1...2 {
            let animal = animals[animalIndex]
            let cardView = CardView()
            cardView.imageName = animal.imageName
            cardView.detailLink = animal.link
            cardView.title = animal.name
            cardView.openWebAction = routeWebVC()
            subStackView.addArrangedSubview(cardView)

            animalIndex += 1
            if animalIndex >= animals.count {
                animalIndex = 0
            }
        }

        return subStackView
    }

    func routeWebVC() -> (String) -> () {
        return {
            urlString in
            let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
            
            if let webVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                webVC.urlString = urlString
                self.navigationController?.pushViewController(webVC, animated: true)
            }
        }
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

