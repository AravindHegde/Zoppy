package com.zoppy.repository;

import com.zoppy.entity.ItemShopAssociationEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemShopAssociationRepository extends JpaRepository<ItemShopAssociationEntity, Integer> {
}
