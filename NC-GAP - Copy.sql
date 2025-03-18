
with 

cte_tb1 as
	(



select cr.snapshot_term_code,
cr.student_cid,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr


, (case when (select distinct academic_standing_inst
			
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code1		
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')
				)  is null then null
	else 'Y'
	end) as "AY_Fallprobation"
, (case when (select distinct academic_standing_inst  		
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 1), '1')			
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')) is null then null
				else 'Y'
				end) as "AY_Springprobation"
								
, (select zc.student_cid				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
			   

				
				
				
FROM uncw.sdm_career_mv as cr		

	left join				(SELECT DISTINCT student_cid AS cid
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
   

   
union all 

select cr.snapshot_term_code,
cr.student_cid,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr


, (case when (select distinct academic_standing_inst
			
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code2		
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')
				)  is null then null
	else 'Y'
	end) as "AY_Fallprobation"
, (case when (select distinct academic_standing_inst  		
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 1), '1')			
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')) is null then null
				else 'Y'
				end) as "AY_Springprobation"
								
, (select zc.STUDENT_CID				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
	
							
				
				
FROM uncw.sdm_career_mv as cr

left join				(SELECT DISTINCT student_cid AS cid
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
   

   
union all 

select cr.snapshot_term_code,
cr.student_cid,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr


, (case when (select distinct academic_standing_inst
			
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code3		
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')
				)  is null then null
	else 'Y'
	end) as "AY_Fallprobation"
, (case when (select distinct academic_standing_inst  		
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 1), '1')			
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')) is null then null
				else 'Y'
				end) as "AY_Springprobation"
								

, (select zc.STUDENT_CID				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention			
				
				
FROM uncw.sdm_career_mv as cr	

left join				(SELECT DISTINCT student_cid AS cid
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
   
   
union all 

select cr.snapshot_term_code,
cr.student_cid,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr


, (case when (select distinct academic_standing_inst
			
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code4	
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')
				)  is null then null
	else 'Y'
	end) as "AY_Fallprobation"
, (case when (select distinct academic_standing_inst  		
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 1), '1')			
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')) is null then null
				else 'Y'
				end) as "AY_Springprobation"
								

, (select zc.STUDENT_CID				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
										
				
				
FROM uncw.sdm_career_mv as cr

left join				(SELECT DISTINCT student_cid AS cid
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
   
   
   
union all 

select cr.snapshot_term_code,
cr.student_cid,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr


, (case when (select distinct academic_standing_inst
			
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code5	
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')
				)  is null then null
	else 'Y'
	end) as "AY_Fallprobation"
, (case when (select distinct academic_standing_inst  		
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 1), '1')			
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')) is null then null
				else 'Y'
				end) as "AY_Springprobation"
								

, (select zc.STUDENT_CID				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
										
				
				
FROM uncw.sdm_career_mv as cr

left join				(SELECT DISTINCT student_cid AS cid
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
   
   
union all 

select cr.snapshot_term_code,
cr.student_cid,
(CASE WHEN cum_4_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr,
(CASE WHEN cum_6_yr.cid IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr


, (case when (select distinct academic_standing_inst
			
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = $Enter_Cohort_SDM_Fall_Term_Code6	
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')
				)  is null then null
	else 'Y'
	end) as "AY_Fallprobation"
, (case when (select distinct academic_standing_inst  		
				    from uncw.sdm_career_mv as zd -----using post grade career dataset				
					where zd.snapshot_type_code = '4'			
					  and zd.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 1), '1')			
					  and zd.STUDENT_CID = cr.student_cid			
					  and zd.academic_standing_inst  in('Academic Contract','Academic Dismissal',			
								'Academic Probation','Insufficient Academic Progress','Must Be Reviewed')) is null then null
				else 'Y'
				end) as "AY_Springprobation"
								

, (select zc.STUDENT_CID				
			   from uncw.sdm_career_mv as zc		
			   where zc.snapshot_type_code = '1'				
			   and zc.SNAPSHOT_TERM_CODE = CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 1), '6')				
			   and zc.STUDENT_CID = cr.STUDENT_CID				
			   ) as FollowingFall_Retention
										
				
				
FROM uncw.sdm_career_mv as cr

left join				(SELECT DISTINCT student_cid AS cid
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
   )
   
   
 select 
tb1.snapshot_term_code,
count(tb1.student_cid) as cohort_size,
count (tb1.FollowingFall_Retention) as retention_count,
concat( (ROUND(CAST(COUNT(tb1.FollowingFall_Retention) AS FLOAT) / CAST(COUNT (tb1.student_cid) AS FLOAT), 4))*100, '%') as retention_rate,

count((case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end)) as "AY_Probation_Student_count",
count((case when  
				(case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end) = '1' 
						and tb1.FollowingFall_Retention is not null  then '1' else null end)) as "Probation_students_retention_count",
concat((ROUND(CAST(count((case when  
				(case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end) = '1' 
						and tb1.FollowingFall_Retention is not null  then '1' else null end)) AS FLOAT) 
			 / CAST(count((case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end)) AS FLOAT), 4))*100, '%' ) as Probation_students_retention_rate,
			 
COUNT(tb1.cum_4yr) AS cum_4yr_ga_hc,
COUNT(tb1.cum_6yr) AS cum_6yr_ga_hc,
ROUND(CAST(COUNT(tb1.cum_4yr) AS FLOAT)/CAST(COUNT(tb1.student_cid)AS FLOAT),4) AS cum_4yr_ga_pc,
ROUND(CAST(COUNT(tb1.cum_6yr) AS FLOAT)/CAST(COUNT(tb1.student_cid)AS FLOAT),4) AS cum_6yr_ga_pc,

count((case when  
				(case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end) = '1' 
						and tb1.cum_4yr is not null  then '1' else null end)) as "Probation_students_4yrgrad_count",
						
						
count((case when  
				(case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end) = '1' 
						and tb1.cum_6yr is not null  then '1' else null end)) as "Probation_students_6yrgrad_count",
						
concat((ROUND(CAST(count((case when  
				(case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end) = '1' 
						and tb1.cum_4yr is not null  then '1' else null end)) AS FLOAT) 
			 / CAST(count((case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end)) AS FLOAT), 4))*100, '%' ) as Probation_students_4yrgrad_rate,
			 
concat((ROUND(CAST(count((case when  
				(case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end) = '1' 
						and tb1.cum_6yr is not null  then '1' else null end)) AS FLOAT) 
			 / CAST(count((case when  tb1.AY_Fallprobation is null and  tb1.AY_Springprobation is null then null else '1' end)) AS FLOAT), 4))*100, '%' ) as Probation_students_6yrgrad_rate,
 
 pell."% pellReturning to Yr2",
total."% totalReturning to Yr2",
minority."% minorityReturning to Yr2"




from cte_tb1 tb1 

left join 
						(SELECT 
					cohort_term_code
					, new_student_type_desc AS "Student Type"
					, '4.PELL: '|| pell  AS "Cohort Type"
					, student_full_part_time AS "Student_FT_PT"
					, COUNT (student_cid) AS cohort_size_original
					, COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS cohort_size_adj_1
					, COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS cohort_size_adj_6
					, COUNT (CASE WHEN (exclude_8 = '0') THEN student_cid END) AS cohort_size_adj_8
					
					, COUNT(CASE WHEN enrl_term_5 = '1'  and grad_term_4 = '0'  THEN student_cid END) AS "# pellReturning to Yr2"
					, concat((ROUND(CAST(COUNT(CASE WHEN enrl_term_5 = '1'  and grad_term_4 = '0'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4))*100,'%') AS "% pellReturning to Yr2"
					, COUNT(CASE WHEN grad_term_4 = '0' AND grad_term_8 = '1'  THEN student_cid END) AS "# Graduating in 2Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_4 = '0' AND grad_term_8 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% pellGraduating in Yr2"
					
					

					, COUNT(CASE WHEN grad_term_8 = '0' AND grad_term_12 = '1'  THEN student_cid END) AS "# pellGraduating in 3Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_8 = '0' AND grad_term_12 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% pellGraduating in Yr3"
					
					
					, COUNT(CASE WHEN grad_term_12 = '0' AND grad_term_16 = '1'  THEN student_cid END) AS "# pellGraduating in 4Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_12 = '0' AND grad_term_16 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% pellGraduating in Yr4"
					
					
					, COUNT(CASE WHEN grad_term_16 = '0' AND grad_term_20 = '1'  THEN student_cid END) AS "# pellGraduating in 5Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_16 = '0' AND grad_term_20 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% pellGraduating in Yr5"
					

					, COUNT(CASE WHEN grad_term_20 = '0' AND grad_term_24 = '1'  THEN student_cid END) AS "# pellGraduating in 6Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_20 = '0' AND grad_term_24 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% pellGraduating in Yr6"
					
					
					
					FROM unc.uncw.da_gradret
					WHERE cohort_term_code LIKE '%6'
					AND student_full_part_time = 'F'
					AND new_student_type IN('F')
					and pell ='1'
					AND grad_retn_from = '1'
					
					GROUP BY cohort_term_code, pell, new_student_type_desc, student_full_part_time
					
					ORDER BY "Student Type",  "Cohort Type", cohort_term_code, "Student_FT_PT") pell on pell.cohort_term_code = tb1.snapshot_term_code
					
					
left join 
					(SELECT 
					cohort_term_code
					--, new_student_type_desc AS "Student Type"
					, '1.Total'  AS "Cohort Type"
					, student_full_part_time AS "Student_FT_PT"
					, COUNT (student_cid) AS cohort_size_original
					, COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS cohort_size_adj_1
					, COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS cohort_size_adj_6
					, COUNT (CASE WHEN (exclude_8 = '0') THEN student_cid END) AS cohort_size_adj_8
					
					, COUNT(CASE WHEN enrl_term_5 = '1'  and grad_term_4 = '0'  THEN student_cid END) AS "# totalReturning to Yr2"
					, concat((ROUND(CAST(COUNT(CASE WHEN enrl_term_5 = '1'  and grad_term_4 = '0'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4))*100,'%') AS "% totalReturning to Yr2"
					, COUNT(CASE WHEN grad_term_4 = '0' AND grad_term_8 = '1'  THEN student_cid END) AS "# totalGraduating in 2Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_4 = '0' AND grad_term_8 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% totalGraduating in Yr2"
					
					
					, COUNT(CASE WHEN grad_term_8 = '0' AND grad_term_12 = '1'  THEN student_cid END) AS "# totalGraduating in 3Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_8 = '0' AND grad_term_12 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% totalGraduating in Yr3"
					

					, COUNT(CASE WHEN grad_term_12 = '0' AND grad_term_16 = '1'  THEN student_cid END) AS "# totalGraduating in 4Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_12 = '0' AND grad_term_16 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% totalGraduating in Yr4"

					, COUNT(CASE WHEN grad_term_16 = '0' AND grad_term_20 = '1'  THEN student_cid END) AS "# totalGraduating in 5Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_16 = '0' AND grad_term_20 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% totalGraduating in Yr5"
		
					, COUNT(CASE WHEN grad_term_20 = '0' AND grad_term_24 = '1'  THEN student_cid END) AS "# totalGraduating in 6Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_20 = '0' AND grad_term_24 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% totalGraduating in Yr6"
					

					
					FROM unc.uncw.da_gradret
					WHERE cohort_term_code LIKE '%6'
					AND student_full_part_time = 'F'
					AND new_student_type IN('F')
					AND grad_retn_from = '1'
					
					GROUP BY cohort_term_code,/* new_student_type_desc,*/ student_full_part_time
					
					ORDER BY /*"Student Type",*/  "Cohort Type", cohort_term_code, "Student_FT_PT") total on total.cohort_term_code = tb1.snapshot_term_code
					
					
left join 
(					SELECT 
					cohort_term_code
					, new_student_type_desc AS "Student Type"
					--, '3.Ethnicity/Race: '|| stdnt_race_ipeds AS "Cohort Type"
					--, student_full_part_time AS "Student_FT_PT"
					, COUNT (student_cid) AS cohort_size_original
					, COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS cohort_size_adj_1
					, COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS cohort_size_adj_6
					, COUNT (CASE WHEN (exclude_8 = '0') THEN student_cid END) AS cohort_size_adj_8
					
					, COUNT(CASE WHEN enrl_term_5 = '1'  and grad_term_4 = '0'  THEN student_cid END) AS "# minorityReturning to Yr2"
					, concat((ROUND(CAST(COUNT(CASE WHEN enrl_term_5 = '1'  and grad_term_4 = '0'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4))*100,'%') AS "% minorityReturning to Yr2"
					, COUNT(CASE WHEN grad_term_4 = '0' AND grad_term_8 = '1'  THEN student_cid END) AS "# minorityGraduating in 2Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_4 = '0' AND grad_term_8 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% minorityGraduating in Yr2"
					

					, COUNT(CASE WHEN grad_term_8 = '0' AND grad_term_12 = '1'  THEN student_cid END) AS "# minorityGraduating in 3Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_8 = '0' AND grad_term_12 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% minorityGraduating in Yr3"
					

					, COUNT(CASE WHEN grad_term_12 = '0' AND grad_term_16 = '1'  THEN student_cid END) AS "# minorityGraduating in 4Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_12 = '0' AND grad_term_16 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% minorityGraduating in Yr4"
					

					, COUNT(CASE WHEN grad_term_16 = '0' AND grad_term_20 = '1'  THEN student_cid END) AS "# minorityGraduating in 5Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_16 = '0' AND grad_term_20 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% minorityGraduating in Yr5"
					
					

					, COUNT(CASE WHEN grad_term_20 = '0' AND grad_term_24 = '1'  THEN student_cid END) AS "# minorityGraduating in 6Yrs"
					, ROUND(CAST(COUNT(CASE WHEN grad_term_20 = '0' AND grad_term_24 = '1'  THEN student_cid END) AS FLOAT) / CAST(COUNT (student_cid) AS FLOAT), 4) AS "% minorityGraduating in Yr6"
									
					
					
					FROM unc.uncw.da_gradret
					WHERE cohort_term_code LIKE '%6'
					AND student_full_part_time in ('F')
					AND new_student_type IN('F')
					AND grad_retn_from = '1'
					and stdnt_race_ipeds in ('American Ind or Alaska Nat', 'Asian', 'Black or African American', 'Hispanic or Latino', 'Native Hawaiian or Pacific I', 'Two or More Races')
					
					GROUP BY cohort_term_code, /*stdnt_race_ipeds,*/ new_student_type_desc/*, student_full_part_time*/
					
					ORDER BY "Student Type",  /*"Cohort Type",*/ cohort_term_code/*, "Student_FT_PT"*/
) minority on minority.cohort_term_code = tb1.snapshot_term_code
					
group by tb1.snapshot_term_code,  pell."% pellReturning to Yr2", total."% totalReturning to Yr2", minority."% minorityReturning to Yr2"
order by tb1.snapshot_term_code;

