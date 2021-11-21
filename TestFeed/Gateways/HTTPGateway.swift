//
//  HTTPGateway.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import Foundation
import Combine

final class HTTPGateway {
    private let baseUrl: URL
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(url: String) {
        guard let baseUrl = URL(string: url) else {
            fatalError("Base URL is not valid.")
        }
        self.baseUrl = baseUrl
        self.session = URLSession.shared
        self.jsonDecoder = .init()
    }
    
    func get<S, T, SourceDTO: ParametersConvertable, TargetDTO: Decodable>(value: S, at path: ExchangePath<S, T>, source: Converter<S, SourceDTO>, target: Converter<TargetDTO, T>) -> AnyPublisher<T, Error> {
        var components = URLComponents(url: baseUrl.appendingPathComponent(path.path), resolvingAgainstBaseURL: false)
        let queryItems: [URLQueryItem] = source.convert(value).parameters.map { parameter in
            URLQueryItem(name: parameter.key, value: parameter.value as? String)
        }
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            fatalError("Target URL is not valid.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return session
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: TargetDTO.self, decoder: jsonDecoder)
            .map { target.convert($0) }
            .eraseToAnyPublisher()
    }
}

// MARK: - ParamatersConvertable protocol

protocol ParametersConvertable: Encodable {
    var parameters: [String: Any] { get }
}

extension ParametersConvertable {
    var parameters: [String: Any] {
        guard
            let encoded = try? JSONEncoder().encode(self),
            let result = try? JSONSerialization.jsonObject(with: encoded, options: []) as? [String: Any]
        else {
            fatalError("Failed to encode")
        }
        return result
    }
}

// MARK: - Converter

struct Converter<Source, Target> {
    let convert: (Source) -> Target
}

extension Converter where Source == Target {
    static var identity: Converter {
        return .init(convert: { $0 })
    }
}

// MARK: - ExchangePath

struct ExchangePath<Source, Target> {
    let path: String
}
