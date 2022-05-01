//
//  MainViewPresenter.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 30.04.2022.
//

import Foundation

final class MainViewPresenter {

    weak var view: MainViewController?
    var cars = [Car]()
    var filteredCars = [Car]()

    private var firstLoad = true

    required init(_ view: MainViewController) {
        self.view = view
        initialSetup()
    }

    private func initialSetup() {
        fetchCars()
    }

    private func fetchCars() {
        if let url = Bundle.main.url(forResource: "car_list", withExtension: "json") {
             do {
                 let data = try Data(contentsOf: url)
                 let fetchedCars = try JSONDecoder().decode([Car].self, from: data)
                 fetchedCars.forEach {
                     var car = $0
                     car.infoIsHidden = true
                     self.cars.append(car)
                 }
             } catch {
                 print("error:\(error.localizedDescription)")
             }
         }
    }

    private func getCarImage(for carModel: String?) -> String {
        switch carModel {
        case "Range Rover": return "Range_Rover"
        case "Roadster": return "Alpine_roadster"
        case "3300i": return "BMW_330i"
        case "GLE coupe": return "Mercedez_benz_GLC"
        default: return "car_placeholder2"
        }
    }

    private func closeInfoSection() {
        var carToCollapse = cars.first { $0.infoIsHidden == false }
        carToCollapse?.infoIsHidden = true
        let index = cars.firstIndex(where: { $0.infoIsHidden == false })
        if let index = index, let car = carToCollapse {
            cars.remove(at: Int(index))
            cars.insert(car, at: Int(index))
        }
    }
}

// MARK: - MainViewPresenterProtocol
extension MainViewPresenter: MainViewPresenterProtocol {

    func getNumberOfRows() -> Int {
        filteredCars.isEmpty ? cars.count : filteredCars.count
    }

    func getCar(with indexPath: IndexPath) -> Car? {
        var car: Car?
        if !filteredCars.isEmpty {
            car = filteredCars[indexPath.row]
        } else {
            car = cars[indexPath.row]
        }
        guard var car = car else { return nil }
        car.imageName = getCarImage(for: car.model)
        if firstLoad && indexPath.row == 0 {
            car.infoIsHidden = false
            firstLoad = false
        }
        return car
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard var car = getCar(with: indexPath) else { return }
        closeInfoSection()
        car.infoIsHidden?.toggle()
        cars.remove(at: indexPath.row)
        car.infoIsHidden = false
        cars.insert(car, at: indexPath.row)
        view?.reloadTableView()
    }
}

// MARK: - MainViewPresenterProtocol
extension MainViewPresenter: FilterViewDelegate {
    func didFilterBy(_ text: String?) {
        filteredCars.removeAll()
        guard let text = text?.lowercased() else { return }
        filteredCars = cars.filter({ car in
            car.model.lowercased().contains(text) || car.make.lowercased().contains(text)
        })
        firstLoad = true
        view?.reloadTableView()
    }
}
