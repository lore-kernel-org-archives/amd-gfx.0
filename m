Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6C5C5475B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 03:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CBB10F1D2;
	Thu,  7 Mar 2024 03:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mWVvsu2W";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC9510F1D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 03:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp8E0cjyI7JUv4Hp/zKZHOT2T9nvHPKxCCuvX4iAsrI+BwZdqt2+U7rLqapRJTXbHUxqtqx7No6xgKZrNtl+QR9x7XEd1N3g+6KRYibmmFL/jaO1/lDy43dY1ZThh+5aJIo8Qn/hEHbhaSKZx+UkCEiszwUzBfUf1lLC1BAWUgxk2/AqMiaHVkSXp7sqOff1j6eodBXpO0e5ZzLRsK9cdDMI0VjaNkDAYJoM6LzFTyghuCgYTYwUPyrahiBEDp4J8IONfF8yOVLFu9Ndm9vvq8KWDLaByCBflSfH34WQM+kSjxc5qcPRXzOqVdAxv+3kICXLFhm07TMEIW7LZW2Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muCuRXabVx4QIwIMVD3OAqNkDrGaoxk/D9ba4RatUDc=;
 b=fiAUpsgubJySL3lz4TZxceTaA3h9KX/KSGPfDBI9MdxV+0RtMGgWBBqVs0P31Qm7BRBgvdOB9EI/Dku3lU4XhG1oRW06JbAVh9qVo2UlHt1lAhVQa75F32mVeUBMJVHfBZ5bsiei7JSdwr54V7UOEcgcVBOSEiRceHBc7luEKyEDWVYR2+9yjzwCQuQ6+Y/2Y5JG/4rl8QHd2u4aJ2PpE/WqmufZ49QPLNn1qW+kFr0OkTkUiKFthbJkfHEwfSaRDxXGxFnlG3tsrxwsIfB0BX/+WKRFCub/TlCZ+RLs4MaH76+moZslLZzaev5aiAh/f1PIDfBSfYbn1Jq0V1iYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muCuRXabVx4QIwIMVD3OAqNkDrGaoxk/D9ba4RatUDc=;
 b=mWVvsu2W04kYgB15P5F6m+jg5Qu6arawDgII0o3KEJSla2lWISBbE3VUcK9LYRjlCnH3CYEoG/EsfOOm/DJgx0/in1/IFAXh2yK1V3qcVPABUSwDzH4mYJxt03UaUyT218ytDXLuNK/UUjj1Y2SaIrV2mcpxE9GS/A8MZK6E+l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 03:32:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 03:32:27 +0000
Message-ID: <20dfca86-fe0a-45fa-b1b0-a9ace5d7090f@amd.com>
Date: Thu, 7 Mar 2024 09:02:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix NULL pointer dereference when set/get
 power limit
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com,
 Yin Zhenguo <zhenguo.yin@amd.com>
References: <20240306102615.2117462-1-Jun.Ma2@amd.com>
 <c4362e69-e540-4cd8-b680-539dba82f806@amd.com>
 <097c4133-47d0-40c9-b441-cdd38b746c77@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <097c4133-47d0-40c9-b441-cdd38b746c77@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 636854b8-dcb3-47de-dda5-08dc3e573656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3OZ7I7Vp09x9tvfEmoADwfyEjUTQQc5DmbKPxJCMCWJ6wO9irq/XniIVdO2HWEYoKnB23QOdEHGNZtGJ51mPJhRewgMJGdbUzTHFGmi+es7ttezGTig/0+hft3s9P4dq/w0X9hMo8hfiqi+uf1tC3KFWaP1s8gJgpTnFLANcjRjjPoRJDxuwgPXpyHszxNc0J6LIi6ZZ7n14RQGoceWWJHsQyHPWwlGm6n3zktjm/+JOtERjFevIvNuT+6QqBJVYx4RjlBbLwt+Vg+E6W1gGoBjYryha2yTkVpq7NiyCLh0C4koQYK0PNij7LEf9QssiAiNFlmMGxcsDQel6rhiBcdzRk/YtKaO/OgmGidtTghUyUIGdVtSUl+n8V/fSWrtHXLKe/6tKnNvVNeD/hun0fTJ8G2yKuRGpm/Vlq+kb85WNeVbS1PPFBB+ZNq9aEQAPpZ53L2asas68brcBcjlvYOEiA+To+pJfksAOU6W04jWxRVRfKlfCpB9tM+W43uHn7EkqjP8Yo5hFc7kzvtDlnpgPO/9s250P4mWkeBq7+9aH0fE1RD5BVoXnPnx073isCua3bE3zNKGmevOltXV59pCNcewpAJ8e90v7/+fUeuW82kX6Dafq//LK3BnPucs7ZmDmoJpDn28Dh2Ch4gHRj6PL+rsljhePqzvqdngACk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitScUhOTXJGUmpvckwxYlhKaDJTMmdnZ3dzWUM2THhNTGp2STFod2toa09W?=
 =?utf-8?B?MUdNODlIb24rOFp6SXFsZ2tpTWJiSjdZK0RLRVdsMDVJS0V0UEZhTGoybHdT?=
 =?utf-8?B?Q3lIYWZ1UnhoVVlDQlZKVTNoV1R0Sk5MSTNaM3MybWQvOFIzM2lLOHp0L3dQ?=
 =?utf-8?B?Mmx1aU8zeGdBZFFsem5NWWNuK3ZROW9LSVBRSTlraU96WEdaTk1WbzhpaFVm?=
 =?utf-8?B?bDJuT2hxekQ2M2MyMGZSMDVPNnE1OXA1ME9xRmMvVDFhMTZ4ZlNyVmhtSlpU?=
 =?utf-8?B?VG9MSHZMWVVQK0JUczgybVVtMmdGc2hBaTZUVFdzSVdMS3VRSnlrRlFTR1ph?=
 =?utf-8?B?eVRhcW5DZ0xmUVF3SWZzUVlPUjVHSzJUM2RDTGp5Wk1Qb05HS21JcWNuTHky?=
 =?utf-8?B?WGVaZXN5VlE3dzBQQ2x3Nzc2SzdzcUlIV2JITlhpb1gxK011VnVOUlNvb01y?=
 =?utf-8?B?d2lhM1N6aENxNzdEVEl2TFJXVmhqeU40eEtXVTU2dFFOd1E4UFBGSE51TUgv?=
 =?utf-8?B?bE51cFNpYjVXWkNEUnRMWGU3YmZTQWQ5Z25TZU9DaEZrQTVFVXlrNlhHYnh6?=
 =?utf-8?B?ZzRnVnROMzM5b3NjSFRnS0NYQXEzQ2cwSDR1L1FZQkgzSFdrY3g3KzZZZ3VY?=
 =?utf-8?B?aWVtUzYwMzh6cnBzczdZVWRIc1k5T240dDJtcmt1MUdDQWJ6c1dmeTRGZ0hl?=
 =?utf-8?B?LzR3a01TeTZJWEJoYUhyMnBRRlVQTkJ0NkZQSE56ajlkeHJEZDJ1dDZiRGF2?=
 =?utf-8?B?QXZubWFTdTV3TzFIc3hzUnVXa1RjKzlxVVdvdkZYOFBHUVVqMStTWHo5ZUQw?=
 =?utf-8?B?aWg2bTBXNUxYNTJ2eTQyZFd1N3ltNjRaVjRDUyt4TEU2Q3Z5NzV0eFBvbUpo?=
 =?utf-8?B?bUNEalhQQkZ6NE5ZazFBQVBUc3JlMGZsZHFlOHUyMTdEUjZaZmZQMXBCVGJI?=
 =?utf-8?B?bUR5cm1SczFsWHQrZ2lsallqaWg5aWRkTlN4dHZ0MHpqZVRlNWQ5MDV2OExP?=
 =?utf-8?B?Y2laK1VSeFlObHdmVmZwK3hHRmtML04vUmV3WFB3bElWQjdaVHZ4a25VTWJF?=
 =?utf-8?B?ZzRNVDVlS2ErdENXUEdRd0tyVUQ0ajEzT1N2YXhIalNBZUdDa01xUjRveWdU?=
 =?utf-8?B?a0lvaWhNTTdkbk1KWkJQMUR1TTd1Mnc5bkhWVDJGTVcwNERlKy9EZzdZcXlS?=
 =?utf-8?B?VHJYd01nVW1laFZMaG5tb3NvY1lBWFpVYjZTeldES3l0WDlmN0pjVzJhK0d4?=
 =?utf-8?B?eFRXWW4zQ0syMGJhbzNndHg1TlpNQ3d6RE5WZG1zNldkZThJY3ZxMWRMVGlh?=
 =?utf-8?B?WmFHeWlQWUxUZTFSa3IxRkFLTFZLelpxUGUrdDNYT3RpU1hFejVHY0RLVXY4?=
 =?utf-8?B?WHFEdXRiNXM2WjdEWk5xZXRuVysrK0I1MzYvVi93WGYxNm5yYlU1a1pvN3ky?=
 =?utf-8?B?djdIQWZIazQ5U3BCcUxncU5NYnRNUUM2S05qYS9LejFGQ2FoK21zNkg4WWhL?=
 =?utf-8?B?dnBBZGE4Y0tBNktWdzJXZHBISXJwMVhwcnRxa1dERk9JaDQzM2pDUkR6Wk92?=
 =?utf-8?B?b25Gc0FIWmZkQktLUW5PQk53UFpHQmJlZytSVUpVZE5sWE9NYVhTNGdBSmVK?=
 =?utf-8?B?MFlVWGZXTnRxS2lYQ01EN2xsSHBuNTFDcFFoUmUrbXd2TXNVZk1UMG5teThn?=
 =?utf-8?B?KzE1endXVTZ6MTA4TlVUYVIrKytLbjRQSHFtWTJlU1MvdFBwSUdxQlBrcTB5?=
 =?utf-8?B?Rk9FS0p2d0Y5dFlQNjgyZ0FrdkJDN2JqYzVVSHAyemV6d0JEaDFYMFdORmRU?=
 =?utf-8?B?RDdLcVFUblE5ZTU4eVIrUkd3R3dnRVEyMTh2a0pUT2Y2THRwTkIzRW9RZXBP?=
 =?utf-8?B?c1F4ZmU0bHlCbnVqbDR2blhia2pjM3plc2NKQUZ1R09EbXhFYUk2QkdLdlcr?=
 =?utf-8?B?bUN2NjlkMExOeHlGKzdESWhieE4zczUvWnZteFNjS0xaSDI0TGFCY2dMd2hs?=
 =?utf-8?B?cC9Kd0hMb1NUVUNpSmU4VXk1ZzhMclpRdG5SVndkbmdVYmQ2bkZoOWVLMUww?=
 =?utf-8?B?R2xaWTFtaThjT2tKam52aWZYQXJ3YUM4OUticVZwVVN5STBITXhKUGVUQmNw?=
 =?utf-8?Q?smtSmZVh8LSec16Z17smYul48?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636854b8-dcb3-47de-dda5-08dc3e573656
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 03:32:27.8173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4mgHdn6AQRuC3jVPDeNwisw0MlHKk8MhUcZOHjRxCoMWAM5lfhoQsWopPUEQKDA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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



On 3/7/2024 7:42 AM, Ma, Jun wrote:
> Hi Lijo,
> 
> On 3/6/2024 7:16 PM, Lazar, Lijo wrote:
>>
>>
>> On 3/6/2024 3:56 PM, Ma Jun wrote:
>>> Because powerplay_table initialization is skipped under
>>> sriov case, We set default lower and upper OD value to
>>> avoid NULL pointer issue.
>>
>> pp_od_clk_voltage is not enabled in SRIOV (except for GC 9.4.3 one VF
>> mode). Since the interface is not available for SRIOV, a better fix may
>> be to set smu->od_enabled itself to false for SRIOV.
>>
> This is not about pp_od_clk_voltage and od_enabled. This problem only occurs
> when getting power1_cap_* value, because we need to read the od_percent_lower
> value from poweplay_table.

od_enabled = false means there is no OD capability and then OD
lower/higher percentage should be zero. For SRIOV, this will be the case.

Instead you are putting some default values which doesn't necessarily
work for all SKUs (that's the reason they are part of powerplay table).

Thanks,
Lijo

> 
> Regards,
> Ma Jun
>> Thanks,
>> Lijo
>>
>>>
>>> Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
>>> ---
>>>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 15 ++++++++++-----
>>>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c  | 16 ++++++++++------
>>>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 15 ++++++++++-----
>>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 15 ++++++++++-----
>>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 15 ++++++++++-----
>>>  5 files changed, 50 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> index 1d96eb274d72..42c5e6b103e8 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> @@ -1303,12 +1303,17 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>>>  	if (default_power_limit)
>>>  		*default_power_limit = power_limit;
>>>  
>>> -	if (smu->od_enabled)
>>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>>> -	else
>>> -		od_percent_upper = 0;
>>> +	if (powerplay_table) {
>>> +		if (smu->od_enabled)
>>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>>> +		else
>>> +			od_percent_upper = 0;
>>>  
>>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>>> +	} else {
>>> +		od_percent_upper = 0;
>>> +		od_percent_lower = 10;
>>> +	}
>>>  
>>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>>  							od_percent_upper, od_percent_lower, power_limit);
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> index ed189a3878eb..6cc2e2d27a0d 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> @@ -2356,13 +2356,17 @@ static int navi10_get_power_limit(struct smu_context *smu,
>>>  	if (default_power_limit)
>>>  		*default_power_limit = power_limit;
>>>  
>>> -	if (smu->od_enabled &&
>>> -		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
>>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>>> -	else
>>> -		od_percent_upper = 0;
>>> +	if (powerplay_table) {
>>> +		if (smu->od_enabled && navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
>>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>>> +		else
>>> +			od_percent_upper = 0;
>>>  
>>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>>> +	} else {
>>> +		od_percent_upper = 0;
>>> +		od_percent_lower = 10;
>>> +	}
>>>  
>>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>>  					od_percent_upper, od_percent_lower, power_limit);
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> index e2ad2b972ab0..5daeac2e6239 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> @@ -640,12 +640,17 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>>>  	if (default_power_limit)
>>>  		*default_power_limit = power_limit;
>>>  
>>> -	if (smu->od_enabled)
>>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>>> -	else
>>> -		od_percent_upper = 0;
>>> +	if (powerplay_table) {
>>> +		if (smu->od_enabled)
>>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>>> +		else
>>> +			od_percent_upper = 0;
>>>  
>>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>>> +	} else {
>>> +		od_percent_upper = 0;
>>> +		od_percent_lower = 10;
>>> +	}
>>>  
>>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>>  					od_percent_upper, od_percent_lower, power_limit);
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> index 215f7c91ca73..271151c518e1 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> @@ -2369,12 +2369,17 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>>>  	if (default_power_limit)
>>>  		*default_power_limit = power_limit;
>>>  
>>> -	if (smu->od_enabled)
>>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>>> -	else
>>> -		od_percent_upper = 0;
>>> +	if (powerplay_table) {
>>> +		if (smu->od_enabled)
>>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>>> +		else
>>> +			od_percent_upper = 0;
>>>  
>>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>>> +	} else {
>>> +		od_percent_upper = 0;
>>> +		od_percent_lower = 10;
>>> +	}
>>>  
>>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>>  					od_percent_upper, od_percent_lower, power_limit);
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> index 3dc7b60cb075..533a3c1ba41e 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> @@ -2333,12 +2333,17 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>>>  	if (default_power_limit)
>>>  		*default_power_limit = power_limit;
>>>  
>>> -	if (smu->od_enabled)
>>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>>> -	else
>>> -		od_percent_upper = 0;
>>> +	if (powerplay_table) {
>>> +		if (smu->od_enabled)
>>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>>> +		else
>>> +			od_percent_upper = 0;
>>>  
>>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>>> +	} else {
>>> +		od_percent_upper = 0;
>>> +		od_percent_lower = 10;
>>> +	}
>>>  
>>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>>  					od_percent_upper, od_percent_lower, power_limit);
