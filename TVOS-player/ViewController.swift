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

    @IBAction func playVideo(_ sender: Any) {
        let vod =  "https://vod-hls-uk.live.cf.md.bbci.co.uk/usp/auth/vod/piff_abr_full_hd/efd8aa-m000crsj/vf_m000crsj_d8ecfb25-9648-4ca8-8b19-664f28c3344a.ism/vf_m000crsj_d8ecfb25-9648-4ca8-8b19-664f28c3344a-audio_eng=48000-video=281000.m3u8"
        play(vod)
    }
    
    @IBAction func playAudio(_ sender: Any) {
        let aod =  "https://aod-hls-uk-live.akamaized.net/usp/auth/vod/piff_abr_full_audio/e7881a-m0013jmz/vf_m0013jmz_b165ea45-5c43-4a45-820b-deaf10d5abff.ism/mobile_wifi_main_sd_abr_v2_uk_hls_master.m3u8?__gda__=1647548921_06e57756b5cec30015a8e0bd2321987d"
        play(aod)
    }
    
    @IBAction func playVideoSimulcast(_ sender: Any) {
        let videoSimulcast = "https://vs-hls-push-uk-live.akamaized.net/x=3/i=urn:bbc:pips:service:bbc_one_hd/mobile_wifi_main_sd_abr_v2.m3u8"
        play(videoSimulcast, isLive: true)
    }
    
    @IBAction func playAudioSimulcast(_ sender: Any) {
        let audioSimulcast = "https://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/high/aks/bbc_6music.m3u8"
        play(audioSimulcast, isLive: true)
    }
    
    func play(_ mediaUrl: String, isLive: Bool = false) {
        let statisticsConsumer = StubBBCSMPAVStatisticsConsumer()
        let playerItemProvider = BBCSMPStaticURLPlayerItemProvider(url: URL(string: mediaUrl)!, avStatisticsConsumer: statisticsConsumer)
        if (isLive) {
            playerItemProvider.streamType = .simulcast
        }
        
        let player = BBCSMPPlayerBuilder().withPlayerItemProvider(playerItemProvider).build()
        let playerViewController = player.buildUserInterface().buildViewController()

        let navigationController: UINavigationController = UINavigationController(rootViewController: playerViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

