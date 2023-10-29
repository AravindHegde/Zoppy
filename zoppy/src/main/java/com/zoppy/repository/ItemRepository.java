package com.zoppy.repository;

import com.zoppy.entity.ItemEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemRepository extends JpaRepository<ItemEntity, Integer> {
    ItemEntity findOneByName(String itemName);
}
