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
        let vod =  "https://vod-hls-uk-live.akamaized.net/usp/auth/vod/piff_abr_full_hd/efd8aa-m000crsj/vf_m000crsj_d8ecfb25-9648-4ca8-8b19-664f28c3344a.ism/mobile_wifi_main_sd_abr_v2_hls_master.m3u8?__gda__=1647874667_781c7d692f0878f597bf248d0c5b8462"
        let subtitles =
            "https://vod-sub-uk-live.akamaized.net/iplayer/subtitles/ng/modav/bUnknown-7c4985de-20fb-451d-9069-0c46e28d6f2c_m000crsj_pips-pid-m000crsj_1638872506838.xml?__gda__=1647874667_82bdbfa6364f87a7ae2344410920aad5"
        play(vod, subtitles)
    }
    
    @IBAction func playAudio(_ sender: Any) {
        let aod =  "https://aod-hls-uk-live.akamaized.net/usp/auth/vod/piff_abr_full_audio/77dc2a-m00153sq/vf_m00153sq_643b08fe-e4a8-42ed-8cff-d0d761c3a592.ism/mobile_wifi_main_sd_abr_v2_uk_hls_master.m3u8?__gda__=1647877256_3fea8e68a81fd1b62c0f72cf610aa32e"
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
    
    func play(_ mediaUrl: String, _ subtitlesUrl: String = "", isLive: Bool = false) {
        let statisticsConsumer = StubBBCSMPAVStatisticsConsumer()
        let playerItemProvider = !subtitlesUrl.isEmpty ?
            BBCSMPStaticURLPlayerItemProvider(url: URL(string: mediaUrl)!, subtitleUrl: URL(string: subtitlesUrl)!, avStatisticsConsumer: statisticsConsumer) :
            BBCSMPStaticURLPlayerItemProvider(url: URL(string: mediaUrl)!, avStatisticsConsumer: statisticsConsumer)
        if (isLive) {
            playerItemProvider.streamType = .simulcast
        }
        
        let decoderFactory = BBCSMPAVDecoderFactory()
        
        let player = BBCSMPPlayerBuilder()
            .withPlayerItemProvider(playerItemProvider)
            .withSubtitlesDefaultedOn()
            // MARK: THIS IS IMPORTANT!
            .withDecoderFactory(decoderFactory)
            .build()
        
        let playerViewController = player.buildUserInterface()
            .withFullscreenConfiguration(self.createUIConfiguration())
            .buildViewController()
        
        // MARK: THIS IS IMPORTANT!
        decoderFactory.withVideoTrackSubscriber(playerViewController)

        let navigationController: UINavigationController = UINavigationController(rootViewController: playerViewController)
        self.present(navigationController, animated: true, completion: nil)
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

