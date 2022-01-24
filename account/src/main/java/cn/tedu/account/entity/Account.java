package cn.tedu.account.entity;

import lombok.*;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Account {
    private String id;
    private String userId;
    /**
     *总额度
     */
    private BigDecimal total;
    /**
     *已用余额
     */
    private BigDecimal used;
    /**
     *剩余可用余额
     */
    private BigDecimal residue;
    /**
     *tcc冻结金额
     */
    private BigDecimal frozen;
}
