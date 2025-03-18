SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code1,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code1
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code

UNION ALL

SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code2,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code2
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code
union all

SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code3,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code3
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code
union all
SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code4,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code4
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code
union all

SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code5,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code5
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code

union all
SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code6,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code6
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code
 union all
 
 SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code7
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code

union all
SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code7,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code7
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code
union all
SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code8,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code8
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code
union all
SELECT cohort_term_code
, COUNT(student_pidm) AS cohort_size
, COUNT(cum_4yr) AS cum_4yr_ga_hc
, COUNT(cum_5yr) AS cum_5yr_ga_hc
, COUNT(cum_6yr) AS cum_6yr_ga_hc
, ROUND(CAST(COUNT(cum_4yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_4yr_ga_pc
, ROUND(CAST(COUNT(cum_5yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_5yr_ga_pc
, ROUND(CAST(COUNT(cum_6yr) AS FLOAT)/CAST(COUNT(student_pidm)AS FLOAT),4) AS cum_6yr_ga_pc
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 4), '8') as yr4
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 5), '8') as yr5
, CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 6), '8') as yr6


FROM(

			SELECT DISTINCT
			c.snapshot_term_code AS cohort_term_code
			, c.student_cid
			, c.student_pidm
			, (CASE WHEN cum_4_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_4yr
			, (CASE WHEN cum_5_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_5yr
			, (CASE WHEN cum_6_yr.pidm IS NULL THEN NULL ELSE 'Y' END) AS cum_6yr

			FROM uncw.sdm_career_admit_mv c


			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 4), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 4), '6')
					)cum_4_yr ON cum_4_yr.pidm = c.student_pidm
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 5), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 5), '6')
					)cum_5_yr ON cum_5_yr.pidm = c.student_pidm			

						
						
			Left join 
					(SELECT DISTINCT student_pidm AS pidm
					 FROM uncw.sdm_completion_student_mv
					 WHERE 	snapshot_type_code = '4'
					 	AND major_flag = 'Y' 
						AND student_first_major = 'Y'
						AND degree_award_flag = 'Y'
						AND degree_level_code = '3'
					 	AND snapshot_term_code <= CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 6), '8')
					 	AND snapshot_term_code != CONCAT((CAST(SUBSTRING($Enter_Cohort_SDM_Fall_Term_Code9,1,4) AS INTEGER) + 6), '6')
					)cum_6_yr ON cum_6_yr.pidm = c.student_pidm
					
					
			WHERE snapshot_term_code = $Enter_Cohort_SDM_Fall_Term_Code9
			AND snapshot_term_type = 'Fall'
			and snapshot_type_code = '1'
			and exclude_from_ipeds_flag = 'N'
			and primary_career_flag = 'Y'
			and career_code = 'U'
			and enrollment_status_code_ipeds in ('1')
	) GROUP BY cohort_term_code

