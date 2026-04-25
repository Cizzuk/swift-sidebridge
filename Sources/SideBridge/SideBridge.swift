import Foundation

public struct SBMessage: Codable, Equatable, Hashable, Identifiable, Sendable {
    public enum From: String, Codable, Equatable, Sendable {
        case user, assistant, system, unknown
    }
    
    public struct Source: Codable, Equatable, Hashable, Sendable {
        public init(
            title: String = "",
            url: URL
        ) {
            if title.isEmpty {
                self.title = url.absoluteString
            } else {
                self.title = title
            }
            self.url = url
        }
        
        public var title: String
        public var url: URL
    }
    
    public init(
        id: UUID = UUID(),
        from: From,
        content: String,
        sources: [Source] = []
    ) {
        self.id = id
        self.from = from
        self.content = content
        self.sources = sources
    }
    
    public var id: UUID
    public var from: From
    public var content: String
    public var sources: [Source] = []
}

public struct SBOptions: Codable, Equatable, Hashable, Sendable {
    public init() { }
    
    public var disableSendHistory: Bool? = nil
    public var endSession: Bool? = nil
}

public struct SBRequest: Codable, Equatable, Hashable, Sendable {
    public enum RequestType: String, Codable, Equatable, Sendable {
        case newChat, resumeChat, sendMessage, unknown
    }
    
    public init(
        chatId: UUID = UUID(),
        type: RequestType,
        messages: [SBMessage]? = nil,
        history: [SBMessage]? = nil
    ) {
        self.chatId = chatId
        self.type = type
        self.messages = messages
        self.history = history
    }
    
    public var sidebridge = "1.0"
    public var chatId: UUID
    public var type: RequestType
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
