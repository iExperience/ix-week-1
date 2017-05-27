//
//  ViewController.swift
//  Sounds
//
//  Created by Miki von Ketelhodt on 2017/05/25.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a recording filename
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.string(from: currentDateTime) + ".wav"
        
        // Append the unique filename on to the documents directory
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                                    in: FileManager.SearchPathDomainMask.userDomainMask)
        let soundFileURL = paths[0].appendingPathComponent(recordingName)
        
        // Initialize some default settings
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        // Initialize the audio recorder with the filename and settings
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL, settings: recordSettings)
            audioRecorder?.delegate = self
        } catch {
            // Error!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // TODO: Implement what happens when a recording has finished
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        // TODO: Implement what happens when an error has occurred
    }


}

