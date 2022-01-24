package cn.tedu.account.mapper;

import cn.tedu.account.entity.Account;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;

@Mapper
public interface AccountMapper extends BaseMapper<Account> {
    void decrease(Long userId, BigDecimal money);

    void updateFrozen(@Param("userId") String userId, @Param("residue") BigDecimal residue, @Param("frozen") BigDecimal frozen);

    void updateFrozenToUsed(@Param("userId") String userId, @Param("money") BigDecimal money);

    void updateFrozenToResidue(@Param("userId") String userId, @Param("money") BigDecimal money);
}