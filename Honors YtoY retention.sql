with
cte_tbl as
(


select $Enter_Cohort_SDM_Fall_Term_Code1 as Cohort
,ca.student_cid
,ca.STUDENT_TYPE_CODE_INST							
,ca.STUDENT_TYPE_INST
,ca.enrollment_status_ipeds
,ca.CLASS_LEVEL							
,ca.CLASS_LEVEL_INST --- new field as of 6/6/2017	
, ca.honors_flag
,(case when ca.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
       else 'N' end) as Inst_Honors_Ind														
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code1 as float) + 10 ) as varchar) as second_fall
, co.class_level_inst as second_fall_class_level_inst
, (CASE WHEN co.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_second_fall

, (case when co.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_second_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code1 as float) + 20 ) as varchar) as third_fall
, co3.class_level_inst as third_fall_class_level_inst
, (CASE WHEN co3.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_third_fall


, (case when co3.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co3.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_third_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code1 as float) + 30 ) as varchar) as fourth_fall
, co4.class_level_inst as fourth_fall_class_level_inst
, (CASE WHEN co4.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fourth_fall
,(case when co4.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co4.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fourth_fall



FROM uncw.sdm_career_mv ca
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and ca.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and ca.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and ca.career_code =co4.career_code

WHERE 
 ca.snapshot_type_code = '1'
 and ca.snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code1
and ca.exclude_from_ipeds_flag = 'N'
and ca.primary_career_flag = 'Y'
and ca.career_code = 'U'
and ca.enrollment_status_code_ipeds in ('1')

union all 


select $Enter_Cohort_SDM_Fall_Term_Code2 as Cohort
,ca.student_cid
,ca.STUDENT_TYPE_CODE_INST							
,ca.STUDENT_TYPE_INST
,ca.enrollment_status_ipeds
,ca.CLASS_LEVEL							
,ca.CLASS_LEVEL_INST --- new field as of 6/6/2017	
, ca.honors_flag
,(case when ca.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
       else 'N' end) as Inst_Honors_Ind														
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code2 as float) + 10 ) as varchar) as second_fall
, co.class_level_inst as second_fall_class_level_inst
, (CASE WHEN co.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_second_fall

, (case when co.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_second_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code2 as float) + 20 ) as varchar) as third_fall
, co3.class_level_inst as third_fall_class_level_inst
, (CASE WHEN co3.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_third_fall


, (case when co3.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co3.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_third_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code2 as float) + 30 ) as varchar) as fourth_fall
, co4.class_level_inst as fourth_fall_class_level_inst
, (CASE WHEN co4.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fourth_fall
,(case when co4.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co4.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fourth_fall



FROM uncw.sdm_career_mv ca
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and ca.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and ca.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and ca.career_code =co4.career_code

WHERE 
 ca.snapshot_type_code = '1'
 and ca.snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code2
and ca.exclude_from_ipeds_flag = 'N'
and ca.primary_career_flag = 'Y'
and ca.career_code = 'U'
and ca.enrollment_status_code_ipeds in ('1')


union all 

select $Enter_Cohort_SDM_Fall_Term_Code3 as Cohort
,ca.student_cid
,ca.STUDENT_TYPE_CODE_INST							
,ca.STUDENT_TYPE_INST
,ca.enrollment_status_ipeds
,ca.CLASS_LEVEL							
,ca.CLASS_LEVEL_INST --- new field as of 6/6/2017	
, ca.honors_flag
,(case when ca.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
       else 'N' end) as Inst_Honors_Ind														
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code3 as float) + 10 ) as varchar) as second_fall
, co.class_level_inst as second_fall_class_level_inst
, (CASE WHEN co.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_second_fall

, (case when co.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_second_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code3 as float) + 20 ) as varchar) as third_fall
, co3.class_level_inst as third_fall_class_level_inst
, (CASE WHEN co3.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_third_fall


, (case when co3.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co3.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_third_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code3 as float) + 30 ) as varchar) as fourth_fall
, co4.class_level_inst as fourth_fall_class_level_inst
, (CASE WHEN co4.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fourth_fall
,(case when co4.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co4.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fourth_fall



FROM uncw.sdm_career_mv ca
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and ca.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and ca.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and ca.career_code =co4.career_code

WHERE 
 ca.snapshot_type_code = '1'
 and ca.snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code3
and ca.exclude_from_ipeds_flag = 'N'
and ca.primary_career_flag = 'Y'
and ca.career_code = 'U'
and ca.enrollment_status_code_ipeds in ('1')


union all 


select $Enter_Cohort_SDM_Fall_Term_Code4 as Cohort
,ca.student_cid
,ca.STUDENT_TYPE_CODE_INST							
,ca.STUDENT_TYPE_INST
,ca.enrollment_status_ipeds
,ca.CLASS_LEVEL							
,ca.CLASS_LEVEL_INST --- new field as of 6/6/2017	
, ca.honors_flag
,(case when ca.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
       else 'N' end) as Inst_Honors_Ind														
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code4 as float) + 10 ) as varchar) as second_fall
, co.class_level_inst as second_fall_class_level_inst
, (CASE WHEN co.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_second_fall

, (case when co.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_second_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code4 as float) + 20 ) as varchar) as third_fall
, co3.class_level_inst as third_fall_class_level_inst
, (CASE WHEN co3.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_third_fall


, (case when co3.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co3.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_third_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code4 as float) + 30 ) as varchar) as fourth_fall
, co4.class_level_inst as fourth_fall_class_level_inst
, (CASE WHEN co4.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fourth_fall
,(case when co4.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co4.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fourth_fall



FROM uncw.sdm_career_mv ca
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and ca.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and ca.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and ca.career_code =co4.career_code

WHERE 
 ca.snapshot_type_code = '1'
 and ca.snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code4
and ca.exclude_from_ipeds_flag = 'N'
and ca.primary_career_flag = 'Y'
and ca.career_code = 'U'
and ca.enrollment_status_code_ipeds in ('1')


union all


select $Enter_Cohort_SDM_Fall_Term_Code5 as Cohort
,ca.student_cid
,ca.STUDENT_TYPE_CODE_INST							
,ca.STUDENT_TYPE_INST
,ca.enrollment_status_ipeds
,ca.CLASS_LEVEL							
,ca.CLASS_LEVEL_INST --- new field as of 6/6/2017	
, ca.honors_flag
,(case when ca.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
       else 'N' end) as Inst_Honors_Ind														
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code5 as float) + 10 ) as varchar) as second_fall
, co.class_level_inst as second_fall_class_level_inst
, (CASE WHEN co.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_second_fall

, (case when co.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_second_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code5 as float) + 20 ) as varchar) as third_fall
, co3.class_level_inst as third_fall_class_level_inst
, (CASE WHEN co3.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_third_fall


, (case when co3.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co3.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_third_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code5 as float) + 30 ) as varchar) as fourth_fall
, co4.class_level_inst as fourth_fall_class_level_inst
, (CASE WHEN co4.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fourth_fall
,(case when co4.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co4.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fourth_fall



FROM uncw.sdm_career_mv ca
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and ca.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and ca.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and ca.career_code =co4.career_code

WHERE 
 ca.snapshot_type_code = '1'
 and ca.snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code5
and ca.exclude_from_ipeds_flag = 'N'
and ca.primary_career_flag = 'Y'
and ca.career_code = 'U'
and ca.enrollment_status_code_ipeds in ('1')

union all


select $Enter_Cohort_SDM_Fall_Term_Code6 as Cohort
,ca.student_cid
,ca.STUDENT_TYPE_CODE_INST							
,ca.STUDENT_TYPE_INST
,ca.enrollment_status_ipeds
,ca.CLASS_LEVEL							
,ca.CLASS_LEVEL_INST --- new field as of 6/6/2017	
, ca.honors_flag
,(case when ca.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
       else 'N' end) as Inst_Honors_Ind														
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code6 as float) + 10 ) as varchar) as second_fall
, co.class_level_inst as second_fall_class_level_inst
, (CASE WHEN co.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_second_fall

, (case when co.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_second_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code6 as float) + 20 ) as varchar) as third_fall
, co3.class_level_inst as third_fall_class_level_inst
, (CASE WHEN co3.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_third_fall


, (case when co3.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co3.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_third_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code6 as float) + 30 ) as varchar) as fourth_fall
, co4.class_level_inst as fourth_fall_class_level_inst
, (CASE WHEN co4.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fourth_fall
,(case when co4.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co4.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fourth_fall



FROM uncw.sdm_career_mv ca
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and ca.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and ca.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=ca.student_cid
			and CAST( (CAST (ca.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and ca.career_code =co4.career_code

WHERE 
 ca.snapshot_type_code = '1'
 and ca.snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code6
and ca.exclude_from_ipeds_flag = 'N'
and ca.primary_career_flag = 'Y'
and ca.career_code = 'U'
and ca.enrollment_status_code_ipeds in ('1')
)


select tbl.Cohort
,tbl.student_cid
,tbl.STUDENT_TYPE_CODE_INST							
,tbl.STUDENT_TYPE_INST
,tbl.enrollment_status_ipeds
,tbl.CLASS_LEVEL							
,tbl.CLASS_LEVEL_INST --- new field as of 6/6/2017	
, tbl.honors_flag
,tbl.Inst_Honors_Ind	
, tbl.second_fall
,tbl.second_fall_class_level_inst
, tbl.retained_in_second_fall
, tbl.Inst_Honors_Ind_second_fall

, tbl.third_fall
, tbl.third_fall_class_level_inst
, tbl.retained_in_third_fall
, tbl.Inst_Honors_Ind_third_fall

, tbl.fourth_fall
, tbl.fourth_fall_class_level_inst
, tbl.retained_in_fourth_fall
, tbl.Inst_Honors_Ind_fourth_fall


/*, (case 	when tbl.Inst_Honors_Ind = 'Y' and tbl.Inst_Honors_Ind_second_fall = 'Y' then 'Retained_in_honors'
		 	when tbl.Inst_Honors_Ind = 'Y' and tbl.Inst_Honors_Ind_second_fall = 'N' and tbl.retained_in_second_fall ='Y' then 'Retained_in_inst_only' 
			else null end) as retained_as_honors_or_inst_f2*/
			
, (case 	when tbl.Inst_Honors_Ind = 'Y' and tbl.Inst_Honors_Ind_second_fall = 'Y' then 'Retained_in_honors'
			when tbl.Inst_Honors_Ind = 'N' and tbl.Inst_Honors_Ind_second_fall = 'Y' then 'New_in_honors_f2'
		 	when tbl.Inst_Honors_Ind = 'Y' and tbl.Inst_Honors_Ind_second_fall = 'N' and tbl.retained_in_second_fall ='Y' then 'Retained_in_inst_only' 
			else null end) as retained_as_honors_or_inst_f2
			
/*, (case 	when tbl.Inst_Honors_Ind_second_fall = 'Y' and tbl.Inst_Honors_Ind_third_fall = 'Y' then 'Retained_in_honors'
		 	when tbl.Inst_Honors_Ind_second_fall = 'Y' and tbl.Inst_Honors_Ind_third_fall = 'N' and tbl.retained_in_third_fall ='Y' then 'Retained_in_inst_only' 
			else null end) as retained_as_honors_or_inst_f3	*/

, (case 	when tbl.Inst_Honors_Ind_second_fall = 'Y' and tbl.Inst_Honors_Ind_third_fall = 'Y' then 'Retained_in_honors'
			when tbl.Inst_Honors_Ind_second_fall = 'N' and tbl.Inst_Honors_Ind_third_fall = 'Y' then 'New_in_honors_f3'
			when tbl.Inst_Honors_Ind_second_fall = 'Y' and tbl.Inst_Honors_Ind_third_fall = 'N' and tbl.retained_in_third_fall ='Y' then 'Retained_in_inst_only' 
			else null end) as retained_as_honors_or_inst_f3

			
/*, (case 	when tbl.Inst_Honors_Ind_third_fall = 'Y' and tbl.Inst_Honors_Ind_fourth_fall = 'Y' then 'Retained_in_honors'
		 	when tbl.Inst_Honors_Ind_third_fall = 'Y' and tbl.Inst_Honors_Ind_fourth_fall = 'N' and tbl.retained_in_fourth_fall ='Y' then 'Retained_in_inst_only' 
			else null end) as retained_as_honors_or_inst_f4	*/

,  (case 	when tbl.Inst_Honors_Ind_third_fall = 'Y' and tbl.Inst_Honors_Ind_fourth_fall = 'Y' then 'Retained_in_honors'
			when tbl.Inst_Honors_Ind_third_fall = 'N' and tbl.Inst_Honors_Ind_fourth_fall = 'Y' then 'New_in_honors_f4'
			when tbl.Inst_Honors_Ind_third_fall = 'Y' and tbl.Inst_Honors_Ind_fourth_fall = 'N' and tbl.retained_in_fourth_fall ='Y' then 'Retained_in_inst_only' 
			else null end) as retained_as_honors_or_inst_f4



from cte_tbl tbl


