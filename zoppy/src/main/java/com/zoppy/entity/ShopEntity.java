package com.zoppy.entity;
import com.zoppy.utility.ShopCategories;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "shop")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ShopEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Integer id;
    String shopName;
    String shortName;
    Double lattitude;
    Double logitude;
    Boolean isWholeSaleShop;
    ShopCategories category;
    Integer parentId;
}
