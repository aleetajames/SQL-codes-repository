/* filename: career_program_mv matric_major_grad_distinct_PSY.sql*/

SELECT distinct zcp.snapshot_type_code
--for example 'MMatric: 20186' as MMatric_Terms
, 'MMatric: ' || (case when SUBSTRING(zcp.mmatric_term_code, 5, 1) IN ('1') then zcp.mmatric_term_code
					when SUBSTRING(zcp.mmatric_term_code, 5, 1) IN ('6'/*, '7','8'*/) then substring (zcp.mmatric_term_code,1,4) || '6'
					end) AS MMatric_Terms
--for example 'MMatricCampus: 201910' as Campus_Mmatric_Terms

		
, zcp.STUDENT_CID
, zcp.STUDENT_PIDM
, (zcp.program_plan_code_inst || '-' || zcp.program_plan_inst) as Major_at_Matric

	
, (select (case when student_cid is NULL then NULL
			else 'Y'
			END) AS Retained_MF2
			From unc.uncw.sdm_career_mv as mca2
			Where mca2.student_cid=zcp.student_cid
			and mca2.snapshot_type_code ='1'
			and mca2.career_code_inst = zcp.career_code_inst
			and mca2.primary_career_flag ='Y'
			and mca2.EXCLUDE_FROM_IPEDS_FLAG = 'N'
			and mca2.snapshot_term_code = (case when SUBSTRING(zcp.mmatric_term_code, 5, 1) IN ('1') then cast(cast(zcp.mmatric_term_code as integer) + 10 AS VARCHAR)
												when SUBSTRING(zcp.mmatric_term_code, 5, 1) IN ('6'/*, '7','8'*/) then cast(cast(substring (zcp.mmatric_term_code,1,4) || '6' as integer) + 10 AS VARCHAR)
												end)
	) AS Ret_mf2
	
FROM uncw.sdm_career_program_mv as zcp
------*****UPDATE TERM*********UPDATE TYPE********UPDATE TERM********UPDATE TYPE********UPDATE TERM***
WHERE zcp.mmatric_term_code >= '20186'
	and zcp.mmatric_term_code like '%6'
	and zcp.Snapshot_Type_Code = '3' -----'1'=Census ---'2'=BOT ---'4'=PostGrades
	AND zcp.PRIMARY_CAREER_FLAG = 'Y'
	AND zcp.EXCLUDE_FROM_IPEDS_FLAG = 'N' ----or <>'N'
	AND zcp.MAJOR_FLAG='Y'

	AND zcp.PRIORITY_NUMBER =
			(select distinct min(xcp.PRIORITY_NUMBER)
			from uncw.sdm_career_program_mv as xcp
			where xcp.SNAPSHOT_TERM_CODE = zcp.SNAPSHOT_TERM_CODE
				and xcp.snapshot_type_code = zcp.snapshot_type_code
				and xcp.STUDENT_PIDM = zcp.STUDENT_PIDM
				and xcp.PRIMARY_CAREER_FLAG = zcp.PRIMARY_CAREER_FLAG
				and xcp.program_plan_code_inst = zcp.program_plan_code_inst
				and xcp.MAJOR_FLAG = 'Y')
	and zcp.program_department_code = 'PSY'
	AND zcp.career_code_inst = 'UG'
	AND zcp.degree_award_flag = 'Y'
	AND zcp.program_plan_code_inst = 'PSY'
	

order by zcp.snapshot_term_code
