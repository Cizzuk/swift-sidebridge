import Foundation

public struct SBMessage: Codable, Equatable, Hashable, Identifiable, Sendable {
    public enum From: String, Codable, Equatable, Sendable {
        case user, assistant, system, unknown

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = (try? container.decode(String.self)) ?? ""
            self = From(rawValue: rawValue) ?? .unknown
        }
    }
    
    public struct Source: Codable, Equatable, Hashable, Sendable {
        public init(
            title: String,
            url: URL
        ) {
            self.title = title
            self.url = url
        }
        
        public var title: String
        public var url: URL
    }
    
    public init(
        id: UUID,
        from: From,
        content: String,
        sources: [Source]? = nil
    ) {
        self.id = id
        self.from = from
        self.content = content
        self.sources = sources
    }
    
    public var id: UUID
    public var from: From
    public var content: String
    public var sources: [Source]?
}

public struct SBOptions: Codable, Equatable, Hashable, Sendable {
    public init() { }
    
    public var disableSendHistory: Bool? = nil
    public var endSession: Bool? = nil
    
    public mutating func merge(with other: SBOptions) {
        if let disableSendHistory = other.disableSendHistory {
            self.disableSendHistory = disableSendHistory
        }
        if let endSession = other.endSession {
            self.endSession = endSession
        }
    }
}

public struct SBRequest: Codable, Equatable, Hashable, Sendable {
    public init(
        sidebridge: String = "1.0",
        chatId: UUID,
        messages: [SBMessage]? = nil,
        history: [SBMessage]? = nil
    ) {
        self.sidebridge = sidebridge
        self.chatId = chatId
        self.messages = messages
        self.history = history
    }
    
    public var sidebridge: String
    public var chatId: UUID
    public var messages: [SBMessage]?
    public var history: [SBMessage]?
}

public struct SBResponse: Codable, Equatable, Hashable, Sendable {
    public init(
        messages: [SBMessage]? = nil,
        options: SBOptions? = nil
    ) {
        self.messages = messages
        self.options = options
    }
    
    public var messages: [SBMessage]?
    public var options: SBOptions?
}
