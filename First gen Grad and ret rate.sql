select distinct gr.student_cid
   
      , gr.cohort_term_code
   ,(case when fn.first_generation_fafsa_code in('Y','P') then 'Y' else 'N'end) as first_gen_calc
   ,(case  when gr.grad_term_16 = '1' then '4 yr'
        when gr.grad_term_20 = '1' and gr.grad_term_16 = '0' then '5 yr'
        when gr.grad_term_24 = '1' and gr.grad_term_20 = '0' then '6 yr'
        else 'Not graduated' end) as Graduated
--, (CASE WHEN enrl_term_5 = '1'  and grad_term_4 = '0'  THEN  '1' else 'Not retained to yr2' end) "Returning_to_Yr2"
        
from uncw.da_gradret gr 
left join uncw.sdm_finaid_yr_awrd_dtl_short_v as fn 
on fn.snapshot_term_code = gr.cohort_term_code 
and fn.student_cid = gr.student_cid 

where 
gr.cohort_term_code LIKE '20166'
AND gr.new_student_type = 'F'
and gr.grad_retn_from = '1'
and fn.finaid_year = '1617'
 and fn.snapshot_type_code = '7'

