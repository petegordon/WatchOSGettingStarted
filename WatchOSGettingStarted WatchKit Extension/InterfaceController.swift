//
//  InterfaceController.swift
//  WatchOSGettingStarted WatchKit Extension
//
//  Created by Pete Gordon on 7/29/17.
//  Copyright © 2017 UsersFirst. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    
    @IBOutlet var btnAudioRecorder: WKInterfaceButton!
    @IBOutlet var btnAudioPlay: WKInterfaceButton!
    @IBOutlet var displayLabel: WKInterfaceLabel!

    var saveUrl: URL!

    @IBAction func buttonAudioPlay() {
        let options = [WKMediaPlayerControllerOptionsAutoplayKey : "true"]
        
        presentMediaPlayerController(with: saveUrl!, options: options,
                                            completion: { didPlayToEnd, endTime, error in
                                                if let err = error {
                                                    print(err.localizedDescription)
                                                }
        })
    }
    @IBAction func buttonAudioRecorder() {
        displayLabel.setText("Audio Recorder Tapped")
        print("buttonAudioRecorder")
        
   //      self.saveUrl = container?.URLByAppendingPathComponent(fileName)
        
        
        let duration = TimeInterval(120)
        let recordOptions = [WKAudioRecorderControllerOptionsMaximumDurationKey : duration]
        presentAudioRecorderController(withOutputURL: saveUrl!,
                                                    preset: .wideBandSpeech,
                                                    options: recordOptions,
                                                    completion: { saved, error in
                                                        
                                                        if let err = error {
                                                            print(err.localizedDescription)
                                                        }
                                                        print("in the completion")
                                                        print(saved)
                                                        if saved {
                                                            self.btnAudioPlay.setEnabled(true)
                                                            // Write code to execute when audio file gets saved.
                                                            
                                                        }
        })
    }
    @IBAction func buttonDictation() {
        displayLabel.setText("Dictation Tapped!")
        //let phrases = ["I'm in a meeting", "I'll call you later", "Call me later"]
        
        self.presentTextInputController(withSuggestions: nil, allowedInputMode: .plain,
                                                  completion: {(results) -> Void in })
        
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        let fileName = "audioFile.wav"
        
        let fileManager = FileManager.default
        let container = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.petegordon.WatchOSGettingStarted")
        saveUrl = container?.appendingPathComponent(fileName)
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
