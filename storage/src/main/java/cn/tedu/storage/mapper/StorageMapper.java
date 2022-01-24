package cn.tedu.storage.mapper;

import cn.tedu.storage.entity.Storage;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;

@Mapper
public interface StorageMapper extends BaseMapper<Storage> {
    void decrease(Long productId, Integer count);

    void updateFrozen(@Param("productId") String productId, @Param("residue") BigDecimal residue, @Param("frozen") BigDecimal frozen);

    void updateFrozenToUsed(@Param("productId") String productId, @Param("count") BigDecimal count);

    void updateFrozenToResidue(@Param("productId") String productId, @Param("count") BigDecimal count);
}
