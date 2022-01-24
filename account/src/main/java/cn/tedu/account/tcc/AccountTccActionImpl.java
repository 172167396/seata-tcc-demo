package cn.tedu.account.tcc;

import cn.tedu.account.entity.Account;
import cn.tedu.account.mapper.AccountMapper;
import io.seata.rm.tcc.api.BusinessActionContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;

@Component
@Slf4j
public class AccountTccActionImpl implements AccountTccAction {
    @Resource
    private AccountMapper accountMapper;

    @Transactional
    @Override
    public boolean prepareDecreaseAccount(BusinessActionContext businessActionContext, String userId, BigDecimal money) {
        log.info("减少账户金额，第一阶段锁定金额，userId=" + userId + "， money=" + money);

        Account account = accountMapper.selectById(userId);
        if (account.getResidue().compareTo(money) < 0) {
            throw new RuntimeException("账户金额不足");
        }

        accountMapper.updateFrozen(userId, account.getResidue().subtract(money), account.getFrozen().add(money));

        //保存标识
        ResultHolder.setResult(getClass(), businessActionContext.getXid(), "p");
        return true;
    }

    @Transactional
    @Override
    public boolean commit(BusinessActionContext businessActionContext) {

        String userId = businessActionContext.getActionContext("userId").toString();
        BigDecimal money = new BigDecimal(businessActionContext.getActionContext("money").toString());
        log.info("减少账户金额，第二阶段，提交，userId=" + userId + "， money=" + money);

        //防止重复提交
        if (ResultHolder.getResult(getClass(), businessActionContext.getXid()) == null) {
            return true;
        }

        accountMapper.updateFrozenToUsed(userId, money);

        //模拟异常
//        throw new RuntimeException("account service confirm throws runtimeException");
        //删除标识
        ResultHolder.removeResult(getClass(), businessActionContext.getXid());
        return true;
    }

    @Transactional
    @Override
    public boolean rollback(BusinessActionContext businessActionContext) {
        String userId = businessActionContext.getActionContext("userId").toString();
        BigDecimal money = new BigDecimal(businessActionContext.getActionContext("money").toString());

        //防止重复提交
        if (ResultHolder.getResult(getClass(), businessActionContext.getXid()) == null) {
            return true;
        }

        log.info("减少账户金额，第二阶段，回滚，userId=" + userId + "， money=" + money);

        accountMapper.updateFrozenToResidue(userId, money);

        //删除标识
        ResultHolder.removeResult(getClass(), businessActionContext.getXid());
        return true;
    }
}
