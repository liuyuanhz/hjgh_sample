package com.cmcc.hjgh.sample.util;

import org.json.JSONObject;

public class ResponseBuilder {
    public static final String EMPTY_DATA = "{\"results\":0,\"rows\":[]}";

    public static String error(HttpError error) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errCode", error.getCode());
        jsonObject.put("errMsg", error.getMessage());
        return jsonObject.toString();
    }

    public static String success() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errCode", HttpError.SUCCESS.getCode());
        jsonObject.put("errMsg", HttpError.SUCCESS.getMessage());
        return jsonObject.toString();
    }

    public static String success(org.json.JSONObject detailJSONObject) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errCode", HttpError.SUCCESS.getCode());
        jsonObject.put("errMsg", HttpError.SUCCESS.getMessage());
        jsonObject.put("detail", detailJSONObject);
        return jsonObject.toString();
    }
    
    public static String success(String jsonKey, Object jsonValue) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errCode", HttpError.SUCCESS.getCode());
        jsonObject.put("errMsg", HttpError.SUCCESS.getMessage());
        jsonObject.put(jsonKey, jsonValue);
        return jsonObject.toString();
    }
}
