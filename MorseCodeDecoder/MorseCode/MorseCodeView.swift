//
//  ViewController.swift
//  MorseCodeDecoder
//
//  Created by Bohdan Arkhypchuk on 18.02.2023.
//

import UIKit
import SnapKit
import RxSwift

final class MorseCodeView: UIViewController {
    
    private let viewModel: MorseCodeViewModel?
    
    private let disposeBage = DisposeBag()
    
    private let contentView = UIView()
    private let inputLabel = UILabel()
    
    private let dotButton = Button(
        textColor: .systemCyan,
        buttonColor: .white,
        title: "."
    
    )
    private let dashButton =  Button(
        textColor: .systemCyan,
        buttonColor: .white,
        title: "-"
    )
    
    private let spaceButton =  Button(
        textColor: .systemCyan,
        buttonColor: .white,
        title: "_"
    )
    
    private let resetButton =  Button(
        textColor: .systemCyan,
        buttonColor: .white,
        title: "Reset"
    )
    
    private let alert: UIAlertController = {
        let alert = UIAlertController(
            title: "Oops",
            message: "Your message lost meaning :(",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        return alert
    }()
    
    init(viewModel: MorseCodeViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        setupUI()
        setupInitialState()
        setUpRx()
    }
    
    func setUpRx() {
        self.viewModel?.outSubj
            .subscribe( onNext: { [weak self] in
                guard let self else {return}
                if $0.last == "!" {
                    self.present(self.alert, animated: true, completion: nil)
                    self.inputLabel.text = "Morse code here"
                } else {
                    self.inputLabel.text = $0
                }
            })
            .disposed(by: disposeBage)
    }

    func setupUI() {
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        inputLabel.isUserInteractionEnabled = false
        inputLabel.text = "Morse code here"
        inputLabel.numberOfLines = 10
        inputLabel.textAlignment = .center
        
        contentView.addSubview(inputLabel)
        inputLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(dashButton)
        dashButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerX.equalTo(inputLabel.snp.centerX)
            $0.top.equalTo(inputLabel.snp.bottom).offset(25)
        }
        
        contentView.addSubview(dotButton)
        dotButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.right.equalTo(dashButton.snp.left).offset(-10)
            $0.top.equalTo(inputLabel.snp.bottom).offset(25)
        }
        
        contentView.addSubview(spaceButton)
        spaceButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.left.equalTo(dashButton.snp.right).offset(10)
            $0.top.equalTo(inputLabel.snp.bottom).offset(25)
        }
        
        contentView.addSubview(resetButton)
        resetButton.snp.makeConstraints {
            $0.left.equalTo(dotButton.snp.left)
            $0.right.equalTo(spaceButton.snp.right)
            $0.top.equalTo(dashButton.snp.bottom).offset(10)
        }
    }
    
}

extension MorseCodeView: MorseCodeDelegate {
    
    func setupInitialState() {
        dotButton.addTarget(viewModel, action: #selector(viewModel?.sendCharacter(sender:)), for: .touchUpInside)
        dashButton.addTarget(viewModel, action: #selector(viewModel?.sendCharacter(sender:)), for: .touchUpInside)
        spaceButton.addTarget(viewModel, action: #selector(viewModel?.sendCharacter(sender:)), for: .touchUpInside)
        resetButton.addTarget(viewModel, action: #selector(viewModel?.resetText), for: .touchUpInside)

    }
    
    func changeLableText(text: String) {
        inputLabel.text = text
    }
}

