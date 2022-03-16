//
//  ViewController.swift
//  TVOS-player
//
//  Created by Rory Clear on 16/03/2022.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    @IBAction func playVideo(_ sender: Any) {
        let vod =  "https://vod-hls-uk.live.cf.md.bbci.co.uk/usp/auth/vod/piff_abr_full_hd/efd8aa-m000crsj/vf_m000crsj_d8ecfb25-9648-4ca8-8b19-664f28c3344a.ism/vf_m000crsj_d8ecfb25-9648-4ca8-8b19-664f28c3344a-audio_eng=48000-video=281000.m3u8"
        
        let videosim = "https://vs-hls-push-uk-live.akamaized.net/x=3/i=urn:bbc:pips:service:bbc_one_hd/mobile_wifi_main_sd_abr_v2.m3u8"
        
        let audiosim = "https://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/high/ak/bbc_6music.m3u8"
        
        let aod =  "https://aod-hls-uk-live.akamaized.net/usp/auth/vod/piff_abr_full_audio/9b54cc-p0bkp2ln/vf_p0bkp2ln_e2bf87d2-bd01-403c-ae58-c504841775ad.ism/mobile_wifi_main_sd_abr_v2_uk_hls_master.m3u8?__gda__=1647467687_05a68a9eab254be31c203c157412f575"
        
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

