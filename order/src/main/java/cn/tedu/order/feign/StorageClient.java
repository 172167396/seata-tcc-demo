package cn.tedu.order.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;

@FeignClient(name = "storage")
public interface StorageClient {
    @GetMapping("/decrease")
    String decrease(@RequestParam String productId, @RequestParam BigDecimal count);
}