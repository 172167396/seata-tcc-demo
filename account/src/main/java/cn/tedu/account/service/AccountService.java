package cn.tedu.account.service;

import java.math.BigDecimal;

public interface AccountService {
    void decrease(String userId, BigDecimal money);
}