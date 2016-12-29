//
//  ViewController.swift
//  ContentProposal
//
//  Created by Jan GORMAN on 29/12/2016.
//  Copyright © 2016 Schnaub. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  private let player = Player()
  private let videos: [Video] = {
    return [
      // streamUrls are bound to a token so are likely to be invalid.
      // See https://developer.dailymotion.com/api or use some other random video stream
      Video(streamUrl: URL(string: "http://www.dailymotion.com/cdn/manifest/video/x4th35g.m3u8?auth=1483196370-2562-uf33swns-6adc17fd7e089d8ebfabb1c1eb2a9346")!,
            title: "Paris Sunset - Timelapse (Public Domain)-HD",
            description: "A timelapse shot of sunset in Paris.\nDownloaded from https://vimeo.com/147309712",
            thumbnail: UIImage(named: "timelapse")!),
      Video(streamUrl: URL(string: "http://www.dailymotion.com/cdn/manifest/video/x4r5udv.m3u8?auth=1483196229-2562-4l325jgk-4032ce00ac0f6206e03399d688847223")!,
            title: "Midnight Sun | Iceland", description: "A lovely looking midnight sun",
            thumbnail: UIImage(named: "midnight_sun")!)
    ]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func launchVideo(_ sender: Any) {
    player.play(fromController: self, videos: videos)
  }

}
