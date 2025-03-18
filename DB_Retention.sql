select distinct ca.student_cid 
, ca.student_gender_ipeds
, ca.stdnt_race_ipeds
, ca.county_of_residence
, ca.student_perm_county
, ca.class_level_inst
, ca.housing_indicator
, ca.residency
, ca.snapshot_term_code
, ca.honors_flag
, ca.student_res_county_rural_ind/**-- earlier ca.rural_county_flag**/
, ca.first_generation_fafsa_code
, NVL((select distinct 'Y'
from uncw.sdm_finaid_yr_awrd_dtl_short_v as fn
where fn.snapshot_type_code in ('1','4','7')
/**-----'7' = Finaidsnapshot, '1'=census, '4'=postgrade**/
and fn.award_term_code_inst in ('201710','201720','201760','201810','201820','201860','201910','201920','201960','202010','202020','202060','202110','202120','202160')
and fn.award_code = 'FA'
and fn.amount_paid > 0
and fn.student_pidm = ca.student_pidm), 'N') as fa_pell_offer_flag
/**-- fa. award_term_code**/
, CAST( (CAST (ca.snapshot_term_code as float) + 10 ) as varchar) as next_fall
, (CASE WHEN co.student_cid IS NULL THEN 'N' ELSE 'Y' END) AS retained_in_following_fall

FROM uncw.sdm_career_mv ca
left join 

(SELECT student_cid, snapshot_term_code, career_code

FROM uncw.sdm_career_mv
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

 LEFT JOIN

(SELECT DISTINCT finaid_year, student_cid, first_generation_fafsa, award_term_code
FROM uncw.sdm_finaid_yr_awrd_dtl_full_mv fa
WHERE snapshot_type_code = '7'
) fa ON
ca.student_cid = fa.student_cid
and ca.snapshot_term_code  =CONCAT( CONCAT('20',SUBSTRING(fa.finaid_year,1,2)), '6')

WHERE 
 ca.snapshot_type_code = '1'
and snapshot_term_type ='Fall'
and ca.exclude_from_ipeds_flag = 'N'
and ca.primary_career_flag = 'Y'
and ca.career_code = 'U'
and ca.enrollment_status_code_ipeds in ('1')

