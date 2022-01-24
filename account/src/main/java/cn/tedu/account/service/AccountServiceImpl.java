package cn.tedu.account.service;

import cn.tedu.account.tcc.AccountTccAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
@Service
public class AccountServiceImpl implements AccountService {


    @Resource
    private AccountTccAction accountTccAction;

    @Override
    public void decrease(String userId, BigDecimal money) {
        accountTccAction.prepareDecreaseAccount(null, userId, money);
    }
}