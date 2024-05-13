Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE91EC25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 11:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B30210E645;
	Mon, 13 May 2024 11:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EHMJH3cK";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B595210E645
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 11:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOwApUTVvMhIzSzHZfIvOuKsRlN1tCkDPgX/ftEOGjr089+DtYeKWDlFtpUCInLnCrE/ahUa1sdy9ixxg7sWLRiHUWrjMaWiJwGIYxz5gkou1hkMXJ7iZvtzwcuCimx04Xtm0LREqZOzrcP6oxDPL9EGAqP+xzT019qdErPK6kR1flLv/kIG2vhLTHE3B7HZAzjDgC1tilGrYIYmYDoKiFwDZp8fphE+OkG8+455hRa8U+KimdU2hz8dwphb0kw6OHV2Vk+IlWYeaFIHKrE33+sV5KcZV3cgabrJa9/1IX7BvC5utkYBPf9AORqy+1ckIDgJR5kpqQIATLEwsY6A6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjR70ncWIUQ82dK1x/CaodQ0x0gNi/f2Dq6NG5rbB3M=;
 b=dt9FTnOXDtWIrs4WF/SZ8xYVLElsD+H/Ke/7xAH45qixHt4NhiUff+Q77rAsd3xwRGCVaKf4cKrAgHhV85xVvEZaJd+xn6xZwo5y+ns2vd1pJi4kf5PKbBFAzqQ4bDI0fMLAzOVg02YlMv22QikiS8+R4D8UlFZSMrOP3xtRlHbrNluVNZZAtTv97TEQYHc3/WxpTiX492XYLSikyX1YwqnBDs3guNFJ3LvbOkCW+kBffhN0pjnv+YNXPODKKmb8SIZpDRF4cy9Y2QqaZZOtcX2wrBUVtNcIU0vD83ctfwshfFE/gUQcMqX8MBGhIRhCoHAXPFwFLUmqtuC7qQpmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjR70ncWIUQ82dK1x/CaodQ0x0gNi/f2Dq6NG5rbB3M=;
 b=EHMJH3cKOS2q6+8BvOmuUsplHDzI2vp1EoBDMHxVxMt6YkD7kd0XHG0AhIK0g/RMdU6183ZAqVmZFP1S1/2HamN8PosXhpiEVM1O6h5bDwvPa0GSzyvTmmSrLQOf9CAnKI+zo31AW+HJIEJd0dG9h9wzBlEX7BGs8h4Nj+2/aCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:04:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:04:55 +0000
Message-ID: <6cfbe700-8ef4-4ff8-95c0-ae40d9796a36@amd.com>
Date: Mon, 13 May 2024 16:34:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] drm/amd/pm: check specific index for smu13
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-9-jesse.zhang@amd.com>
 <bab7e769-0c47-49b3-b406-fd20f54ccfc4@amd.com>
Content-Language: en-US
In-Reply-To: <bab7e769-0c47-49b3-b406-fd20f54ccfc4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3b8cb5-2bf7-4237-4536-08dc733c8548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjliYWhZZGRYRlRtNkcxb3RSdTYxbzkyQjM1R2hkNDlrWkhPRCtwNVdjM0U1?=
 =?utf-8?B?dEVJQy9zbkROVXpybDRxRXB1YVAyVWJuYld2MEF2Rm8vQjgybEZDRE03c1lD?=
 =?utf-8?B?R3oyZWlwa0p2TXVaenpnQTZTZHhWOS8rcW5BcEtHcG5hNzVRcVhnYmZDcmls?=
 =?utf-8?B?ZlpBZUNkWGJFT29xc0xxQlJzWW9VM1hNVGdDV09XbGUzZXNzQnBOYUdYS0xN?=
 =?utf-8?B?c0tLaThJK0kwRXFDbEZEelpvOEtvbWdVSU1ibEMyTXZvVzk1T1p1OWNVRGZR?=
 =?utf-8?B?WVQyNTdNL2RiazVrMHFvOTd6S0VKd09HdVE3N2U5ZXNZYmdMeWFSWW9NVXE5?=
 =?utf-8?B?YVUrYkFkajJTcHhlbDltOWtzdmU5NldnSkZJWTdjSVRDWnpPc0pBNVAvV24y?=
 =?utf-8?B?N0hKeFB0UDZJV1l6bVpZaDVqOEQ4TWRSbk50bW1kZGxnWXJuM0ZpbDd6T1Ri?=
 =?utf-8?B?L25ldGNuamJ1eDVzWjRHL1doaHNaUmlUK0Jzc1paOHVIdGovNGdlTUF4Zi9j?=
 =?utf-8?B?VWZiTmFaaDFldDc3YnZ3enJhZ1ZZMDJ0WlpzTEQ4WjVwYlJrQ0c2dkIvRTUx?=
 =?utf-8?B?cWl5S25aaHhoYXBlTjZ6dDFmTXhZZEdUQWlsMjUxM2Ryc0FTdmxsd0FCQnYv?=
 =?utf-8?B?Mi81ZFZjeDVYMkNtL1o0amxLeTRTY256dWhlVEpTd3pHUjlIa1FQWTRwRDY4?=
 =?utf-8?B?Ym9hbkR1bmFQZGluYnFGL0J6MkJlbGloOXNTNjBzRUJKbVFnUUZuRHNxUyt6?=
 =?utf-8?B?SFo0NWVFSDY5WndCWDVFcjdYcHNZbjdIM1A3OUV1Ui9NQTFNY1RGR09tcEp5?=
 =?utf-8?B?KzRrSGxFcExPbWxNd2Y4V0hwRzJvM0hlN2lGa2pUN0RscEhmeit0VTRHS3Mw?=
 =?utf-8?B?dUN4T04xSjVXTFR2UlZqc1V5TTJnK3lDdWYyZ0FERm5BQTg3VStBVzM1M2hB?=
 =?utf-8?B?NHExWkVQWjhDUis1MU9SM01mUFplUGZkSEJFSjJ5T2FmWHpaNFl1OUZ0elJB?=
 =?utf-8?B?SjkwYTZ1TWF6S2NOOERMakxhZzArampoT0xXZm9PdFhCVHB5cnV6dTBlWTBx?=
 =?utf-8?B?bjFXeThsdWxxMW5EK0NJeXpGaHBwRlpMN2Rnck1vdlJPK0hydXJHbGJjT3lW?=
 =?utf-8?B?dzhyRVloczhILytNbjB0WEtDZGdvWjhmZGpyeE5YbEQ3NloxVk85c3NVWjhT?=
 =?utf-8?B?dEdkRHhQekdxTSttYzJrQXpGWFlVQnZ3ejBaNkJ5VEtTdlBkc0lEc0JvcE1x?=
 =?utf-8?B?MkhrSGtocDRjTHBmTmw3MzVFTDkwUFl4cXJYczFwV01rRE1YanVmTUl2UDBL?=
 =?utf-8?B?V0hoN25CaldWRUxJb2JPSjEzZ05KaTk3cmxBbDFNMElJTjBpVjc4UElaUi92?=
 =?utf-8?B?YzYzQmhWYmVVYXRGSU14MndqbVFLb1F5VThqbnZwNGJ5NUhVdTNQVlNJSHMw?=
 =?utf-8?B?QzBMNnEwVjdFZHJ5RnpsQzJGUEJaS2thYnNTbDFCdDd1S0tJTVpTVmZ6YTZI?=
 =?utf-8?B?dDFCMXhWQUFGakFXQklaUCtYYU9WRTQwUTFOT2lFbWpuWWJYcnpKL2c4UExU?=
 =?utf-8?B?bjdud0lyVnpRRFZBakhFQUdaRHRFWHdWdjlaUkRBMllYTEQxZmZpMEVDUTBy?=
 =?utf-8?B?bVNaYWhjSWx6NU5PZXBvajhXTmJyaUJFY3R6MkJ3ZW1QMGpxcmtxWVhiOU42?=
 =?utf-8?B?bUxsY0MwNEs3OG5Jc1hoTHFCa1VOWHRJVHdUMENJV0ppL3RCM1ZKS1lnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHppdFp6bFJzdlFFTG8rOFBUL2lOMjl6ODF4WTJ2Nmp4VU8wMEVpbzhhYXJB?=
 =?utf-8?B?V3VHRDVDRUg2R1hoMWk3L3J6OFRFYWdsR3J1M3ErNmZpeEYyK3IwZWlsN1ZT?=
 =?utf-8?B?MnVuQXhrd0EvdFVnRzFyS0lsZVZ1NkFTVFJ6TlVyWlV2anYxYVB1UUM5SXRK?=
 =?utf-8?B?UmowakhBbE05U1Z1Y3cxZTlxcUNMNWlqN0dJR1d3elY2dksyd3p6aDdFcFNE?=
 =?utf-8?B?aXprb0Y4SzU4LysvL3RFb1FVYXdDYm82RE5ORkN3dnh5Y0lBT1NYSkhnOVpu?=
 =?utf-8?B?djBsdjY1TURiR2F0TWh5TlNzTHBnWkN6QiszWTArR2E4dlA1Y2pQaG5tOWFK?=
 =?utf-8?B?N2MzN3FQOUd3azFJT1VzOURGK2VqT2RFVFdVWGhtT3Q2NmVSNjFOS0JTRmlZ?=
 =?utf-8?B?YWMwZndhYnR4RGRmellVMzFYcWxIMFpId0llZ0J3aUh6c2R1ZzRERU95VjF6?=
 =?utf-8?B?K1l1a3BRaW5rczBJSHRMbXVvQitUTGdYVG1FUE5hczQ5VXR3NVFsU2QyTldm?=
 =?utf-8?B?R0VpOS9vdDVadUFXVUh2ZHFMZmVlN2JIWGpBU2dyYTI1enMzdzQ1c1dCT1JH?=
 =?utf-8?B?dTh3bm5aTkE3US84dE5XTWFZb2NCU1ZHRVE2Y0FOVnUrQWx0UHo2azI2UzVM?=
 =?utf-8?B?Rmd4REg5WTlQMkJsdVY3cGdKRE43aHBWNWFaOWpYTlJBV0tkTnVGbWlIRUZu?=
 =?utf-8?B?ZVFRcElRNUp4UmF6dXRob0hGaU53MGRhNkYyb2Q1aTBTcnZpZFdDaVBWRFRs?=
 =?utf-8?B?TEF0TGJtcGJFbUNMN2dneXZTcnNxbDQyaHZ5YlRob0V4RkhZYUpHd0dMdTR1?=
 =?utf-8?B?L1pzeU9kK0xyVmhWbTZ1eHVYV0J1R3pZSjRDZ0U2QnFKUzRTWElZOCs2TW94?=
 =?utf-8?B?eEdIMlR1TmQxSXdJeEVtU3JrYWI5Z1M5dUZBeEdnRndJV1VCSkxwMUJvZjJU?=
 =?utf-8?B?NzZNeEF6YVNaYkhEOWhBYXF1djhqdVZzMEoyRzloNDQyd3E3Q1JjaUZvYXhJ?=
 =?utf-8?B?NFFiR2pLMVZoNEdnUXRlL2cxbDJQRzNUaVVxQTdGU3cvbXNtQ1IvRVUxRWNC?=
 =?utf-8?B?WStGNHBiNHk3RGRLb0tLYlhBNTFrUkZrcjJsQ2krRm85SElQNUEwWHRielBr?=
 =?utf-8?B?eExQanVkSFMzVzRtMzNITWExYXo5MmxaTmNVSFl5QmJibmU4NklKY1J2TnVH?=
 =?utf-8?B?dXZqaDJqTFBkSVJrQ1JTRVJ2eTNucm9XdW5BRDdRVkc5TGVSRlF6cDhmbHd2?=
 =?utf-8?B?dy84K2xPS0txNlcvZm9WeE5wVnRWempUazZLdW94MGpHVUY2ZW04NW5YSGR0?=
 =?utf-8?B?YzNmNVZBV2gwWGhXUWt6cGNFT1lmV1N3NENjMGJ5WDVpcldDc1dpeWRpTDNV?=
 =?utf-8?B?ZWFFelBDYVlsOWNQektRZVBpL1J1TnRIOEovNUN0UjA2U3MvSW0zejBHSFg3?=
 =?utf-8?B?ZW5MYSt5SlhvY2lCcU9XUmVVb0F6RHBPbFB2ZzZ5Vi9lTE1NVjdHRGJHU2th?=
 =?utf-8?B?ZGF1dktmTHdGc2l0TVlOU1lWdk5obHhKTU1ucWZ6MUtQdGgvNlhwTTkxc3N6?=
 =?utf-8?B?aFNRQ0gzMW55dXUza2U2ZEtRZlVhYzVQNUVCTlUyZmQyeW9ZWUNsdGNrUmJJ?=
 =?utf-8?B?bnAybk1kUnNMRDdaZzZtMXZ4c2ZzM1N4V292Wm16YXRRajc5SXlNenlBWFZT?=
 =?utf-8?B?bmVhQnZPWjZidk1BalJxWk9SVWlJWWtwM00zcnVFNEVNcWN2bnB3ZlJpTjJQ?=
 =?utf-8?B?YnJtUitmM2V1OGxyOW9BcVE4ZnhmOUFJYnNEVWVPaEdNTlVJbEVoRzIxb09w?=
 =?utf-8?B?KzFKekdiUmNvaUlVZS9CL0htZ00rVVJyRFFsT01HRGthMUxmU1dNQ0RLdTVH?=
 =?utf-8?B?N0h1M1NHY2pDU0h2eVlwNktva0h2YldaYzZ1bjFEdkQ3YWVHblBjMlpkMVlk?=
 =?utf-8?B?bFViUERUVGE2VU00RW5STGxDTy9HbFZTcGU1Y1FncldkM1M3VDNEbXFzOFcw?=
 =?utf-8?B?TlBCU3BVZUVhampkZHpqT3lVamZNUDhZeXZXNGxJTWhwVmRHRlBIRWhXZW9Y?=
 =?utf-8?B?NzdBQmQwdHZhZXNUQmcrNGpkMkRzQkhFTThTbWZ2SlZDc3dQT2R6RHRFdHk5?=
 =?utf-8?Q?Dk4ip0A3F/OWvJ64bN3XEcRy0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3b8cb5-2bf7-4237-4536-08dc733c8548
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:04:55.4489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRS5M58TTqf5SkjQq2cW+KtLQca/pLM9HwQ4Gmk2F+n9RVyicsZg7FRPZ6f8rxKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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



On 5/13/2024 4:27 PM, Lazar, Lijo wrote:
> 
> 
> On 5/10/2024 8:20 AM, Jesse Zhang wrote:
>> Check for specific indexes that may be invalid values.
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 051092f1b1b4..7c343dd12a7f 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -2336,6 +2336,8 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
>>  
>>  	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
>>  					       SMU_MSG_GfxDeviceDriverReset);
>> +	if (index < 0)
>> +		ret = -EINVAL;
>>  
> 
> This check is unnecessary. This is IP specific logic and the index is
> expected to exist.
> 

If you are seeing a warning problem because of this, drop index and use
PPSMC_MSG_GfxDriverReset directly.

Thanks,
Lijo

> See this entry in smu_v13_0_6_message_map
> 
> MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,
>                SMU_MSG_RAS_PRI),
> >
> Thanks,
> Lijo
> 
>>  	mutex_lock(&smu->message_lock);
>>  
