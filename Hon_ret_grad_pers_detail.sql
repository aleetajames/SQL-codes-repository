
with
cte_tb1
as
(select cr.snapshot_term_code,
cr.student_cid,
/*(CASE WHEN cum_0_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_0yr,*/
(CASE WHEN cum_1_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_1yr,
(CASE WHEN cum_2_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_2yr,
(CASE WHEN cum_3_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_3yr,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_5_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

/*,cum_0_yr.degree_honors_inst as DH_0yr_graduates*/
,cum_1_yr.degree_honors_inst as DH_1yr_graduates
,cum_2_yr.degree_honors_inst as DH_2yr_graduates
,cum_3_yr.degree_honors_inst as DH_3yr_graduates
,cum_4_yr.degree_honors_inst as DH_4yr_graduates
,cum_5_yr.degree_honors_inst as DH_5yr_graduates
,cum_6_yr.degree_honors_inst as DH_6yr_graduates
								
,cr.CLASS_LEVEL_INST --- new field as of 6/6/2017	
,(case when cr.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
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


, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code1 as float) + 40 ) as varchar) as fifth_fall
, co5.class_level_inst as fifth_fall_class_level_inst
, (CASE WHEN co5.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fifth_fall
,(case when co5.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co5.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fifth_fall
       
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code1 as float) + 50 ) as varchar) as sixth_fall
, co6.class_level_inst as sixth_fall_class_level_inst
, (CASE WHEN co6.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_sixth_fall
,(case when co6.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co6.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_sixth_fall




, (select zc.student_cid				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
			   

				
				
				
FROM uncw.sdm_career_mv as cr



left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and cr.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and cr.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and cr.career_code =co4.career_code

			 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n5
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co5
			on co5.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 40 ) as varchar) = co5.snapshot_term_code
			 and cr.career_code =co5.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n6
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co6
			on co6.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 50 ) as varchar) = co6.snapshot_term_code
			 and cr.career_code =co6.career_code
			 
			 
/*graduation joins*/
/*			 left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) ), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) ), '6')
					)cum_0_yr ON cum_0_yr.cid = cr.student_cid		/*graduating the same AY*/*/
			 
			 

	left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 1), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 1), '6')
					)cum_1_yr ON cum_1_yr.cid = cr.student_cid		/*graduating at the end of first  AY*/	 
								 
			 


	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 2), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 2), '6')
					)cum_2_yr ON cum_2_yr.cid = cr.student_cid
				
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 3), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 3), '6')
					)cum_3_yr ON cum_3_yr.cid = cr.student_cid
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.cid = cr.student_cid
					
	
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.cid = cr.student_cid
					
					
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.cid = cr.student_cid
					
					
						
WHERE cr.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code1			
	AND cr.snapshot_type_code = '1'			
   AND cr.ENROLLMENT_STATUS_CODE_IPEDS in ('1')
         
/*second cohort*/   
union all  
   
select cr.snapshot_term_code,
cr.student_cid,
/*(CASE WHEN cum_0_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_0yr,*/
(CASE WHEN cum_1_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_1yr,
(CASE WHEN cum_2_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_2yr,
(CASE WHEN cum_3_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_3yr,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_5_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

/*,cum_0_yr.degree_honors_inst as DH_0yr_graduates*/
,cum_1_yr.degree_honors_inst as DH_1yr_graduates
,cum_2_yr.degree_honors_inst as DH_2yr_graduates
,cum_3_yr.degree_honors_inst as DH_3yr_graduates
,cum_4_yr.degree_honors_inst as DH_4yr_graduates
,cum_5_yr.degree_honors_inst as DH_5yr_graduates
,cum_6_yr.degree_honors_inst as DH_6yr_graduates

								
,cr.CLASS_LEVEL_INST --- new field as of 6/6/2017	
,(case when cr.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
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

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code2 as float) + 40 ) as varchar) as fifth_fall
, co5.class_level_inst as fifth_fall_class_level_inst
, (CASE WHEN co5.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fifth_fall
,(case when co5.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co5.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fifth_fall
       
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code2 as float) + 50 ) as varchar) as sixth_fall
, co6.class_level_inst as sixth_fall_class_level_inst
, (CASE WHEN co6.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_sixth_fall
,(case when co6.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co6.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_sixth_fall





, (select zc.student_cid				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
			   

				
				
				
FROM uncw.sdm_career_mv as cr



left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and cr.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and cr.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and cr.career_code =co4.career_code


			 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n5
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co5
			on co5.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 40 ) as varchar) = co5.snapshot_term_code
			 and cr.career_code =co5.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n6
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co6
			on co6.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 50 ) as varchar) = co6.snapshot_term_code
			 and cr.career_code =co6.career_code

/*graduation joins*/
			 /*left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) ), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) ), '6')
					)cum_0_yr ON cum_0_yr.cid = cr.student_cid		/*graduating the same AY*/*/
			 
			 

	left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 1), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 1), '6')
					)cum_1_yr ON cum_1_yr.cid = cr.student_cid		/*graduating at the end of first AY*/	 
					
					

	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 2), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 2), '6')
					)cum_2_yr ON cum_2_yr.cid = cr.student_cid
				
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 3), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 3), '6')
					)cum_3_yr ON cum_3_yr.cid = cr.student_cid
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.cid = cr.student_cid
					
	
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.cid = cr.student_cid
					
					
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.cid = cr.student_cid
					
					
						
WHERE cr.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code2		
	AND cr.snapshot_type_code = '1'			
   AND cr.ENROLLMENT_STATUS_CODE_IPEDS in ('1')
   
/*third cohort*/   
union all

select cr.snapshot_term_code,
cr.student_cid,
/*(CASE WHEN cum_0_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_0yr,*/
(CASE WHEN cum_1_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_1yr,
(CASE WHEN cum_2_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_2yr,
(CASE WHEN cum_3_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_3yr,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_5_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

/*,cum_0_yr.degree_honors_inst as DH_0yr_graduates*/
,cum_1_yr.degree_honors_inst as DH_1yr_graduates
,cum_2_yr.degree_honors_inst as DH_2yr_graduates
,cum_3_yr.degree_honors_inst as DH_3yr_graduates
,cum_4_yr.degree_honors_inst as DH_4yr_graduates
,cum_5_yr.degree_honors_inst as DH_5yr_graduates
,cum_6_yr.degree_honors_inst as DH_6yr_graduates

								
,cr.CLASS_LEVEL_INST --- new field as of 6/6/2017	
,(case when cr.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
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

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code3 as float) + 40 ) as varchar) as fifth_fall
, co5.class_level_inst as fifth_fall_class_level_inst
, (CASE WHEN co5.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fifth_fall
,(case when co5.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co5.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fifth_fall
       
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code3 as float) + 50 ) as varchar) as sixth_fall
, co6.class_level_inst as sixth_fall_class_level_inst
, (CASE WHEN co6.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_sixth_fall
,(case when co6.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co6.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_sixth_fall





, (select zc.student_cid				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
			   

				
				
				
FROM uncw.sdm_career_mv as cr



left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and cr.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and cr.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and cr.career_code =co4.career_code


			 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n5
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co5
			on co5.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 40 ) as varchar) = co5.snapshot_term_code
			 and cr.career_code =co5.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n6
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co6
			on co6.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 50 ) as varchar) = co6.snapshot_term_code
			 and cr.career_code =co6.career_code

/*graduation joins*/
			 /*left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) ), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) ), '6')
					)cum_0_yr ON cum_0_yr.cid = cr.student_cid		/*graduating the same AY*/*/
			 
			 

	left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 1), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 1), '6')
					)cum_1_yr ON cum_1_yr.cid = cr.student_cid		/*graduating at the end of first AY*/	 
					
					
			 
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 2), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 2), '6')
					)cum_2_yr ON cum_2_yr.cid = cr.student_cid
				
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 3), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 3), '6')
					)cum_3_yr ON cum_3_yr.cid = cr.student_cid
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.cid = cr.student_cid
					
	
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.cid = cr.student_cid
					
					
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.cid = cr.student_cid
					
					
						
WHERE cr.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code3			
	AND cr.snapshot_type_code = '1'			
   AND cr.ENROLLMENT_STATUS_CODE_IPEDS in ('1')
   
/*fourth cohort*/   
union all

select cr.snapshot_term_code,
cr.student_cid,
/*(CASE WHEN cum_0_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_0yr,*/
(CASE WHEN cum_1_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_1yr,
(CASE WHEN cum_2_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_2yr,
(CASE WHEN cum_3_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_3yr,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_5_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

/*,cum_0_yr.degree_honors_inst as DH_0yr_graduates*/
,cum_1_yr.degree_honors_inst as DH_1yr_graduates
,cum_2_yr.degree_honors_inst as DH_2yr_graduates
,cum_3_yr.degree_honors_inst as DH_3yr_graduates
,cum_4_yr.degree_honors_inst as DH_4yr_graduates
,cum_5_yr.degree_honors_inst as DH_5yr_graduates
,cum_6_yr.degree_honors_inst as DH_6yr_graduates
								
,cr.CLASS_LEVEL_INST --- new field as of 6/6/2017	
,(case when cr.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
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


, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code4 as float) + 40 ) as varchar) as fifth_fall
, co5.class_level_inst as fifth_fall_class_level_inst
, (CASE WHEN co5.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fifth_fall
,(case when co5.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co5.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fifth_fall
       
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code4 as float) + 50 ) as varchar) as sixth_fall
, co6.class_level_inst as sixth_fall_class_level_inst
, (CASE WHEN co6.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_sixth_fall
,(case when co6.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co6.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_sixth_fall


       


, (select zc.student_cid				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
			   

				
				
				
FROM uncw.sdm_career_mv as cr



left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and cr.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and cr.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and cr.career_code =co4.career_code


			 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n5
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co5
			on co5.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 40 ) as varchar) = co5.snapshot_term_code
			 and cr.career_code =co5.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n6
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co6
			on co6.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 50 ) as varchar) = co6.snapshot_term_code
			 and cr.career_code =co6.career_code

/*graduation joins*/
			 /*left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) ), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) ), '6')
					)cum_0_yr ON cum_0_yr.cid = cr.student_cid		/*graduating the same AY*/*/
			 
			 

	left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 1), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 1), '6')
					)cum_1_yr ON cum_1_yr.cid = cr.student_cid		/*graduating at the end of first AY*/	 
					
								 
			 

	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 2), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 2), '6')
					)cum_2_yr ON cum_2_yr.cid = cr.student_cid
				
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 3), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 3), '6')
					)cum_3_yr ON cum_3_yr.cid = cr.student_cid
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.cid = cr.student_cid
					
	
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.cid = cr.student_cid
					
					
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.cid = cr.student_cid
					
					
						
WHERE cr.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code4			
	AND cr.snapshot_type_code = '1'			
   AND cr.ENROLLMENT_STATUS_CODE_IPEDS in ('1') 
   
/*fifth cohort*/
union all
select cr.snapshot_term_code,
cr.student_cid,
/*(CASE WHEN cum_0_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_0yr,*/
(CASE WHEN cum_1_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_1yr,
(CASE WHEN cum_2_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_2yr,
(CASE WHEN cum_3_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_3yr,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_5_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

/*,cum_0_yr.degree_honors_inst as DH_0yr_graduates*/
,cum_1_yr.degree_honors_inst as DH_1yr_graduates
,cum_2_yr.degree_honors_inst as DH_2yr_graduates
,cum_3_yr.degree_honors_inst as DH_3yr_graduates
,cum_4_yr.degree_honors_inst as DH_4yr_graduates
,cum_5_yr.degree_honors_inst as DH_5yr_graduates
,cum_6_yr.degree_honors_inst as DH_6yr_graduates
								
,cr.CLASS_LEVEL_INST --- new field as of 6/6/2017	
,(case when cr.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
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


, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code5 as float) + 40 ) as varchar) as fifth_fall
, co5.class_level_inst as fifth_fall_class_level_inst
, (CASE WHEN co5.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fifth_fall
,(case when co5.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co5.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fifth_fall
       
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code5 as float) + 50 ) as varchar) as sixth_fall
, co6.class_level_inst as sixth_fall_class_level_inst
, (CASE WHEN co6.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_sixth_fall
,(case when co6.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co6.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_sixth_fall




, (select zc.student_cid				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
			   

				
				
				
FROM uncw.sdm_career_mv as cr



left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and cr.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and cr.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and cr.career_code =co4.career_code

			 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n5
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co5
			on co5.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 40 ) as varchar) = co5.snapshot_term_code
			 and cr.career_code =co5.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n6
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co6
			on co6.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 50 ) as varchar) = co6.snapshot_term_code
			 and cr.career_code =co6.career_code

/*graduation joins*/
			 /*left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) ), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) ), '6')
					)cum_0_yr ON cum_0_yr.cid = cr.student_cid		/*graduating the same AY*/*/
			 
			 

	left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 1), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 1), '6')
					)cum_1_yr ON cum_1_yr.cid = cr.student_cid		/*graduating at the end of first AY*/	 
					
								 
			 
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 2), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 2), '6')
					)cum_2_yr ON cum_2_yr.cid = cr.student_cid
				
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 3), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 3), '6')
					)cum_3_yr ON cum_3_yr.cid = cr.student_cid
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.cid = cr.student_cid
					
	
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.cid = cr.student_cid
					
					
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.cid = cr.student_cid
					
					
						
WHERE cr.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code5			
	AND cr.snapshot_type_code = '1'			
   AND cr.ENROLLMENT_STATUS_CODE_IPEDS in ('1')
   
/*sixth cohort*/
union all
select cr.snapshot_term_code,
cr.student_cid,
/*(CASE WHEN cum_0_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_0yr,*/
(CASE WHEN cum_1_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_1yr,
(CASE WHEN cum_2_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_2yr,
(CASE WHEN cum_3_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_3yr,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_5_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

/*,cum_0_yr.degree_honors_inst as DH_0yr_graduates*/
,cum_1_yr.degree_honors_inst as DH_1yr_graduates
,cum_2_yr.degree_honors_inst as DH_2yr_graduates
,cum_3_yr.degree_honors_inst as DH_3yr_graduates
,cum_4_yr.degree_honors_inst as DH_4yr_graduates
,cum_5_yr.degree_honors_inst as DH_5yr_graduates
,cum_6_yr.degree_honors_inst as DH_6yr_graduates
								
,cr.CLASS_LEVEL_INST --- new field as of 6/6/2017	
,(case when cr.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
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


, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code6 as float) + 40 ) as varchar) as fifth_fall
, co5.class_level_inst as fifth_fall_class_level_inst
, (CASE WHEN co5.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fifth_fall
,(case when co5.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co5.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fifth_fall
       
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code6 as float) + 50 ) as varchar) as sixth_fall
, co6.class_level_inst as sixth_fall_class_level_inst
, (CASE WHEN co6.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_sixth_fall
,(case when co6.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co6.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_sixth_fall




, (select zc.student_cid				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
			   

				
				
				
FROM uncw.sdm_career_mv as cr



left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and cr.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and cr.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and cr.career_code =co4.career_code

			 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n5
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co5
			on co5.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 40 ) as varchar) = co5.snapshot_term_code
			 and cr.career_code =co5.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n6
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co6
			on co6.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 50 ) as varchar) = co6.snapshot_term_code
			 and cr.career_code =co6.career_code
			 
			 
/*graduation joins*/
			/* left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) ), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) ), '6')
					)cum_0_yr ON cum_0_yr.cid = cr.student_cid		/*graduating the same AY*/*/
			 
			 

	left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 1), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 1), '6')
					)cum_1_yr ON cum_1_yr.cid = cr.student_cid		/*graduating at the end of first AY*/	 
					
								 
			 

	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 2), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 2), '6')
					)cum_2_yr ON cum_2_yr.cid = cr.student_cid
				
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 3), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 3), '6')
					)cum_3_yr ON cum_3_yr.cid = cr.student_cid
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.cid = cr.student_cid
					
	
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.cid = cr.student_cid
					
					
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.cid = cr.student_cid
					
					
						
WHERE cr.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code6			
	AND cr.snapshot_type_code = '1'			
   AND cr.ENROLLMENT_STATUS_CODE_IPEDS in ('1')
   

/*seventh cohort*/
union all
select cr.snapshot_term_code,
cr.student_cid,
/*(CASE WHEN cum_0_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_0yr,*/
(CASE WHEN cum_1_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_1yr,
(CASE WHEN cum_2_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_2yr,
(CASE WHEN cum_3_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_3yr,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_5_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

/*,cum_0_yr.degree_honors_inst as DH_0yr_graduates*/
,cum_1_yr.degree_honors_inst as DH_1yr_graduates
,cum_2_yr.degree_honors_inst as DH_2yr_graduates
,cum_3_yr.degree_honors_inst as DH_3yr_graduates
,cum_4_yr.degree_honors_inst as DH_4yr_graduates
,cum_5_yr.degree_honors_inst as DH_5yr_graduates
,cum_6_yr.degree_honors_inst as DH_6yr_graduates
								
,cr.CLASS_LEVEL_INST --- new field as of 6/6/2017	
,(case when cr.CLASS_LEVEL_INST like '%Honors%' then 'Y'							
       else 'N' end) as Inst_Honors_Ind	
       
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code7 as float) + 10 ) as varchar) as second_fall
, co.class_level_inst as second_fall_class_level_inst
, (CASE WHEN co.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_second_fall
, (case when co.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_second_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code7 as float) + 20 ) as varchar) as third_fall
, co3.class_level_inst as third_fall_class_level_inst
, (CASE WHEN co3.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_third_fall
, (case when co3.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co3.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_third_fall

, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code7 as float) + 30 ) as varchar) as fourth_fall
, co4.class_level_inst as fourth_fall_class_level_inst
, (CASE WHEN co4.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fourth_fall
,(case when co4.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co4.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fourth_fall


, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code7 as float) + 40 ) as varchar) as fifth_fall
, co5.class_level_inst as fifth_fall_class_level_inst
, (CASE WHEN co5.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_fifth_fall
,(case when co5.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co5.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_fifth_fall
       
, CAST( (CAST ($Enter_Cohort_SDM_Fall_Term_Code7 as float) + 50 ) as varchar) as sixth_fall
, co6.class_level_inst as sixth_fall_class_level_inst
, (CASE WHEN co6.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_sixth_fall
,(case when co6.CLASS_LEVEL_INST like '%Honors%' then 'Y'
	   when co6.CLASS_LEVEL_INST ISNULL then 'N' ---- added null for not retained
       else 'N' end) as Inst_Honors_Ind_sixth_fall




, (select zc.student_cid				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
			   

				
				
				
FROM uncw.sdm_career_mv as cr



left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co
			on co.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 10 ) as varchar) = co.snapshot_term_code
			 and cr.career_code =co.career_code
 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n3
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co3
			on co3.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 20 ) as varchar) = co3.snapshot_term_code
			 and cr.career_code =co3.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n4
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co4
			on co4.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 30 ) as varchar) = co4.snapshot_term_code
			 and cr.career_code =co4.career_code

			 
		left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n5
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co5
			on co5.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 40 ) as varchar) = co5.snapshot_term_code
			 and cr.career_code =co5.career_code
			 
			 
	    left join (SELECT student_cid, snapshot_term_code, career_code, class_level_inst
			
			
			FROM uncw.sdm_career_mv n6
			WHERE
			snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and snapshot_term_type ='Fall'
			) co6
			on co6.student_cid=cr.student_cid
			and CAST( (CAST (cr.snapshot_term_code as float) + 50 ) as varchar) = co6.snapshot_term_code
			 and cr.career_code =co6.career_code
			 
			 
/*graduation joins*/
			 /*left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) ), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) ), '6')
					)cum_0_yr ON cum_0_yr.cid = cr.student_cid		/*graduating the same AY*/*/
			 
			 

	left join				(SELECT DISTINCT student_cid AS cid
								,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 1), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 1), '6')
					)cum_1_yr ON cum_1_yr.cid = cr.student_cid		/*graduating at the end of first AY*/	 
								 
			 


	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 2), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 2), '6')
					)cum_2_yr ON cum_2_yr.cid = cr.student_cid
				
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 3), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 3), '6')
					)cum_3_yr ON cum_3_yr.cid = cr.student_cid
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.cid = cr.student_cid
					
	
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.cid = cr.student_cid
					
					
					
	left join				(SELECT DISTINCT student_cid AS cid
									,degree_honors_inst
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.cid = cr.student_cid
					
					
						
WHERE cr.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code7			
	AND cr.snapshot_type_code = '1'			
   AND cr.ENROLLMENT_STATUS_CODE_IPEDS in ('1')
         


)
 

 select 
tb1.snapshot_term_code,
tb1.student_cid


/*retention to hon or inst only*/
,  (tb1.FollowingFall_Retention) as retention
/*,concat( (ROUND(CAST( (tb1.FollowingFall_Retention) AS FLOAT) / CAST(  (tb1.student_cid) AS FLOAT), 4))*100, '%') as retention_rate*/


, ((case when tb1.Inst_Honors_Ind = 'Y' then '1' else null end)) as inst_hon_fall1

,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_second_fall = 'Y' then 'Retained_in_honors'
			else null end)) as retained_as_honors_f2
			
,  ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_second_fall = 'N' and tb1.retained_in_second_fall ='Y' then 'Retained_in_inst_only' 
				else null end)) as retained_in_inst_only_f2
				
				
/*fall3 hon*/
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_third_fall = 'Y' then 'Retained_in_honors'
			else null end)) as retained_as_honors_f3
			
,  ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_third_fall = 'N' and tb1.retained_in_third_fall ='Y' then 'Retained_in_inst_only' 
				else null end)) as retained_in_inst_only_f3
				
/*fall4 hon*/
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_fourth_fall = 'Y' then 'Retained_in_honors'
			else null end)) as retained_as_honors_f4
			
,  ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_fourth_fall = 'N' and tb1.retained_in_fourth_fall ='Y' then 'Retained_in_inst_only' 
				else null end)) as retained_in_inst_only_f4
				
/*fall5 hon*/
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_fifth_fall = 'Y' then 'Retained_in_honors'
			else null end)) as retained_as_honors_f5
			
,  ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_fifth_fall = 'N' and tb1.retained_in_fifth_fall ='Y' then 'Retained_in_inst_only' 
				else null end)) as retained_in_inst_only_f5

/*fall6 hon*/
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_sixth_fall = 'Y' then 'Retained_in_honors'
			else null end)) as retained_as_honors_f6
			
,  ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_sixth_fall = 'N' and tb1.retained_in_sixth_fall ='Y' then 'Retained_in_inst_only' 
				else null end)) as retained_in_inst_only_f6

/*/*fall7 hon*/
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_seventh_fall = 'Y' then 'Retained_in_honors'
			else null end)) as retained_as_honors_f7
			
,  ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_seventh_fall = 'N' and tb1.retained_in_seventh_fall ='Y' then 'Retained_in_inst_only' 
				else null end)) as retained_in_inst_only_f7*/
				
/****tracking graduation****/

/*,  (tb1.cum_0yr) as grad_rate_0yr  /*cohort graduation*/
/*tracking degree hon graduation of freshmen*/
,  (tb1.DH_0yr_graduates) as DH_0yr
/*tracking graduation of hon freshmen*/
, ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.DH_0yr_graduates is not null then '1' else null end)) as FrHon_DH_0yr*/

,  (tb1.cum_1yr) as grad_rate_1yr  /*cohort graduation*/
/*tracking degree hon graduation of freshmen*/
,  (tb1.DH_1yr_graduates) as DH_1yr
/*tracking graduation of hon freshmen*/
, ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.DH_1yr_graduates is not null then '1' else null end)) as FrHon_DH_1yr
				
,  (tb1.cum_2yr) as grad_rate_2yr  /*cohort graduation*/
/*tracking degree hon graduation of freshmen*/
,  (tb1.DH_2yr_graduates) as DH_2yr
/*tracking graduation of hon freshmen*/
, ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.DH_2yr_graduates is not null then '1' else null end)) as FrHon_DH_2yr

,  (tb1.cum_3yr) as grad_rate_3yr
/*tracking degree hon graduation of freshmen*/
,  (tb1.DH_3yr_graduates) as DH_3yr
/*tracking graduation of hon freshmen*/
, ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.DH_3yr_graduates is not null then '1' else null end)) as FrHon_DH_3yr


, ( tb1.cum_4yr) as grad_rate_4yr
/*tracking degree hon graduation of freshmen*/
,  (tb1.DH_4yr_graduates) as DH_4yr
/*tracking graduation of hon freshmen*/
, ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.DH_4yr_graduates is not null then '1' else null end)) as FrHon_DH_4yr


,  (tb1.cum_5yr) as grad_rate_5yr
/*tracking degree hon graduation of freshmen*/
,  (tb1.DH_5yr_graduates) as DH_5yr
/*tracking graduation of hon freshmen*/
, ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.DH_5yr_graduates is not null then '1' else null end)) as FrHon_DH_5yr


,  (tb1.cum_6yr) as grad_rate_6yr
/*tracking degree hon graduation of freshmen*/
,  (tb1.DH_6yr_graduates) as DH_6yr
/*tracking graduation of hon freshmen*/
, ((case when tb1.Inst_Honors_Ind = 'Y' and tb1.DH_6yr_graduates is not null then '1' else null end)) as FrHon_DH_6yr

/* Persistence*/   
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and (tb1.Inst_Honors_Ind_second_fall = 'Y' or tb1.DH_2yr_graduates is not null ) then 'Persisted_in_honors'
			else null end)) as persisted_in_honors_f2
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and (tb1.Inst_Honors_Ind_third_fall = 'Y' or  tb1.DH_3yr_graduates is not null ) then 'Persisted_in_honors'
			else null end)) as persisted_in_honors_f3
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and (tb1.Inst_Honors_Ind_fourth_fall = 'Y' or tb1.DH_4yr_graduates is not null ) then 'Persisted_in_honors'
			else null end)) as persisted_in_honors_f4
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and (tb1.Inst_Honors_Ind_fifth_fall = 'Y' or tb1.DH_5yr_graduates is not null ) then 'Persisted_in_honors'
			else null end)) as persisted_in_honors_f5
,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and (tb1.Inst_Honors_Ind_sixth_fall = 'Y' or tb1.DH_6yr_graduates is not null ) then 'Persisted_in_honors'
			else null end)) as persisted_in_honors_f6
/*,   ((case 	when tb1.Inst_Honors_Ind = 'Y' and tb1.Inst_Honors_Ind_seventh_fall = 'Y' and tb1.DH_5yr_graduates is not null  then 'Persisted_in_honors'
			else null end)) as persisted_in_honors_f7*/


/*,  ((case when tb1.retained_in_second_fall = 'Y' then '1' else null end)) as ret_fall2*/
/*, tb1.retained_in_second_fall
, tb1.Inst_Honors_Ind_second_fall*/






from cte_tb1 tb1 



--where tb1.student_cid = '****74704'
