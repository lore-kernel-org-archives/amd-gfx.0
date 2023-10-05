Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABFAE93701
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 10:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461D210E163;
	Thu,  5 Oct 2023 10:57:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDE910E163
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 10:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7RJhBAd0PGP5hdNVjCtCVaNq2yGQD/HkAE+0UJHJKR1uaT0kS4c+D+fOr69JdycmG0B5glBp/zzySoyqwrBmHBC7Dyq6wgxwpL+oHkEhjr66RBbS5Xhjd8UPTzkqbOpYJ7APqzmeSx26jBDKCX+ZjYzy+Qbcamz9ERr31NoRgirMhK0ncAk8WyzX/qTN3JldM0RmL7pIiLeyIF5TvTHhV1VtkDsHcrQJSnkO47Jnh2NKH/bmYAbWDiSfQOX8Gt69sGdDGizanJE/Y/X87aC4Fv2xTVj3IAtMP+r2mvBWQ4C3LTDTY90Key0XiNCczgPXu8z11+pcBtlWxfE/RCfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUj5ZHMlzsM6wSTFWqfkDM/dZ1zG5ZDBknxY8t4lJEY=;
 b=M6fWy6uP8kUP72m2m/e8AqULEzo60Dxcq3DLnfuOan61bfvWMCAJ6YBKgTDPfbkdWiKOgdjSk9aDZM5IvPrmOzL+o0bj8QldLFi6/SytltXSSDzoPrybXatrSg7aq4daobRF0DXnoCSkgagC3rQ0YgbDyp8RmdppTZ5yv6oTigA1VGv2tbvCilTLa2hk5xZYuqCh23nTFxZq8zVhWpm4XTYvV+ulp4ZLD211apAsenkYeyxQNm0Wg08oLqOfB4zZm4C9POWugmnK1XiR3lCbUbvLNTNorArcKXmOfxTWVwNzjxzwRGrOC6jghwtl1llr9dmmGkEZWbDQ1V40GX0XRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUj5ZHMlzsM6wSTFWqfkDM/dZ1zG5ZDBknxY8t4lJEY=;
 b=vJjIlrQ1LivtDXqFCMxmCNiFn6CR8xoWryI+6S0whkJfEl6go6jWVAkkxrCaCGa/hCrN9vHY/6IkLKU3PORDK3vVfWw6t7LIY7b4Lmi5YgCpid8FfIwN7GnF1IrEXcmHejrGt7eLbq8mV3Boe7OpN874UqjdWCcEYkdEsczY7kA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 10:57:41 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::c65c:9847:210d:2f2d]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::c65c:9847:210d:2f2d%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 10:57:41 +0000
Message-ID: <073a639e-89ab-f553-434b-149bcbffd6e3@amd.com>
Date: Thu, 5 Oct 2023 12:57:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 7/9] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-8-shashank.sharma@amd.com>
 <022fbf02-b9f6-1286-bd25-dd150384047e@gmail.com>
 <816ed7f8-9a22-4b17-ae0e-27701ea51557@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <816ed7f8-9a22-4b17-ae0e-27701ea51557@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eca0544-7bc4-45ba-7739-08dbc591e55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPXhVbl4WyA9zDqY82J2TZDP43ffFl1qekkq4xY9h/b7x6QgKjQ7RyY9WURz1V3PyiNnt6GbBICwvLWNU3yrVrLMgoWCI/cmdXUBBlhSZW1uo1MvRp5wiEk2sA7NnroVIIen+6wKkKML6NCLBlNE6sVMGrOq1ALMVXSbS4N30KF2yJP2SLCjzmJBzMYJ/l3pyXEdfni2p0BPbyQG1pvuj030n2KhsgvPQf9Yh3/kcpdFtGp+IXf4F96NJb1BCKz4t2a4NgsfpxqLnDfmbkPXpIMof5bo6VnKMbJyvJbMTK1nn5K10hXFEyC9l9yIaAO5QN0CZ35qHqHEp26zP5/zBJVx/ACD2F0kYLOu45yooEhfmb0YYKqrL57ofuBPsNYw9B8EpxO7i3cwfQkTMn4JXJ2DRaRieD2Vw3OJYR0ilMMyWb30/zmTPOHhamvsXfiev/9iCehw0BvwUNY6l3aqB5Bms0ohxABmUAa98CnqdEE51y7bbnVSS0s1y6/04hi4+o29yBqLELAFnXL8x5MH/22PvRDAlGVBCpNOnt6b99o8Sr1YKBtqFZJ0509gY1jxhLMr1cEQFDPFAafIJHnUCr65mQcSF/A44h+vc5WCGhk9Es3r2wJD4EZLQovys4youixKTXj4PsxNmWRMDDhBOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6666004)(83380400001)(6506007)(2616005)(6512007)(53546011)(6486002)(2906002)(66574015)(8676002)(5660300002)(66556008)(110136005)(44832011)(4326008)(66476007)(66946007)(316002)(41300700001)(26005)(8936002)(478600001)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3oraEtZUXlqSTBKOHh0Ky90cSthL1dUNGVIVllqZEs0NUxubEsvQnNhdjdk?=
 =?utf-8?B?TWEwallMekhqeE5ubk93ZDNkM1JaZ1JwRjFkVU5pMFA1T1ZGUndUM0JlSGFx?=
 =?utf-8?B?aU9Kc2lOdW9FK3Q1NVhyYmgxSzA0a3NldTZ1bnU2eU56bzQyTHFBZEowV0Vv?=
 =?utf-8?B?dDFZVys4OXZkUlZFUTFQMXU5VXAxODV6VXBUa2V2Rm85UFA5U2gvSWg3MDFH?=
 =?utf-8?B?TzMwLzRyL0lEaXJINTcvRnFPNFdNYjh0UlZJNWNZeElSdzE3OTdIT25OSzk1?=
 =?utf-8?B?cmhjWEJ0L3pLbzdjSkhHelFvR25RcE1pWVZyN0VweUl3TFpCdFlOZVlBREZW?=
 =?utf-8?B?Ky9wTG5rZTNuUEZQeU9hSGR4YVVxbnNkQXB0Ukh2RmJldnlBaGI3UWplNmVi?=
 =?utf-8?B?b3NHRVFGWmMxVy9menYwREdwZm5JRzNNNHBYUmtnaHBpZ1NGWGRDVWNrM3dL?=
 =?utf-8?B?d0M4WUVnUmduQmQzQmw2a3pHTGh0NGpHWjlwNzlJak50dHZPZTc1ZjMwZzlZ?=
 =?utf-8?B?NG44akUydmpSUnlXWGRxb1VOM2pjRUgvb3A1bFM4WUFVN1daOTFnNU1KU25R?=
 =?utf-8?B?S1FZWU5nODlIQ3Z1enZQRGtxT09PRHZKNzZJeEJpZ2lManBoVUZIaEdIUTFp?=
 =?utf-8?B?Q3FWUnp1ZWQ4UHZVbTVQTThHQWxYcUI4L1Q4MC9ZU2VzbThicTBBZkcrZ2Yw?=
 =?utf-8?B?ejFFT3dzaFpmcUhwclVlU3VyNlpjdzQ4MFlRay9UU0JhL3JYN29DSmZ6VEE1?=
 =?utf-8?B?c0dWZ1BDYk5oN1lRVmZkbXIzanRHRXljQ3g0aVZKcnQ1ekNsWDBJcXlmKzNh?=
 =?utf-8?B?clBQUnJzRDZoOTJ0dmwxcmxWNDBkMlpKWTEyTUZDQUlIRE5xYnlMK29Jd0dM?=
 =?utf-8?B?NUgxZENHZ2w5emg4am5TZ3UxQkJxNU1BSTNmdVR6MXdqUHM2N2s3bHgrbHcx?=
 =?utf-8?B?R2hwTjVWbENyRFlleVhyNCtCZmEyUCt0OExBdnZoWmNtcGdyc29qdnJQRjhY?=
 =?utf-8?B?OXQ1aENYQzBHL0Q2ejlMK0luY3I2Mzc0UUhaaWxXK2w5Y3UrTWZZbE9Iakwr?=
 =?utf-8?B?WlkrbVJ6UDhHUTJ0RnVCS3hNS2JnQ3p3aldVclFPWmtsMmluM09DODJ6QmlN?=
 =?utf-8?B?MmEyaWpFNDNnQzJJMVI4d2xZSHl0SitTWWRtd2I3TDFmMkJNMVFOT3FDWVBm?=
 =?utf-8?B?cjJXcnlPSlMzN0dPd3BLZFdRQnR4cVJCOFhBOFZLQjhyYVRKZXF5SldwRFpJ?=
 =?utf-8?B?eEg1OE9rMzhRbk4wcEpacWVWN09pMExlZXBMMXU0aXVQSTEvTkRxMFNNdG5k?=
 =?utf-8?B?YXdla2xSaG41eHRtTlp4YkFrRWpiMWlzWjlsMFVyUXJiaER4c2lkVkNJK3JH?=
 =?utf-8?B?QmlQajc1RGVlS1crSGdJcEhVMnJuUjJ4YmI1T1lpeGtIbnVHVXIzWEFZdlRB?=
 =?utf-8?B?bjJQKzcvVkJZQ2lIaFdBTVMyKzljTmVNL1RoZVlKeE4xbmYzTkErMWxHc21q?=
 =?utf-8?B?UVdGeDA3VjBGdXFlSUVuUFBDQ2laWFZRS1BqWWRKZW1FSG5QZVhBUCtnOFZy?=
 =?utf-8?B?WGtCQXZPN3psMVk5QnhDZXM4YWM5SEtoQ3dHWExUd01lK1I0YWNHdFpUdklQ?=
 =?utf-8?B?Q2VQNTVuYUdYNHhXZjRwcmoybzllYW12eGh5VFdXUkVETE1SN3JYZ25yVU5X?=
 =?utf-8?B?aDFtank5eEhZZTQ1ZEF2UXAyUU1FOWtzU1ZQcVVFdU0rRGF4dWE1bm1zc05C?=
 =?utf-8?B?dVNSRXN5MmNsbnhXc2Fua01TNDNpUGpwK1dIbjh3U2NqQm4vMGlKUElaU0FP?=
 =?utf-8?B?c3pCZm1ucFphUXU3NzdYL3F6bzJVMGhiNS8rRFZvQVpkSWZYZ3ZqNWhCQmJs?=
 =?utf-8?B?ejNMUWlwQ2tEWXFtaVcxVGVGWmNiajhPUlB1REtJOUFVY3VyTzkwLyszRWs0?=
 =?utf-8?B?RjNMOXNTQnk1cXF0cTFBTFgvSFhhZVNJTDJYU3ppc2NJRHpDSTZwcndERFF4?=
 =?utf-8?B?dTFnVkFteUd0SHdMdHM1MnRaejl3cHRnV2lWVnlTK0xlZkxqUUtUOUpxNlEx?=
 =?utf-8?B?RS9yWWhXQzA2aSszTFg1MDh0ZVAwMG1GYzN4d0M2YWJDdU8vZzFaV2hjUGFq?=
 =?utf-8?Q?Dvys1RzOsZckjVMdaAHpKP7G1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eca0544-7bc4-45ba-7739-08dbc591e55f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 10:57:41.5498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97J1O4dENRbcVDzna7fqelJQciZu6hdB2mOi9b041rcsMkEqR9QprVhWq4nJkRlMkCsFwqjH6mdm/buoP4bOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Felix,

On 04/10/2023 23:34, Felix Kuehling wrote:
>
> On 2023-09-18 06:32, Christian König wrote:
>> Am 08.09.23 um 18:04 schrieb Shashank Sharma:
>>> To support oversubscription, MES FW expects WPTR BOs to
>>> be mapped into GART, before they are submitted to usermode
>>> queues. This patch adds a function for the same.
>>>
>>> V4: fix the wptr value before mapping lookup (Bas, Christian).
>>> V5: Addressed review comments from Christian:
>>>      - Either pin object or allocate from GART, but not both.
>>>      - All the handling must be done with the VM locks held.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 81 
>>> +++++++++++++++++++
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>>   2 files changed, 82 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index e266674e0d44..c0eb622dfc37 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -6427,6 +6427,79 @@ const struct amdgpu_ip_block_version 
>>> gfx_v11_0_ip_block =
>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>   };
>>>   +static int
>>> +gfx_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct 
>>> amdgpu_bo *bo)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = amdgpu_bo_reserve(bo, true);
>>> +    if (ret) {
>>> +        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>>> +        goto err_reserve_bo_failed;
>>> +    }
>>> +
>>> +    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>>> +    if (ret) {
>>> +        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>>> +        goto err_map_bo_gart_failed;
>>> +    }
>>> +
>>> +    amdgpu_bo_unreserve(bo);
>>
>> The GART mapping can become invalid as soon as you unlock the BOs.
>>
>> You need to attach an eviction fence for this to work correctly.
>
> Don't you need an eviction fence on the WPTR BO regardless of the GTT 
> mapping?

Yes, Christian also mentioned this in this iteration, I have implemented 
the basic eviction fence for [V7], I will publish it soon.

- Shashank

>
> Regards,
>   Felix
>
>
>>
>>> +    bo = amdgpu_bo_ref(bo);
>>> +
>>> +    return 0;
>>> +
>>> +err_map_bo_gart_failed:
>>> +    amdgpu_bo_unreserve(bo);
>>> +err_reserve_bo_failed:
>>> +    return ret;
>>> +}
>>> +
>>> +static int
>>> +gfx_v11_0_create_wptr_mapping(struct amdgpu_device *adev,
>>> +                  struct amdgpu_usermode_queue *queue,
>>> +                  uint64_t wptr)
>>> +{
>>> +    struct amdgpu_bo_va_mapping *wptr_mapping;
>>> +    struct amdgpu_vm *wptr_vm;
>>> +    struct amdgpu_bo *wptr_bo = NULL;
>>> +    int ret;
>>> +
>>> +    mutex_lock(&queue->vm->eviction_lock);
>>
>> Never ever touch the eviction lock outside of the VM code! That lock 
>> is completely unrelated to what you do here.
>>
>>> +    wptr_vm = queue->vm;
>>> +    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>>> +    if (ret)
>>> +        goto unlock;
>>> +
>>> +    wptr &= AMDGPU_GMC_HOLE_MASK;
>>> +    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> 
>>> PAGE_SHIFT);
>>> +    amdgpu_bo_unreserve(wptr_vm->root.bo);
>>> +    if (!wptr_mapping) {
>>> +        DRM_ERROR("Failed to lookup wptr bo\n");
>>> +        ret = -EINVAL;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    wptr_bo = wptr_mapping->bo_va->base.bo;
>>> +    if (wptr_bo->tbo.base.size > PAGE_SIZE) {
>>> +        DRM_ERROR("Requested GART mapping for wptr bo larger than 
>>> one page\n");
>>> +        ret = -EINVAL;
>>> +        goto unlock;
>>> +    }
>>
>> We probably also want to enforce that this BO is a per VM BO.
>>
>>> +
>>> +    ret = gfx_v11_0_map_gtt_bo_to_gart(adev, wptr_bo);
>>> +    if (ret) {
>>> +        DRM_ERROR("Failed to map wptr bo to GART\n");
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
>>
>> This needs to be amdgpu_bo_gpu_offset() instead.
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +unlock:
>>> +    mutex_unlock(&queue->vm->eviction_lock);
>>> +    return ret;
>>> +}
>>> +
>>>   static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>>                     struct amdgpu_usermode_queue *queue)
>>>   {
>>> @@ -6475,6 +6548,7 @@ static int gfx_v11_0_userq_map(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>>       queue_input.queue_size = userq_props->queue_size >> 2;
>>>       queue_input.doorbell_offset = userq_props->doorbell_index;
>>>       queue_input.page_table_base_addr = 
>>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>> +    queue_input.wptr_mc_addr = queue->wptr_mc_addr;
>>>         amdgpu_mes_lock(&adev->mes);
>>>       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>> @@ -6601,6 +6675,13 @@ static int gfx_v11_0_userq_mqd_create(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>>           goto free_mqd;
>>>       }
>>>   +    /* FW expects WPTR BOs to be mapped into GART */
>>> +    r = gfx_v11_0_create_wptr_mapping(adev, queue, 
>>> userq_props.wptr_gpu_addr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to create WPTR mapping\n");
>>> +        goto free_ctx;
>>> +    }
>>> +
>>>       /* Map userqueue into FW using MES */
>>>       r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
>>>       if (r) {
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index 34e20daa06c8..ae155de62560 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -39,6 +39,7 @@ struct amdgpu_usermode_queue {
>>>       int            queue_type;
>>>       uint64_t        doorbell_handle;
>>>       uint64_t        doorbell_index;
>>> +    uint64_t        wptr_mc_addr;
>>>       uint64_t        flags;
>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>       struct amdgpu_userq_mgr *userq_mgr;
>>
