//
//  ArrayBuilder.swift
//  SampleResultBuilder
//
//  Created by Hardik Modha on 11/04/24.
//

import Foundation

@resultBuilder
enum ArrayBuilder<Element> {
    typealias Component = [Element]
    typealias Expression = Element
    static func buildBlock(_ components: Component...) -> Component {
        var result = Component()
        for component in components {
            result.append(contentsOf: component)
        }
        return result
    }
    
    static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }
    
    static func buildEither(first component: ArrayBuilder<Element>.Component) -> ArrayBuilder<Element>.Component {
        component
    }
    
    static func buildEither(second component: ArrayBuilder<Element>.Component) -> ArrayBuilder<Element>.Component {
        component
    }
    
    static func buildArray(_ components: [ArrayBuilder<Element>.Component]) -> ArrayBuilder<Element>.Component {
        components.flatMap { $0 }
    }
    
    static func buildOptional(_ component: ArrayBuilder<Element>.Component?) -> ArrayBuilder<Element>.Component {
        if let component {
            return component
        } else {
            return []
        }
    }
    
    static func buildExpression(_ expression: Expression?) -> ArrayBuilder<Element>.Component {
        if let expression {
            return [expression]
        } else {
            return []
        }
    }
    
    static func buildLimitedAvailability(_ component: ArrayBuilder<Element>.Component) -> ArrayBuilder<Element>.Component {
        component
    }
    
    static func buildPartialBlock(first: ArrayBuilder<Element>.Component) -> ArrayBuilder<Element>.Component {
        first
    }
    
    static func buildPartialBlock(accumulated: ArrayBuilder<Element>.Component, next: ArrayBuilder<Element>.Component) -> ArrayBuilder<Element>.Component {
        var result = accumulated
        for item in next {
            result.append(item)
        }
        return result
    }
}

extension Array {
    init(@ArrayBuilder<Element> builder: () -> [Element]) {
        self = builder()
    }
}

// MARK: - Custom Logic our
extension ArrayBuilder where Element == Book {
    static func buildExpression(_ title: String) -> ArrayBuilder<Element>.Component {
        .init([.init(title: title)])
    }
    
    static func buildExpression(_ expression: (String, repeating: Int)) -> ArrayBuilder<Element>.Component {
        .init(repeating: .init(title: expression.0), count: expression.1)
    }
    
    static func buildExpression(_ expression: ForEach) -> ArrayBuilder<Element>.Component {
        let books = expression.books
        return books
    }
}
