//
//  MorseCodeModel.swift
//  MorseCodeDecoder
//
//  Created by Bohdan Arkhypchuk on 18.02.2023.
//

import Foundation

protocol MorseCodeDelegate: AnyObject {
    
    func setupInitialState()
    func changeLableText(text: String)
}

final class MorseCodeModel {
    
    weak var delegate: MorseCodeDelegate?
    
    func decodeMorse(_ morseCode: String) -> String {
        let morseToLetter: [String: String] = [
            ".-": "A", "-...": "B", "-.-.": "C", "-..": "D", ".": "E",
            "..-.": "F", "--.": "G", "....": "H", "..": "I", ".---": "J",
            "-.-": "K", ".-..": "L", "--": "M", "-.": "N", "---": "O",
            ".--.": "P", "--.-": "Q", ".-.": "R", "...": "S", "-": "T",
            "..-": "U", "...-": "V", ".--": "W", "-..-": "X", "-.--": "Y",
            "--..": "Z", ".----": "1", "..---": "2", "...--": "3", "....-": "4",
            ".....": "5", "-....": "6", "--...": "7", "---..": "8", "----.": "9",
            "-----": "0", "": " "
        ]
        
        let letters = morseCode
            .split(separator: "_")
            .map { morseToLetter[String($0)] ?? "!" }
            .joined()
        
        return letters
    }
    
}

