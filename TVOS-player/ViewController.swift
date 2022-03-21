//
//  ViewController.swift
//  TVOS-player
//
//  Created by Rory Clear on 16/03/2022.
//

import UIKit
import AVFoundation
import AVKit
import SMP

class ViewController: UIViewController {
    
    var observer: Any?

    @IBAction func playVideo(_ sender: Any) {
        let vpid = "m000crsj"
        play(vpid, streamType: .VOD, avType: .video)
    }
    
    @IBAction func playAudio(_ sender: Any) {
        let vpid = "m00153sq"
        play(vpid, streamType: .VOD, avType: .audio)
    }
    
    @IBAction func playVideoSimulcast(_ sender: Any) {
        let vpid = "bbc_one_hd"
        play(vpid, streamType: .simulcast, avType: .video)
    }
    
    @IBAction func playAudioSimulcast(_ sender: Any) {
        let vpid = "bbc_6music"
        play(vpid, streamType: .simulcast, avType: .video)
    }
    
    func play(_ mediaUrl: String, streamType: BBCSMPStreamType, avType: BBCSMPAVType) {
        let statisticsConsumer = StubBBCSMPAVStatisticsConsumer()
        
        // mediaSet is "mobile-phone-main" but it's tvOS?
        let itemProvider = MediaSelectorItemProviderBuilder(VPID: mediaUrl, mediaSet: "mobile-phone-main", AVType: .video, streamType: streamType, avStatisticsConsumer: statisticsConsumer).buildItemProvider()
        
        let decoderFactory = BBCSMPAVDecoderFactory()
        
        let player = BBCSMPPlayerBuilder()
            .withPlayerItemProvider(itemProvider)
            .withSubtitlesDefaultedOn()
            .withDecoderFactory(decoderFactory)
            .build()
        
        let playerViewController = player.buildUserInterface()
            .withFullscreenConfiguration(self.createUIConfiguration())
            .buildViewController()
        
        let thisController = AVPlayerViewController()
        
        class Observer: NSObject, PlaybackStateObserver {
            
            let thisPlayer: BBCSMP
            let thisController: AVPlayerViewController
            let viewController: ViewController
            
            init(_ player: BBCSMP, _ playerController: AVPlayerViewController, _ viewController: ViewController) {
                thisPlayer = player
                thisController = playerController
                self.viewController = viewController
            }
            
            func state(_ state: PlaybackState) {
                if state is PlaybackStatePlaying {
                    thisPlayer.setup?(forTvOSViewController: thisController)
                }
            }
                
        }
        
        observer = Observer(player, thisController, self)
        
        player.add(stateObserver: observer as! Observer)
    
        
        // MARK: THIS IS IMPORTANT!
//        decoderFactory.withVideoTrackSubscriber(playerViewController)
        
        self.present(thisController, animated: true) {
            player.play()
        }

//        let navigationController: UINavigationController = UINavigationController(rootViewController: playerViewController)
//        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func createUIConfiguration() -> BBCSMPUIConfiguration {
        let config = BBCSMPUIDefaultConfiguration()
        config.volumeSliderHidden = false
        return config
      }
    
    class StubBBCSMPAVStatisticsConsumer: NSObject, BBCSMPAVStatisticsConsumer {
        func trackAVSessionStart(itemMetadata: BBCSMPItemMetadata!, playerSize: CGSize, mediaLength mediaLengthInSeconds: Int) {
            
        }
        
        func trackAVSessionStart(itemMetadata: BBCSMPItemMetadata) {
            
        }
        
        func trackAVFullMediaLength(lengthInSeconds mediaLengthInSeconds: Int) {
            
        }
        
        func trackAVPlayback(currentLocation: Int, customParameters: [AnyHashable: Any]?) {
            
        }
        
        func trackAVPlaying(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, currentLocation: Int, assetDuration: Int) {
            
        }
        
        func trackAVBuffer(playlistTime: Int, assetTime: Int, currentLocation: Int) {
            
        }
        
        func trackAVPause(playlistTime: Int, assetTime: Int, currentLocation: Int) {
            
        }
        
        func trackAVResume(playlistTime: Int, assetTime: Int, currentLocation: Int) {
            
        }
        
        func trackAVScrub(from fromTime: Int, to toTime: Int) {
            
        }
        
        func trackAVEnd(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, assetDuration: Int, wasNatural: Bool, customParameters: [AnyHashable: Any]?) {
            
        }
        
        func trackAVSubtitlesEnabled(_ subtitlesEnabled: Bool) {
            
        }
        
        func trackAVPlayerSizeChange(_ playerSize: CGSize) {
            
        }
        
        func trackAVError(_ errorString: String, playlistTime: Int, assetTime: Int, currentLocation: Int, customParameters: [AnyHashable: Any]?) {
            
        }
    }

}
