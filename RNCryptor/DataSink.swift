//
//  DataSink.swift
//  RNCryptor
//
//  Created by Rob Napier on 6/27/15.
//  Copyright © 2015 Rob Napier. All rights reserved.
//

public protocol DataSinkType: class {
    func put(data: UnsafeBufferPointer<UInt8>) throws
}

// FIXME: I don't believe Swift 2b2 can avoid this code duplication
public extension DataSinkType {
    public func put(data: [UInt8]) throws {
        try data.withUnsafeBufferPointer {
            try self.put($0)
        }
    }
    public func put(data: ArraySlice<UInt8>) throws {
        try data.withUnsafeBufferPointer {
            try self.put($0)
        }
    }
}

public final class DataSink: DataSinkType, CustomStringConvertible {
    public var array: [UInt8] = []
    public func put(data: UnsafeBufferPointer<UInt8>) throws {
        self.array.extend(data)
    }
    public init() {}
    public var description: String {
        return "\(self.array)"
    }
}

public final class NullSink: DataSinkType {
    public func put(data: UnsafeBufferPointer<UInt8>) throws {}
}