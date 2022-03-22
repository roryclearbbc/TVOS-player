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
import MediaPlayer

class ViewController: UIViewController {
    
    @IBAction func playVideo(_ sender: Any) {
        let vpid = "m000crsj"
        play(vpid, streamType: .VOD, avType: .video)
    }
    
    var player: BBCSMP? = nil
    var stateObserver = StateObserver()
    
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
        
        self.player = player
        player.add(stateObserver: stateObserver)
        
        let playerViewController = player.buildUserInterface()
            .withFullscreenConfiguration(self.createUIConfiguration())
            .buildViewController()
        
        // MARK: THIS IS IMPORTANT!
        decoderFactory.withVideoTrackSubscriber(playerViewController)
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: playerViewController)
        self.present(navigationController, animated: true, completion: { [weak self] in
            self?.registerForRemoteCommands(view: playerViewController.view)
            
        })
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
    
    private func registerForRemoteCommands(view: UIView) {
        // Gesture to handle play pause state
        let playPauseGesture = UITapGestureRecognizer(target: self, action: #selector(togglePlaybackState))
        playPauseGesture.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue), NSNumber(value: UIPress.PressType.select.rawValue)]
        view.addGestureRecognizer(playPauseGesture)
        
        // MPRemoteCommands to handle play pause state
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        remoteCommandCenter.playCommand.addTarget(self, action: #selector(playHandler))
        remoteCommandCenter.pauseCommand.addTarget(self, action: #selector(pauseHandler))
    }
    
    @objc private func togglePlaybackState() -> MPRemoteCommandHandlerStatus {
        print("togglePlaybackState")
        
        guard let state = stateObserver.state else {
            return .commandFailed
        }
        
        if state is PlaybackStatePlaying {
            return pauseHandler()
        } else if state is PlaybackStatePaused {
            return playHandler()
        } else {
            return .commandFailed
        }
    }
    
    @objc private func playHandler() -> MPRemoteCommandHandlerStatus {
        print("play")
        player?.play()
        
        return .success
    }
    
    @objc private func pauseHandler() -> MPRemoteCommandHandlerStatus {
        print("pause")
        player?.pause()
        
        return .success
    }
    
    class StateObserver: NSObject, PlaybackStateObserver {
        private(set) var state: PlaybackState? = nil
        
        func state(_ state: PlaybackState) {
            self.state = state
        }
    }
    
}
