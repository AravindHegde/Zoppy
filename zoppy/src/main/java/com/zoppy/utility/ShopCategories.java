package com.zoppy.utility;

public enum ShopCategories {
    PARENT,
    SUBSIDIARY,
    INDIVIDUAL;
    public boolean contains(String type) {
        for (ShopCategories st : ShopCategories.values()) {
            if (st.name().equals(type)) {
                return true;
            }
        }
        return false;
    }
}
