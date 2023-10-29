package com.zoppy.repository;

import com.zoppy.entity.UserShopAssociationEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserShopAssociationRepository extends JpaRepository<UserShopAssociationEntity, Integer> {
}
