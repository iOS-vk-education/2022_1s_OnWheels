//
//  MyEventsViewController.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//


import UIKit
import PinLayout

final class MyEventsViewController: UIViewController {
    private let output: MyEventsViewOutput
    
    private let navigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.backgroundColor = .backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainBlueColor as Any]
        return navBar
    }()
    
    private let myEventsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.isUserInteractionEnabled = true
        return table
    }()
    
    private let myEventsHeaderView = MyEventsHeader()
    
    init(output: MyEventsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = R.string.localizable.myEvents()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
        setupMyEventsTableView()
    }
}

extension MyEventsViewController: MyEventsViewInput {
}

extension MyEventsViewController: EventsViewInput {
}

private extension MyEventsViewController {
    func setupLayout(){
        navigationBar.pin
            .top()
            .right()
            .left()
        
        myEventsTableView.pin
            .top(to: navigationBar.edge.bottom)
            .marginTop(Constants.MyEventsTableView.marginTop)
            .left(Constants.MyEventsTableView.left)
            .right(Constants.MyEventsTableView.right)
            .bottom()
    }
    
    func setupUI(){
        view.backgroundColor = .backgroundColor
        view.addSubview(myEventsTableView)
        view.addSubview(navigationBar)
    }
    
    func setupMyEventsTableView() {
        myEventsTableView.separatorStyle = .none
        myEventsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        myEventsTableView.showsVerticalScrollIndicator = false
        myEventsTableView.backgroundColor = .backgroundColor
        myEventsTableView.delegate = self
        myEventsTableView.dataSource = self
        myEventsTableView.register(EventsInfoCell.self)
        myEventsTableView.allowsSelection = true
        myEventsTableView.tableHeaderView = myEventsHeaderView
        myEventsTableView.tableHeaderView?.frame.size = CGSize(width: myEventsTableView.frame.width,
                                                               height: 36)
        setupHeaderAction()
    }
    
    func setupHeaderAction(){
        myEventsHeaderView.setAction { sender in
            print("Selected Segment Index is : \(sender)")
        }
    }
    
    struct Constants {
        struct MyEventsTableView {
            static let marginTop: CGFloat = 32
            static let left: CGFloat = 12
            static let right: CGFloat = 12
        }
    }
}

extension MyEventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(cellType: EventsInfoCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.setupLayout()
        cell.configure(mainText: R.string.localizable.eventName(),
                       dateText: R.string.localizable.eventDate(),
                       placeText: R.string.localizable.eventPlace(),
                       imageName: R.image.durtbike.name,
                       likeText: 18,
                       sharedText: 12,
                       watchedText: 23,
                       isLiked: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 410
    }
}

