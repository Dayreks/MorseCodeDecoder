//
//  MorseCodeViewModel.swift
//  MorseCodeDecoder
//
//  Created by Bohdan Arkhypchuk on 18.02.2023.
//

import Foundation
import RxSwift

final class MorseCodeViewModel {
    
    private var currentText = ""
    private let model: MorseCodeModel?
    
    private let disposeBage = DisposeBag()
    
    var inSubj = PublishSubject<String>()
    var outSubj = PublishSubject<String>()
    
    init(model: MorseCodeModel) {
        self.model = model
        
        inSubj
            .subscribe(
                onNext: { [weak self] line in
                    guard let self else { return }
                    let stringToOut = self.model?.decodeMorse(line)
                    if stringToOut?.last == "!" { self.currentText = "" }
                    self.outSubj.onNext (stringToOut ?? "")
                }
            )
            .disposed(by: self.disposeBage)
    }
    
    @objc func sendCharacter(sender: Any) {
        guard let character = (sender as! Button).titleLabel?.text else { return }
        self.currentText.append(character)
        self.model?.delegate?.changeLableText(text: self.currentText)
        
        if character == "_" { self.inSubj.onNext(self.currentText) }
    }
    
    @objc func resetText() {
        self.currentText = ""
        self.model?.delegate?.changeLableText(text: "Morse code here")
    }
}
