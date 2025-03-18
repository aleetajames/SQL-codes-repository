select snapshot_term_code,
major_1_inst ,
sum (total_cred_hrs_in_term ) as total_credit_hrs_inTerm,
count (student_cid) as total_students,
round (total_credit_hrs_inTerm/total_students,4) as average_sch
from sdm_career_mv scm 
where snapshot_term_code in ('20196','20206','20216','20226')
and snapshot_type_code ='1'
and exclude_from_ipeds_flag = 'N'
and primary_career_flag = 'Y'
and career_code = 'U'
--and enrollment_status_code_ipeds in ('1')
and major_1_inst IN ('Biology','Marine Biology','Pre-Biology','Pre-Marine Biology','UC-Biology','UC-Marine Biology')
--and major_1_code_inst in ('1ABI','1AMB','MBIO','BIO','MBY')
group by snapshot_term_code
, major_1_inst
order by snapshot_term_code