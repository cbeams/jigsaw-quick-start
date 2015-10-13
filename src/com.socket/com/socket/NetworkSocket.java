package com.socket;

import com.socket.spi.NetworkSocketProvider;

import java.io.Closeable;
import java.util.Iterator;
import java.util.ServiceLoader;

public interface NetworkSocket extends Closeable {

    static NetworkSocket open() {
        ServiceLoader<NetworkSocketProvider> serviceLoader =
            ServiceLoader.load(NetworkSocketProvider.class);

        Iterator<NetworkSocketProvider> providers = serviceLoader.iterator();
        if (!providers.hasNext())
            throw new RuntimeException("No service providers found!");

        NetworkSocketProvider provider = providers.next();
        return provider.openNetworkSocket();
    }
}
