//
//  ContentProposalViewController.swift
//  ContentProposal
//
//  Created by Jan GORMAN on 29/12/2016.
//  Copyright © 2016 Schnaub. All rights reserved.
//

import UIKit
import AVKit

final class ContentProposalViewController: AVContentProposalViewController {
  
  @IBOutlet private var thumbnailImageView: UIImageView!
  @IBOutlet private var nextButton: UIButton!
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    thumbnailImageView.image = contentProposal?.previewImage
    titleLabel.text = contentProposal?.title
    
    func description(_ item: AVMetadataItem) -> Bool {
      return item.identifier == AVMetadataCommonIdentifierDescription
    }

    guard let descriptionText = contentProposal?.metadata.lazy.filter(description).first?.value as? String else {
      return
    }
    descriptionLabel.text = descriptionText
  }

  override var preferredPlayerViewFrame: CGRect {
    return CGRect(x: 0,
                  y: UIScreen.main.bounds.height / 2,
                  width: UIScreen.main.bounds.width,
                  height: UIScreen.main.bounds.height / 2)
  }
  
  override var preferredFocusEnvironments: [UIFocusEnvironment] {
    return [nextButton]
  }

  @IBAction private func playNext(_ sender: Any) {
    dismissContentProposal(for: .accept, animated: true, completion: nil)
  }
  
  @IBAction private func stop(_ sender: Any) {
    dismissContentProposal(for: .reject, animated: true, completion: nil)
  }

}
