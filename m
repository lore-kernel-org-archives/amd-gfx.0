Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE88AC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 14:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D6C10E609;
	Wed,  8 Jul 2026 14:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dChk0iRV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315FC10E609
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 14:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCubAdjku2qvbOoBG+LKhLjN6YYLzSNdYY+o0hHI5HWEDrezSYcGgerBVSIUgxLndboG1YEbn7HPj15NoPdzgWPrCpSK6Of8bDA8G5fYd617gJ0J5QJM4Sg2mle8UhepqEQZKUFAhsyuq3TcFdoiha/BERH8QfgETwfiC3Ktz/RATBUFtBcAX+vb3KRcMknf/Hlgeny1RQKmO0D6q6/yu86vh+KkWnXV3qHM8BdKUxe2EAscifV5a0iEYgRhX2uNqHrAdkI/h64h+FDEBvx3n50pW2aUQOSauscsdVvSr0e5sZ89OveWXNyutXxvlcLijXqSAL4V10JC2f/0bldtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KkAUKUWfufAvJ7dbSMfaTiS5NmLgCcE2ka7mAoTDIk=;
 b=VP7DsaW5I3LugyI4AYeweMUwPV6nfNtX6H7ijnYzkHcaqHK6ABAmF2YibCuwDzLcrBwT3Hz+75woBby+D+K5kDO9Trz9WDHLoEVfPAdznbQe3C/yBrV7dmPMlsGKPuaWi7BOR5MW9wr57Y+08rZnFxb2Q8KuUjRastl49wEtpB8qyLaODioVUB5tg3hBs0jXkXqS6iUuVCAQ7M1NKvDHoiIXY7zV5FU9i6rOqLA73KPcDENO11O1rtb7qIoXgP7eLv8N0DPTAi/URI69bxQEjNdQJ6SjVPnb7XUFAJ9TCz7OyehltMlkcCHVsYM+dRtpA9WxKybXugwcHqsm4olcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KkAUKUWfufAvJ7dbSMfaTiS5NmLgCcE2ka7mAoTDIk=;
 b=dChk0iRVX01xW3aScoB1a+LDhR07jW2n2SXML/TUxKSKf7SzYtTyeHYptTeTZgav3Yo2w+rNKlKKzqj5hvcqNXe4jBXS9Fx2HR7y8XjjxHOyCruOCS941FUKuSzG8mXciWg42Zcd1MvXWDqT2nCNK3uZYz5riXsavTl0uS91OiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 14:47:26 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 14:47:26 +0000
Message-ID: <564d755f-4505-4213-879b-6c97277b8c33@amd.com>
Date: Wed, 8 Jul 2026 20:17:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: disallow gfxoff around gfx/compute/sdma
 KQ reset
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
 <20260707143420.2104857-4-alexander.deucher@amd.com>
 <4730132e-8bd0-44c3-b639-3fb9e7f3c86f@amd.com>
 <CH0PR12MB51392C204D64BC4663A27850F7FF2@CH0PR12MB5139.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CH0PR12MB51392C204D64BC4663A27850F7FF2@CH0PR12MB5139.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::11) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: d879a4be-5cf7-4a66-276b-08dedcffd3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: V4ZDd6R3exSSXqaRiHKN1Ux32Xwoy+MmDgUpKaMgAe88E+1dd8PdS7kCD5tEHVaK5ZrDdMHE9yEu5I9xOSu6E3nedxn0oiPs0upvndljG+E3UxZjewqmLtjV1Be25dzrLp7/qop/SprMF26s0DbVkdGuZ97xauEBZd76PIhWsetltaH79q1jTLSQ9bvHgMz6nPFAb4CiFlWqlpJ5+19uZXVluVf8PUfmfL1Dqmm3z3EyeqZWII7R2SVb+GTKwiUZt2PH5BEuA44GXeg8agkYj7yi8MvUkJ3HQVcXUu50W9OnwDNJoyHVWWrdYBKYRU9ZiZdmZlU0w9cIgrLxPScwTD1kMvwQoqrNtxNwVzQSKiZBDCql4mYRmuKCvWLomEDb1jic/HIO7ObL7cEYtmW/UyHJ+Z7njNTROkd2Z6r7GgOngNNiyrX4jmb0IKypZYoIzK+bYtr5hUD3+7yBTF6Y1xSU3Qe3TVDA3ZSWFNJXlE6S+GD3IbvW+g4e0P3/zq6yvF38N6NpjSoCeVwaczXjIZeQj0qdfPGrJWGIiaOmJwW+mJrJhUpFVB5hcpG1kOcU6RGL/P7sK0gDf9Iz8Nt6kAujfjhYFAEXxPvuj0FapHzZ78B9xuF7v+ZJ7ussAt4o1qvd4+Fp6zwTUFMoC3lqxjc0+pM5mWgHBYZOeIzeRw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cENZQnBQT25vQ2JkbVhWMlg4d1lZcWl2RHAvaklyNXZ0Rng1Tlh2VDhtTVdV?=
 =?utf-8?B?K0toZ2JVWWhJTERNbjltajhoVFRlbVh6UDQ0ZXJEOHk5dzZoZm9GZFlZWktq?=
 =?utf-8?B?ck1LcTl3bjBDWExwZ1pNNXkwcFZCekFQZkQ2MUNXbWUrMWVGMHNPOWg2d0xy?=
 =?utf-8?B?RHpnVk51aGxTVzI5ang0Q2NNZVplR3hwT3hYZWxhZ1prYXlPbVdsd3g3bkY2?=
 =?utf-8?B?Q1YrZFE5cHlNQmJVcVZ4aytWR1dGUXpWdFZwREVXU3A3VGpkZ1NKNFFFMWw4?=
 =?utf-8?B?TDVZYWF3NlhoWVdxVUxKOXJ1NTlBMzUyOS9NQ05mYWluSjJRL2tMV1hCY2FD?=
 =?utf-8?B?Ly9TUlZnTVhrK0Vqa29xcHNMaE9oUDFZSTNKQjhRZzNhK2lXNmZGTGpVR3Zy?=
 =?utf-8?B?TTZMN1YxY3N6NWxmSTgvNFFHc0I5RDJ1cjg5TEEyNEM3Q3lqVnBIRXJoVnpt?=
 =?utf-8?B?Z0NhNzNwQmcrVlFFb281L2VHUHorSVdLS3V0SHZoQW1BUXJjWGhnMmlCNW9X?=
 =?utf-8?B?clpObFZNMzYxY2xVRkZUcVlUM0NRMEN3QitvMXR0ZmVvUHJTNVBJN2RLaStw?=
 =?utf-8?B?R3UwMlhWR3V3aVZFVTlVOWR1TDlCcGg0Z01EL09CT0lKSkJydEFDWng2Qita?=
 =?utf-8?B?VHNxenFhOXdLUkl1R0pDdVExcE1mK3dvdE1YWkh4WnZVVEtndUY1ZUdXQTZr?=
 =?utf-8?B?WjltM0h6L1Nha3JXU2dZa1I4c1RYQkxBcU1GVWl2L1pza3BiTHpxYWdndHVR?=
 =?utf-8?B?cllnbHM2MGlWakpITzYyZUIwUE5wT0xDWFAxVDhqREg0Zm5yQ21tbzREYmlH?=
 =?utf-8?B?WHNvMVZNdTBXZFYwekt2Qk0zalFrcml0amFXQjlBemxWcE9wSmdST0ErUEhZ?=
 =?utf-8?B?bkNpV0FMZG9WQXlYZDNZOGsrZkdKdDJKR2NPNGpyb1MzRFRJSUxiazh0V3c3?=
 =?utf-8?B?MHpiT3VFUTNsMWJkcUErL01uMGZvNmFELzdDL3hKSDY2Q2dnVXRVQ2dvVHJp?=
 =?utf-8?B?Y0RRYWRvMDN4eGVEUnpzbThsRVNVZ1V2TnkvQ2dHZHhJc1BFL2hVb3BOQkZ3?=
 =?utf-8?B?L0hYdFp4YXhyQTNQQ3BxSEcvZ2p4K1FkUHVnTWdSMW9HNUE2dDdIcFNlbHQ5?=
 =?utf-8?B?VHpYcVQ0OEVFQ2xPazZ6cG5aT3hINzJxdmVOcUJvNVN6SkhXN0NvTkk5aHVG?=
 =?utf-8?B?WVVjSUI4UjU4dTdpQXdpQ0Vzclhzb0J5TVFwQmVialFSUitCMURwSXMyTzNj?=
 =?utf-8?B?RkVWNVdWeXBodzBpZWY1cVVoNkxFSWliL1dmNG9sQmhIa0FQV0o1a0tvRTR2?=
 =?utf-8?B?R0t1OVlJVVMrNEd6dXRvY3FVcEswdHpYblNTYUY1RVhycG1BNER4UkpKWm1l?=
 =?utf-8?B?L2VXU1M3MFQ0TEJBcVdTa2V3UG13czBWd002ODVsSVJ6ZjZuOUd5MDB2ck9P?=
 =?utf-8?B?aWxFWkkyWUdRZGozMnljYVM1enVSVG1CSHltOE83b2U1ejc5ekpydWl5MnV6?=
 =?utf-8?B?TTgzeUFDcUJmZmE3aFhIWHdWcDAyNnNYNXh1WGJaNmNSdlBIcHZocHJaWFNh?=
 =?utf-8?B?Z1hWZTJYckFUclFjZ0tLZ29qRzhhRHNuRnVDQ0JwMjZXZi82YnF5dU14SHo0?=
 =?utf-8?B?Q0ZjZjB3NnBKaFhIRm1OQ2JaeEE2TmtWcyt1ZFJFYjNkUTROUUs1RUVwamUx?=
 =?utf-8?B?QTZicUhRbUJrSVhyYUFEc011UFpnTnJYZmdGSktGVHBrSitDVXdGNDYwd3dP?=
 =?utf-8?B?UmhUODdTcjNFUXIySmhaeEZSREtIdmgzM01qZitoSFp5aDFXdE5rMWVMTm8v?=
 =?utf-8?B?eHpuT2pkaHM1Z2RZYVd4dUlLT0dvOTd6dFlKb0tNNit1aE94NkJILzdJa1BS?=
 =?utf-8?B?UWRzMzZEcmRlUTZwOFhPa1dDYlRIS3hLM04zckNKS3djQllvVFdwSXVlYzFK?=
 =?utf-8?B?MFFBUGJQTnA1VFdJNlVob1dBeC9zdzYyTDVaRGxEZVBmZGpWdEFLNUNGcEhS?=
 =?utf-8?B?aTBOazhmMDZDOTBsMm9qTFdUN0JVWlBhUjhUS21xMU1KamlXZ2hNVjBMU1I1?=
 =?utf-8?B?cTVLTU8ydjlqSm5xekZ0amdZaFFWbTBuV0tNSS9UVUFwb1pxOG03U1Q4OENx?=
 =?utf-8?B?bW5Zb1FCTFhNUHovejBpNzMvRjBCVUt0NFFWSnZFUlFoWGVISTRYKzNKczFR?=
 =?utf-8?B?WG00MHZORkZYVll0Q3VVUDk2NzhocWU4UWxKSU92V1hMQmZsakRFOW9Hck80?=
 =?utf-8?B?WGh0VWdra2UvSXV0VmlNYzdpSEMxNU13dGJxcGxwYklQQkhPVCtMaDJrYjBZ?=
 =?utf-8?B?ZlRpdVBLTDdOU2VwL2EwVW1lVndoUUFualRZYjZJc2EyMGVELzR1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d879a4be-5cf7-4a66-276b-08dedcffd3f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:47:26.7296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLGZYHWtEKGAk8FkhBL9W8FMgTJEpY6lTMPUfjuvg8y+Sw5LRghcL4PdoACllkb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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



On 08-Jul-26 7:29 PM, Deucher, Alexander wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, July 7, 2026 11:34 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 4/6] drm/amdgpu: disallow gfxoff around
>> gfx/compute/sdma KQ reset
>>
>>
>>
>> On 07-Jul-26 8:04 PM, Alex Deucher wrote:
>>> If the engine is hung, we shouldn't need this since it won't be
>>> powered down, but we could potentially have a case where a queue can
>>> be preempted, but due to logic errors in the commands, the fence never
>>> signals.  The engine could potentially go into the off state.  Protect
>>> against that.
>>
>> On a second thought, is this a real case? If engine already goes to off state,
>> wouldn't everything be reset by default once it comes back?
> 
> I'm not sure if gfxoff will actually enter or not, but consider the case of an IB which is waiting for some memory location.  It's just waiting so the queue can be preempted, but when it's resumed, it just goes back to waiting so it needs to be reset even though it's not hung per se because it's fence will never signal.  For compute queues at least, we peempt all the queues in the reset handler and then reset the bad queues.  In theory there could be a window there where gfxoff entry could happen and then we may access a GC register via MMIO when we reset one of the bad queues.
> 

I'm assuming IB execution will be considered as some part of GFX being 
active. A wakeup from gfxoff requires external intervention, so it's 
unlikely that it enters gfxoff during the wait. As far as I know, only 
doorbells could trigger external wakeup.

Thanks,
Lijo
> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index b5c2d1d4d8839..c8a1aa88a9de0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -137,7 +137,15 @@ static enum drm_gpu_sched_stat
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>                      s_job->sched->name);
>>>              /* Stop the scheduler to prevent anybody else from touching
>> the ring buffer. */
>>>              drm_sched_wqueue_stop(&ring->sched);
>>> +           if (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
>>> +               ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +               ring->funcs->type == AMDGPU_RING_TYPE_SDMA)
>>> +                   amdgpu_gfx_off_ctrl(adev, false);
>>>              r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>>> +           if (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
>>> +               ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +               ring->funcs->type == AMDGPU_RING_TYPE_SDMA)
>>> +                   amdgpu_gfx_off_ctrl(adev, true);
>>>              if (!r) {
>>>                      /* Start the scheduler again */
>>>                      drm_sched_wqueue_start(&ring->sched);
> 

