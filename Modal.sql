/********************************************************************************************
Created:      20221202

Created By:   Sunitha Manne

Purpose:      Spec for loading patients into M*Modal - 3M Health Information Systems require a CSV file of all the future outpatient appointments.

Location:     https://servicedesk.ubht.nhs.uk/WorkOrder.do?woMode=viewWO&woID=918411#details

Modified:

*******************************************************************************************/

USE HDM;

SELECT 
		'S13'						AS [Message Type],
		NULL						AS [Client id],
		P.PAS_ID					AS [MRN], 
		P.Title_DESC				AS [Patient Title],
		P.ForeName					AS [Patient Last Name],
		P.Surname					AS [Patient First Name],
		NULL						AS [Patient Middle Name],
		CONVERT(VARCHAR(10), P.BIRTH_DTTM, 112) AS [Date of Birth],
		SEX_NHSCODE					AS [Sex],
		REPLACE(P.NHS_Number,' ','')	AS [NHS Number],
		--P.TEST_PAT_FLAG		        AS [Visit/Encounter Number],
		F.APPT_DTTM					AS [Appointment Start Time],
		NULL						AS [Appointment End Time],
		H.ForeName					AS [Consultant First Name],
		H.Surname			        AS [Consultant Last Name],
		H.DIM_HCP_ID				AS [Consultant Doctor ID],
		Org.HCO_NAME			   	AS [GP First Name],
		NUll				    	AS [GP Last Name],
		ORG.Dim_HCO_ID				AS [GP Practice ID], 
		ORG.HCO_ADDRESS_LINE_1		AS [Street Address1],
		ORG.HCO_ADDRESS_LINE_2		AS [Street Address2],
		ORG.HCO_ADDRESS_LINE_3		AS City,
		ORG.HCO_ADDRESS_LINE_4      AS Province,
		ORG.HCO_POST_CODE			AS Postcode,
		Sess.SESSION_CLINIC_CODE	AS Clinic_Code,
		Sess.SESSION_NAME			AS [Clinic Name],	
		SPEC_DIVISION_DESCRIPTION   AS Division
FROM HDM.dbo.FACT_OP_APPOINTMENTS AS F
JOIN HDM.dbo.DIM_PATIENT AS P ON F.DIM_PATIENT_ID = P.DIM_PATIENT_ID
JOIN HDM.dbo.DIM_HC_PROFESSIONAL AS H ON F.DIM_HCP_ID = H.DIM_HCP_ID
JOIN HDM.dbo.DIM_HC_ORGANISATION AS ORG ON F.DIM_PRAC_ID = ORG.Dim_HCO_ID
JOIN HDM.DBO.DIM_SPECIALTY AS S ON F.DIM_SPECT_ID = S.DIM_SPECIALTY_ID
JOIN HDM.dbo.DIM_OP_CLINIC_SESSIONS AS Sess ON F.DIM_SESS_ID = Sess.DIM_CLINIC_SESSN_ID  
WHERE P.TEST_PAT_FLAG = 'Y'