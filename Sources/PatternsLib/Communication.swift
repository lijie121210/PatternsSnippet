//
//  Communication.swift
//  Patterns
//
//  Created by viwii on 2017/5/8.
//
// Bridge


public class Communicator {
    let clearChannel: ClearMessageChannel
    let secureChannel: SecureMessageChannel
    
    // new
    let priorityChannel: PriorityMessageChannel
    
    init(clearChannel: ClearMessageChannel, secureChannel: SecureMessageChannel, priorityChannel: PriorityMessageChannel) {
        self.clearChannel = clearChannel
        self.secureChannel = secureChannel
        self.priorityChannel = priorityChannel
    }
    
    func send(clear message: String) {
        clearChannel.send(clear: message)
    }
    
    func send(encrypted message: String) {
        secureChannel.send(encrypted: message)
    }
    
    // new
    func send(priority message: String) {
        priorityChannel.send(priority: message)
    }
}



// Two sending channels: clear and secure
public protocol ClearMessageChannel {
    func send(clear message: String)
}

public protocol SecureMessageChannel {
    func send(encrypted message: String)
}


// Two networks: landline and wireless
public class Landline: ClearMessageChannel {
    public func send(clear message: String) {
        print(#function, message)
    }
}

public class SecureLandLine: SecureMessageChannel {
    public func send(encrypted message: String) {
        print(#function, message)
    }
}

public class Wireless: ClearMessageChannel {
    public func send(clear message: String) {
        print(#function, message)
    }
}

public class SecureWireless: SecureMessageChannel {
    public func send(encrypted message: String) {
        print(#function, message)
    }
}



// Message
public protocol Message {
    var contentToSend: String { get }
    init(text: String)
    func prepare()
}

public class ClearMessage: Message {
    private var message: String
    
    public var contentToSend: String {
        return message
    }
    
    public required init(text: String) {
        self.message = text
    }
    
    public func prepare() {
        print(#function)
    }
}

public class SecureMessage: Message {
    private var clearText: String
    private var cipherText: String?
    
    public var contentToSend: String {
        return cipherText ?? ""
    }
    
    public required init(text: String) {
        self.clearText = text
    }
    
    public func prepare() {
        cipherText = String(clearText.characters.reversed())
    }
}


// New Channel
// Ignore messages' type

public protocol Channel {
    func send(_ message: Message)
}

public class LandLineChannel: Channel {
    public func send(_ message: Message) {
        print(#function, message.contentToSend)
    }
}

public class WirelessChannel: Channel {
    public func send(_ message: Message) {
        print(#function, message.contentToSend)
    }
}


// Bridge

public class CommunicatorBridge: ClearMessageChannel, SecureMessageChannel {
    private var channel: Channel
    
    public init(channel: Channel) {
        self.channel = channel
    }
    
    public func send(clear message: String) {
        let msg = ClearMessage(text: message)
        send(msg)
    }
    
    public func send(encrypted message: String) {
        let msg = SecureMessage(text: message)
        send(msg)
    }
    
    fileprivate func send(_ message: Message) {
        message.prepare()
        channel.send(message)
    }
}



// New

// new sending channel
public protocol PriorityMessageChannel {
    func send(priority message: String)
}

// edit Communicator

// new channel
public class SatelliteChannel: Channel {
    public func send(_ message: Message) {
        print(#function, message.contentToSend)
    }
}

// add new message type
public class PriorityMessage: ClearMessage {
    public override var contentToSend: String {
        return "Important: \(super.contentToSend)"
    }
}

extension CommunicatorBridge: PriorityMessageChannel {
    public func send(priority message: String) {
        let msg = PriorityMessage(text: message)
        send(msg)
    }
}




public func __use_communicator_1() {
    // use SatelliteChannel
    let bridge = CommunicatorBridge(channel: SatelliteChannel())
    let communicator = Communicator(clearChannel: bridge, secureChannel: bridge, priorityChannel: bridge)
    communicator.send(clear: "Hi")
    communicator.send(encrypted: "viwii")
    communicator.send(priority: "323523")
}
