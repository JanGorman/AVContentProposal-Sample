//
//  Video.swift
//  ContentProposal
//
//  Created by Jan GORMAN on 29/12/2016.
//  Copyright © 2016 Schnaub. All rights reserved.
//

import UIKit
import AVKit

struct Video {

  let streamUrl: URL
  let title: String
  let description: String
  let thumbnail: UIImage
  
  var metadata: [AVMetadataItem] {
    return [
      newMetadataItem(AVMetadataCommonIdentifierTitle, value: title),
      newMetadataItem(AVMetadataCommonIdentifierDescription, value: description),
      newMetadataItem(AVMetadataCommonIdentifierArtwork, value: thumbnail)
    ]
  }
  
  private func newMetadataItem(_ identifier: String, value: String) -> AVMetadataItem {
    let item = AVMutableMetadataItem()
    item.identifier = identifier
    item.value = value as NSString
    item.extendedLanguageTag = "und"
    return item.copy() as! AVMetadataItem
  }
  
  private func newMetadataItem(_ identifier: String, value: UIImage) -> AVMetadataItem {
    let item = AVMutableMetadataItem()
    item.identifier = identifier
    let data = UIImagePNGRepresentation(value)!
    item.value = data as NSData
    item.extendedLanguageTag = "und"
    return item.copy() as! AVMetadataItem
  }

}
