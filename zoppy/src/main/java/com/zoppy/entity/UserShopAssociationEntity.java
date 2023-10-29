package com.zoppy.entity;
import jakarta.persistence.*;
import lombok.*;
@Entity
@Table(name = "user_shop_association")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserShopAssociationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Integer id;
    String shopId;
    String userId;
    Boolean isAdmin;
}
