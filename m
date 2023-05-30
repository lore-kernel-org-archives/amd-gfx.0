Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C0BC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 18:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820E010E1E8;
	Tue, 30 May 2023 18:05:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E10510E1E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 18:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIUxKYK0nvaP6087Q+ou06hQL07eSIDz8j1OzlyG4vBhPl4znpHT3+VxViBUXDenORVKsBQwkzwkUmHADbSrqMXetK2v5hCtC/681zgKED8yug9YDB0ZlQ5T1dW/jLxzRiDFlcqn5EyZpTEpztrM5LfRmsJbdLYxVQz1IDOmhp+UEraohXP4Z191QDhE7w9jWOMhuLtfCWFLFnFIdwP9wDMyo3oBI9innqtuFGwrVu+XWP5XPUQssv7c5nQqd11VBtVcSEyjxeSEY8HlXKpBhu0GTjCFD/7FWmadsS5Q5ekqVxyeh9Jk/+/iwUpQtCoSAyehwF924gNNbDBN7AOkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n15X/QkOvYGzkXLi/JytuYpWAO3EIohfaTsrJ0G0Sw0=;
 b=AmPwK6+2gtNfaERHTjTtyu2CQZAH6iqUJPNo3Mj0P0YazMsS2SY2tE4zsOz9zcvh0+qZx3oPfHRQD21Bz+Mn5Or3NnoBxiAKxVZcg0c+kOjScG5G+jTXVVmMP9nn9voHqNuZ8umTjjxnmhT0sF6pRoXbBe2C4oWdf8AZ26oN3xvvuFbDUE7Jxp6yJ/yB44Jh+cSLCrP75iXIL2S4T12FWYWg/OpB+HRM1+S7dZzdYlTId+na4YX2nIrqho0OjRKbVdP3z5en2NDUiuqDg8sDPlgb/wetuK9eVO9rowcfKZBK9YezHOo7gI91X7erV1PGUX16i2XcFUAWWBLSg8B3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n15X/QkOvYGzkXLi/JytuYpWAO3EIohfaTsrJ0G0Sw0=;
 b=UvYX131P+6/NmgEWLGadRJ+8PA661rB3q4KX9y3FytzsrnVxQ6uwlE8+eNRpRq+h1UOrtXsf8x/KbdSC4kK1o4pA4vMpK4XNRQBjRWeVQCYIo090XeSgdaVAEjw2+XnehyD9L5NwueisseQ1534yoYIcCXe9/ysHMD4bF2Ve3ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 18:05:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e566:9ca5:28e0:a42b]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e566:9ca5:28e0:a42b%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 18:05:36 +0000
Message-ID: <62332367-872e-bfb2-94dd-b4ee174d3836@amd.com>
Date: Tue, 30 May 2023 20:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Add a low priority scheduler for VRAM clearing
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230517214040.539342-1-mukul.joshi@amd.com>
 <41e91d4b-7504-a431-d891-ac5e79c5b80e@amd.com>
 <d9a0013d-642a-afb5-27de-93d085a796f2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <d9a0013d-642a-afb5-27de-93d085a796f2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab12784-2bd1-4a76-f1e1-08db613877bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+83qcaRdVWBHJIRIKyJ3JDv/YmjPxaQcz1Aew4u0bl4BmgsNZJ7/KzUoaQLNTq+dhanpndlFikXBKr8D9uRiW7Obf/8s0ybmlBrpIDpDJDov+/erCpUMbGh1y5RB80BIbQPKv2UMp6drM6RIk/f/uukilXWYD/NO5x65dcRkL7yhhr11WvOkAUdUFjIdnz8QXvTzbTPVtjYwzdFuo3M90wv7hTSM0Ma3RuQxH9EECbfNTq+s1qEP4cFLW6KjAVtaMo/uPmgSEkQdxpDuZmX1tE0dAt0i6HZoTmU1PIvMGNgY1+0zIoU1IcX+2+BTvGX3u5cRFNITsTQcYulvKB8wgZUveH+VO+wtzEY/pr1guWumlI6HhWhU3/DL6WK6wLkg7eqZGu221jOnqgsol7r32P1l5yqi+m127EPHdOFS6gaxPoP6YqP/13NT2F7S7oFy4KH9iv9mKuzdof/p98+T/ts7uUaZ2jg9td7nIFmcdlt48LysIKI5CvIfivKnGMClvYSajczbLfJD0XqltqCUpz/igD57xME9GZ1OuoiCk40hSsdMUFsUFUybEXMVXjwdmLuPaECi0E/AJw98Esazfa5kTkxMk39+1SDXliAfDUztCB8uIkCv4s/p/Ba9tGH21awcDKGW0jkIkbnAf6AZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(86362001)(31696002)(36756003)(478600001)(110136005)(316002)(66946007)(66556008)(66476007)(6486002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(2906002)(38100700002)(2616005)(6512007)(186003)(53546011)(6506007)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dhenl5S3poUkxMdWJCWm9MRUQxNzB2WiszZU1mem5QUVlGMk1ZbTlhUUVm?=
 =?utf-8?B?Z3NBM1kyeDRlNzVaWEQ4YUEvcml4YmZqMUxXbWhibEhMYlhlTWtneTl2V2ZN?=
 =?utf-8?B?WGZBSkVuRVh5MWdMM3dUL1FUazAxVHRYSUFTUGJSczJLTWRDcjYyeW8rV05q?=
 =?utf-8?B?Mk0zell6NGZsZjVMeUZRR2I1WHlFUVdIWjdtOUZGemlYVENtaWNMRXRYanJR?=
 =?utf-8?B?VTNHOTJJRVhyM1MxbjRlalhpS3FrenFZYnJaYk5FT2ZNbmdaRXJ4OU45Zmtj?=
 =?utf-8?B?MlMrQ0NNVHJOaGlDSGxNNHlWNExIMWFGSzBDdndFdVVibHhoekpLbm4rRER3?=
 =?utf-8?B?NmJjeE02dHZuaUgydEVpWUZudzY1eDVvY3NPNnBBc2ZTMWF6cEtCd0pKQ2d2?=
 =?utf-8?B?MWJFMXByaGZyWFQ5S1MybWdTYTVRSXd2eWtUZVowVWJMZEpSWUpsVlFKSjlJ?=
 =?utf-8?B?c2hQMXZ6b3RBeU85L0dqM2NDMDNxOTQ2RHpQTUtzdWw4Ylk2WVZZNVlkeXZi?=
 =?utf-8?B?UURFN1N4elZzcHFiTzNTTWhET1NVdnRxYmI3dG0wMWVTOE1ORDdSK0JXTkpB?=
 =?utf-8?B?KzF2c2QrTFJVYmNIZloxcytUVmZhUUJmR013NmpXSDJzKzFuTyt6S2JQbFo4?=
 =?utf-8?B?bytDVjRuSEQySWd1TENQSXQ5QmhKS1V2YmpUSDgzWE9SM29lTUgxZ1ZwMWNV?=
 =?utf-8?B?ZHV4OWtKZTBHV3p1SkhUSEtWQmI5dDFVN0lRL1VuKyt4WllLd1R6UGhSQUdn?=
 =?utf-8?B?T2d1VXRYSUdidDc0QUdCS2c0c2dxL3hIcTRJWVRXT1k3dU1YSGdXYlJRNkg2?=
 =?utf-8?B?N0dqejFJdHhsT3Z0cUdmb2JGQVJCaS9McDRxQlZoV2p5aDRVSTAwNUtUQ1BC?=
 =?utf-8?B?cGhOU0tweHRIVUVVbFNzMXF2clo2Z3hVUEtwRThzZlAvWGhOQ1JwZ005eGRx?=
 =?utf-8?B?cm9icjJwczBZRHB0VXpLYk1sQUQ0ZFFEcGNkUEFCbjQ4WUZrajJLenB0MFhp?=
 =?utf-8?B?ZmRtTUpxR3JQUFhyMzJFckJzRTZSWlRLTTZ1YWlJV1VreVRUK1hBMXJEV1pB?=
 =?utf-8?B?MHdPUGV5cTVPRjJGeEQ3NG1TdnV3YkRmUSttMDdienhWWFlWZlZOdC9vOWla?=
 =?utf-8?B?NGNaN2lXb0lBVjBhY2pQL1RNZkJwOE5OSjE1dGVKbUdYdTRPdGlvQ3lOenFT?=
 =?utf-8?B?citKZm5oOHdsSnE5aGVVMEdGMlRKeW5QbmxReFUrQmhhcXJ0ZnRZUmdHVmtO?=
 =?utf-8?B?QUt6UytBN3laVy9aVTBMaDU2dE8yMzh2MUFiNlR5V2ZvQzc2Z2IvTzF3U3Zr?=
 =?utf-8?B?RUhPQnN3Ym9zR3JRakYrS0VFcll0aTJRcElycnYzcWxvS2plT3Nxb3loSmNS?=
 =?utf-8?B?WGpuNDFIWm1iYkFOT3ArR3V6TUZmU0F6SjVmNE9TYVR4dEx5MnhVcFc2WUhr?=
 =?utf-8?B?dkNaSUVYRU1tc3N1L2gzeFpUTXJPbmc0MHdyckd6T3V1eERCajlyVWNaRGtz?=
 =?utf-8?B?Umhwc0RxZGQwdWUxOXZuWGdpNGEzbnNBOU42OTR2WWcyNzhhNFc2aWVaZGk1?=
 =?utf-8?B?Y2NtQ3VhUVNLQ1lxUHNvRGx0VXRLVlJQS0E2WVVRektmTEc3M2RqN3FBa0VO?=
 =?utf-8?B?blhTQWEwYjFXUG13OGlFWTdkbGtVRU9xWVhvV1dkL0ExYzRhbmZNZjNhL1NX?=
 =?utf-8?B?Z2FwV1BZQVg1RkdaMlM5Z0hnbWF0LzNvMVRxS2tSNUJ1V0I0ZWF1dnVrdUpm?=
 =?utf-8?B?bE41RDVOMmN5STVyUUNLU2Z2bG9aOFl6YlFHM2UzZU5EQVE4bHl6dWIxbDhN?=
 =?utf-8?B?R0NjZlJKbWUzU2VqVC9vQ3QzZzdGR3ZvbXYxN2NzK0d5OWhPZHJHSW8vckMw?=
 =?utf-8?B?d21rRjF1UW9TazFuZXM2ajdPeXV2MHBIYm1ZSkwwVGZTRXBvN2FTeUlzL05i?=
 =?utf-8?B?cURYVmpsV0g4ZXd0T2RVdko4MitqSnAzeUlyOGs4aHFHaXY1RStCQW9iY3FU?=
 =?utf-8?B?L1JxMSttajVGZDM3bkx4c2xqczUrSXlydWRwcHlmZFhpV3BITDBHODV2Z2M4?=
 =?utf-8?B?YnpzQzJuWWw0SVg2ZjN1M2RuR0VqQTBmd2t0VFVodHBOclFWZlc3eDhiZysz?=
 =?utf-8?B?ZW42TENCdzhpcCtaTzdRTDEyTXp5Y2FSSDJQK0U0ZjE3MUJMV0NVWE9ETm1M?=
 =?utf-8?Q?TZ/UchrP+Wpt3H3WG7bM/fTwNTh1/zfkSuLSLxfnYLjB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab12784-2bd1-4a76-f1e1-08db613877bf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 18:05:35.9856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feZhjsVZ6yFgGw4DHeM9LymlGO+IJfDf63Us0LJQHrzwWDe06omm380Gbe0zQMpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
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

Am 19.05.23 um 03:09 schrieb Chen, Xiaogang:
>
> On 5/17/2023 5:10 PM, Felix Kuehling wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> On 2023-05-17 17:40, Mukul Joshi wrote:
>>> Add a low priority DRM scheduler for VRAM clearing instead of using
>>> the exisiting high priority scheduler. Use the high priority scheduler
>>> for migrations and evictions.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 37 
>>> ++++++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  5 ++-
>>>   3 files changed, 34 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 9924c8de57ab..46f249912b67 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -627,7 +627,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>>           bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>>>               struct dma_fence *fence;
>>>
>>> -             r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, &fence);
>>> +             r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, 
>>> &fence, true);
>>>               if (unlikely(r))
>>>                       goto fail_unreserve;
>>>
>>> @@ -1354,7 +1354,7 @@ void amdgpu_bo_release_notify(struct 
>>> ttm_buffer_object *bo)
>>>       if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
>>>               return;
>>>
>>> -     r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, 
>>> &fence);
>>> +     r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, 
>>> &fence, true);
>>>       if (!WARN_ON(r)) {
>>>               amdgpu_bo_fence(abo, fence, false);
>>>               dma_fence_put(fence);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 34724b771ace..bbdad0dc1b07 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -384,7 +384,8 @@ static int amdgpu_move_blit(struct 
>>> ttm_buffer_object *bo,
>>>           (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>>>               struct dma_fence *wipe_fence = NULL;
>>>
>>> -             r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, 
>>> &wipe_fence);
>>> +             r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, 
>>> &wipe_fence,
>>> +                                     false);
>>>               if (r) {
>>>                       goto error;
>>>               } else if (wipe_fence) {
>>> @@ -2040,8 +2041,18 @@ void 
>>> amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool 
>>> enable)
>>>                                 r);
>>>                       return;
>>>               }
>>> +
>>> +             r = drm_sched_entity_init(&adev->mman.delayed,
>>
>> I'm not a big fan of the "delayed" name. But I see the parallel with
>> "immediate" and "delayed" entities in amdgpu_vm. We may want to rename
>> adev->mman.entity to "immediate" as well to make the distinction 
>> clearer.

Well NAK. The delayed and immediate names in the VM have a completely 
different meaning than here (e.g. memory management restrictions).

I think we should just name them high and low priority.

>>
>>
>>> + DRM_SCHED_PRIORITY_NORMAL, &sched,
>>
>> I wonder if this could even be DRM_SCHED_PRIORITY_MIN to minimize its
>> performance impact on page table updates and graphics user mode
>> submissions. Either way, the patch is
>>
>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>> Thanks,
>>   Felix
>>
> I think you may make it more general: not jut two drm_sched_entity at 
> adev->mma:
>
> struct amdgpu_mman {
> ....
>  struct drm_sched_entity entity[DRM_SCHED_PRIORITY_COUNT];

Please don't. Every entity comes with a small overhead and we really 
just need the high and low priority I think.

Regards,
Christian.

>
> ....
>
> }
>
> then drm_sched_entity_init each adev->mman.entity[i] at 
> amdgpu_ttm_set_buffer_funcs_status. So you can use adev->mma.entity[i] 
> for different usage, like adev->mma.entity[DRM_SCHED_PRIORITY_KERNEL] 
> for svm migration, adev->mma.entity[DRM_SCHED_PRIORITY_NORMAL] for 
> buffer cleaning during alloc/free,  
> adev->mma.entity[DRM_SCHED_PRIORITY_MIN] for page table update, etc. 
> That will handle different buffer copies with different priorities, 
> led to performance improvement.
>
>>
>>> + 1, NULL);
>>> +             if (r) {
>>> +                     DRM_ERROR("Failed setting up TTM BO move 
>>> entity (%d)\n",
>>> +                               r);
>>> +                     goto error_free_entity;
>>> +             }
>>>       } else {
>>> drm_sched_entity_destroy(&adev->mman.entity);
>>> + drm_sched_entity_destroy(&adev->mman.delayed);
>>>               dma_fence_put(man->move);
>>>               man->move = NULL;
>>>       }
>>> @@ -2053,6 +2064,11 @@ void 
>>> amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool 
>>> enable)
>>>               size = adev->gmc.visible_vram_size;
>>>       man->size = size;
>>>       adev->mman.buffer_funcs_enabled = enable;
>>> +
>>> +     return;
>>> +
>>> +error_free_entity:
>>> +     drm_sched_entity_destroy(&adev->mman.entity);
>>>   }
>>>
>>>   static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>>> @@ -2060,14 +2076,16 @@ static int amdgpu_ttm_prepare_job(struct 
>>> amdgpu_device *adev,
>>>                                 unsigned int num_dw,
>>>                                 struct dma_resv *resv,
>>>                                 bool vm_needs_flush,
>>> -                               struct amdgpu_job **job)
>>> +                               struct amdgpu_job **job,
>>> +                               bool delayed)
>>>   {
>>>       enum amdgpu_ib_pool_type pool = direct_submit ?
>>>               AMDGPU_IB_POOL_DIRECT :
>>>               AMDGPU_IB_POOL_DELAYED;
>>>       int r;
>>> -
>>> -     r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
>>> +     struct drm_sched_entity *entity = delayed ? &adev->mman.delayed :
>>> + &adev->mman.entity;
>>> +     r = amdgpu_job_alloc_with_ib(adev, entity,
>>> AMDGPU_FENCE_OWNER_UNDEFINED,
>>>                                    num_dw * 4, pool, job);
>>>       if (r)
>>> @@ -2108,7 +2126,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring 
>>> *ring, uint64_t src_offset,
>>>       num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>>>       num_dw = ALIGN(num_loops * 
>>> adev->mman.buffer_funcs->copy_num_dw, 8);
>>>       r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
>>> -                                resv, vm_needs_flush, &job);
>>> +                                resv, vm_needs_flush, &job, false);
>>>       if (r)
>>>               return r;
>>>
>>> @@ -2144,7 +2162,7 @@ static int amdgpu_ttm_fill_mem(struct 
>>> amdgpu_ring *ring, uint32_t src_data,
>>>                              uint64_t dst_addr, uint32_t byte_count,
>>>                              struct dma_resv *resv,
>>>                              struct dma_fence **fence,
>>> -                            bool vm_needs_flush)
>>> +                            bool vm_needs_flush, bool delayed)
>>>   {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       unsigned int num_loops, num_dw;
>>> @@ -2157,7 +2175,7 @@ static int amdgpu_ttm_fill_mem(struct 
>>> amdgpu_ring *ring, uint32_t src_data,
>>>       num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
>>>       num_dw = ALIGN(num_loops * 
>>> adev->mman.buffer_funcs->fill_num_dw, 8);
>>>       r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, 
>>> vm_needs_flush,
>>> -                                &job);
>>> +                                &job, delayed);
>>>       if (r)
>>>               return r;
>>>
>>> @@ -2180,7 +2198,8 @@ static int amdgpu_ttm_fill_mem(struct 
>>> amdgpu_ring *ring, uint32_t src_data,
>>>   int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>>                       uint32_t src_data,
>>>                       struct dma_resv *resv,
>>> -                     struct dma_fence **f)
>>> +                     struct dma_fence **f,
>>> +                     bool delayed)
>>>   {
>>>       struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>       struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>> @@ -2209,7 +2228,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>>                       goto error;
>>>
>>>               r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, 
>>> resv,
>>> -                                     &next, true);
>>> +                                     &next, true, delayed);
>>>               if (r)
>>>                       goto error;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 8ef048a0a33e..e82b1edee7a4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -61,6 +61,8 @@ struct amdgpu_mman {
>>>       struct mutex                            gtt_window_lock;
>>>       /* Scheduler entity for buffer moves */
>>>       struct drm_sched_entity                 entity;
>>> +     /* Scheduler entity for VRAM clearing */
>>> +     struct drm_sched_entity                 delayed;
>>>
>>>       struct amdgpu_vram_mgr vram_mgr;
>>>       struct amdgpu_gtt_mgr gtt_mgr;
>>> @@ -152,7 +154,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct 
>>> amdgpu_device *adev,
>>>   int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>>                       uint32_t src_data,
>>>                       struct dma_resv *resv,
>>> -                     struct dma_fence **fence);
>>> +                     struct dma_fence **fence,
>>> +                     bool delayed);
>>>
>>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);

