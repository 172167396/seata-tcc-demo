package cn.tedu.storage.service;

import cn.tedu.storage.tcc.StorageTccAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
public class StorageServiceImpl implements StorageService {
    // @Autowired
    // private StorageMapper storageMapper;

    @Autowired
    private StorageTccAction storageTccAction;

    @Override
    public void decrease(String productId, BigDecimal count) throws Exception {
        // storageMapper.decrease(productId,count);
        storageTccAction.prepareDecreaseStorage(null, productId, count);
    }

}
