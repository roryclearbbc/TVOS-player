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
        
        let videosim = "https://vs-hls-push-uk-live.akamaized.net/x=3/i=urn:bbc:pips:service:bbc_one_hd/mobile_wifi_main_sd_abr_v2.m3u8"
        
        let audiosim = "https://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/high/ak/bbc_6music.m3u8"
        
        let aod =  "https://aod-hls-uk-live.akamaized.net/usp/auth/vod/piff_abr_full_audio/9b54cc-p0bkp2ln/vf_p0bkp2ln_e2bf87d2-bd01-403c-ae58-c504841775ad.ism/mobile_wifi_main_sd_abr_v2_uk_hls_master.m3u8?__gda__=1647467687_05a68a9eab254be31c203c157412f575"
        
       // let playerItemProvider = MediaSelectorItemProviderBuilder(VPID: "m000ryh8", mediaSet: "mobile-phone-main", AVType: .video, streamType: .VOD, avStatisticsConsumer: MyAvStatisticsConsumer())
        let statisticsConsumer = StatisticsComsumer()
        let playerItemProvider = BBCSMPStaticURLPlayerItemProvider(url: URL(string: vod)!, avStatisticsConsumer: statisticsConsumer)
        
        let player = BBCSMPPlayerBuilder().withPlayerItemProvider(playerItemProvider).build()
        let playerViewController = player.buildUserInterface().buildViewController()

        let navigationController: UINavigationController = UINavigationController(rootViewController: playerViewController)
        self.present(navigationController, animated: true, completion: nil)
        /*
        
        guard let url = URL(string: videosim) else { return }

        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)

        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player

        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
         */
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    class StatisticsComsumer: BBCSMPAVStatisticsConsumer {
        
        init() {
            description = ""
            hash = 420
        }
        
        func trackAVSessionStart(itemMetadata: BBCSMPItemMetadata) {
            
        }
        
        func trackAVFullMediaLength(lengthInSeconds mediaLengthInSeconds: Int) {
            
        }
        
        func trackAVPlayback(currentLocation: Int, customParameters: [AnyHashable : Any]?) {
            
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
        
        func trackAVEnd(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, assetDuration: Int, wasNatural: Bool, customParameters: [AnyHashable : Any]?) {
            
        }
        
        func trackAVSubtitlesEnabled(_ subtitlesEnabled: Bool) {
            
        }
        
        func trackAVPlayerSizeChange(_ playerSize: CGSize) {
            
        }
        
        func trackAVError(_ errorString: String, playlistTime: Int, assetTime: Int, currentLocation: Int, customParameters: [AnyHashable : Any]?) {
            
        }
        
        func isEqual(_ object: Any?) -> Bool {
            return true
        }
        
        var hash: Int
        
        var superclass: AnyClass?
        
        func `self`() -> Self {
            return self
        }
        
        func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
            return nil
        }
        
        func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
            return nil
        }
        
        func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
            return nil
        }
        
        func isProxy() -> Bool {
            return true
        }
        
        func isKind(of aClass: AnyClass) -> Bool {
            return true
        }
        
        func isMember(of aClass: AnyClass) -> Bool {
            return true
        }
        
        func conforms(to aProtocol: Protocol) -> Bool {
            return true
        }
        
        func responds(to aSelector: Selector!) -> Bool {
            return true
        }
        
        var description: String
        
        
    }


}

