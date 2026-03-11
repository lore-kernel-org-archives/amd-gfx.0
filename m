Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3052AFD88F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9171510E309;
	Wed, 11 Mar 2026 04:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2bo1+TEw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500A910E309
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXU47BNgyiAMLcwHMCyO3iG1tuac64koDAfFFm759m9dvPjStG1y0ycnDta5w7ORs/5Tijyi9I1E0KIlhhh0TbXejWvqgGoa/Akduqh11IbZyPsXNGHHhhUeeJXe1ihXjNkMvJuiBkrgmyy1xUTk5nDY4L9q1OViBwb+R+HaaaTOP04RI6q+IS7VZcCz+UFrCuiSzCmp/3Jp0G87kUYZv2xRl6k+1XIb/+LqwA5dFQ84+1HKP95M9R1Itpkxo/5tKWzArKDjWZfVtwSIrFfSf2d7xkAQvUYwgR0OruR+YTcayCE57zJ36QyiSJuWLMXQ6h6+J7OpdRr+xfpv9Jjk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQRxHS8sBbesyNetvm2nRYGgL3K94rq3jYXgeUsBcJc=;
 b=y8SvWMJY/wwTl0ylotROITpwfiMQz6+e8RfAz1j27qzh/vLofcteMEmRkJ9gslndJFuiuv8LcUffBG8f+xnmQJ19/JVN0r3kyu1IklylPNvAECHABr3QEOTr/8ZiEQPCq+TZ8Cq1JPDLheFHAetDGa9traOhfOJQFF+Soqey23breOigyeoWMfbuzH3FMq6euyCxzzmX+CZH18Qu0x+1LK2yg/Gu4kbfNyK33WtK4IylRFDfdxgSHZk8sHTIjqETI5E++wYpkOk7cmByrw1L0eGjf1sjNtN7Lg8oJZaef6NsnoRKZSVCJIok9rMYkMHdg2UJalxDQb52bt7CB4nX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQRxHS8sBbesyNetvm2nRYGgL3K94rq3jYXgeUsBcJc=;
 b=2bo1+TEwhu18eu/T+G0cCpRVA/crPbneEO3RycjxUUEbuCsyUs8iofIkITbe6AQ5V6X4U0pRUhGoGA07riByzrAUGHJB84PhAFrLvtzdEmr6GPj1kqPUbrAe7TIO4Z4r+B2+KHE3l3nR1c7V0pP5qOnwZ6ywlgccQBI1FDGq4Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Wed, 11 Mar
 2026 04:44:05 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 04:44:05 +0000
Message-ID: <49dec79f-ae11-4ac2-b402-ffe8c2784d8f@amd.com>
Date: Wed, 11 Mar 2026 10:13:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
 fix fence timeout
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
 <20260309170950.1982724-1-Chenglei.Xie@amd.com>
 <36bdc19b-87c3-4ed2-ab60-b1f97cb9c0a7@amd.com>
 <SJ1PR12MB61217E58C7938385842E32478046A@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SJ1PR12MB61217E58C7938385842E32478046A@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca5a0e4-5e35-4ce0-b0a1-08de7f28d328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KTjBZv8k8c/j9eAl0avNerPb4fAzuaAiwgK7zyZdbvrGkw0hlCGBPrvTBwcfXWFpicUVkvXNIrxFnaBc6j8BzdUCQgxo3j2OIgYFe6iKk0qw1W2IeQUpdg/Wv3QxRZjfYkN9YTAoo5zCtEfDNuXDtPYOHkfYdboj/kI7WwTWo80LUbFhx3uHrHbVfNxuBRGdJa3vLQlFCVgcXS0JgxXijCKgC3g0TO47ojGq0Bo1d5jllDpdd8q9+7Sqb0K2t18AIH4mSCQC3G1HnUQoDtDHjKqv63C7phjXOy0lnj6RB23tK3AV9DMC8+P+xac2w/vBjwn/7AUp7vT9HLUS6mZbdF2/8AmLPd5bwRm71T8OrRsiGL7cN1B+pUpR77PiPRObyHGcYVEL7qjUsphsTAoCJwfwfBvT270HSwPUAZT1fqDs0lNJfGBSHzbA0yrRRGV0rf+clybnhEra5vjySCTw5og4zZ1ERQf7aLhUqbeWYemSILg5lPxF776y/QtP3j9A8ETL/3nnrPwgDlXg3KtlOU0NN06O45zj80D8bMOy2/Wn34oRKSCEcaTc5hbGcbiD7iy4CirL4QRgfMtedEPDGy1gqtQI2MOqwqbFWKAjM9D1Kk9GrWrwxF/mFrZtLrCN8gZZu3FucMRI/HbahU10OHE8gpS3QqxIeqI2f7Z38HJQdGSpVTd6dQJda6Wrllg5AKZNR9r32FGybuxx7S9CUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNOZlA4dEZvYk9CT09JaDJWV2JXNVhSUEFSZ1drbHIrVUJ4VXFDNThrMHNK?=
 =?utf-8?B?VnVyZFowckxWU3dOT1FGMGc3UlZnbkZrTHBPMXRRS09BcFBWT3RWNVpZL2dL?=
 =?utf-8?B?bzdLYTUrMjdKdVB6N0QzNmxtRDN1OExjSGM0SVNTL3RDaEk3bVg2NUZDUW5r?=
 =?utf-8?B?ME0wRXc1QzBRZ1A1aW11V016amdhOFJ5ekJBUlZJc3NjWnNyUFlaT0JSMjUx?=
 =?utf-8?B?ejdXd2gvYkxEUGVGdUtFWU1MVWRRNEVQenBscWVvTlV0SFM1TWdtbUxvR3hZ?=
 =?utf-8?B?TjJHWGRmUFBkaVg3QmhWbVhraW1yWklqMU43WlNCK1hzQ2ViOHVJTGtHWnh6?=
 =?utf-8?B?MGxSRllXTEtoZStVMUpvN3paUVFna0E4ZFlvak1WbkhSc2FVUnJCWXRic0dk?=
 =?utf-8?B?TjJ5ZlMyaHJDc0F2RmVsMU1zY2hlYmpKbVpTYkJoVFRxa0tpVHNIb1ZUOEk1?=
 =?utf-8?B?ZWRxOTBBcmdBelE3aDE2T2xTcTB2b3NvZHJHWVBkQ09CVXpRU3dPejVxS3o0?=
 =?utf-8?B?Y3dpeFEvYmdYNmhQY1FOZ0NXSThyZ3lBWEl4ekZHNklGY0VGNGs3T2cyWXI2?=
 =?utf-8?B?K1FBTlM4T3Y4S0xnNlFUdEErbkIzZXlEWHhVNWM5dTgvYi9uOFhsM2lOWDJP?=
 =?utf-8?B?L3lNZFh6c3NLQVZDU3JhK1QvY1lNQUpJK1ZXbkJZQzZzZ3lkVDlQVVNzREhF?=
 =?utf-8?B?WnpoQ0xiT2N0KzBZZ3ltcnhvVy8rc0xQTFNBTjcwNktkWXVLSDZ0ZXhnMGNz?=
 =?utf-8?B?K0VlYnYydUQ1d3Z5L0FWMTM1Q2phV2l5T2VTVW16NWk1RW9meng0QXE5dEth?=
 =?utf-8?B?YTZzM1lONkdzSkVnQXVLMkZ6N0d1YzJ6TEZQRXRxQ0J3K3JZUlNLYmVqZlRT?=
 =?utf-8?B?OHptUVU0ekdBd01GZ2lRcDQrWjBQVW9BRHdvdzJ1YU5MTHZiZk5ROW84dFV0?=
 =?utf-8?B?OG9tZUhlb3BlR254WFR2bTdncVppdlJhQll2MmtpMDdNS0dUMDNZaEI5cHZz?=
 =?utf-8?B?UVBzUHFIREZQdFZDSUN5RVVXVFkrQjhkd1ZCbWs3M1U3alE2Qlh1MlNFSWg2?=
 =?utf-8?B?R2dIZERxOHNWRjFia1VKM3JBRFlJU3N4LzN4SDY1ZDlSYnhOV2VkT2ppQWZl?=
 =?utf-8?B?aEMwV0ZaZ0hHUHpPV3lWRWt2aUJTeHBMSWZPeVF2TXZwRmR4UU9IbTF3amFi?=
 =?utf-8?B?b1paUE1rN0xqTjU0VVRBelM1aERpUjdiQlIyNlR5YU54SWQ2UXNzSDJtZnRq?=
 =?utf-8?B?d1hSQzZCNmZoMFY5eWpEVmowK3VEbmk0V3dHM2NjZ2tNcGJ6WjdQd2pNTFpz?=
 =?utf-8?B?L1I4K0ZFQUlnY1lZNlQrTU9KSUFoTUVaQ1ZhRVhiek9iMTdVYlpBbnpTSUtw?=
 =?utf-8?B?bTh0dWxqUzNiUkNjOUJtOHFpM0tIdlB1M2xsazFZWGxEcDVBa295S3dwbTd0?=
 =?utf-8?B?Vml4RWh0VFc4dng5cmt2aWJUa1ovK0tNbGhBTUZoR3c3NFJEbHROcVFRd0NM?=
 =?utf-8?B?MnFyVGJZOEVmUXRCZmdZS01pZFdhZis4WGVwQytYdEFYYnE0TDYvKzE1bFBr?=
 =?utf-8?B?SjcwTG93WURpenYvU3ByQ1NUbDA1WEZrRm1nL2FsdHFmNklLa0NTZlhLREp0?=
 =?utf-8?B?M2FEckZqc21tMTZaeGhaS1d1M3dadUxySjFvMTd6MlFlVWxqMFp5QXF1N3pE?=
 =?utf-8?B?bkRvUFlXOXA0WjZsRnZMTzl4cXRIYS9zL2ppVjhDTTNYanAwOWw2cU9GczB4?=
 =?utf-8?B?dkRjWkhmQnpIdHZjdFY4eUFRYSsrSWYxd1V6TjBWRDBFSXRQZDB3TlgrYk45?=
 =?utf-8?B?QzN0anlldVBzdkRxZVhZcFIrU2pEaU9JMjV1ckRKaS9aVDgvblo0R1B6VkVE?=
 =?utf-8?B?aU52MUR0cU9ZaVlya1dpNGVwOXRXZG9jSzlVc01ZU3ZVMzc0bUJ3MVFCMnM3?=
 =?utf-8?B?S3NTZ28vVE1PTDBnTzYxM2hZRkpQQnN1RWxrM2tlWGphL0JWbG1KKzE4S1ZP?=
 =?utf-8?B?UFg5ZmVZSEpzL0U4Rk41ZGYxc1lLd2xPQVdiek42bkFGdG9jUVc3ZnBTTXE3?=
 =?utf-8?B?SDl2VElpd1A2SEI0NDl6YUVyMzJORWVmaGRGMkRMZjQrOU81OXZXU0R2VHhn?=
 =?utf-8?B?cG1FMEZLTHhJWHlLbkxiMGp3cXlOKzM4TFdJdTFNQksvWEhocU94UHRPU0ZN?=
 =?utf-8?B?d3BOdUpuckdGbXVRS2RTODBZRWRFSlRpTVZSMk1Pd0xBTldXeW94T09HVnJ0?=
 =?utf-8?B?bDlkNHg5RFFPK29uMkhVWUlmOWk2R0RWZ2VOcGIzU3pFZHlsZDJtOFYwWW8x?=
 =?utf-8?B?anQ2Yjk3QWRhQnFpZDcvRS95SGwzajlFS2F1cDhBR2FEZWZKRTVkZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca5a0e4-5e35-4ce0-b0a1-08de7f28d328
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:44:05.5283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ6OjUkYjhEbdMWeR1fHu0+7hDTZRiE6pTlnvCysjwJmJDOSlWbpWGfCvUur8DHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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



On 11-Mar-26 2:08 AM, Xie, Chenglei wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  3 +++
>>    2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index cab3196a87fb1..0021e763b753a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1124,6 +1124,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
>>           if (adev->mes.ring[0].sched.ready)
>>                   return amdgpu_mes_rreg(adev, reg, xcc_id);
>>
>> +       if (amdgpu_in_reset(adev))
>> +               return ~0;
>> +
> 
>> Please note that the existing logic assumes that kiq access will work fine even during reset and only could fail under certain reset situations (not all) -
>>
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c#L1107
>>
>>
>> Also, there are additional things done after full access is released -
>>
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L5610
>>
>> May be it needs a force completion at the right place somewhere in
>> amdgpu_device_reset_sriov() as Alex suggested and not to simply block all KIQ based reg accesses during reset. In baremetal case, it is done during pre-reset as we don't expect any more packet submission/indirect register accesses through kernel rings afterwards.
>>
>> Thanks,
>> Lijo
> 
> Chenglei: After the in_gpu_reset flag is set in the KIQ paths, the current logic allows a short window of time when HW and KIQ can still run to process packets before the HW actually start reset. But once the HW reset stared, HW would stop processing and new jobs in the KIQ ring would fail because of that.
> 

Do you know the source for those ring submissions? I think it's not 
expected to happen once host driver driver is notified.

> If we want to avoid blocking all kiq access during reset, we can have amdgpu_fence_driver_force_completion() called in amdgpu_device_reset_sriov() after -
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L5586
> where the rings are re-inited.
> 

I was thinking more like forcing kiq fence completion right after host 
driver is notified. Ideally, no submission is expected after that. You 
may also return from KIQ reg read/write paths if runtime service is 
disabled. I'm assuming they are supposed to be used only at that time.

> Also, the current logic in amdgpu_device_pre_asic_reset() skips rings without gpu scheduler -
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L5810
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c#L862
> So that KIQ rings are skipped and never got force_completion before reset.
> 
> Issue should be fixed if we force completion on all possible rings on both pre reset(both SRIOV and BM) and post rest(SRIOV only). I will send out new patch based on this.

I think you should trace the source of submission while HW reset is 
ongoing. Ideally force completion should be done before reset even in 
SRIOV case.

Thanks,
Lijo

> 
> Thanks,
> Chenglei
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, March 10, 2026 2:40 AM
> To: Xie, Chenglei <Chenglei.Xie@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to fix fence timeout
> 
> 
> 
> On 09-Mar-26 10:39 PM, Chenglei Xie wrote:
>> [Some people who received this message don't often get email from
>> chenglei.xie@amd.com. Learn why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> After GPU reset, the hardware queue is cleared and all pending fences
>> are lost, but the fence writeback memory stays stale. If the driver
>> keeps submitting to the KIQ ring during reset (e.g. HDP flush),
>> sync_seq advances while writeback does not, so
>> amdgpu_fence_emit_polling() waits for lost fences and hits -ETIMEDOUT, blocking further KIQ use.
>>
>> Fix this by skipping KIQ ring use when in reset.
>>
>> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>> Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  3 +++
>>    2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index cab3196a87fb1..0021e763b753a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1124,6 +1124,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
>>           if (adev->mes.ring[0].sched.ready)
>>                   return amdgpu_mes_rreg(adev, reg, xcc_id);
>>
>> +       if (amdgpu_in_reset(adev))
>> +               return ~0;
>> +
> 
> Please note that the existing logic assumes that kiq access will work fine even during reset and only could fail under certain reset situations (not all) -
> 
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c#L1107
> 
> Also, there are additional things done after full access is released -
> 
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L5610
> 
> May be it needs a force completion at the right place somewhere in
> amdgpu_device_reset_sriov() as Alex suggested and not to simply block all KIQ based reg accesses during reset. In baremetal case, it is done during pre-reset as we don't expect any more packet submission/indirect register accesses through kernel rings afterwards.
> 
> Thanks,
> Lijo
> 
>>           BUG_ON(!ring->funcs->emit_rreg);
>>
>>           spin_lock_irqsave(&kiq->ring_lock, flags); @@ -1202,6 +1205,9
>> @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>>                   return;
>>           }
>>
>> +       if (amdgpu_in_reset(adev))
>> +               return;
>> +
>>           spin_lock_irqsave(&kiq->ring_lock, flags);
>>           r = amdgpu_ring_alloc(ring, 32);
>>           if (r)
>> @@ -1298,6 +1304,10 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
>>           if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
>>                   return amdgpu_mes_hdp_flush(adev);
>>
>> +       /* Avoid KIQ ring access during reset; caller will use amdgpu_hdp_flush fallback */
>> +       if (amdgpu_in_reset(adev))
>> +               return -EBUSY;
>> +
>>           if (!ring->funcs->emit_hdp_flush) {
>>                   return -EOPNOTSUPP;
>>           }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 20e1395b39882..f9db2b17105b7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -876,6 +876,9 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>>                   return;
>>           }
>>
>> +       if (amdgpu_in_reset(adev))
>> +               return;
>> +
>>           spin_lock_irqsave(&kiq->ring_lock, flags);
>>           amdgpu_ring_alloc(ring, 32);
>>           amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
>> --
>> 2.34.1
>>
> 

