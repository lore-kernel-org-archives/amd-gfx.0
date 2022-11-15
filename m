Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB885C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 15:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D5C10E413;
	Tue, 15 Nov 2022 15:36:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796AA10E41F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 15:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kibhOBx51C7r4ayxmwO2gsyULSnKVgU8PGouXamPellK6UkJCoaz7ckD3YQ7q7MkJfCeq8WwPr7P/X1C8qBWCM33JxRcsaB7TOYRw0FaO0HgyW6SR3acHFmMekeevofi5KHyu70g9KMjF4vsXYHZ6eKSw79F3wzwhrjOSjpyNKUhD/84efZvRby3N58nTkmH320fvzbhipuKe25bgT1cIwe/E+rk1EbnLexXHFK36QJ6TFO+zJvmw7IGLSdlYpXnzXR1B/e9hZKjRlM8bWmK0Q55W4wGh+Y9eah8ji3/YxE+ehFMKfKgxvulF0CfZdF0TjZxcgC5RV6Bk0z099CBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LoOXdfEE88UUE3g2qW33dwQB0Vg/GW5CNYCHBlQvCQ=;
 b=ctk4InnkwE+ckASGT9KFCeHafALiWJw/rANghlZv45dhCxGpf6+QKaLCZ0UJFledUrskekx8/hR2yFoV8UxgqqcWB6kfCd6NHFvj5T5QQM5KfcSCPQtpTHhCvV3ry/xeyRcDqbDeJCuI7eV9DRNE1Ya/TZ0t47U4HauSh6QRtQH8w+ThhVCC30NKfnrbfXRRIVCyMBNCS1z3JVgLa+bP8HINVRstkv96anQeIwztt5oMq325q98tTI3gv5k3RPguKRQSL3jw0ZUsR1c41oc1Z8qHvrzh0v/JEdZeTb0nX6iAPoUx5jOpMdO3QgRDDK4M4hJbFAS/X/60DOhsZ1WGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LoOXdfEE88UUE3g2qW33dwQB0Vg/GW5CNYCHBlQvCQ=;
 b=16GcNGnAQ6HKVHr3vbgbxIIdvRT5L8NkIk7urXHRoQV2cEaWq4QbPYkKo3tB14viV5GhsGni6VApmMkBU3bivyiPlClUwl/5SRNBZ2r8eIMAwr3wVu24RmcU10Q+5CBs7Mu5YcAwuTM7tEJeDh/F0+JSOD8lj6wy0hXY6gducEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 15:36:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 15:36:47 +0000
Message-ID: <1df24ebe-1a93-c292-f637-7c9dea278aa2@amd.com>
Date: Tue, 15 Nov 2022 10:36:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] drm/amdgpu: fix userptr HMM range handling
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
References: <20221110130009.1835-1-christian.koenig@amd.com>
 <20221110130009.1835-2-christian.koenig@amd.com>
 <aa3a76c2-e5f3-8e15-717a-a90a1d9c516f@amd.com>
 <2093f939-1079-655a-b24c-f47fe1168eac@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <2093f939-1079-655a-b24c-f47fe1168eac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: b84f21a5-817f-42f0-5084-08dac71f33ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O56n3WHDJkND+vRG1fEnyqTs4Q7+3kMqcas2VhqJ4wR5/N9N3ryfd4lZ9sYlqoj4FKj/qB28ITgD+dC/IINvWzvtoG1g3XopFeic0SCEyF5BbfWDHsbpQwxoFNLcSu8m9xBoP1GyuynBgfM1YbuK4WijlNSBESqwE/4i+TYIr0DRGoJomLuA53tYtdITlLt/wvxzJZcs6cNaXvIWQ1JbKrxU6eXYBsityh+0lJUh5Sx8LatH3giyxRAjsqaAJ2G/pNM+liemsfn4r0DqsmrwxEzX3WPifGgkTsDIDUO1/l6cuHMOru3XP/NGRl+QhJ4A90Fq2awnDfiF5PuosgtTOxkH9hFzQOIjBrnG3phfkXYvq5br7cQksKsnrOvWeyeSNV/iByXhWw8XRnZZXH9m76WQr9BxG4o0IeolWb/0B/07i5Ht4VUOBLdyyDHsLFinWlKefCMrWG0O9vGVcwmTPwCHKWful7UFGE4yCb/k/U/L26Hj+4JRof1klZswz8gHscJ6cGNlYxL+LcZZBgyzKyZAgZYHOyLwWKd9sy/6x96IvJmshB0Ao5U82bUt8286izXzApZFeN0w7J+qzl4KpV/inqqJnu1iFZW9h21xt6BxJkFm2B50/khZRySojJjKx2hpCAzRIFaurBXfEiyiMV312Hc8Kz7+lutoHxr4eEFef12bFb00GnFjfzwY2bk3c1BBlPuHGIcY9sBlF021sknODMWgs7/ghLRp7igYgJ+dELZn/Ym8RtGZ153k/FQuw4Z/7/h6k1042br0n3kCktTPElr5CS41413/7vyj9FE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(6512007)(26005)(31696002)(316002)(86362001)(66574015)(30864003)(44832011)(83380400001)(4001150100001)(2906002)(66946007)(66556008)(66476007)(41300700001)(8936002)(4326008)(36756003)(8676002)(38100700002)(5660300002)(186003)(2616005)(478600001)(31686004)(6486002)(6666004)(6506007)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0J3Q3pSb3AxZzh4RGNDWFFValVQaGN6bG5EVklaL1gwN09ndVlPek9CaGNa?=
 =?utf-8?B?YTliQVluYmhOQ1p2NEwwWVJpUTQ3SmJYRExMU0VMK016bEU2aUhNckQwdVRE?=
 =?utf-8?B?S1BHR09KT29zU2VQN1dnTzVrSUxXZUwreVNaOUNlaUlTWEtMNkpHaERJZkNJ?=
 =?utf-8?B?Y1REUnd5L3dBcVhxSXNIVk14SHJLaEM4cmZjd09OcmF2bzhTZG9ORnpiU1Nn?=
 =?utf-8?B?R2V0RVM3cWd4QjA4MHY0WjBkdzNOcGxCZEVtbHJNTWR0WDhvc2FUM1RaeXhh?=
 =?utf-8?B?ZithSHFtcElyeXpTdTc3ZVVvSE95NDdHT2JXVUNNUDAraCtyZVJnTnRMTnEy?=
 =?utf-8?B?MVIzc3VwSXoyWkhOblN0R2FkVS9QRVlNZXM5Q0phYlFpZ2dPd3hKNXBGTE9z?=
 =?utf-8?B?SzI2d0NDNTVxdkZaeDRGRytXRjU2V1dFWmNiTllhc3ZCMk1aVlNtcTk4TkpQ?=
 =?utf-8?B?TG02UHRMMFVVNWU3b3gzTFFjL0haK1JlYUFWQjIwVTlPUFZzSFpVdDJtSlZz?=
 =?utf-8?B?OWFvMGxZODE0ODhaM1pvenpCcnJmWHBVSkxSVGtseW02Um5IWTFXVjdGMWpt?=
 =?utf-8?B?VTI0cDNXMnVEcTBPbTlJdmlKandaSzY4OEk3a2o2V2N5TDRpdThncitJZlBx?=
 =?utf-8?B?a1VRcHE5NGh0V1VvUWhoOWpMZ1IwS2hTUzJBQ1JIczlmblhnWXRmWEdCaW9H?=
 =?utf-8?B?czFrS0tUWno5SXQ0b0pkUFFlRE9zZUhOcXFaK2FhUkVqSFlyWTlVVTBIQjFE?=
 =?utf-8?B?T1N2bHdpRXZ2QzlUc3dxb2JUSis5WmRNeERaUXdoRmxnUkNtamFoZEpwdndY?=
 =?utf-8?B?akczRTRBQWw4WkF6NGVrQUxWN2h0QThrYzlsOFZ6YUlCcW9BZlNobE91dG5Q?=
 =?utf-8?B?Yi9LSVZHRW9EMmNMbEw3ZG5QMGdQWTVtM3hEV0toRHlndVdpMlpHMnBqUDFH?=
 =?utf-8?B?WkdiYjB4dDNJekNCZzBsQ3I0UVowbXFBQnBvRDJycVZ6Z3B4dGhPeXgzQ1Ny?=
 =?utf-8?B?NWhlaWZRZnVWbG9YUkFIUGpYeEQrbUxhaFpQY1MyRDI0cVEvbURBcHhhMXRo?=
 =?utf-8?B?ZER6YWVMc1lhOGcvMElwbU9GQ0xMckxUenFYT0RONVQ4ZlVIYmdIU1RHN1ky?=
 =?utf-8?B?NEtFZmVTaU1WTFBrY1JhZmp1bHVHNW9tZ25Gd2lJQ1ZrOVU5SkhvaHdYRnFt?=
 =?utf-8?B?a0Q5N1BTVTUybjVITGFSNGxtNSt6amxocjVWRnFyVFE2a2NaYUdaUEtJL2g4?=
 =?utf-8?B?UTJkVXd6OE9WaldLYkU3RmIvdUY5dkkrQ2JRbkVxZXRZWm01NGh0WDQrTEN3?=
 =?utf-8?B?S3krTXA1TVNSZVdaYjdTN1NuVitDSldpZ0w2RHJ5SVFFdk9RUlZiS2RuRmdq?=
 =?utf-8?B?ekZIYld1dkpFcSsxeThBSUhKcDdHYndMZTJsK0R2cVp4c3hVNXdyZTRRU053?=
 =?utf-8?B?RHRmcExmaXlWYlVLVzVzQXdocDNCSnE2cklraWFRdmtnTE96UG96YTh2VFNa?=
 =?utf-8?B?MGFQeWV1Sm1iT2R3Zm80M1VtaDQ4OXlrQmk2YjVvaHhwUkJCQUYzcnpkZzFV?=
 =?utf-8?B?endhTG5FaVlnQU4rcm9yT1Z2Z0phcWlVZWhMS1BsRlkzbHJFWFBGTUIvQ0xl?=
 =?utf-8?B?V3FvbVVrblh5OEdJY1hocjJXUGpIeFlEMWMxN1Q3QTNwL1VKNmJQODhwYytl?=
 =?utf-8?B?OGVXeTBCUHQyT3Bpcng4RlZWL2Jra3NzU210c1BNTHZQOGFWMVdkUW50alFy?=
 =?utf-8?B?WUdRakYxWU9raCtNY1RBemM0VnZLVUpMVWZraFhLai9aR3NwTVN0VGd5SkhJ?=
 =?utf-8?B?K0NqYjBXWVRmS09tYjZ2cSt4ZjlyT0RiMldUK1RXc1NtYWVjQTE0am9nOEha?=
 =?utf-8?B?VjdGVkUrSzROb3huRnVTMFl2NEtKRzlPaUl1RHJ1N1p2NHR1aE53WUZlbmFh?=
 =?utf-8?B?eFNUSHdoK0JXWG1TcVhiQ1kvcHhySGJmRFBqTXVTQzhXZTBkMHE3VjBUVGho?=
 =?utf-8?B?QXpBOHlLNytIbmlGU0ZoZzN5TUxwQjdYUHlsUlZmTFlJVHdNTkV4bUEwdUtO?=
 =?utf-8?B?Ulp4aExhWVVKRTRIT1FUc2htWkQ1NTJsZ0FNb2wvaktkeUZpenZDR0Y1YjZG?=
 =?utf-8?Q?0bEZuu82iNjUt9RUVDjzz98jL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84f21a5-817f-42f0-5084-08dac71f33ff
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 15:36:47.2267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9tmOZO/Q4hf0cGc8PdU8ZI9+9znvwsCzIOtQxh1AEUR9s3IPgEx1+xUYWyiao3YNGXJIQ9tK6uZI3+xOL7vkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
Cc: stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-11-15 um 08:37 schrieb Christian König:
> Am 10.11.22 um 22:55 schrieb Felix Kuehling:
>>
>> Am 2022-11-10 um 08:00 schrieb Christian König:
>>> The basic problem here is that it's not allowed to page fault while
>>> holding the reservation lock.
>>>
>>> So it can happen that multiple processes try to validate an userptr
>>> at the same time.
>>>
>>> Work around that by putting the HMM range object into the mutex
>>> protected bo list for now.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> CC: stable@vger.kernel.org
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 12 +++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c   |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  3 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  8 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  6 ++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 50 
>>> +++++--------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 14 ++++--
>>>   7 files changed, 43 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index c5c9bfa2772e..83659e6419a8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -940,6 +940,7 @@ static int init_user_pages(struct kgd_mem *mem, 
>>> uint64_t user_addr,
>>>       struct amdkfd_process_info *process_info = mem->process_info;
>>>       struct amdgpu_bo *bo = mem->bo;
>>>       struct ttm_operation_ctx ctx = { true, false };
>>> +    struct hmm_range *range;
>>
>> I'd feel better if these local hmm_range pointers here and in 
>> update_invalid_user_pages and amdgpu_gem_userptr_ioctl were 
>> initialized to NULL. amdgpu_ttm_tt_get_user_pages leaves it 
>> uninitialized in case of errors and amdgpu_ttm_tt_get_user_pages_done 
>> checks for !range.
>
> I've opted to initializing range to NULL in case of an error.
>
>>
>> With that fixed, the patch is
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Does that still counts?

If you don't mind, please send the updated patch again. It's always good 
to have a second pair of eyes on error handling.

Thanks,
   Felix


>
> Thanks,
> Christian.
>
>>
>>
>>>       int ret = 0;
>>>         mutex_lock(&process_info->lock);
>>> @@ -969,7 +970,7 @@ static int init_user_pages(struct kgd_mem *mem, 
>>> uint64_t user_addr,
>>>           return 0;
>>>       }
>>>   -    ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
>>> +    ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, 
>>> &range);
>>>       if (ret) {
>>>           pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
>>>           goto unregister_out;
>>> @@ -987,7 +988,7 @@ static int init_user_pages(struct kgd_mem *mem, 
>>> uint64_t user_addr,
>>>       amdgpu_bo_unreserve(bo);
>>>     release_out:
>>> -    amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
>>> +    amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>>>   unregister_out:
>>>       if (ret)
>>>           amdgpu_mn_unregister(bo);
>>> @@ -2319,6 +2320,8 @@ static int update_invalid_user_pages(struct 
>>> amdkfd_process_info *process_info,
>>>       /* Go through userptr_inval_list and update any invalid 
>>> user_pages */
>>>       list_for_each_entry(mem, &process_info->userptr_inval_list,
>>>                   validate_list.head) {
>>> +        struct hmm_range *range;
>>> +
>>>           invalid = atomic_read(&mem->invalid);
>>>           if (!invalid)
>>>               /* BO hasn't been invalidated since the last
>>> @@ -2329,7 +2332,8 @@ static int update_invalid_user_pages(struct 
>>> amdkfd_process_info *process_info,
>>>           bo = mem->bo;
>>>             /* Get updated user pages */
>>> -        ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
>>> +        ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
>>> +                           &range);
>>>           if (ret) {
>>>               pr_debug("Failed %d to get user pages\n", ret);
>>>   @@ -2348,7 +2352,7 @@ static int update_invalid_user_pages(struct 
>>> amdkfd_process_info *process_info,
>>>                * FIXME: Cannot ignore the return code, must hold
>>>                * notifier_lock
>>>                */
>>> - amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
>>> +            amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>>>           }
>>>             /* Mark the BO as valid unless it was invalidated
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> index 2168163aad2d..252a876b0725 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> @@ -209,6 +209,7 @@ void amdgpu_bo_list_get_list(struct 
>>> amdgpu_bo_list *list,
>>>               list_add_tail(&e->tv.head, &bucket[priority]);
>>>             e->user_pages = NULL;
>>> +        e->range = NULL;
>>>       }
>>>         /* Connect the sorted buckets in the output list. */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> index 9caea1688fc3..e4d78491bcc7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> @@ -26,6 +26,8 @@
>>>   #include <drm/ttm/ttm_execbuf_util.h>
>>>   #include <drm/amdgpu_drm.h>
>>>   +struct hmm_range;
>>> +
>>>   struct amdgpu_device;
>>>   struct amdgpu_bo;
>>>   struct amdgpu_bo_va;
>>> @@ -36,6 +38,7 @@ struct amdgpu_bo_list_entry {
>>>       struct amdgpu_bo_va        *bo_va;
>>>       uint32_t            priority;
>>>       struct page            **user_pages;
>>> +    struct hmm_range        *range;
>>>       bool                user_invalidated;
>>>   };
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index d371000a5727..7f9cedd8e157 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -910,7 +910,7 @@ static int amdgpu_cs_parser_bos(struct 
>>> amdgpu_cs_parser *p,
>>>               goto out_free_user_pages;
>>>           }
>>>   -        r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages);
>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages, 
>>> &e->range);
>>>           if (r) {
>>>               kvfree(e->user_pages);
>>>               e->user_pages = NULL;
>>> @@ -988,9 +988,10 @@ static int amdgpu_cs_parser_bos(struct 
>>> amdgpu_cs_parser *p,
>>>             if (!e->user_pages)
>>>               continue;
>>> -        amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
>>> +        amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
>>>           kvfree(e->user_pages);
>>>           e->user_pages = NULL;
>>> +        e->range = NULL;
>>>       }
>>>       mutex_unlock(&p->bo_list->bo_list_mutex);
>>>       return r;
>>> @@ -1265,7 +1266,8 @@ static int amdgpu_cs_submit(struct 
>>> amdgpu_cs_parser *p,
>>>       amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>>           struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>>>   -        r |= !amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
>>> +        r |= !amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, 
>>> e->range);
>>> +        e->range = NULL;
>>>       }
>>>       if (r) {
>>>           r = -EAGAIN;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 111484ceb47d..91571b1324f2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -378,6 +378,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device 
>>> *dev, void *data,
>>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>>       struct drm_amdgpu_gem_userptr *args = data;
>>>       struct drm_gem_object *gobj;
>>> +    struct hmm_range *range;
>>>       struct amdgpu_bo *bo;
>>>       uint32_t handle;
>>>       int r;
>>> @@ -418,7 +419,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           goto release_object;
>>>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>>> -        r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
>>> +                         &range);
>>>           if (r)
>>>               goto release_object;
>>>   @@ -441,7 +443,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device 
>>> *dev, void *data,
>>>     user_pages_done:
>>>       if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE)
>>> -        amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
>>> +        amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>>>     release_object:
>>>       drm_gem_object_put(gobj);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 76a8ebfc9e71..a56d28bd23be 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -642,9 +642,6 @@ struct amdgpu_ttm_tt {
>>>       struct task_struct    *usertask;
>>>       uint32_t        userflags;
>>>       bool            bound;
>>> -#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>> -    struct hmm_range    *range;
>>> -#endif
>>>   };
>>>     #define ttm_to_amdgpu_ttm_tt(ptr)    container_of(ptr, struct 
>>> amdgpu_ttm_tt, ttm)
>>> @@ -657,7 +654,8 @@ struct amdgpu_ttm_tt {
>>>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() 
>>> once and only
>>>    * once afterwards to stop HMM tracking
>>>    */
>>> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page 
>>> **pages)
>>> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page 
>>> **pages,
>>> +                 struct hmm_range **range)
>>>   {
>>>       struct ttm_tt *ttm = bo->tbo.ttm;
>>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>>> @@ -673,10 +671,6 @@ int amdgpu_ttm_tt_get_user_pages(struct 
>>> amdgpu_bo *bo, struct page **pages)
>>>           return -EFAULT;
>>>       }
>>>   -    /* Another get_user_pages is running at the same time?? */
>>> -    if (WARN_ON(gtt->range))
>>> -        return -EFAULT;
>>> -
>>>       if (!mmget_not_zero(mm)) /* Happens during process shutdown */
>>>           return -ESRCH;
>>>   @@ -694,7 +688,7 @@ int amdgpu_ttm_tt_get_user_pages(struct 
>>> amdgpu_bo *bo, struct page **pages)
>>>         readonly = amdgpu_ttm_tt_is_readonly(ttm);
>>>       r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
>>> -                       ttm->num_pages, &gtt->range, readonly,
>>> +                       ttm->num_pages, range, readonly,
>>>                          true, NULL);
>>>   out_unlock:
>>>       mmap_read_unlock(mm);
>>> @@ -712,30 +706,24 @@ int amdgpu_ttm_tt_get_user_pages(struct 
>>> amdgpu_bo *bo, struct page **pages)
>>>    *
>>>    * Returns: true if pages are still valid
>>>    */
>>> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
>>> +bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>>> +                       struct hmm_range *range)
>>>   {
>>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>>> -    bool r = false;
>>>   -    if (!gtt || !gtt->userptr)
>>> +    if (!gtt || !gtt->userptr || !range)
>>>           return false;
>>>         DRM_DEBUG_DRIVER("user_pages_done 0x%llx pages 0x%x\n",
>>>           gtt->userptr, ttm->num_pages);
>>>   -    WARN_ONCE(!gtt->range || !gtt->range->hmm_pfns,
>>> -        "No user pages to check\n");
>>> +    WARN_ONCE(!range->hmm_pfns, "No user pages to check\n");
>>>   -    if (gtt->range) {
>>> -        /*
>>> -         * FIXME: Must always hold notifier_lock for this, and must
>>> -         * not ignore the return code.
>>> -         */
>>> -        r = amdgpu_hmm_range_get_pages_done(gtt->range);
>>> -        gtt->range = NULL;
>>> -    }
>>> -
>>> -    return !r;
>>> +    /*
>>> +     * FIXME: Must always hold notifier_lock for this, and must
>>> +     * not ignore the return code.
>>> +     */
>>> +    return !amdgpu_hmm_range_get_pages_done(range);
>>>   }
>>>   #endif
>>>   @@ -812,20 +800,6 @@ static void 
>>> amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>>>       /* unmap the pages mapped to the device */
>>>       dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
>>>       sg_free_table(ttm->sg);
>>> -
>>> -#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>> -    if (gtt->range) {
>>> -        unsigned long i;
>>> -
>>> -        for (i = 0; i < ttm->num_pages; i++) {
>>> -            if (ttm->pages[i] !=
>>> - hmm_pfn_to_page(gtt->range->hmm_pfns[i]))
>>> -                break;
>>> -        }
>>> -
>>> -        WARN((i == ttm->num_pages), "Missing get_user_page_done\n");
>>> -    }
>>> -#endif
>>>   }
>>>     static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 6a70818039dd..a37207011a69 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -39,6 +39,8 @@
>>>     #define AMDGPU_POISON    0xd0bed0be
>>>   +struct hmm_range;
>>> +
>>>   struct amdgpu_gtt_mgr {
>>>       struct ttm_resource_manager manager;
>>>       struct drm_mm mm;
>>> @@ -149,15 +151,19 @@ void amdgpu_ttm_recover_gart(struct 
>>> ttm_buffer_object *tbo);
>>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, 
>>> uint32_t type);
>>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page 
>>> **pages);
>>> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm);
>>> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page 
>>> **pages,
>>> +                 struct hmm_range **range);
>>> +bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>>> +                       struct hmm_range *range);
>>>   #else
>>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                           struct page **pages)
>>> +                           struct page **pages,
>>> +                           struct hmm_range **range)
>>>   {
>>>       return -EPERM;
>>>   }
>>> -static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt 
>>> *ttm)
>>> +static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt 
>>> *ttm,
>>> +                             struct hmm_range *range)
>>>   {
>>>       return false;
>>>   }
>
