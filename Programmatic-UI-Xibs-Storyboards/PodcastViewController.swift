//
//  ViewController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Alex Paul on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
  
  private let podcastView = PodcastView()
  
  private var podcasts = [Podcast]() {
    didSet {
      // code here
        DispatchQueue.main.async {
            self.podcastView.collectionView.reloadData()
        }
    }
  }

  override func loadView() {
    view = podcastView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.title = "Podcasts"
    podcastView.collectionView.dataSource = self
    podcastView.collectionView.delegate = self
    
    // register cell
    // 1)
    // podcastView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "podcastCell")
    
    // register cell using xib
    // 2)
    podcastView.collectionView.register(UINib(nibName: "PodcastCell", bundle: nil), forCellWithReuseIdentifier: "podcastCell")
    fetchPodcasts()
  }
  
  private func fetchPodcasts(_ name: String = "swift") {
    PodcastAPIClient.fetchPodcast(with: name) { (result) in
      switch result {
      case .failure(let appError):
        print("error fetching podcasts: \(appError)")
      case .success(let podcasts):
        self.podcasts = podcasts
      }
    }
  }
}

extension PodcastViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return podcasts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // 1) let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath)
    // 2)
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
        fatalError()
    }
    cell.backgroundColor = .systemGray
    return cell
  }
}

extension PodcastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.95
        return CGSize(width: itemWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = podcasts[indexPath.row]
        print(podcast.collectionName)
    }
}




