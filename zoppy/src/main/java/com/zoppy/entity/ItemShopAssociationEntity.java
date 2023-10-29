package com.zoppy.entity;
import jakarta.persistence.*;
import lombok.*;
@Entity
@Table(name = "item_shop_association")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemShopAssociationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Integer id;
    Integer itemId;
    Integer shopId;
    Float retailPrice;
    Float boughtPrice;
    Float sellingPrice;
    Integer quantity;
}
