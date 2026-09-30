Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDB7CA5FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 14:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02B710E068;
	Wed, 30 Sep 2026 14:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="be6nKepI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E377A10E068
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 14:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIpOkVuX/1BRhHswf/IK1aF6MD7GRihSSljmpCVI89/BxifQIvUrEgDv0rfcFQGSkivYjhA729Ke552gnEXgoQJRAvFrlIqbgLdvbasTTBWGt9RRhNrc22Y3H1RsPP+dUj7uA5Yd5HteftBISGLazABkHA6KeCYC3n++zqp+b7jvz+9bnYkxVzH4ryn/e2/rrU9/h0XG1XIof+jlIq9BZKkgggmXhIFg0Gho63iiaS0rzxc0o8j5568gIDcuIdjx7VwfL0/2kVtojg5kRJPrxHl3HOw80R9stLemAXMTzVLhopFeb7jpmOobWIwxyDYKBBgNHIJwzUIa2XtoLW/Lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McguWTGI7ix8x5rExlREDpgu76qUcjvm2me5oIwrQBw=;
 b=fd2DqBkr4Q0BLadt6YkKT8wse8SwTPVAFstJfm2HJGyTa0mNmDJhwbGu4ercre3+K9z+0Ycg+dqtQS8rWrx69W6/uxXB2JKatQnKL50Qtf3+DPgGOcftk4fhCKaWHbv2MWW+Zpk7MvckqJRMdMZ6ah+nKYKjagKxE/pUgi/DnN/qK/JMqTYFizG+1SWCDR8uSDZEsXEB5mvE3tQJkm9rCH7wIItZYC51aH6MCwB6muejwFABY78APcMPEWrUCcXgJPHcWPc4RqgRIgFSFJR1tVCqr+QbFgqvH6OvCM97K/N0OEmIO0iXiZzLSD+QghnDr0sdRytQy0qXdEyEjPmqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McguWTGI7ix8x5rExlREDpgu76qUcjvm2me5oIwrQBw=;
 b=be6nKepIgpOAbVXpP1DjTJVVLzl/p1cB2rMFT7gTl2etFgNIWdPgD1UqzaP/qfOt6mHdVd3epcYUWZNIKqwIjmTybnNfLGdJzWwi1Ww6nB6fz+n3egb0TXERh7JKCNOFay8yvxpx0ih9vbsBuOsfLWZrMkbrZFTdIBqxvUQH5BU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 14:31:53 +0000
Received: from SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3]) by SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3%3]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 14:31:52 +0000
Content-Type: multipart/alternative;
 boundary="------------uSDpgi70x1Xkf4LSYY0qY2Ji"
Message-ID: <a7492744-8b46-483d-8923-cf7d12a0c83d@amd.com>
Date: Wed, 30 Sep 2026 20:01:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: add amdgpu_vmid_uq_mask() helper
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930141823.4161298-1-sunil.khatri@amd.com>
 <6f0ea6ba-078d-460f-9dd7-1b96c7e5bb00@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <6f0ea6ba-078d-460f-9dd7-1b96c7e5bb00@amd.com>
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7782:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df29332-8083-4513-c84e-08df1eff91f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003|8096899003;
X-Microsoft-Antispam-Message-Info: Lyo4uN9PSEhHYyHM2d3n83okcu9F0c/SBNcluZp1jHiNIl08HeEO+9u8OO+SO38+S3y8HUaLRgdQZ1FU1zG/415QVswua23HyMaEoeUkWR36rENJ/D27JrBJqxKDaGP9LpbV3T2kVF7sbwLk/KYEUrFrPSAB/fYPNjHcp2V5IpWCkI+1A9rFgHhMNi6oBCBcNzINfnpWFH6dV4uPqfzplagBsPHLSveLOWJPxB3BwJqDYWv5XKAU9tHFFUZ5K3hhckAJ7EKYeApGAhupviiAZ8aNYxbZK2nKzWqGWTEingObns7UMzX7YTOtErIEkpRgTdy3+a07sV3orWY7dOLAvMfssv+LZYGaAMOjw471BI/CpWvpjQdB1g3fsstLaHtBaURU/jQnrYERR9Vu7unQCOWJsCfHn5hopCCrWhXH0ECPPwvBveD8omJox4OJT7koxsRmZ68kExTyYTQyFMmpbN/+vsrU09o5r2pbTaeYGPCnbYAqB+tQXvMRZQmIspuv6BvQrPWNVssX49UGIpaJmKYh2Fnh4Xymbw5ODD/wLpyFZTpKLM9DyRBwwjlkXhaTpOzy0UY+z+LhyisQjyygqrK4ychdkylH/IHih7YVzmvUN+w0SH6SpskS/tppYB2V5sAh2Ij7Q8OYr2/99CP9BNLxzaUuyN+fhoM48EB/0/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7782.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtBdnM0NGRCZjl5S1Q5a1h3WkMwNHdwWnB3M2NacWdibExjdWx2S1dRVHBy?=
 =?utf-8?B?Sm1yWlh3RWVjcjM2ZTEwcm4zQlR2c3hEb3poSWM5QjJEVkZCMkdjMEVmMXNj?=
 =?utf-8?B?S3lEUk00QVFrRDdIZDdrVkF2N3JOWWJEb2JRYWRKaE1qd2p0Wnc2OFJHbFMr?=
 =?utf-8?B?NFZyanNTK1ZvcExMc2VZa0tIblRGSFNpcTJGcmhVOFBDSnEzYW9xM3BkMFNu?=
 =?utf-8?B?K0gvL1JYNTlaU0s2RmZscVkzZE96Z1ZXbVVkTENzMFJTSndIbVVGNXd0UXhy?=
 =?utf-8?B?MTVmM29Tb21XUlhzV2lTcUhWNmZtRlNrTUtGL0JZUmFVa3Rad2RRZnY3M2t2?=
 =?utf-8?B?OVVyeTdzcW5QRFNNNkRrVFlWUlorblh2WmMvOG0yYStEb3hJZDNDUDE1TnR4?=
 =?utf-8?B?VUtlMVdSRGtrcEwxcmNxMTIvay9sL09sTEFnYXdvWis2MldqaEx5NlVpZERr?=
 =?utf-8?B?bFpzNFNoYmNkdWVhNHlwSDFRa3hpQURxK0cwRnhOWHllVXoyUEIwQTBLaXhq?=
 =?utf-8?B?YXZwQ3YwYWxicmxHMFZBRUIxOWVOU3ZLT2NBTSs3YmpJTnNSUFdhdGhFVXdz?=
 =?utf-8?B?ZkdZVWI1RnJ6UFlSTUV5a09yZkYrVWpQWS92dkhtVXJxMVpEQlBRQUplYytu?=
 =?utf-8?B?Z3pVZ2xSYkUydU9IdVpmSjA5YlNTVGVXeTMycWszRXVXbUp6YlQ1aFJ4d2Yr?=
 =?utf-8?B?WWNqL3FtV2NpYjRNUXdQdVdseHZqcjlXUGd0THlzYUEvcm9XY3VaTytuUzZR?=
 =?utf-8?B?SFlnZVd5bDJ2STNkakZLV1c4MXZiOWlLanRRKzBjS2VQSmxCNDRSUkpQNjdQ?=
 =?utf-8?B?TFhadzQ3M1VHZlZ3am5PV0JDL1J1UCtoeHlFcjg3a1JOUVhsNzhtUlBmRWRY?=
 =?utf-8?B?c2NFdTh3bXozaFhQamFmSzlFN1hSQzYvcVFuREdwU1AyallpOU12dDhSc0F2?=
 =?utf-8?B?TUJuSUJkTStWWk1KTk5NOGNLYVhUazhiQUNoMnJ3L2lNeDFNUkI0c0hBZ2o4?=
 =?utf-8?B?eG9EZmNRb2grbGRtM2JZb0txVW9jNWd4SkZ3UUUraWMyVnZnOXVqTGRhVjVV?=
 =?utf-8?B?Znh6MGt1S1VVK1JCalhvV3lpeGlkaVFNOGZPd3BJRE1DcEtzaGhzMnVLaFNv?=
 =?utf-8?B?RnB5MFAxQ1FKbTdiUmhsZzdISk9VSGFwQ0dBeXhBcEdiNHZWYmJoM3hwRHQx?=
 =?utf-8?B?WDQrbjBRR2dDVVVBS2ZMb05zYXh3RXB2dmlwT1hVNk02YnU4dml6ajV2UTJn?=
 =?utf-8?B?QksvM0psa1ZjYTd2ZlhqMkxEUlA4S0JDSXpDejFsWUNxa0pwb2drMXBxaFEx?=
 =?utf-8?B?VldBcWMwMDFlVmFsYVlZV2s1cCtGajRJWEV3UzR1VzZUQklKVUhydUdicEJW?=
 =?utf-8?B?TzlUU0hKL2oxTU93VUFPY0YySGd4R1pDMmtwbTdOaUFkeG5jSTBydVpzejB0?=
 =?utf-8?B?YjdLTjlRdVFGSllGWXVRNUxzTlI1TnNGeGwvdHJFZ3lZSDFMbkp1cmFWcEE5?=
 =?utf-8?B?KzAyVUVOZlZQNXRmWGkrdk1rc0J1Q2htWExBb1VXWlBSdzlWNk9JMU9sMUgw?=
 =?utf-8?B?aUs3cWpBdUhVeGVIN3pOS3RtRFlsOW5WZVRVL1JvbGQyYitDWTF1WE5mOGpY?=
 =?utf-8?B?aHNoL2xYWnJEdThpVDdTR0dta01wWStnVURmdGdqY0FBQldsM1NjRkdRelJq?=
 =?utf-8?B?NkZDODZnU0hhbTRlbENyWWVhbnBZL0llakdaY3NvU282d0paNkhrbGJXRzV4?=
 =?utf-8?B?azZ0Q3VibUNmSysvSGhaaUFRMUJHWlZ4QkJmbjd3RG1WY2VyZU5ONVlUTzhS?=
 =?utf-8?B?NVRHYWpBMTBxZjdrL0Z3YU9mVHI0VUxWY0x1Y3dpdGdXTGY4VUMzMFBleU5a?=
 =?utf-8?B?NHl4UG1pZGtEUllFNDhOalo3RyswNmJVK1M3cDQzRERXb3ZIQ1kxejg4UzdH?=
 =?utf-8?B?Y2Jzd1YwYXcyVFBqQVpCanZTNVFvT0NqbVJMaCtZNE5tWFNiQWlURHcxblBa?=
 =?utf-8?B?NHdnUGdpbU5lK0NTWGdTRnZlaE5DRTZqTk55SGF4WGY5KzVFc0Mrd1diazU4?=
 =?utf-8?B?VllReC9KNW5qOS9QalRhL0ZtMWVzT0xUYkpNNkJCRXEwYmV1eXlwTTBPS09h?=
 =?utf-8?B?aXd5TnZtN0c3N1o3aVZmOWlxb1hHdi9jM3FpSGtiam56cFc4NjgvcmJrcHNt?=
 =?utf-8?B?UmRTZU9PeTJ1RGtaYnYzTWNla3BYK1ZQbDdKOGJ1aVY0SE1hQUNCa3VEQ2hM?=
 =?utf-8?B?WTZpQTQ1Sm8vZ3c5eXpLTk1TQUJEK3JIQXJYcGNHY2ZuOWVlb0J1bWJybjZM?=
 =?utf-8?B?dGQ1TXJYRXNLZFBzWDNOUTJ5SFBsYW03WEljRHlxNWhTbVdZVitWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df29332-8083-4513-c84e-08df1eff91f4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:31:52.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsmKCnGHfdwYWTyfu+s+csU+RbUVH9KpbwCvgYfjwzsEnWhlB2R1T6KQXUuzY7IdbHH6qR3bkfb/22XxoHFOhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A
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

--------------uSDpgi70x1Xkf4LSYY0qY2Ji
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30-09-2026 07:57 pm, Christian König wrote:
> On 9/30/26 16:18, Sunil Khatri wrote:
>> Move the duplicated VMID-mask-above-first_kfd_vmid computation out of
>> amdgpu_mes.c and amdgpu_amdkfd.c into a shared helper.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 14 ++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  6 +-----
>>   4 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index afcfb92fb9f5f..582be4f0a3b76 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -178,9 +178,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>   
>>   	if (adev->kfd.dev) {
>>   		struct kgd2kfd_shared_resources gpu_resources = {
>> -			.compute_vmid_bitmap =
>> -				((1 << AMDGPU_NUM_VMID) - 1) -
>> -				((1 << adev->vm_manager.first_kfd_vmid) - 1),
>> +			.compute_vmid_bitmap = amdgpu_vmid_uq_mask(adev),
>>   			.num_pipe_per_mec = adev->gfx.mec.num_pipe_per_mec,
>>   			.num_queue_per_pipe = adev->gfx.mec.num_queue_per_pipe,
>>   			.gpuvm_size = min(adev->vm_manager.max_pfn
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 4e37de79f0318..c94a085bf6503 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -646,6 +646,20 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>>   	}
>>   }
>>   
>> +/**
>> + * amdgpu_vmid_uq_mask - VMID mask not reserved for kernel queues
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Returns the mask of VMIDs at or above first_kfd_vmid. Shared by KFD
>> + * and MES user queues, which both draw from this same pool.
>> + */
>> +u32 amdgpu_vmid_uq_mask(struct amdgpu_device *adev)
> That is a good start, but I was rather assuming that function would initialize adev->vm_manager.vmid_uq_mask_*hub.
>
> And then we use those values for both the compute_vmid_bitmap of KFD and MES.

Got it .. so use the same function to hold value in 
adev->vm_manager.vmid_uq_mask_gfxhub than returning the value ... and 
then in kfd use adev->vm_manager.vmid_uq_mask_gfxhub directly.

Regards Sunil Khatri

>
> Regards,
> Christian.
>
>> +{
>> +	return ((1U << AMDGPU_NUM_VMID) - 1) &
>> +	       ~((1U << adev->vm_manager.first_kfd_vmid) - 1);
>> +}
>> +
>>   /**
>>    * amdgpu_vmid_mgr_init - init the VMID manager
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> index 21d6a41d1738a..8e450abf2ab0c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> @@ -120,5 +120,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
>>   void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
>>   void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>>   				   unsigned long vmid_mask, bool for_mmhub);
>> +u32 amdgpu_vmid_uq_mask(struct amdgpu_device *adev);
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index d1e956cf8e5b8..9424d94af465a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -111,7 +111,6 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
>>   int amdgpu_mes_init(struct amdgpu_device *adev)
>>   {
>>   	int i, r, num_pipes, num_queues = 0;
>> -	u32 total_vmid_mask, reserved_vmid_mask;
>>   	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
>>   	u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_per_me,
>>   				adev->gfx.me.num_queue_per_pipe,
>> @@ -134,11 +133,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>   	atomic_set(&adev->mes.userq_hw_queue_count, 0);
>>   	INIT_DELAYED_WORK(&adev->mes.userq_notify_unmap_work,
>>   			  amdgpu_mes_userq_notify_unmap_work_handler);
>> -	total_vmid_mask = (u32)((1UL << 16) - 1);
>> -	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
>> -
>>   	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
>> -	adev->vm_manager.vmid_uq_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>> +	adev->vm_manager.vmid_uq_mask_gfxhub = amdgpu_vmid_uq_mask(adev);
>>   
>>   	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>>   	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
--------------uSDpgi70x1Xkf4LSYY0qY2Ji
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30-09-2026 07:57 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6f0ea6ba-078d-460f-9dd7-1b96c7e5bb00@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/30/26 16:18, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Move the duplicated VMID-mask-above-first_kfd_vmid computation out of
amdgpu_mes.c and amdgpu_amdkfd.c into a shared helper.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  6 +-----
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index afcfb92fb9f5f..582be4f0a3b76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -178,9 +178,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 	if (adev-&gt;kfd.dev) {
 		struct kgd2kfd_shared_resources gpu_resources = {
-			.compute_vmid_bitmap =
-				((1 &lt;&lt; AMDGPU_NUM_VMID) - 1) -
-				((1 &lt;&lt; adev-&gt;vm_manager.first_kfd_vmid) - 1),
+			.compute_vmid_bitmap = amdgpu_vmid_uq_mask(adev),
 			.num_pipe_per_mec = adev-&gt;gfx.mec.num_pipe_per_mec,
 			.num_queue_per_pipe = adev-&gt;gfx.mec.num_queue_per_pipe,
 			.gpuvm_size = min(adev-&gt;vm_manager.max_pfn
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 4e37de79f0318..c94a085bf6503 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -646,6 +646,20 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * amdgpu_vmid_uq_mask - VMID mask not reserved for kernel queues
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Returns the mask of VMIDs at or above first_kfd_vmid. Shared by KFD
+ * and MES user queues, which both draw from this same pool.
+ */
+u32 amdgpu_vmid_uq_mask(struct amdgpu_device *adev)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That is a good start, but I was rather assuming that function would initialize adev-&gt;vm_manager.vmid_uq_mask_*hub.

And then we use those values for both the compute_vmid_bitmap of KFD and MES.</pre>
    </blockquote>
    <p>Got it .. so use the same function to hold value in&nbsp;<span style="white-space: pre-wrap">adev-&gt;vm_manager.vmid_uq_mask_gfxhub than returning the value ... and then in kfd use </span><span style="white-space: pre-wrap">adev-&gt;vm_manager.vmid_uq_mask_gfxhub directly.</span></p>
    <p><span style="white-space: pre-wrap">Regards
Sunil Khatri</span></p>
    <blockquote type="cite" cite="mid:6f0ea6ba-078d-460f-9dd7-1b96c7e5bb00@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+{
+	return ((1U &lt;&lt; AMDGPU_NUM_VMID) - 1) &amp;
+	       ~((1U &lt;&lt; adev-&gt;vm_manager.first_kfd_vmid) - 1);
+}
+
 /**
  * amdgpu_vmid_mgr_init - init the VMID manager
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 21d6a41d1738a..8e450abf2ab0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -120,5 +120,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 				   unsigned long vmid_mask, bool for_mmhub);
+u32 amdgpu_vmid_uq_mask(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index d1e956cf8e5b8..9424d94af465a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -111,7 +111,6 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes, num_queues = 0;
-	u32 total_vmid_mask, reserved_vmid_mask;
 	int num_xcc = adev-&gt;gfx.xcc_mask ? NUM_XCC(adev-&gt;gfx.xcc_mask) : 1;
 	u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev-&gt;gfx.me.num_pipe_per_me,
 				adev-&gt;gfx.me.num_queue_per_pipe,
@@ -134,11 +133,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	atomic_set(&amp;adev-&gt;mes.userq_hw_queue_count, 0);
 	INIT_DELAYED_WORK(&amp;adev-&gt;mes.userq_notify_unmap_work,
 			  amdgpu_mes_userq_notify_unmap_work_handler);
-	total_vmid_mask = (u32)((1UL &lt;&lt; 16) - 1);
-	reserved_vmid_mask = (u32)((1UL &lt;&lt; adev-&gt;vm_manager.first_kfd_vmid) - 1);
-
 	adev-&gt;vm_manager.vmid_uq_mask_mmhub = 0xFF00;
-	adev-&gt;vm_manager.vmid_uq_mask_gfxhub = total_vmid_mask &amp; ~reserved_vmid_mask;
+	adev-&gt;vm_manager.vmid_uq_mask_gfxhub = amdgpu_vmid_uq_mask(adev);
 
 	num_pipes = adev-&gt;gfx.me.num_pipe_per_me * adev-&gt;gfx.me.num_me;
 	if (num_pipes &gt; AMDGPU_MES_MAX_GFX_PIPES)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------uSDpgi70x1Xkf4LSYY0qY2Ji--
