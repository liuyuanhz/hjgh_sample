package com.cmcc.hjgh.sample.dao.mybatis;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cmcc.hjgh.sample.dto.entity.UserInfo;


public interface SampleMybatis {
	List<String> loadUserList(@Param("groupId") long groupId) throws SQLException;
	
	List<String> loadUsers(@Param("userInfo") UserInfo userInfo) throws SQLException;
}
