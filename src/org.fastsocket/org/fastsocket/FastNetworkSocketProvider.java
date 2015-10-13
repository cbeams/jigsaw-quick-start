package org.fastsocket;

import com.socket.NetworkSocket;
import com.socket.spi.NetworkSocketProvider;

public class FastNetworkSocketProvider implements NetworkSocketProvider {

    @Override
    public NetworkSocket openNetworkSocket() {
        return new FastNetworkSocket();
    }
}
