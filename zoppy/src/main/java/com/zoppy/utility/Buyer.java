package com.zoppy.utility;

public enum Buyer {
    USER,
    SHOP;
    public boolean contains(String type) {
        for (Buyer b : Buyer.values()) {
            if (b.name().equals(type)) {
                return true;
            }
        }
        return false;
    }
}
