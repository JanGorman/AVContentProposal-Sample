# AVContentProposal-Sample

During WWDC 2016 Apple presented their own way of proposing next content to your tvOS users in [session 506](https://developer.apple.com/videos/play/wwdc2016/506/).

Specifically they mention `AVContentProposalDelegate` which is conspicuously absent in the final version of the SDK. Since they focus on the delegate methods during the presentation it's not immediately clear how to implement content proposal. This sample project shows how it's done.

---

First of all, implement a subclass of `AVContentProposalViewController` in your project. You can use storyboards and autolayout. The minimum features should include a preview image view, next and cancel buttons, and a title. Your subclass will have access to a `contentProposal: AVContentProposal` property that you can pick data from and set in the `viewDidLoad()` method. To pass the user's decision about whether to accept or reject a proposal, call `dismissContentProposal(for:animated:completion:)` from your controller. Pass either `AVContentProposalAction.accept` or `.reject`.

---

The second part involves implementing the `AVPlayerViewControllerDelegate` in the class that deals with presenting the video. If you have some content to propose:

```swift
func playerViewController(_ playerViewController: AVPlayerViewController,
                            shouldPresent proposal: AVContentProposal) -> Bool {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ContentProposalViewController") as! ContentProposalViewController
    playerViewController.contentProposalViewController = vc
    return true
}
```
---

  Return `true` if you have a proposal and `false` if not. Easy. Then to deal with accepting or rejecting the proposal, implement `func playerViewController(_ playerViewController: AVPlayerViewController, didAccept proposal: AVContentProposal)` and `func playerViewController(_ playerViewController: AVPlayerViewController, didReject proposal: AVContentProposal)`. When the user accepted the proposal, replace the currently playing item on `AVPlayer` with a new one and in case the user rejected the propsal dismiss the player.

---

  And finally to actually set your proposal, construct a `AVContentProposal` instance and set that on your currently playing item:

  ```swift
// kCMTimeIndefinite tells the proposal to be shown right at the end of the current video
let proposal = AVContentProposal(contentTimeForTransition: kCMTimeIndefinite, title: "Title",
                                    previewImage: UIImage(named: ""))
proposal.url = "Your video URL"
proposal.automaticAcceptanceInterval = 3 // Optional. Accept the proposal after n seconds
proposal.metadata = video.metadata
playerViewController.player?.currentItem?.nextContentProposal = proposal
  ```

---

That's pretty much it. Check out the sample project for details. I hope you find it useful. If you have any feedback or questions ping me on [Twitter](https://twitter.com/JanGorman).