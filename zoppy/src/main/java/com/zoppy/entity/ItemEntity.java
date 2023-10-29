package com.zoppy.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "item")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Integer id;
    String name;
    String shortName;
    String category;
    String photoLocation;
}

