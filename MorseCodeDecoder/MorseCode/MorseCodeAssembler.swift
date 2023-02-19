//
//  MorseCodeAssembler.swift
//  MorseCodeDecoder
//
//  Created by Bohdan Arkhypchuk on 19.02.2023.
//

import UIKit

enum MorseCodeAssembler {

    static func makeModule() -> UIViewController {
        let model = MorseCodeModel()
        let viewModel = MorseCodeViewModel(model: model)
        let controller = MorseCodeView(viewModel: viewModel)
        model.delegate = controller
    
        return controller
    }
}
