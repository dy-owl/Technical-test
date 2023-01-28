//
//  DataManager.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation
import Combine

final class DataManager {

    private let path = "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"

    func fetchQuotes() -> AnyPublisher<[Quote], Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: path)!)
            .tryMap { data, response in
                guard 200...299 ~= response.code else { throw NetworkError.badServerResponse }
                return try JSONDecoder().decode([Quote].self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
