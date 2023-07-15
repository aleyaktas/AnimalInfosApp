
import UIKit
import AVKit
import AVFoundation

class AnimalsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    private let animals: [Animals] = [
        Animals(name: "elephant", imageName: "elephant", link: "https://en.wikipedia.org/wiki/Elephant"),
        Animals(name: "lion", imageName: "lion", link:"https://en.wikipedia.org/wiki/Lion"),
        Animals(name: "giraffe", imageName: "giraffe",link:"https://en.wikipedia.org/wiki/Giraffe"),
        Animals(name: "hippo", imageName: "hippo",link:"https://en.wikipedia.org/wiki/Hippopotamus"),
        Animals(name: "cheetah", imageName: "cheetah", link:"https://en.wikipedia.org/wiki/Cheetah"),
        Animals(name: "gorilla", imageName: "gorilla",link:"https://en.wikipedia.org/wiki/Gorilla"),
        Animals(name: "ostrich", imageName: "ostrich", link:"https://en.wikipedia.org/wiki/Common_ostrich."),
        Animals(name: "zebra", imageName: "zebra", link:"https://en.wikipedia.org/wiki/Zebra."),
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
            cardView.videoLink = animal.name
            cardView.openVideoAction = { [weak self] videoLink in
                       self?.openVideo(videoLink: videoLink)
                   }
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
    
    private func openVideo(videoLink: String) {
        print("Opening video: \(videoLink)")

        if let videosURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Videos"),
            let videoURL = Bundle.main.url(forResource: videoLink, withExtension: "mp4") {
            
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: videosURL.path) {
                do {
                    try fileManager.createDirectory(at: videosURL, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Failed to create Videos directory: \(error)")
                    return
                }
            }
            
            let destinationURL = videosURL.appendingPathComponent("\(videoLink).mp4")
            
            if !fileManager.fileExists(atPath: destinationURL.path) {
                do {
                    try fileManager.copyItem(at: videoURL, to: destinationURL)
                } catch {
                    print("Failed to copy video to destination: \(error)")
                    return
                }
            }
            
            let player = AVPlayer(url: destinationURL)
            let playerController = AVPlayerViewController()
            playerController.player = player
            
            DispatchQueue.main.async {
                self.present(playerController, animated: true) {
                    player.play()
                }
            }
        } else {
            print("Video not found.")
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

