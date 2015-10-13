package com.greetings;

import com.socket.NetworkSocket;

public class Main {

    public static void main(String[] args) {
        NetworkSocket socket = NetworkSocket.open();
        Object name = socket.getClass();
        System.out.format("Greetings from %s!\n", name);
    }
}
