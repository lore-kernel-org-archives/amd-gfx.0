Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41835C54E60
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 08:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA5110E51B;
	Tue, 19 Mar 2024 08:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cBvUu0Y8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2109.outbound.protection.outlook.com [40.107.244.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2921010E51B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 08:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS09GOMSPVvD+0g4aM4oeB6S/RNfdXePq2AF7Xm/IBC2xO98IZPxkdZ3c4tc4r0/J554Q2vSBcLnQ8VQl+mndKSZ//eglW5eqlJOC+x11vI+pU11x1QIClNBN5+zKq7OasUFgwyBrDF5oLvr4Wf+qZjwbqaeOqkprUeYJ1b+EBCIQB3NiKnjwg+iR+hh7UC4iRmEUDzU37C5PqomemybahqKrYsEo/IYrVyp0duIR03XHpkhct7CoRex17Bwhri2VzNV/T+9KeZQoPKR2WSIUUG6lKAp6EdQKmaaAgzE6TpgVo2MZTow1MSn3MrIyPUbtGULZOjrhb1VL+EbS3z9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc20sjEGRA3FFEa0ytPulRKzixbaPS7b5dgHIEyomRo=;
 b=BcoQrOglFXu2lF8yKaIY1JvoDCqfLahjmvZGp/ajT5l+srFUwpAvNIoyXtLvrCwmIAMDJni5o5WXElzXRT+HaxVPwRhbrDnPRoV67yuHAWvBTx0zbvDVhNzsFhDQDjiuuKCzBl5qec0y2VXFc/+oBQIBFx3hH/qrdgf8QMOjk9sBDnj1NakhKr4IBuRzlzXsZcIKtMG0z5+Wm5YeUr9iI7Uv4AXRTg6w+bAb5PoctVTZAL7QiGcIQkz/4LkDLLZcBitdvKTjw+GzzmOJ0ewj9FoYRJoDyNbmMMRlnYpBzSQbq/hmoQ2s0Y0CJvKvshVjhbS8ijlt+Vwd9M0k0gkIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc20sjEGRA3FFEa0ytPulRKzixbaPS7b5dgHIEyomRo=;
 b=cBvUu0Y8mr0NRNdJT3GapiNDhlaVbrAAspe+mwL+xo9JgSdKeIqUAYay1MJ1Dho3y6l8vu0k4TO79srVjtCnR0KJVP+v5PjnGWDJJrIt4RB1RJ9EjOohoUTKX2TYJwiIpmF1gRwpOyUlydBjs75Orgv68JPxSEFpC3V0jN8MhqM=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.30; Tue, 19 Mar 2024 08:48:57 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7362.031; Tue, 19 Mar 2024
 08:48:56 +0000
Message-ID: <51d19107-727b-4ec5-aa95-2584e9a49010@amd.com>
Date: Tue, 19 Mar 2024 16:48:50 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, srinivasan.shanmugam@amd.com
Subject: Re: [PATCH] Revert "drm/amd/amdgpu: Fix potential ioremap() memory
 leaks in amdgpu_device_init()"
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240319080728.2558078-1-Jun.Ma2@amd.com>
 <4e5cd8d0-b27e-4a32-a055-618a58d6bbfd@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <4e5cd8d0-b27e-4a32-a055-618a58d6bbfd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SN7PR12MB6690:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEkTPaspaJqlN1klGfq5P4bXLuQ0kRp+KYi2iLMsfKY6wp5CyNWftOoICdG+vYEijq1AUBu9H8tw2PzxaQUjHmvBWQ/Rv9Nw7Ecs0DD2hGb93dmEDwEAkVAiiTUHk8+JblTokLb77L1I4QS0zg/+zBFwEYb4oxDpPckV9YDtvWOtau+U+Hi4UzjuTOkLxuAz7zcNSJek8maVsu5ajRS6dEs7PdB9gvk0LBnyCh98YJUOCKx/plw5tkxYIwBQQ/gaTi+UQ7Iw6VZ+ENrnkguaJV/JrQLkbZJ1t1VtLbLPx3VMlGuLmrcX77Bxs00XyHQKMrtbEgHgOMGKWq1GA4z3tiIfJWtTYLr4qVAQy2jOhS1vcje3cVWV79HdphYBWA/DmS5nHaFWHAYGWQ02p30F90b1dxsYiGibysvZEhQWrSiR2wEowHuKDxKGOkVJONu5RKbEvDvpugI/E0CBGVNNsykOvrSsSnB9cqtOi2RL30uJNDokmS9y+ycaqjoDvFdulP1LHJNfvF4cgIiMtesPoTSkZuficHeIelEUnLODWrXpiaJ87KfEUeNrhufZj0SieG8a/1UAVG0dkCXpAQoSnRjYozXLivO8o2fi7DoZwQOHqsM0kR2E2RM0WmzTrKxNZiquCOmCWsCIwIf6CZXUYUO3jVQNJFznMmolC6oTwYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1h0MVpxVHFhS01xNTVoeDdCeVJuYTFrK3l4bTB4cUVjZG12MGU0WllMNWo1?=
 =?utf-8?B?amcvUW03czRoYzVxT3NCSEtvd3ZGUmE3U01YOGZFQUpVQlVOTEIzR1FIeXM1?=
 =?utf-8?B?NGpudW9GdW9DS1lueE1LVmtOeUVRR3FPUHJCK0FicUx2cDJzOXBNNWVjbmxj?=
 =?utf-8?B?bWtOVldqRFkrMlY1TkdXY0ZRMU94NkszMklVc3gwckhsZGNQWC91RXJhT1E2?=
 =?utf-8?B?WHJsdEg4aVFIMmphcjkvaE1nandGQzl1aU1lYzZJbnp0M09xSmVpM25xQ004?=
 =?utf-8?B?UXhLd0pjNUxOWXFEUjVjOWhOVU1XcXlWb3pjWUZEbXZvZ3czTXJrd1ZsSldP?=
 =?utf-8?B?QUU2aDR6WjdmRlRDUFl2ZDJLdWpjcFNJNU9pTDRBSzNOUUpiZUprRVBhamFz?=
 =?utf-8?B?VnVQQWtIRGFkRVpwdUN5bGVFUEs1aEo3QnZFNkxScCtaeDRiMkhaVWRaZjNp?=
 =?utf-8?B?NkZFYlA3U1VNeUhtSXF4TDNUaVhRYUFxWjlMOTNOMzlkdWpLNE90enAveWw1?=
 =?utf-8?B?MnJjaC92bHhYbG05V3R4MjM0L3E2QkhmSmNEWnhRVXpmbEdKWUsxOURRVTNP?=
 =?utf-8?B?Q3Q0WXY4SG4xclNTNWw5VFdwMmRFT1BKMDhVU2N2ZWRRY2txaDc1WUpMRzRQ?=
 =?utf-8?B?WitEcWZZc1VXcTZ3MnRCMFg0WEZrcDR5WmdIZE5Cem8wcjlLMEI2ODk3UGFC?=
 =?utf-8?B?U0xieUxqZ3lTMEs4ZHB5SDQvaGRDWUJqQ2VadnJQU3VMQ0I3cmpLZGdjWCtU?=
 =?utf-8?B?K1l3bnZVUFFmNklwUzBPTTZnbS9sdkxEcFY4c0ExaWpKTVJxRzl0azZGczNm?=
 =?utf-8?B?VVZHU1lLSlNaVXd0bVg0OUg4NEovTm9yVllkbEQ1ZVVYeXoxdTZIRnEyL1BK?=
 =?utf-8?B?ZFdGU2lQNW9xY0ovR2trY0JkbzhNbWR1NlNwRUhPdTFsTFhTU2R0VGZKWjFn?=
 =?utf-8?B?ZVlCSUUvSXRpVFZGUVRsU0hIK0JpVnJtUUNSbmtDOWJvL2NBWldWREh5WUZR?=
 =?utf-8?B?LzZFRVRwNFNFR245MUpJQll3amYyRDVYaDFrY0JLRFowWEpxMHViSUZNUk9T?=
 =?utf-8?B?OEM3VzFaQkNxd1BiSHRSRVFhandMaDRLM2cxakt0TlRtNGsrVlBLa1RxSmt0?=
 =?utf-8?B?WHB3RGk1K1NFM2J2bzg3K29Ya3RnVXZTcjZkOWxjMHZ2YWZKWkIwSzJ6SUVl?=
 =?utf-8?B?TDFnV01rWkJ2SDBwcmxjYVB4UThvNHZvMkE0WUdLU01zaHJ5aXJxWWFJSXdB?=
 =?utf-8?B?ckVNaEN4eTJOclZMbGFCUlpmNlhoaWJPQXlCRSszMmk3V29vdTRFQyt2dGtj?=
 =?utf-8?B?WG5GZk13M0VMU0hhdlRkbjk0am5xRXZwZ0JMMHlNL2VVeG8zYm1wbjdOWEd3?=
 =?utf-8?B?WWw5a3FMcUdPT0RUanpKVTRHM2FMaXBMaXA3U3p1Z01DMzZ0cHpuRmlRZFVv?=
 =?utf-8?B?MW4wMHBoTjF1ODJDSTdSdmNVMThPcmhtWXplSXpsRTVBNG9zWE53ZjY4NVd4?=
 =?utf-8?B?eStkaTR5QnpDTkhNNXdUTjkzYVd4UzNrWFBSNkRvcGcvNDNsakxDWUFwcDdL?=
 =?utf-8?B?dDVjT2NzK3kwaE9FQXN4OHFBcU5qclRNOHdRRDgvWHB3SnF1WVliRHNsYmNi?=
 =?utf-8?B?cEZSc0pEL0N4c2JxbFNLdGowZDhueXF4NHBkUXNuaUZneUNQQTAvQVNXZklF?=
 =?utf-8?B?SmpzWGp2cTlrZzhINjh4RlZpVzBMMlBVSzBva0s2ckYzcnBLMC9lL202MEZP?=
 =?utf-8?B?SWtvN1VRQ3dKZU91ZEpYOS9mL3VZNE9lcTBlMnFScGs3WDRmZVFCcDdWK2Jt?=
 =?utf-8?B?ZzM5TGgvMjh6M2djejdoTTByUGd2YmQrSlNXM3lJU3FwaXE2dE56YzRaN3FT?=
 =?utf-8?B?Q2FIOStKcVBSeUQwM1pmZi9XQnd6bHM3YVFWbS8yYjlWdGQrVm5KTHNDbW5X?=
 =?utf-8?B?VFRENDJaTTQ5bDhHbGNjU2VqeDhjNjN2WGtZWWdWR2ticHkyVW11RW43Ymww?=
 =?utf-8?B?eXowaitNWVRLL0hzbmFrWk9lc0FXZ1dtL24rMDVkS3ZEalFid1dlamNVbXdG?=
 =?utf-8?B?SHRGcTN6MGM0RytDMnV2bUxST0tDZ3FXNEpHQ3gyeFNvcWhFMkpPM1BVZldT?=
 =?utf-8?Q?UH3bPbV4kanLBhpiwIKada8Ks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15588648-03dc-4108-ce21-08dc47f169ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:48:56.8017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5+FafKFqtdUFgo+a2dycfYgOCWN5TqOkjZeth78ErquMN8otMeHVSetYZ65akig
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
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

Thanks, I will fix it when push to the next branch

Regards,
Ma Jun

On 3/19/2024 4:22 PM, Christian König wrote:
> Am 19.03.24 um 09:07 schrieb Ma Jun:
>> This patch causes the following iounmap erorr and calltrace
>> iounmap: bad address 00000000d0b3631f
> 
>> So just revert it and amdgpu_device_fini_sw() will cleanup the
>> rmmio mapping.
> 
> I think we can improve the wording here. Something like this:
> 
> The original patch was unjustified because amdgpu_device_fini_sw() will 
> always cleanup the
> rmmio mapping.
> 
>>
>> This reverts commit 923f7a82d2e12a99744a940954f3829ab18a9dc7.
> 
> You Signed-off-by tag is missing.
> 
> With that fixed the patch is Reviewed-by: Christian König 
> <christian.koenig@amd.com>
> 
> Regards,
> Christian.
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 70261eb9b0bb..3204b8f6edeb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4042,10 +4042,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	 * early on during init and before calling to RREG32.
>>   	 */
>>   	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
>> -	if (!adev->reset_domain) {
>> -		r = -ENOMEM;
>> -		goto unmap_memory;
>> -	}
>> +	if (!adev->reset_domain)
>> +		return -ENOMEM;
>>   
>>   	/* detect hw virtualization here */
>>   	amdgpu_detect_virtualization(adev);
>> @@ -4055,7 +4053,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	r = amdgpu_device_get_job_timeout_settings(adev);
>>   	if (r) {
>>   		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
>> -		goto unmap_memory;
>> +		return r;
>>   	}
>>   
>>   	amdgpu_device_set_mcbp(adev);
>> @@ -4063,12 +4061,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	/* early init functions */
>>   	r = amdgpu_device_ip_early_init(adev);
>>   	if (r)
>> -		goto unmap_memory;
>> +		return r;
>>   
>>   	/* Get rid of things like offb */
>>   	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
>>   	if (r)
>> -		goto unmap_memory;
>> +		return r;
>>   
>>   	/* Enable TMZ based on IP_VERSION */
>>   	amdgpu_gmc_tmz_set(adev);
>> @@ -4078,7 +4076,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	if (adev->gmc.xgmi.supported) {
>>   		r = adev->gfxhub.funcs->get_xgmi_info(adev);
>>   		if (r)
>> -			goto unmap_memory;
>> +			return r;
>>   	}
>>   
>>   	/* enable PCIE atomic ops */
>> @@ -4347,8 +4345,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   failed:
>>   	amdgpu_vf_error_trans_all(adev);
>>   
>> -unmap_memory:
>> -	iounmap(adev->rmmio);
>>   	return r;
>>   }
>>   
> 
