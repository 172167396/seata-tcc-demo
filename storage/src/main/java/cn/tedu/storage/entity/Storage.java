package cn.tedu.storage.entity;

import lombok.*;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Storage {
    private String id;
    private String productId;
    private BigDecimal total;
    private BigDecimal used;
    private BigDecimal residue;
    private BigDecimal frozen;
}
