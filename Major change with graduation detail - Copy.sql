SELECT  
         a.snapshot_term_code AS cohort_term_code
       , a.SNAPSHOT_TERM_CODE_CAMPUS AS cohort_term_code_campus
       , a.student_cid
       , a.student_pidm
       , a.enrollment_status_code_ipeds
       , a.enrollment_status_ipeds
       , a.class_level_inst
       , a.CUM_XFER_EARNED_HOURS
       , a.major_1_degree_code_inst


       , MAX(case when a.major_1_college_code in ('AS','XA') then 'CAS'
        when a.major_1_college_code in ('BA','XB') then 'CSB'
        when a.major_1_college_code in ('ED','XE') then 'WCE'
        when a.major_1_college_code in ('HH','XH') then 'CHHS'
        else a.major_1_college_code end) as F1_College
       , a.major_1_department as F1_School_Dept
       , a.major_1_inst as F1_Major

------- Fall 2
       , (CASE WHEN MAX(CASE WHEN t.term05 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) = 'Y' THEN 'Y'
               WHEN (MAX(CASE WHEN t.term05 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) IS NULL
                  AND MAX(CASE WHEN comp.B_Degree_First_Term <= t.term05 THEN 'G' ELSE NULL END) = 'G') THEN 'G'
          ELSE 'N'
          END) AS f2_status

       , MAX(CASE WHEN t.term05 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) F2_Retained
       , MAX(CASE WHEN t.term05 = enrl.snapshot_term_code THEN enrl.college ELSE NULL END) F2_College
       , MAX(CASE WHEN t.term05 = enrl.snapshot_term_code THEN enrl.school_dept ELSE NULL END) F2_School_Dept
       , MAX(CASE WHEN t.term05 = enrl.snapshot_term_code THEN enrl.major ELSE NULL END) F2_Major
------- Fall 3

       , (CASE WHEN MAX(CASE WHEN t.term09 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) = 'Y' THEN 'Y'
               WHEN (MAX(CASE WHEN t.term09 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) IS NULL
                  AND MAX(CASE WHEN comp.B_Degree_First_Term <= t.term09 THEN 'G' ELSE NULL END) = 'G') THEN 'G'
          ELSE 'N'
          END) AS f3_status

       , MAX(CASE WHEN t.term09 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) F3_Retained
       , MAX(CASE WHEN t.term09 = enrl.snapshot_term_code THEN enrl.college ELSE NULL END) F3_College
       , MAX(CASE WHEN t.term09 = enrl.snapshot_term_code THEN enrl.school_dept ELSE NULL END) F3_School_Dept
       , MAX(CASE WHEN t.term09 = enrl.snapshot_term_code THEN enrl.major ELSE NULL END) F3_Major
------- Fall 4

       , (CASE WHEN MAX(CASE WHEN t.term13 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) = 'Y' THEN 'Y'
               WHEN (MAX(CASE WHEN t.term13 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) IS NULL
                  AND MAX(CASE WHEN comp.B_Degree_First_Term <= t.term13 THEN 'G' ELSE NULL END) = 'G') THEN 'G'
          ELSE 'N'
          END) AS f4_status

       , MAX(CASE WHEN t.term13 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) F4_Retained
       , MAX(CASE WHEN t.term13 = enrl.snapshot_term_code THEN enrl.college ELSE NULL END) F4_College
       , MAX(CASE WHEN t.term13 = enrl.snapshot_term_code THEN enrl.school_dept ELSE NULL END) F4_School_Dept
       , MAX(CASE WHEN t.term13 = enrl.snapshot_term_code THEN enrl.major ELSE NULL END) F4_Major
------- Fall 5



       , (CASE WHEN MAX(CASE WHEN t.term17 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) = 'Y' THEN 'Y'
               WHEN (MAX(CASE WHEN t.term17 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) IS NULL
                  AND MAX(CASE WHEN comp.B_Degree_First_Term <= t.term17 THEN 'G' ELSE NULL END) = 'G') THEN 'G'
          ELSE 'N'
          END) AS f5_status

       , MAX(CASE WHEN t.term17 = enrl.snapshot_term_code THEN 'Y' ELSE NULL END) F5_Retained
       , MAX(CASE WHEN t.term17 = enrl.snapshot_term_code THEN enrl.college ELSE NULL END) F5_College
       , MAX(CASE WHEN t.term17 = enrl.snapshot_term_code THEN enrl.school_dept ELSE NULL END) F5_School_Dept
       , MAX(CASE WHEN t.term17 = enrl.snapshot_term_code THEN enrl.major ELSE NULL END) F5_Major

------- Completion
       , comp.B_Degree_First_Term
       , comp.B_Degree_First_Term_Major
       , comp.B_Degree_First_College
       , comp.B_Degree_First_School_Dept

 FROM uncw.sdm_career_mv a

------- Calculating Terms
INNER JOIN (
            SELECT DISTINCT
            a.term_code
            , CAST(CAST(a.term_code AS INTEGER) + 10 AS VARCHAR) AS term05 --Fall2
            , CAST(CAST(a.term_code AS INTEGER) + 20 AS VARCHAR) AS term09 --Fall3
            , CAST(CAST(a.term_code AS INTEGER) + 30 AS VARCHAR) AS term13 --Fall4
            , CAST(CAST(a.term_code AS INTEGER) + 40 AS VARCHAR) AS term17 --Fall5  
            , CAST(CAST(a.term_code_inst AS INTEGER) + 10 AS VARCHAR) AS term05_campus --Fall2
            , CAST(CAST(a.term_code_inst AS INTEGER) + 20 AS VARCHAR) AS term09_campus --Fall3
            , CAST(CAST(a.term_code_inst AS INTEGER) + 30 AS VARCHAR) AS term13_campus --Fall4
            , CAST(CAST(a.term_code_inst AS INTEGER) + 40 AS VARCHAR) AS term17_campus --Fall5  

            FROM uncw.sdm_term_mv a
            WHERE  a.term_type = 'Fall'
                AND a.term_code > '20156'
            ORDER BY a.term_code      
           
            ) t ON t.term_code = a.snapshot_term_code

-------- Term Enrollments
LEFT JOIN (
       SELECT
         a.snapshot_term_code
       , a.snapshot_term_code_campus
       , a.student_pidm
       , a.student_cid
       , (case  when a.major_1_college_code in ('AS','XA') then 'CAS'
                when a.major_1_college_code in ('BA','XB') then 'CSB'
                when a.major_1_college_code in ('ED','XE') then 'WCE'
                when a.major_1_college_code in ('HH','XH') then 'CHHS'
                else a.major_1_college_code end) as College
       , a.major_1_department as School_Dept
       , a.major_1_inst as Major

       FROM uncw.sdm_career_mv a
       WHERE  a.snapshot_term_type = 'Fall'
          AND a.snapshot_term_code > '20156'
          AND a.snapshot_type_code = '1'
          AND a.primary_career_flag = 'Y'
          AND a.career_code = 'U'
          ---AND a.deceased_flag IS NULL

          ) enrl ON enrl.student_cid = a.student_cid
                AND a.snapshot_term_code <> enrl.snapshot_term_code
                AND enrl.snapshot_term_code > a.snapshot_term_code

-------- Completions
LEFT JOIN (
        SELECT DISTINCT c.cohort_term_code, c.student_cid  
                , g.COMP_TERM_CODE_CAMPUS AS B_Degree_First_Term
                , g.program_plan_inst AS B_Degree_First_Term_Major
                , g.program_coll_code AS B_Degree_First_College                  
                , g.program_department  AS B_Degree_First_School_Dept
       
        FROM
                (
                SELECT DISTINCT a.snapshot_term_code AS cohort_term_code, a.student_cid , a.enrollment_status_code_ipeds
                FROM uncw.sdm_career_mv a
                WHERE a.snapshot_type_code = '1'
                AND enrollment_status_code_ipeds IN ('1', '5')
                AND primary_career_flag = 'Y'
                AND career_code = 'U'
                AND a.snapshot_term_code_campus = (SELECT MIN (a1.snapshot_term_code_campus)
                                            FROM uncw.sdm_career_mv a1
                                            WHERE a1.student_cid = a.student_cid
                                            AND a1.enrollment_status_code_ipeds IN ('1', '5')
                                            AND a1.snapshot_type_code = '1'
                                            --AND a.snapshot_term_code_campus > '201610'
                                            AND a1.primary_career_flag = 'Y'
                                            AND career_code = 'U'
                                            )
                ) c ,
       
                (
                SELECT DISTINCT
                  co.student_cid
                , co.COMP_TERM_CODE_CAMPUS --AS B_Degree_First_Term
                , co.program_plan_inst --AS B_Degree_First_Term_Major
                , (case when co.program_college_code in ('AS','XA') then 'CAS'
                        when co.program_college_code in ('BA','XB') then 'CSB'
                        when co.program_college_code in ('ED','XE') then 'WCE'
                        when co.program_college_code in ('HH','XH') then 'CHHS'
                    else co.program_college_code end) AS program_coll_code  --AS B_Degree_First_College
                   
                , co.program_department -- AS B_Degree_First_School_Dept
       
                 FROM uncw.sdm_completion_student_mv  co
                 WHERE  co.snapshot_type_code = '4'
                    AND co.student_first_major = 'Y'
                    and co.degree_award_flag = 'Y'
                    ) g

        WHERE  g.COMP_TERM_CODE_CAMPUS =(select Min(co1.COMP_TERM_CODE_CAMPUS)
                                           from uncw.sdm_completion_student_mv as co1
                                           where co1.snapshot_type_code = '4'
                                           and co1.degree_award_flag = 'Y'
                                           and co1.COMP_TERM_CODE_CAMPUS >= c.cohort_term_code
                                           and co1.student_cid = c.student_cid
                                           and co1.program_degree like 'B%'
                                        )
        AND c.student_cid = g.student_cid
   
        )comp ON comp.student_cid = a.student_cid
       
       
       
WHERE a.snapshot_term_type = 'Fall'
AND a.snapshot_term_code > '20156'
AND a.snapshot_type_code = '1'
AND a.exclude_from_ipeds_flag ='N'
AND a.enrollment_status_code_ipeds IN ('1', '5')
AND a.primary_career_flag = 'Y'
AND a.deceased_flag IS NULL

GROUP BY
         a.snapshot_term_code
       , a.SNAPSHOT_TERM_CODE_CAMPUS
       , a.student_cid
       , a.student_pidm
       , a.enrollment_status_code_ipeds
       , a.enrollment_status_ipeds
       , a.class_level_inst
       , a.CUM_XFER_EARNED_HOURS
       , a.major_1_degree_code_inst
       , a.major_1_department
       , a.major_1_inst
       , comp.B_Degree_First_Term      
       , comp.B_Degree_First_Term_Major
       , comp.B_Degree_First_College
       , comp.B_Degree_First_School_Dept
     
ORDER BY a.snapshot_term_code


