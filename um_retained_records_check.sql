SELECT 
	itsci2.hrid,
	itsci3.hrid,
	itsci2.statistical_code_ids,
	hrtsci.statistical_code_ids,
	itsci3.statistical_code_ids,
	iti.identifiers__value,
	iti.identifiers__identifier_type_id,
	it.metadata__created_date::date,
	it.metadata__updated_date::date
FROM 
	inventory.item__t__statistical_code_ids itsci2 
	LEFT JOIN inventory.holdings_record__t__statistical_code_ids hrtsci ON hrtsci.id = itsci2.holdings_record_id 
	LEFT JOIN inventory.instance__t__statistical_code_ids itsci3 ON itsci3.id = hrtsci.instance_id 
	LEFT JOIN inventory.instance__t it ON it.id = itsci3.id
	LEFT JOIN inventory.instance__t__identifiers iti ON iti.id = it.id
WHERE 
	(itsci2.statistical_code_ids = '5ddb8219-c093-4106-af1c-ebd3d0c56c87'
OR 
	hrtsci.statistical_code_ids = '5ddb8219-c093-4106-af1c-ebd3d0c56c87'
OR 
	itsci3.statistical_code_ids = '5ddb8219-c093-4106-af1c-ebd3d0c56c87');
	