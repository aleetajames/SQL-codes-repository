SELECT distinct ca.student_cid 
,ca.student_gender_ipeds
--,ca.enrollment_status_ipeds AS "Student Type"
--,ca.snapshot_term_code
, (CASE WHEN co.student_cid IS NOT NULL THEN 'Y' ELSE 'N' END) AS retained_in_following_fall
, (CASE WHEN fa.student_cid IS NOT NULL THEN 'Y' ELSE 'N' END) AS fa_grant_fy_awarded
, (CASE WHEN fa.agi_official IS not NULL THEN fa.agi_official
	 when fa.parent_agi IS not NULL then fa.parent_agi 
	 when fa.student_agi IS not NULL then fa.student_agi Else Null END) AS family_income
,	fa.agi_official
,	fa.parent_agi
,	fa.student_agi
, ca.housing_indicator
, ca.residency
, ca.county_of_residence
, ca.stdnt_race_ipeds
, fa.first_generation_fafsa
, 	ca.fa_pell_offer_flag
,	ca.low_income_flag



FROM uncw.sdm_career_mv ca
left join (SELECT student_cid

FROM uncw.sdm_career_mv
WHERE snapshot_term_code ='20196'
and snapshot_type_code = '1'
and exclude_from_ipeds_flag = 'N'
and primary_career_flag = 'Y'
and career_code = 'U'
) co
on co.student_cid=ca.student_cid


LEFT JOIN

(SELECT DISTINCT finaid_year, student_cid, first_generation_fafsa, parent_agi, student_agi, agi_official
FROM uncw.sdm_finaid_yr_awrd_dtl_full_mv fa
WHERE snapshot_type_code = '7'
AND finaid_year = '1819'
AND award_type_code = 'G') fa ON
ca.student_cid = fa.student_cid

WHERE ca.snapshot_term_code = '20186'
and ca.snapshot_type_code = '1'
and ca.exclude_from_ipeds_flag = 'N'
and ca.primary_career_flag = 'Y'
and ca.career_code = 'U'
and ca.enrollment_status_code_ipeds in ('1')
--and ca.low_income_flag != ca.fa_pell_offer_flag **40 students**


