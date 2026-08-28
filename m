Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D784C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9878510F409;
	Fri, 28 Aug 2026 15:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pl5v+gLG";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD6F10F409
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntbEsWCH8FrwRHQMAStFqPgEoja2907m7agmRasPxueVKcgSb/R1HMI02+295sUVRHjSWme68s10WaEQ5t7YWX9+wgJTWAr2tQwXnqbNEOptHty3G2iqtOXfGKEicTjNftp2mbpPlPuMDcR9+Bc4i/GhlCpDOVH5cgPpu3VUWkSxCw9cMpMCaBygv41ph5Wx2HTe1kGV/0nvuqgZXIjXaNV7AfhDnV1fPi64BCcdHA/eb7GJCBUzwJC80w6dqeWLQUBnxwy0XO/nu8hk7SXoCk4q7O2QM7ORBBAgyGuv7LTi6NfuWDgWqXAz1GE4uhJfx2BeEQ+nGb7wI0T4I4uM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3QP82Ci9jIC8SqaP+4bQZiuqU+0K07j21GnjJerRBQ=;
 b=fh9AsDB3wvmrfoGMrNinUeLZLgXOFkQa8xXFcGnSeRiS8luNRUCF2sSIrqtCAZKNnsNuqKcdJayiOFUWIC+bDKRA6kHBywdpZV/9x1hXAHnieTG1C8Ymzsvw1sbjV1A98KzCAEZdtWRfbmOI8+8W8EAVmyaUl9Fu/4GIB4cSuXuvjZVX4TdAnHmmnTM6QiVR4UxkbbNsXhEGhHlnSQJXgnkvoDBu8/rO78JGaznS+MgEFU2rKOm7SIjbaCS4uBFaM0S+nT8CKRwAtnEA07Nszfjz3CCHq0wmTDn6Db6Uayc8ECcVnCjNrpW8Vd8zcCZbVkUPOjBX7m3w6fBsaI5AvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3QP82Ci9jIC8SqaP+4bQZiuqU+0K07j21GnjJerRBQ=;
 b=pl5v+gLGnCIc5aVFjXtA+o3CVz5z+TVjoCM0hTHRB8VP4cz5g71fq0YbeuIH0/Y3QPF7JAxUWiAIoBFdcOzBVBD8D8O6EuI4uX++ouF2TSke7GgkHjLovp/uQcI7ffktvbk2pRo4hvPRv5RtaRYx/9u2tu3BPQ8OCr+avnJN2QA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:53:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:53:59 +0000
Message-ID: <a9178bad-bf11-48d9-871f-15eb67335ba2@amd.com>
Date: Fri, 28 Aug 2026 21:23:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common
 code
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-4-timur.kristof@gmail.com>
 <032550fc-5680-4f6c-974c-fe96cc8083e1@amd.com>
 <EhsDbURtRYeOUXN6bnOG9Q@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <EhsDbURtRYeOUXN6bnOG9Q@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0148.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::18) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: 956a464c-72b9-43b2-6d07-08df051c92b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: lhZ3yFmLnJn2V4rgL9iSk7cX5o9Vhco7IVNyW14l+1WyHSBsOEU9fu+F0RUm/pDLs5RK5rH9c+mQdbBA/PJbJwSwzKntjgE/HNeXyaZTF1q+qRJvoWG8czkIk5D6aQXGPGte0no0mUs8ZkkeUuBxiXyf9OHvvRVkPhhUp59s+128Uvl6LRhcyj8AmMVkdNr+FKsRVBkWa8UvEuuw9pe+u2oNtzodwB66Qe1vbCXOmTJobptX1HgTEqIBBY34Qbq1llFDb45blANysSKhY2br8RYPWTjTGLwsKq364B/k1WKrd0F+bvLvQXjvRIHxzaAmWyXLndGQo24iTdAgmkfZWHMj3a4xg3eXKQmfBOvtztoQw+0DfoGXM4+UwiLznAdg46SzfEtQQhXUOu1KYpKnUvByR8bBaKyc8E0OaTjwFViQR+d1P20pP5HvqpVmewwF5ZhPqMmNF64fNlkcAz5WoWjw6jhpcVXjypzK5L3sKjQE3NR/dgWi8vsy9rK1Y7P2qW8apBRNVy4C+D+Sp0hydiJlu4YCXIcZ6Zp9EMQCbIPzIbKV5a7ctvJPnEt4+y19Ck4bQpdzyNXUcMrykfOOpU7KKl2vr16DtejTeLE6kMCnMvD/ZC1gH+dSJwYAG42pDq4H8TcrElhiRukqBerGpNLeKpv61VwSH80Cxn8M6RE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmttV1JPa3EyVFlhL1c5eWxJekZERW5oRE5kOW82QW9oZFN6d01DeWdjeGRJ?=
 =?utf-8?B?U2dxb2owdEFESHdseEFGSCtVazNtbnIrYUlsbXVPZ3c5SDVmdjAwR3ZBM21Y?=
 =?utf-8?B?R0UyQTZDaXpsemI1UlVVZWxaa0NhMzlRSm8rSjY3T2tzUDM4ejM5aC9Jc0tv?=
 =?utf-8?B?ZUFBcDIzQWxTWXRndWV6YlB3Zm9OQlNnU3pWTHROTnNXaGlqZTVoaDFpbTVY?=
 =?utf-8?B?TUVqM1dlcWtmbzc1MVA2T1UxeXlFSHRyMFlVZC9kS1hBZ0E0UHhhdkYwb3Ur?=
 =?utf-8?B?V2p2UTNPY1N4WldJZWhaZWtWN0Z0T3BUc0dDcmsyWC9sOFdvTUxWRUJVc0NG?=
 =?utf-8?B?VVlGcGF1QkxNZkVGS2dsZTJUN0kzcU1MZGsyTDNGcjZuUmU1bmZTT2tRQVBW?=
 =?utf-8?B?SlJxMjZmTGZiaW1yMFF3c0RMc1RCTFJveE00cVBaM1lnVExvK2o5NXBsNC83?=
 =?utf-8?B?MTRUNjB0UUU5TTk3Q05tUy9MR2dtYmQvaS9nN2psKzFqVTd6NFdNbEk1RElM?=
 =?utf-8?B?Q0E0Wm0xK2VaVGFsQWw5SVlsc0VINW5rUE5PdUlkWkRrbCs0eFduZktneWVa?=
 =?utf-8?B?eXdlV2tUcVNnazBEdFNicXdxNXFpb0RnNjc1cndiRm4reXM5SzZMTUlOcEJG?=
 =?utf-8?B?aXdJR1UwOHdFTHpPS25DTnpDNDhPSHI1SHI5ZmFVMzFVNm5xVjlKQUx5Q08y?=
 =?utf-8?B?U204UjBTL0E3ZisxbWNFcy9YemJmZVpOTWtQaWVjcjgyWU5haisyVzE0R2dF?=
 =?utf-8?B?b3I0TG5XT1NRVjU5YTNiTitmdWlUZHZhb0VKVjlLZUR2K3JHQTRnR0syWDRL?=
 =?utf-8?B?Q2g4ckE5dDN3SCtETTEwOWFiMlR2cHRYMjNORGpRTG9MZW5qSmpuWnhWSE53?=
 =?utf-8?B?LzlTeFpWa29jOVVSQWFJVFBtNzRlN0xpckJUSVhEc3ZNcmxvcmFpRHZIbGdP?=
 =?utf-8?B?Z0tmSnJFZkMxb2xXKzd0ei9zSGZxK3JWaXdGZHU1NGZiTUp5d3ZXeFJ3YjRM?=
 =?utf-8?B?RmpNNm1yczd6U284eFA2ZytlMExLUjFDTGlsT0F2bmp1TjNBN3pqWFdSYVU1?=
 =?utf-8?B?aGU4MzJuSEdoUndsWDNWWU1PZHY2L0JIQWRmR0FuOUJmQkZTM0FSZkRWcGJD?=
 =?utf-8?B?bnJYazduOGlwLzFYM2FTTDlvclloc0ZBOG5DSTlxTk4rNjBjZVhEbDZpSy9H?=
 =?utf-8?B?SHZ6a0JVRWNYakJoUzc3bVdnczNOWDdFcEV0Z1djWjFkcG8xUEtOZ0RHQjNt?=
 =?utf-8?B?dXE1dzY5U0Nsdk9tL21ydk8wYk1Tem1EWjRJM3BsOVNsR2JvOUhrZTFhK1RC?=
 =?utf-8?B?M2tmamFvajFhODZSMG5VNytreFBiU2R5QjRONUpIVHNhcHo3b2NVNVdJdzF4?=
 =?utf-8?B?UVoybVlnYW1TV1FnRGdkY3hqYWtzRGJWcGhvS0tWTENMYWlkaDdDZEpXTG12?=
 =?utf-8?B?VXdiTVBpMWNsUjdRWGpEU0RFQTFCVjJZOEVCOTJVa3NEazd2UUJ5aWZlYXhF?=
 =?utf-8?B?UkNqYXV6TlJ6RTlQdVhHM1BFdHVJVjFpOEo0c2U4ODRyU2Y2ZjVSb25sZ3h1?=
 =?utf-8?B?MllCQS9kdlZxaWJLZ2JqOGVTbWxVZSt3ZVBTRDhjTzNtMnFSVHdDU2ZveEQ0?=
 =?utf-8?B?U1FjZ3dtdjhKbXdiUVhhZ3RHOXllSXkzWDN3ZytCN1FRRVlQQ1Q2eGJxendk?=
 =?utf-8?B?dHp0ZExJVDc2U2NkZmxMKzJwWTBiV2orb1c1WjIzbHlic2hkcUNZcURkcGZP?=
 =?utf-8?B?RitqQXZkamRaY3E2U1E3L29JcytaMVhjc3JGUmZtaTE4TUFOSWFPWloyZ1hK?=
 =?utf-8?B?ZzE2VDgxaTExU2JjTUJ4S3BQMkhjYmFydUJ2Q25SMnNRYytzMmpieXV0NkxH?=
 =?utf-8?B?VVZHNTFTYXRpM2I0M0F4bFJTRkVaK0NpeEtHR0hBQWkzbUNLaXBLTHdNOHBH?=
 =?utf-8?B?QXFmSEJ5K3pKNmR3dC9PTHRpWExZNU1mazhUdW5PV3RaUkRiaGNqQTNQcFVm?=
 =?utf-8?B?SWVpSTZyekhqdis3b3hldEt0T0lyK2gzajc2UXZmRDd5b3ZBL3BoUzMrc0ZK?=
 =?utf-8?B?RDFvSHI1YW8ycE8wL0twR1NKN3RRR2J6Yldwb3VmaWY4UTN5OWk0VnZYbVR6?=
 =?utf-8?B?TWI2SW8xSTNCUFVtdDhFRTlIWEFjdVpkQUNTSHRrVWVRSHU0eWRYcWJETElM?=
 =?utf-8?B?d0lTMHFCZzJrMHBjQ0RYM2ZMa05IV094dXlweFNhNjRuK24wMVRyR2VLWk9y?=
 =?utf-8?B?dGFNL0ZGWHpndmV4aDdiQUptU0FOd2lMQ0dnKzk3YWlPaldhYzQ4Z0dtMEdz?=
 =?utf-8?Q?YzTVRIUdBMJjV8/gyL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956a464c-72b9-43b2-6d07-08df051c92b6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:53:59.0546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1aRW2rSI2TMdgYshc58ASXs5P7SMe/3Yb3ioJduX4OF+/8pC8TSD4NDirJy6jh7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D
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



On 28-Aug-26 9:07 PM, Timur Kristóf wrote:
> On Friday, August 28, 2026 4:20:19 PM Central European Summer Time Lazar, Lijo
> wrote:
>> On 28-Aug-26 5:37 PM, Timur Kristóf wrote:
>>> The code was exactly the same between SDMA v5.0 and v5.2
>>> furthermore the exact same implementation can be shared
>>> between all SDMA versions that don't use MES.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 37 ++++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  4 +++
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 25 +---------------
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 +---------------
>>>    4 files changed, 43 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index
>>> 66f278f77f71..9eebd8380834 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> @@ -635,3 +635,40 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device
>>> *adev, uint32_t instance_id,>
>>>    	return ret;
>>>    
>>>    }
>>>
>>> +
>>> +/**
>>> + * amdgpu_sdma_reset_queue_legacy() - Reset legacy SDMA queue after
>>> timeout (without MES) + *
>>> + * @ring: Pointer to the ring of the SDMA queue
>>> + * @vmid: VMID of the timed out job
>>> + * @timedout_fence: Fence of the timed out job
>>> + *
>>> + * Common implementation for resetting SDMA queues without MES (legacy).
>>> + * This relies on the proper amdgpu_sdma_funcs to be set up
>>> + * for the given ring.
>>> + *
>>> + * Applicable to SDMA versions that don't rely on the MES yet,
>>> + * that is all versions up to SDMA v5.x and older.
>>> + */
>>> +int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
>>> +				   unsigned int vmid,
>>> +				   struct amdgpu_fence
> *timedout_fence)
>>> +{
>>> +	struct amdgpu_device *adev = ring->adev;
>>> +	int r;
>>> +
>>> +	if (ring->me >= adev->sdma.num_instances) {
>>> +		dev_err(adev->dev, "sdma instance not found\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>>> +
>>> +	amdgpu_amdkfd_suspend(adev, true);
>>> +	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
>>> +	amdgpu_amdkfd_resume(adev, true);
>>> +	if (r)
>>> +		return r;
>>> +
>>> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>>> +}
>>
>> Instead of moving it here - sdma_v5_x_reset_queue and using it for 5.2
>> is better. This may not work in the same way for all legacy queues.
>>
>> Thanks,
>> Lijo
> 
> Hi,
> 
> As far as I see, this function can be reused for all generations that don't
> use MES. If you don't think so, please explain why not.
> 

This function doesn't take care of paging ring (if enabled). Or, this 
could be made simlar to the one in sdma 4.4.2. It also makes use of the 
helpers, but not sure if the sequence reversal (save content -> kfd 
suspend vs kfd suspend -> save content) has other side effects.

Thanks,
Lijo

> Thanks,
> Timur
> 
>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h index
>>> 4f4e56022c97..7c4e145ca0c1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> @@ -160,6 +160,10 @@ struct amdgpu_buffer_funcs {
>>>
>>>    int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>    instance_id,>
>>>    			     bool caller_handles_kernel_queues);
>>>
>>> +int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
>>> +				   unsigned int vmid,
>>> +				   struct amdgpu_fence
> *timedout_fence);
>>> +
>>>
>>>    #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t)
>>>    (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>>>    #define amdgpu_emit_fill_buffer(adev, ib, s, d, b)
>>>    (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c index 0da54c335822..76f8765fb175
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -1518,29 +1518,6 @@ static int sdma_v5_0_wait_for_idle(struct
>>> amdgpu_ip_block *ip_block)>
>>>    	return -ETIMEDOUT;
>>>    
>>>    }
>>>
>>> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>>> -				 unsigned int vmid,
>>> -				 struct amdgpu_fence
> *timedout_fence)
>>> -{
>>> -	struct amdgpu_device *adev = ring->adev;
>>> -	int r;
>>> -
>>> -	if (ring->me >= adev->sdma.num_instances) {
>>> -		dev_err(adev->dev, "sdma instance not found\n");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>>> -
>>> -	amdgpu_amdkfd_suspend(adev, true);
>>> -	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
>>> -	amdgpu_amdkfd_resume(adev, true);
>>> -	if (r)
>>> -		return r;
>>> -
>>> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>>> -}
>>> -
>>>
>>>    static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
>>>    {
>>>    
>>>    	u32 f32_cntl, freeze, cntl, stat1_reg;
>>>
>>> @@ -1936,7 +1913,7 @@ static const struct amdgpu_ring_funcs
>>> sdma_v5_0_ring_funcs = {>
>>>    	.emit_reg_write_reg_wait =
> sdma_v5_0_ring_emit_reg_write_reg_wait,
>>>    	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
>>>    	.preempt_ib = sdma_v5_0_ring_preempt_ib,
>>>
>>> -	.reset = sdma_v5_0_reset_queue,
>>> +	.reset = amdgpu_sdma_reset_queue_legacy,
>>>
>>>    };
>>>    
>>>    static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c index 5543e381dcca..e7f4b74f27b4
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -1436,29 +1436,6 @@ static int sdma_v5_2_wait_for_idle(struct
>>> amdgpu_ip_block *ip_block)>
>>>    	return -ETIMEDOUT;
>>>    
>>>    }
>>>
>>> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>>> -				 unsigned int vmid,
>>> -				 struct amdgpu_fence
> *timedout_fence)
>>> -{
>>> -	struct amdgpu_device *adev = ring->adev;
>>> -	int r;
>>> -
>>> -	if (ring->me >= adev->sdma.num_instances) {
>>> -		dev_err(adev->dev, "sdma instance not found\n");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>>> -
>>> -	amdgpu_amdkfd_suspend(adev, true);
>>> -	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
>>> -	amdgpu_amdkfd_resume(adev, true);
>>> -	if (r)
>>> -		return r;
>>> -
>>> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>>> -}
>>> -
>>>
>>>    static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
>>>    {
>>>    
>>>    	u32 f32_cntl, freeze, cntl, stat1_reg;
>>>
>>> @@ -1951,7 +1928,7 @@ static const struct amdgpu_ring_funcs
>>> sdma_v5_2_ring_funcs = {>
>>>    	.emit_reg_write_reg_wait =
> sdma_v5_2_ring_emit_reg_write_reg_wait,
>>>    	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
>>>    	.preempt_ib = sdma_v5_2_ring_preempt_ib,
>>>
>>> -	.reset = sdma_v5_2_reset_queue,
>>> +	.reset = amdgpu_sdma_reset_queue_legacy,
>>>
>>>    };
>>>    
>>>    static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
> 
> 
> 
> 

