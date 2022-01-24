package cn.tedu.storage.service;

import java.math.BigDecimal;

public interface StorageService {
    void decrease(String productId, BigDecimal count) throws Exception;
}
