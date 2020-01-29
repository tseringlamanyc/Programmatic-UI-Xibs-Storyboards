//
//  PodcastDetailController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Tsering Lama on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import ImageKit

class PodcastDetailController: UIViewController {

    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    var podcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let podcast = podcast else {
            fatalError()
        }
        artistName.text = podcast.artistName
        podcastImage.getImage(with: podcast.artworkUrl600) { [weak self] (result) in
            switch result {
            case .failure(_):
                print("no picture")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                }
            }
        }
    }
}
