package com.zoppy.repository;

import com.zoppy.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    UserEntity findOneByPhone(String phone);
    boolean existsById(Integer id);
}
