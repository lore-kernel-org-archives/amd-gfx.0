Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F285E98FB3
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 06:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E309410E11D;
	Thu,  9 Apr 2026 06:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5J4NQR3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EE010E11D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 06:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrTeVGv23WYVsHBDFdyC5rb2uJVLtYpdnW47dCPjQ/qWR/VtVx4fWuNsuKxnU1ZVY9MDCNik0HQg02MA+NO6+ZMlHO2exGBSh11rWYwZ/cXMKnf9B9Nm7wr0zH1Wy+Gxkny7tpy20IPAFnas0oT8MjjO1m7UzCqXTDyWyTphheEUobERb1/d75+DQYvHp1YJuRzmyjM1R8zD7KKxD8U/nJw+cff1VJGUqNMdA483ntjosF90UFyTx6kCKNUC+NFwG05A6v6fRwRhvNndotx68VnlLrE2GpGv+W+gQ/PsPG3DKDKarfzKGT5UY7G0Z2T1UP+tdP6N2/EBxj0PIEqY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls6MIpaw+9WyUwD9TsGiu6e7o7aHMRUmX0xWcibhzxw=;
 b=dFgiJFGFGk6D2LqSPYYe41BGf+dYmWWJGxsNuWPxBMhkpNrnhxvA4Xt7dtT2AvmcCDlJpfDv0GRhnn2btrmL3YrdGAkY8wC5D9Z4Npb/gpLsyrtm7T4/cfE9vY6hh6OLJP8w+nxiRjwZG870nkocEhRQjExDXNLgON5DwLiQMT70BG+iBxIxhpCkK9OtXOwcrBI4k6LxMfgScPaaWBhytEyUKs+gDkhgvKw7Qwazrvs0ZjAfmEYMEDf3al6up1/Me4zfc4JXFkhjmoqO+of6QzfJ0TXOUi6EydQJTx/NLZs55Vzkztx+tk8RN9qRGKFRAj4A2kh/6ianpBhflEQw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls6MIpaw+9WyUwD9TsGiu6e7o7aHMRUmX0xWcibhzxw=;
 b=M5J4NQR3If1a76tvDN2kwVwuImgPlnfQQT+mTmrOfU3wWoFIUj7DTYnbt3FGQNirfo58IMk60EQxQpp5Bk/SXO/lny7JftrxjI0rLiqlicj3ffXk//MYo4+3VpJkavvQSimWaBY8xHVspTgAFSvzsk47Ai2ec6iWsuNkuD5Yo4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 06:08:25 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 06:08:24 +0000
Message-ID: <29fadbf6-6d2b-4a40-a5d1-ac2ffc0a933e@amd.com>
Date: Thu, 9 Apr 2026 11:38:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Align PPTable fill with non-Q10 static metrics
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260408134248.323350-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260408134248.323350-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::20) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb02771-2a1d-4b9d-bb12-08de95fe689a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: nYUrlrdWGrklomwzfs0IikIgekCPxX/wkoitbeRsv1m0dye61570VSpUSbPc8CQ+b8TA8JiV3bWj0I3UzS37wGK/PTJv7QGNMOho0BccFyafR/Sb88p1xfPzULwhXgzw+ViykGav3TEy86JWXVVgguyIhyXeAxx+pLEUkisq7UCK7z2/Eai4zUlgeW90mROhZpkHmcOWX9JPpCYznC5p8ybhMcOO4Z0DxXkTqXRfsTO9BLdyudy95vf0DR+3+s4Dd1YwN1CCAWOodCUUkjOe+iVXGyICn59QdQwImJd/hJNAzp4QCv6LoMSb5EFyOkPYoIiwdbiKYUL01BjHvsbgTeZg1ARHpmclenY2ELODf0Ou92rrSLHQcdxFkL5LMcxbPmA5HB7cKAkAopWloljzRF30WSl0Aih+g/OS1cTM5pK4nJIHtHFJA4RCArumlLTMh9qyR4Tx6//JECnxruLoqURS/kjtrQ56lCdz2P3+yfVByxutIuTNhSfMRqSgDdwlkSa1n9x9vteQTRN2mwofE0xokk/126wGGUH2rFnWdbbqE02q5C9+Sddym4RzzDd0M9unbKND4INGJiGDEOxkKsoQyHyWyiBcu9e8Q/A+Sr9KwkcViL00p55DJVmmkDowwzp9/ChjgcV1iI3/cTlCWTv/yrC8uDmxe6fPEDf09EPy0gJuEX6+J+9fC6YyyjcouwNrO2wjSGeWRWNizky+lir8GklG8uVw4yLI4OwI9e8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2xaMTdROGVFeC81V21lYjVWN1NaRmovWUV1b3JRNG1sSVBYSENya3dkUWZz?=
 =?utf-8?B?RUVWRjFqNEE3NjF4K3ZZN1RFMGJ5aFptWHpBRXYwOTZVNFQveXZaTzBSNHEy?=
 =?utf-8?B?eU9LYlY0V3crVyszZmtsNzBoUFRiSndkN1l4cEZ0dE1rdTlmVmFSMmZyUXpZ?=
 =?utf-8?B?UVRyMllUbFJGMG1wbkRJeUdEbktMTm04bDhEcndzQ2YxOWhnZXZ1NjJ2T04v?=
 =?utf-8?B?WnR2MWhNV2MrV25ncjRSaUlyWUxpTzMrclhySS9LcndSaktEQXZhWE5FK1lC?=
 =?utf-8?B?NFJydmNxcC9MOXpmTCt3NWNnZWs1SXBvaEpNVGNCSlJNdTVOc1ZBRytJbXQ5?=
 =?utf-8?B?OWpCd05WSlRsMXhnVE90engrd2ZKLzM3SkR4eEpCUStadk9odWtkNVI2aVgz?=
 =?utf-8?B?MkhHRU9tKys3RGFvMkQvSnIzcTFtYzh2T3hmZVo1QTB2RG9aTFR3bzd6UHdl?=
 =?utf-8?B?QkpaV01ibkdCLzE5Q3BESklsbWdlVURYOGRMTGhHa2xScVExMFRRVnpSLzZN?=
 =?utf-8?B?TFY5VytEckRaWEsrdDBWQU1yNWMvak02VDFyS0thVUFieGNhRXNiZTA1cGxJ?=
 =?utf-8?B?VEFYOWRZMEh0OUFzRjhETHlLUjdhRnpxV2Ruem1JRFMxck9tQ0lWcVZaZGI1?=
 =?utf-8?B?TDRoSmJkdkYvV2hzRkV2RnFKRDY4QmZzdGE3dDRrU1BaMmx0SnJvdUFrc2VI?=
 =?utf-8?B?VTdSWFErRTNKRTFYcUJ2STFmZDZUNWw3Y2VtbWdCTW95QlBZcWlCdVpjVkFw?=
 =?utf-8?B?TEdZUldrdHBsT0U2NHpYWUdEcjJGWW5jOU02Zml1NHVIcGxnMzVrR3FaSFRr?=
 =?utf-8?B?WW9oWmhwdlRncmJWTW5DVmo0azZRNVkyS1NFdkk0Q2JsK3lLbmxRT1ppeUVs?=
 =?utf-8?B?bWIvWXQ0WFlkazgxQldnVC8zbmlFZVR6VU5HL0JVZURzS005SkVpR1ZIekls?=
 =?utf-8?B?bWtWZm9rbUxDT2RsZnpneDZ0dDUyU3ZEVElQTy9WellZYTl0Z1NuNktPejZS?=
 =?utf-8?B?OFJjeHFLSzlVU3R3TlM0aGJ3NCttMnJCNDJrakFSd05YQTZnYWh3aWhST2Rm?=
 =?utf-8?B?WVltOHBBQlNDT3JZY0NLL1UvWlpZK2dxNWdSNW9ubGh6RlFYemVpdEx5b3hz?=
 =?utf-8?B?ZWJDVzhIY0o2ZUl4Uzd0dVFnMWdsT04yYTdUd2NhUGZDUlBtRy9tQ1VoMStt?=
 =?utf-8?B?aVh0R3pqMU15OVBkVVozU0lHZUorRTEwYXZKdFQ4akl6S2MxNi9QSUlBTlIw?=
 =?utf-8?B?ZTA3MVMxQythQlZMT1BscUNKNjkvNStXYnlOVG1KS0QxYXdzZ3pUcTFQMFZu?=
 =?utf-8?B?NDF2K3ZuR0J2TEZJdjRGNmRGbElOc3c0alFRMmVxRlZsL1I5Z1QwVHorMVNi?=
 =?utf-8?B?UkxLNHcxSVhPSFMxSWxPeXhkNERWT3IzQVdDd090clo1S0tMaUpFMXFDNFQ2?=
 =?utf-8?B?QTRaVzhMSzVMK2pNbzljbzBCQzRmbjBZVkhlUHBNK1ZCUTRUZFpYZlU3Rnl6?=
 =?utf-8?B?T2VIWDBSM3Jwem9SbWhlMW9IemZaQ3RkNkJTYXhZdlQ5MlB5T1hPWlhHRXJ5?=
 =?utf-8?B?MW1rRVlzUGVFTTAwSFhNQTQ5ZXZ4SXoxSjltbjZUaDRIK2s2YStLSVhGeDBF?=
 =?utf-8?B?WjB2OWZEbENOcVlCVmRmbkR5Mm9mYmxreUR2SDk1TWtmWU5FZnF0MTZ2TDZu?=
 =?utf-8?B?TDBsVmhiOFFHZzFxU1hnb0ZQM29SRDIxN0tSRXZ6NHBKdVBlS3hkblRqemUy?=
 =?utf-8?B?SW5ybTJpTzdoZlcrUUlxNkJNd1hZWEMvZmJlVTVTOTNldWhONjNEOVVXRU5L?=
 =?utf-8?B?cDU2dDNFSzZBbmpBSjArTXlVRjIrQ2NHeWJPbGU5dHJtWVZmVEV1WGs5MTgy?=
 =?utf-8?B?LzdHejhJSzFIaWh5QzF6ME1xZjUxUlNtRTBROEtRVEJyOFQ5MlN3LzRBT2Jz?=
 =?utf-8?B?b0ZtTVBzQ1orODV1b1R3eFBrUmFvblJscG1LeGd5bElISHlod1JuUEkyUURq?=
 =?utf-8?B?Z0ZHK21rTXh4NksrVDNtVXc5OFIyVVpNajF4N1VkYWJ2UGYya0xUZzNacFc5?=
 =?utf-8?B?cWh4SEUwbHI3eTBkREloOFNEZi9jNTYyQ0lwbFNkUlM0UjF4ZTF3V2RmU0dw?=
 =?utf-8?B?dHJrbFFXaStpVHJmNWV0YndBUmhHSkl0bXN4NXFjK1RCOUZzL1ZTdzR3YXV1?=
 =?utf-8?B?SmJvYWRockplQUlmNTN1dWgvUUY0djIzOFB1ZkJEMXNNR2ZtK3UxbURjVWxa?=
 =?utf-8?B?RW9WaDFTMmhrNjBJYTRmSnpqZ3ZUUXpuNXR4cC8vVVozRnZ2SE00eUd4MmZv?=
 =?utf-8?B?L05SUUhZazNMQy9VUU1WRHlPU3hudFlUNjI4SHM2ZWJkKzlRbHVLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb02771-2a1d-4b9d-bb12-08de95fe689a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 06:08:24.6968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PImnR98cSOtShez15JU5T6rxwUS79SkDmYda31GJfxphVEyXvcPH4n8hVITEefOM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 08-Apr-26 7:12 PM, Asad Kamal wrote:
> Remove Q10 rounding when applying smu_v15_0_8 static metrics
> to the driver PPTable as the firmware now provide raw data
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 52 ++++++++-----------
>   1 file changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index b0faf57b0655..78bab657b139 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -1065,38 +1065,30 @@ static int smu_v15_0_8_set_driver_pptable(struct smu_context *smu)
>   		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
>   			table_version;
>   
> -		pptable->MaxSocketPowerLimit =
> -			SMUQ10_ROUND(static_metrics->MaxSocketPowerLimit);
> -		pptable->MaxGfxclkFrequency =
> -			SMUQ10_ROUND(static_metrics->MaxGfxclkFrequency);
> -		pptable->MinGfxclkFrequency =
> -			SMUQ10_ROUND(static_metrics->MinGfxclkFrequency);
> -		pptable->MaxFclkFrequency =
> -			SMUQ10_ROUND(static_metrics->MaxFclkFrequency);
> -		pptable->MinFclkFrequency =
> -			SMUQ10_ROUND(static_metrics->MinFclkFrequency);
> -		pptable->MaxGl2clkFrequency =
> -			SMUQ10_ROUND(static_metrics->MaxGl2clkFrequency);
> -		pptable->MinGl2clkFrequency =
> -			SMUQ10_ROUND(static_metrics->MinGl2clkFrequency);
> +		pptable->MaxSocketPowerLimit = static_metrics->MaxSocketPowerLimit;
> +		pptable->MaxGfxclkFrequency = static_metrics->MaxGfxclkFrequency;
> +		pptable->MinGfxclkFrequency = static_metrics->MinGfxclkFrequency;
> +		pptable->MaxFclkFrequency = static_metrics->MaxFclkFrequency;
> +		pptable->MinFclkFrequency = static_metrics->MinFclkFrequency;
> +		pptable->MaxGl2clkFrequency = static_metrics->MaxGl2clkFrequency;
> +		pptable->MinGl2clkFrequency = static_metrics->MinGl2clkFrequency;
>   
>   		for (i = 0; i < ARRAY_SIZE(static_metrics->UclkFrequencyTable); ++i)
> -			pptable->UclkFrequencyTable[i] =
> -				SMUQ10_ROUND(static_metrics->UclkFrequencyTable[i]);
> -
> -		pptable->SocclkFrequency = SMUQ10_ROUND(static_metrics->SocclkFrequency);
> -		pptable->LclkFrequency = SMUQ10_ROUND(static_metrics->LclkFrequency);
> -		pptable->VclkFrequency = SMUQ10_ROUND(static_metrics->VclkFrequency);
> -		pptable->DclkFrequency = SMUQ10_ROUND(static_metrics->DclkFrequency);
> -
> -		pptable->CTFLimitMID = SMUQ10_ROUND(static_metrics->CTFLimit_MID);
> -		pptable->CTFLimitAID = SMUQ10_ROUND(static_metrics->CTFLimit_AID);
> -		pptable->CTFLimitXCD = SMUQ10_ROUND(static_metrics->CTFLimit_XCD);
> -		pptable->CTFLimitHBM = SMUQ10_ROUND(static_metrics->CTFLimit_HBM);
> -		pptable->ThermalLimitMID = SMUQ10_ROUND(static_metrics->ThermalLimit_MID);
> -		pptable->ThermalLimitAID = SMUQ10_ROUND(static_metrics->ThermalLimit_AID);
> -		pptable->ThermalLimitXCD = SMUQ10_ROUND(static_metrics->ThermalLimit_XCD);
> -		pptable->ThermalLimitHBM = SMUQ10_ROUND(static_metrics->ThermalLimit_HBM);
> +			pptable->UclkFrequencyTable[i] = static_metrics->UclkFrequencyTable[i];
> +
> +		pptable->SocclkFrequency = static_metrics->SocclkFrequency;
> +		pptable->LclkFrequency = static_metrics->LclkFrequency;
> +		pptable->VclkFrequency = static_metrics->VclkFrequency;
> +		pptable->DclkFrequency = static_metrics->DclkFrequency;
> +
> +		pptable->CTFLimitMID = static_metrics->CTFLimit_MID;
> +		pptable->CTFLimitAID = static_metrics->CTFLimit_AID;
> +		pptable->CTFLimitXCD = static_metrics->CTFLimit_XCD;
> +		pptable->CTFLimitHBM = static_metrics->CTFLimit_HBM;
> +		pptable->ThermalLimitMID = static_metrics->ThermalLimit_MID;
> +		pptable->ThermalLimitAID = static_metrics->ThermalLimit_AID;
> +		pptable->ThermalLimitXCD = static_metrics->ThermalLimit_XCD;
> +		pptable->ThermalLimitHBM = static_metrics->ThermalLimit_HBM;
>   
>   		/* use MID0 serial number by default */
>   		pptable->PublicSerialNumberMID =

