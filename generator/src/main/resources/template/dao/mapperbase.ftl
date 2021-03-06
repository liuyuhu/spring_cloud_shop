    <mapper namespace="${packageName}.${moduleName}.dao<#if subModuleName != "">.${subModuleName}</#if>.${ClassName}Dao">

        <resultMap id="BaseResultMap" type="${packageName}.${moduleName}.entity<#if subModuleName != "">.${subModuleName}</#if>.${ClassName}">
    	<#list table.columnList as c>
	<#if c.isPk == "1">
		<id column="${c.name}" property="${c.javaFieldId}" />
    <#else>
		<result column="${c.name}" property="${c.javaFieldId}" />
    </#if>
        </#list>
        </resultMap>

    <#-- 输出字段列 -->
        <sql id="Base_Column_List">
        <#assign columnField>
            <#list table.columnList as c>
                ${c.name},
            </#list>
        </#assign>
        ${columnField?substring(0, columnField?last_index_of(","))}
        </sql>

        <select id="get" resultMap="BaseResultMap">
            SELECT
            <include refid="Base_Column_List"/>
            FROM ${table.name}
	<#list table.columnList as c>
        <#if c.isPk == "1">
		WHERE ${c.name} = ${"#"}{id}
        </#if>
        <#break>
    </#list>
        </select>

        <select id="count" resultType="java.lang.Integer">
            SELECT COUNT(*)
            FROM ${table.name}
            <include refid="WHERE_BASE" />
        </select>

        <sql id="WHERE_BASE">
            <where>
			<#if table.delFlagExists>
			<choose>
                <when test="valid != null">
                    t.valid = ${"#"}{valid}
                </when>
                <otherwise>
                    t.valid = 1
                </otherwise>
            </choose>
            </#if>
			<#list table.columnList as c>
                <#if (c.isQuery?? && c.isQuery == "1") || (table.parentExists && table.parentTableFk == c.name)>
                    <#if c.queryType ?? && c.queryType == 'between'>
			<if test="begin${c.simpleJavaField?cap_first} != null and end${c.simpleJavaField?cap_first} != null <#if c.simpleJavaField != c.javaFieldId>and begin${c.javaFieldId?cap_first} != null and end${c.javaFieldId?cap_first} != null </#if>and begin${c.javaFieldId?cap_first} != '' and end${c.javaFieldId?cap_first} != ''">
                    <#else>
			<if test="${c.simpleJavaField} != null<#if c.simpleJavaField != c.javaFieldId> and ${c.javaFieldId} != null</#if><#if c.javaType == 'String'> and ${c.javaFieldId} != ''</#if>">
                    </#if>
                    <#if c.queryType ?? && c.queryType == 'between'>
				AND t.${c.name} BETWEEN ${"#"}{begin${c.simpleJavaField?cap_first}} AND ${"#"}{end${c.simpleJavaField?cap_first}}
                    <#elseif c.queryType ?? && c.queryType == 'like'>
				AND t.${c.name} LIKE
					concat('%',${"#"}{${c.javaFieldId}},'%')
                    <#elseif c.queryType ?? && c.queryType == 'left_like'>
				AND t.${c.name} LIKE
					concat('%',${"#"}{${c.javaFieldId}})
                    <#elseif c.queryType ?? && c.queryType == 'right_like'>
				AND t.${c.name} LIKE
					concat(${"#"}{${c.javaFieldId}},'%')
                    <#else>
				AND t.${c.name} = ${"#"}{${c.javaFieldId}}
                    </#if>
			</if>
                </#if>
            </#list>
            </where>
        </sql>

        <select id="list" resultMap="BaseResultMap">
            SELECT
            <include refid="Base_Column_List"/>
            FROM ${table.name} t
            <include refid="WHERE_BASE" />
		<#if table.createDateExists>
		ORDER BY t.create_time ASC
        <#elseif table.updateDateExists>
		ORDER BY t.update_time DESC
        </#if>
        </select>

        <select id="listPage" resultMap="BaseResultMap" parameterType="Page">
            SELECT
            <include refid="Base_Column_List"/>
            FROM ${table.name} t
            <where>
			<#if table.delFlagExists>
			<choose>
                <when test="condition != null">
                    <choose>
                        <when test="condition.valid != null">
                            t.valid = #{condition.valid}
                        </when>
                        <otherwise>
                            t.valid = 1
                        </otherwise>
                    </choose>
                </when>
                <otherwise>
                    t.valid = 1
                </otherwise>
            </choose>
            </#if>
                <if test="condition != null">
			<#list table.columnList as c>
                <#if (c.isQuery?? && c.isQuery == "1") || (table.parentExists && table.parentTableFk == c.name)>
                    <#if c.queryType ?? && c.queryType == 'between'>
			<if test="begin${c.simpleJavaField?cap_first} != null and end${c.simpleJavaField?cap_first} != null <#if c.simpleJavaField != c.javaFieldId>and begin${c.javaFieldId?cap_first} != null and end${c.javaFieldId?cap_first} != null </#if>and begin${c.javaFieldId?cap_first} != '' and end${c.javaFieldId?cap_first} != ''">
                    <#else>
			<if test="condition.${c.simpleJavaField} != null<#if c.simpleJavaField != c.javaFieldId> and ${c.javaFieldId} != null</#if><#if c.javaType == 'String'> and condition.${c.javaFieldId} != ''</#if>">
                    </#if>
                    <#if c.queryType ?? && c.queryType == 'between'>
				AND t.${c.name} BETWEEN ${"#"}{begin${c.simpleJavaField?cap_first}} AND ${"#"}{end${c.simpleJavaField?cap_first}}
                    <#elseif c.queryType ?? && c.queryType == 'like'>
				AND t.${c.name} LIKE
					concat('%',${"#"}{condition.${c.javaFieldId}},'%')
                    <#elseif c.queryType ?? && c.queryType == 'left_like'>
				AND t.${c.name} LIKE
					concat('%',${"#"}{condition.${c.javaFieldId}})
                    <#elseif c.queryType ?? && c.queryType == 'right_like'>
				AND t.${c.name} LIKE
					concat(${"#"}{condition.${c.javaFieldId}},'%')
                    <#else>
				AND t.${c.name} ${c.queryType} ${"#"}{condition.${c.javaFieldId}}
                    </#if>
			</if>
                </#if>
            </#list>
                </if>
            </where>
            <choose>
                <when test="orderBy != null and orderBy != ''">
                    ORDER BY ${"$"}{orderBy}
                </when>
                <otherwise>
				<#if table.createDateExists>
                    ORDER BY t.create_time ASC
                <#elseif table.updateDateExists>
				ORDER BY t.update_time DESC
                </#if>
                </otherwise>
            </choose>
        </select>

        <insert id="save" useGeneratedKeys="true" keyProperty="<#list table.columnList as c><#if c.isPk == "1">${c.name}</#if></#list>">
            INSERT INTO ${table.name}
            <trim prefix="(" suffix=")" suffixOverrides=",">
			<#list table.columnList as c>
				<#if c.isInsert?? && c.isInsert == "1">
			<if test="${c.simpleJavaField} != null<#if c.simpleJavaField != c.javaFieldId> and ${c.javaFieldId} != null</#if><#if c.javaType == 'String'> and ${c.javaFieldId} != ''</#if>">
                ${c.name},
            </if>
                </#if>
            </#list>
            </trim>
            VALUES
            <trim prefix="(" suffix=")" suffixOverrides=",">
			<#list table.columnList as c>
				<#if c.isInsert?? && c.isInsert == "1">
			<if test="${c.simpleJavaField} != null<#if c.simpleJavaField != c.javaFieldId> and ${c.javaFieldId} != null</#if><#if c.javaType == 'String'> and ${c.javaFieldId} != ''</#if>">
                ${"#"}{${c.javaFieldId}},
            </if>
                </#if>
            </#list>
            </trim>
        </insert>

        <update id="update">
            UPDATE ${table.name}
            <set>
				<#list table.columnList as c>
					<#if c.isEdit?? && c.isEdit == "1">
			<if test="${c.javaFieldId} != null<#if c.javaType == 'String'> and ${c.javaFieldId} != ''</#if>">
                ${c.name} = ${"#"}{${c.javaFieldId}},
            </if>
                    </#if>
                </#list>
            </set>
		<#list table.columnList as c>
            <#if c.isPk == "1">
		WHERE ${c.name} = ${"#"}{${c.javaFieldId}}
            </#if>
            <#break>
        </#list>
        </update>

        <update id="updateAll">
            UPDATE ${table.name}
            <set>
			<#list table.columnList as c>
				<#if c.isEdit?? && c.isEdit == "1">
                    ${c.name} = ${"#"}{${c.javaFieldId}},
                </#if>
            </#list>
            </set>
		<#list table.columnList as c>
            <#if c.isPk == "1">
		WHERE ${c.name} = ${"#"}{${c.javaFieldId}}
            </#if>
            <#break>
        </#list>
        </update>

        <delete id="delete" parameterType="java.lang.Boolean">
	<#if table.delFlagExists>
        <choose>
            <when test="logic">
                UPDATE ${table.name}
                SET valid = 0
		<#list table.columnList as c>
            <#if c.isPk == "1">
			WHERE ${c.name} = ${"#"}{id}
            </#if>
            <#break>
        </#list>
            </when>
            <otherwise>
                DELETE FROM ${table.name}
		<#list table.columnList as c>
            <#if c.isPk == "1">
			WHERE ${c.name} = ${"#"}{id}
            </#if>
            <#break>
        </#list>
            </otherwise>
        </choose>
    <#else>
	DELETE FROM ${table.name}
        <#list table.columnList as c>
            <#if c.isPk == "1">
			WHERE ${c.name} = ${"#"}{id}
            </#if>
            <#break>
        </#list>
    </#if>
        </delete>

    </mapper>
