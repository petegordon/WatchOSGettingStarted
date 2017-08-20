//
//  ViewController.swift
//  WatchOSGettingStarted
//
//  Created by Pete Gordon on 7/29/17.
//  Copyright © 2017 UsersFirst. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate  {

    @IBOutlet weak var btnStartStop: UIButton!
    @IBOutlet weak var textOutput: UILabel!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        recordAndRecognizeSpeech()
    }
    
    func recordAndRecognizeSpeech(){
        guard let node = audioEngine.inputNode else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){ buffer, _ in self.request.append(buffer)
        }
        audioEngine.prepare()
        do{
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            //A recognizer is not supported for the current locale
            return
        }
        if(!myRecognizer.isAvailable){
            //A recognizer is not available right now.
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: {result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                self.textOutput.text = bestString
                
            }else if let error = error {
                print(error)
            }
        })
    }

}

