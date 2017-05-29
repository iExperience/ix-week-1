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
    
    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var hint: UILabel!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var reset: UIButton!

    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize some view control state
        hint.text = "Press the microphone to start recording"
        stop.isHidden = true
        play.isHidden = true
        reset.isHidden = true
        
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
    
    @IBAction func startRecording(_ sender: UIButton) {
        
        // First ensure that the audioRecorder is not recording before we start recording
        if audioRecorder?.isRecording == false {
            
            // Start recording
            audioRecorder?.record()
            
            // Update the view state to inform the user of what is happening
            record.isHidden = true
            hint.text = "Recording... Press stop to end your recording"
            stop.isHidden = false
        }
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        
        // First we ensure that the audioRecorder is currently recording before we ask it to stop
        if audioRecorder?.isRecording == true {
            
            // Lets stop recording...
            audioRecorder?.stop()
            
            // Unlike the startRecording function above, we do not update view state in this method
            // Instead, we wait for the AVAudioRecorder to let our delegate (self, i.e. this ViewController)
            // know whether or not the recording was successful
        }
    }
    
    @IBAction func resetRecoding(_ sender: Any) {
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        // The recording was successful! This function is called by the AVAudioRecorder object
        // The AVAudioRecorder object knows about this function because this class implements 
        // the AVAudioRecorderDelegate and we let the AVAudioRecorder object know about us
        
        // Lets print out some of the details from the recording for info/debug purposes
        print(recorder.url)
        print(recorder.url.lastPathComponent)
        
        // Lets update the view state to let the user know...
        hint.text = "Yay! Recording \(recorder.url.lastPathComponent) was successful. Press play to listen to it or reset to record another sound."
        stop.isHidden = true
        play.isHidden = false
        reset.isHidden = false
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        
        // The recording has failed for some reason... This function is called by the AVAudioRecorder object
        // The AVAudioRecorder object knows about this function because this class implements
        // the AVAudioRecorderDelegate and we let the AVAudioRecorder object know about us
        
        // Below is an example of grabbing the localized error message (TODO: Look up what localized means)
        let errorMessage = error?.localizedDescription ?? "An unknown error has occurred during the recording... please try again."
        hint.text = errorMessage
        stop.isHidden = true
        reset.isHidden = false
    }


}

