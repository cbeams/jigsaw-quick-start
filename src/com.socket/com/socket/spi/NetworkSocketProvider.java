package com.socket.spi;

import com.socket.NetworkSocket;

public interface NetworkSocketProvider {

    NetworkSocket openNetworkSocket();
}
