//
//  Player.swift
//  ContentProposal
//
//  Created by Jan GORMAN on 29/12/2016.
//  Copyright © 2016 Schnaub. All rights reserved.
//

import UIKit
import AVKit

final class Player: NSObject {
  
  private let playerViewController: AVPlayerViewController
  private var videos: [Video]!
  
  override init() {
    playerViewController = AVPlayerViewController()
    super.init()

    playerViewController.delegate = self
  }
  
  func play(fromController controller: UIViewController, videos: [Video]) {
    controller.present(playerViewController, animated: true, completion: nil)
    self.videos = videos
    nextVideo()
  }
  
  private func nextVideo() {
    let video = videos.removeFirst()
    videos.append(video)
    let playerItem = AVPlayerItem(url: video.streamUrl)
    playerItem.externalMetadata = video.metadata
    
    if playerViewController.player == nil {
      playerViewController.player = AVPlayer(playerItem: playerItem)
    } else {
      playerViewController.player?.replaceCurrentItem(with: playerItem)
    }
    playerViewController.player?.play()
    addContentProposal()
  }
  
  fileprivate func addContentProposal() {
    let video = videos.removeFirst()
    videos.append(video) // Make it loop
    let proposal = AVContentProposal(contentTimeForTransition: kCMTimeIndefinite, title: video.title,
                                     previewImage: video.thumbnail)
    proposal.url = video.streamUrl
    proposal.automaticAcceptanceInterval = 3
    proposal.metadata = video.metadata
    playerViewController.player?.currentItem?.nextContentProposal = proposal
  }
  
}

extension Player: AVPlayerViewControllerDelegate {
  
  func playerViewController(_ playerViewController: AVPlayerViewController,
                            shouldPresent proposal: AVContentProposal) -> Bool {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ContentProposalViewController") as! ContentProposalViewController
    playerViewController.contentProposalViewController = vc
    return true
  }
  
  func playerViewController(_ playerViewController: AVPlayerViewController, didAccept proposal: AVContentProposal) {
    guard let url = proposal.url else { return }
    
    let nextItem = AVPlayerItem(url: url)
    nextItem.externalMetadata = proposal.metadata
    playerViewController.player?.replaceCurrentItem(with: nextItem)
    playerViewController.player?.play()
    addContentProposal()
  }
  
  func playerViewController(_ playerViewController: AVPlayerViewController, didReject proposal: AVContentProposal) {
    playerViewController.dismiss(animated: true, completion: nil)
  }

}
