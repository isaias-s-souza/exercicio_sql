-- DROP SCHEMA language_school_ticoop_test;
USE language_school_ticoop_test;

-- 1. Vanessa não sabe quais os alunos que mais gastam na escola.
SELECT 	expanses.id,
	expanses.name,
	SUM(expanses.total_price)
   	FROM (
	SELECT 	student.id,
			student.name,
			SUM(contract.total_price) total_price
		FROM students
		INNER JOIN contract_student ON student.id = contract_student.student_id
        INNER JOIN contract ON contract_student.contract_id = contract.id
	GROUP BY 	student.id,
				student.name
	UNION ALL
    SELECT	student.id,
			student.name,
            SUM(sale.total_price)
		FROM student
        INNER JOIN sale ON student.id = sale.student_id
	GROUP BY	student.id,
				student.name
) expanses
GROUP BY 	expanses.id,
			expanses.name
ORDER BY 3 DESC LIMIT 10;

-- 2. Vanessa não sabe quais são os idiomas mais vendidos (inglês, espanhol, italiano, etc).
SELECT 		language.id,
			language.name,
            COUNT(1) as language_amount
		FROM student
		INNER JOIN contract_student ON student.id = contract_student.student_id
        INNER JOIN contract ON contract_student.contract_id = contract.id
        INNER JOIN study_plan ON contract.study_plan_id = study_plan.id
        INNER JOIN language ON study_plan.language_id = language.id
        INNER JOIN status ON contract.status_id = status.id
        WHERE status.description <> 'canceled'
GROUP BY	language.id,
			language.name
ORDER BY 3 DESC LIMIT 5;

-- 3. Vanessa não sabe quantos alunos estão cursando cada idioma.
SELECT 		language.id,
			language.name,
            COUNT(1) as language_amount_student
		FROM student
		INNER JOIN contract_student ON student.id = contract_student.student_id
        INNER JOIN contract ON contract_student.contract_id = contract.id
        INNER JOIN study_plan ON contract.study_plan_id = study_plan.id
        INNER JOIN language ON study_plan.language_id = language.id
        INNER JOIN status ON contract.status_id = status.id
        WHERE 	contract.end_of_contract IS NOT NULL AND 
				contract.end_of_contract <= CURRENT_DATE() AND
                status.description <> 'canceled'
GROUP BY	language.id,
			language.name
ORDER BY language.name;

-- 4. Vanessa não sabe quanto ela fatura com a venda de cursos de idiomas na sua escola.
SELECT		SUM(contract.total_price) as sum_course_sales
		FROM student
		INNER JOIN contract_student ON student.id = contract_student.student_id
        INNER JOIN contract ON contract_student.contract_id = contract.id
        INNER JOIN status ON contract.status_id = status.id
WHERE 	status.description <> 'canceled';
