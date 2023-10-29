package com.zoppy.entity;
import com.zoppy.utility.Buyer;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "cart")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Integer id;
    Integer buyerId;
    Buyer buyerType;
    Integer item;
}
