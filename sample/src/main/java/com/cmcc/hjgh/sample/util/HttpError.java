package com.cmcc.hjgh.sample.util;

public enum HttpError {
    SUCCESS("0", "成功"),
    INVALID_PARAM("1", "参数无效"),
    INVALID_PHONE("2", "号码无效"),

    SERVER_INNER_ERROR("9999", "服务内部错误");

    private String message;
    private String code;

    HttpError(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
