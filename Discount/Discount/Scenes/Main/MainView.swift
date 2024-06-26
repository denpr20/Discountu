import UIKit
import SnapKit

// MARK: Вид главного экрана

protocol MainSceneDelegate: AnyObject {
    func addButtonTapped()
}

final class MainView: UIView {
    private lazy var cardsTableView: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "backgroundColor")
        table.bounces = false
        table.showsVerticalScrollIndicator = false
        table.estimatedRowHeight = UITableView.automaticDimension
        return table
    }()

    private lazy var addButton: UICustomButton = {
        let button = UICustomButton(Strings.addCard)
        button.addAction(UIAction(handler: { _ in
            self.delegate?.addButtonTapped()
        }), for: .touchUpInside)
        return button
    }()

    weak var delegate: MainSceneDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Работа с положением элементов на MainView

private extension MainView {
    func setupLayout() {
        backgroundColor = UIColor(named: "backgroundColor")

        addSubview(cardsTableView)
        addSubview(addButton)

        cardsTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-100)
        }

        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: Работа с данными

extension MainView {
    func setupDataSource(_ dataSource: UITableViewDataSource) {
        cardsTableView.dataSource = dataSource
    }

    func setupDelegate(_ delegate: UITableViewDelegate) {
        cardsTableView.delegate = delegate
    }

    func reloadData() {
        cardsTableView.reloadData()
    }
}
