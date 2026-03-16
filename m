Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F318F506D5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 14:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2366610E1B0;
	Mon, 16 Mar 2026 14:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJ1hWq4T";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B9210E07C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 14:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYcmgq8L/iE5TTdurKnSzMA5zKEfaCabP6ZC3CnINFDZsGNEu28FXa3ypDqgYKMWIfwxnaAhSN0hEblVxIQCvteJZS72OvCW5JLb/IDEWlLSIHKFPs/WWAE4oUmaSN6NlwxYeVgfV5hKNLVtiuRFQINQBNfflGsK4nqWiTE6UuZCxTBOEldH0yfgWLQz3dNo6GSciA7vCA5652ASAezY1Fsn2PUAkLsHY5RlF+/cf55SA+dQkSw+It9r0P5Oil8w3kjBERCeO8llJREcl1oOOWHXZksaYbnUZIpbvzfRneZFFhHrfx9SASDXz5NFojD/V9J77ktlig82mKkhSQ8V0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwOThIn8/Cza/1pJ+gt5gI1XNvRWCAZvf31yEGYivmc=;
 b=l9/EkiF6WOTymOwHoUG6hSvmNgCl8TRb78khfMNA+Rm9GmHugaOrsEbfyMO4tcaNGHT4DJ7vwc49Tqy+EC0QG6K5sBPsuODWDHjMGsFQWIg30qIVlCksFrMfjQ6rUaO8uAPR4e+BXO45v9w1N802zDH9ShznHcw733wt7BC9PzEoRzwcwMHwsZ9RUd/e6X2jo3a71Ng0cnRwKSd7BQmKOiWNg01zyw8oqwR+MvbIgbPzGqEGVaJaPog9Yh9waGYCsGwSVOCqbOcXBu9ZoYICurQaU3oGKWrX/NWOAx+wSNj5MPl9+iFndilAnF5dSieFUfrYF8hQRiP5O3/QIAu1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwOThIn8/Cza/1pJ+gt5gI1XNvRWCAZvf31yEGYivmc=;
 b=FJ1hWq4TzL/0oOHm7j3zHnCpIMbJU9ckjAH8eX8ugLParraavj3vVHdFygQFRiL+zfnr2Y8khoyrBGYfdQTy0C+QBNO7VY239lJi0KaBTqZKsDcAmNfhBtl9zHL4Il2GckAkAAmBE+hAxklYnwMqNvyUqzIl9iiCOXtqzkq18Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 14:20:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 14:20:03 +0000
Message-ID: <649ffc71-0d29-48c0-b621-38da72a041a3@amd.com>
Date: Mon, 16 Mar 2026 15:19:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu: rework amdgpu_userq_wait_ioctl v3
To: Tvrtko Ursulin <tursulin@ursulin.net>, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, Yogesh.Mohanmarimuthu@amd.com,
 SRINIVASAN.SHANMUGAM@amd.com, Sunil.Khatri@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-7-christian.koenig@amd.com>
 <4f60cc9f-b4df-480c-9914-fa0c7f8d224c@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4f60cc9f-b4df-480c-9914-fa0c7f8d224c@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:408:ec::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d554f41-d5d3-406d-e9a4-08de83671d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: gq/wmCLneFfr34DSGYXzwWEFfhxvDWQqEMzrl+o0fAW1A6tN8xy3CUohdDKaKtfbwnYnRoz41YE/dweZZcMFeJUvqzn21Q6o4Faa9aSaSfBVylkzDUlHvCtymhhWcatilRG+6RMsdDGQiry2iFKuQ708og4kvYiVQZIWJ2ztzJ+zjaeiK6VGJ8XyJAEwkFdQgLLZRoZc8BmDAvT8ELZcS3mNDeJA6IMf1kXTaiA6jRSHvVYVyZhcCjtzFRx/j13BfJyTMdfrjcrxfJZWzC+LXbENzHvNlADUpgb/D24UJwP4W11eb5siRFFOJlirtJ+/bkVQrIYPuUaEDYlM4iU2b+7bkdxuRCowSR+s3a970ZS/GX71e0hPMhn4oqjuunmEBpSF/HWRFUcvU93Kzw4l4N7Gnz8KTKOgqFsLllNZbSETOqW895SA/RMEbLy3zys8Qcy0uPnQBU3ZgVOCgloDqSB2YfgZFgC+JBGlCdye+40pJV3zHa686nzlSOhac2V4dmcsOnaeVv05p0wTguSY9FT0s7LscZ8CUU/uj8/EeCdhDFlwiDA4pQKqbl9xomD5pCN3icx4mLDq4omaYh5GSaHTfh0E8jJF4TxqMmw7I78u88FAtndsiBkITpXn2ULaKboyubLZGIjQ9BgvOExvX+Jjd0r2EAeMSO0PiSKZjbWK8JGCXZMLi01JNDb1O5Ycrb+x/6+iAeAbNKUymyB6f83vYqRI84eFzhAVskGwHRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjQxWUdWQXB0VlZyTkFhbjdhZkNFRmtZSmNrSStwendiMGpCdnhRaEhLZUdG?=
 =?utf-8?B?T2pMcjZnUUo1VTBLOHh2VytCcHVobHFKZFdKcGQ4YWQ1b1ZjR3ZLdHgycnNy?=
 =?utf-8?B?Z0w1emFpd0JIaWxITzY3TzFqSVozNzJ4NGlIOWtRaXQvSWhNWS9zL2gyZXkw?=
 =?utf-8?B?ZDlMdkZVLzdPeHRtMlQ3ZUU1UzZmMTNJN3hLc1F2T1N6Y3NYcHowVWkwU0h3?=
 =?utf-8?B?cEVJSGpuOU52NERySlk2anFXeFpaT0poZ3hab2FtN2RrcFNseEtFUG9EMzF1?=
 =?utf-8?B?U0w4L3doeVI2dGpZU3RienRtUlc5L2JGN2RFZ09aN0JXY2VNOE5XWGhVSGZm?=
 =?utf-8?B?UzcvY0NOb2xnQXdUUXlLSE5SUi8xbDdNeWpXcUs0YmFBZkQ3RWpTQjRuZHdF?=
 =?utf-8?B?bC8yK3pOdnBxdXcyVVJsa3h3WG8xczRNelltR0lKZDlCZUNYQmwvZGhLMFU4?=
 =?utf-8?B?ZCtqd2o4MDBnTGdxd0VRQkpZUE1pd1FFQXNranFCZnRGZXplYkpTMkxWYm9W?=
 =?utf-8?B?S2s0Zzc4VDg3NU5GQktGQlZadE91dHpvaytHMUxYYzRxNW5Bc2ZndGpFNzdt?=
 =?utf-8?B?WjFIdERFcHZFVHZ2SmRuc2ZOZWdKSWZ3R3R0WGpRaFVBenFMWEprTE1GaTJ6?=
 =?utf-8?B?VzhCd01lSmdGelVoTlZlN1JUOE5OTURzc2FreEFybko3L05wKzhLYTRWeTkz?=
 =?utf-8?B?a0MvOUFzdDhnbDFuelR6N0dnTHd0MVM1WWtvQlYxeUJRMkUveGRmbFVla3M4?=
 =?utf-8?B?c0p2ZGtsNEp0a0ZNYWRaRGFuQ1duRXRMSDA2OExyQ3plYTZWRnBuOTEyYWRP?=
 =?utf-8?B?WS8wUEp1cmJxdGI2anFjRE80L0lwVDM3Wk01bVkvNEU5MitNWUUxWGpib2c3?=
 =?utf-8?B?bDFqMnJmeXl2WHFCUFU2TlVMRUg4UVh2SkhTZ0NJSmlZdXFPRUd3WWhSeTJz?=
 =?utf-8?B?UXNkUlYvdEEwcmF5RmxETi8rVGdsR2FyWklRdFdEejBwOUJidmQ0dmxncTdK?=
 =?utf-8?B?YzdzdXpEWFVQME5GNTkrQVliOFNUSWJMZDBzeUpWUjVQQVMyeFNET0R4aHc5?=
 =?utf-8?B?S3c3WGpJcDY2M09YRllFRnBCQ3gxRzNEVm4yMm1vNUl3UkVodTJiQllJQzZa?=
 =?utf-8?B?a3NUL2xDblJMbFdPNjVGYWZJd2xDUWJ2bnNCOU83SXlXaE1pZElOZU1YSnlz?=
 =?utf-8?B?eGUxckxYYVArSTlJdDdDclNLcFI3YjFoaTRLTGMwTXRrRnNGMzRWRkEwd1Vn?=
 =?utf-8?B?UHJsZEw5RStJeUlaQWJyZ1dTd0hoZ0xYZjFYcW8zTURhY1Z1ZFZnY0RQVVhs?=
 =?utf-8?B?cko0SXEvOFIzdVdzS1orbFUwRnd2ZE1Dc1VZd2w2MEkzZ2RjNmJHRzg1dXZF?=
 =?utf-8?B?a1dmWjUvVjJBQ0pZYjZ1WmZtejZkZGtrd0JOQWJlUDE5RW9ZSnZaK1J2b2RY?=
 =?utf-8?B?K1J4T3c3RU0wZm93N2RFR3ZKUXR4SXBxb3kyc0FkZWp6cllmNGk4TVhzcExE?=
 =?utf-8?B?NldZZFZvMVhJUXAwdXVnZjdYalNaSnNlTXUvTno2aUpmcXRkR3l5WjFUQjlI?=
 =?utf-8?B?aDluQnhxc0hHRUNCSkhKTHRMSG9sZVQ2RFp4bmNaUi9uTXNFYTBrUVVGa2VC?=
 =?utf-8?B?YmxtcXVvd3BUbVZ2Y2dlM2k5RkMrUE9VTUN5ZzRDTng1cUpKUThMejhnenBt?=
 =?utf-8?B?OGYrbFhtYnVuZUtybzdsZFExU25ySGJRSnlQOUkza3o5Q20za2hRWXRVdjhu?=
 =?utf-8?B?ZjFqMGxjYVAyZGNGODhMeHdudFdTWGRCc2NCc2pxc2YxZ2NpeTF4Y2UzTS9s?=
 =?utf-8?B?aDkxMVpKbVpZbWtNU2paTnRJcjVVTHBGa0YrMEVXRzRTYUJXNnN6ZGNrTVk2?=
 =?utf-8?B?RTRuUkhRcm1lemxTZnpqVmdCNDFodXhQTEhVNmIzWHd3ZldMKzNwUDNCN2hN?=
 =?utf-8?B?dDhOVVJocUZhYXA0M1YwbU1mT2tVcHdFVnlBMnowdlJCSXIyNGFNcVB6bENE?=
 =?utf-8?B?MlVwOVQ2MEMyZmxsSjFISDlaZ1NtaWxpblQ5cEZZR2VUa3VQRVo2eWowNTM3?=
 =?utf-8?B?NWtnVVFFMXdGRjdoemJIWDFWdkZSQlNpdStZSzd0RnM5Y2ZKcXNqekxKK016?=
 =?utf-8?B?YlBZSERXdU9Qb0ZhQnNpVWhqNDRkVnVYNkYwaFJDdmNtYUVmZnpxaThjaGFQ?=
 =?utf-8?B?YnN0NGZZZjlTMzYraDJ4MjlYbmNBZFozOG4xb0YwZ3RqQmY5TW9qZ1Btcmh1?=
 =?utf-8?B?WGUvb1hXcXI2dVE0NnJWRXMrZ1FRZ3ZWV3JUMlhPVEZCc3JwNFJ4RTVDVE95?=
 =?utf-8?Q?UcaTy0p8wW1vOlOg09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d554f41-d5d3-406d-e9a4-08de83671d7d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:20:03.5227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PDBAumTtMByscl693psWjtsUGfxC2TZjqhvqINIfq7BKsOKoGY4KFeVyaXShFYQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509
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

On 3/12/26 17:34, Tvrtko Ursulin wrote:
>> +    /* Retrieve timeline fences */
>> +    num_points = wait_info->num_syncobj_timeline_handles;
>> +    for (i = 0; i < num_points; i++) {
>> +        r = drm_syncobj_find_fence(filp, timeline_handles[i],
>> +                       timeline_points[i],
>> +                       DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>> +                       &fence);
>> +        if (r)
>> +            goto free_fences;
>> +
>> +        dma_fence_unwrap_for_each(f, &iter, fence) {
>> +            if (num_fences >= wait_info->num_fences) {
>> +                r = -EINVAL;
> 
> dma_fence_put(fence);

Fixed.

> 
> Also, maybe -EAGAIN?
> 
> Or even consider dma_fence_dedup_array() and only bail out if it couldn't compact it.

I've replaced the error with a fallback in the next patch anyway.

> 
>> +                goto free_fences;
>> +            }
>>   -        /* Array of fences */
>> -        fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
>> -        if (!fences) {
>> -            r = -ENOMEM;
>> -            goto free_fence_info;
>> +            fences[num_fences++] = dma_fence_get(f);
>>           }
>>   -        /* Retrieve GEM read objects fence */
>> -        for (i = 0; i < num_read_bo_handles; i++) {
>> -            struct dma_resv_iter resv_cursor;
>> -            struct dma_fence *fence;
>> +        dma_fence_put(fence);
>> +    }
>> +
>> +    /* Retrieve boolean fences */
>> +    num_syncobj = wait_info->num_syncobj_handles;
>> +    for (i = 0; i < num_syncobj; i++) {
>> +        struct dma_fence *fence;
>>   -            dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>> -                        DMA_RESV_USAGE_READ, fence) {
>> -                if (num_fences >= wait_info->num_fences) {
>> -                    r = -EINVAL;
> 
> Same as above.

Those doesn't hold an extra reference, so dma_fence_put would underflow the refcount.

>> +        if (!userq_fence) {
>>               /*
>> -             * We need to make sure the user queue release their reference
>> -             * to the fence drivers at some point before queue destruction.
>> -             * Otherwise, we would gather those references until we don't
>> -             * have any more space left and crash.
>> +             * Just waiting on other driver fences should
>> +             * be good for now
>>                */
>> -            r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>> -                     xa_limit_32b, GFP_KERNEL);
> 
> Does it need to put potentially the same fence_drv multiple times into the same xarray?

That would be quite unlikely. We have one fence_drv for each fence context and de-duplicate them above.

It could only happen if you call the wait_ioctl multiple times, but I don't see an use case for that.

Thanks,
Christian.

> 
>> +            r = dma_fence_wait(fences[i], true);
>>               if (r)
>> -                goto free_fences;
>> +                goto put_waitq;
>> +
>> +            continue;
>> +        }
>>   -            amdgpu_userq_fence_driver_get(fence_drv);
>> +        fence_drv = userq_fence->fence_drv;
>> +        /*
>> +         * We need to make sure the user queue release their reference
>> +         * to the fence drivers at some point before queue destruction.
>> +         * Otherwise, we would gather those references until we don't
>> +         * have any more space left and crash.
>> +         */
>> +        r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>> +                 xa_limit_32b, GFP_KERNEL);
>> +        if (r)
>> +            goto put_waitq;
>>   -            /* Store drm syncobj's gpu va address and value */
>> -            fence_info[cnt].va = fence_drv->va;
>> -            fence_info[cnt].value = fences[i]->seqno;
>> +        amdgpu_userq_fence_driver_get(fence_drv);
>>   -            dma_fence_put(fences[i]);
>> -            /* Increment the actual userq fence count */
>> -            cnt++;
>> -        }
>> +        /* Store drm syncobj's gpu va address and value */
>> +        fence_info[cnt].va = fence_drv->va;
>> +        fence_info[cnt].value = fences[i]->seqno;
>>   -        wait_info->num_fences = cnt;
>> -        /* Copy userq fence info to user space */
>> -        if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
>> -                 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
>> -            r = -EFAULT;
>> -            goto free_fences;
>> -        }
>> +        /* Increment the actual userq fence count */
>> +        cnt++;
>>       }
>> +    wait_info->num_fences = cnt;
>> +
>> +    /* Copy userq fence info to user space */
>> +    if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
>> +             fence_info, cnt * sizeof(*fence_info)))
>> +        r = -EFAULT;
>> +    else
>> +        r = 0;
>> +
>> +put_waitq:
>> +    amdgpu_userq_put(waitq);
>>     free_fences:
>> -    if (fences) {
>> -        while (num_fences-- > 0)
>> -            dma_fence_put(fences[num_fences]);
>> -        kfree(fences);
>> -    }
>> +    while (num_fences--)
>> +        dma_fence_put(fences[num_fences]);
>> +    kfree(fences);
>> +
>>   free_fence_info:
>>       kfree(fence_info);
>> -exec_fini:
>> +    return r;
>> +
>> +error_unlock:
>>       drm_exec_fini(&exec);
>> -put_gobj_write:
>> -    for (i = 0; i < num_write_bo_handles; i++)
>> -        drm_gem_object_put(gobj_write[i]);
>> -    kfree(gobj_write);
>> +    goto free_fences;
>> +}
>> +
>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>> +                struct drm_file *filp)
>> +{
>> +    int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
>> +    u32 *syncobj_handles, *timeline_points, *timeline_handles;
>> +    struct drm_amdgpu_userq_wait *wait_info = data;
>> +    struct drm_gem_object **gobj_write;
>> +    struct drm_gem_object **gobj_read;
>> +    void __user *ptr;
>> +    int r;
>> +
>> +    if (!amdgpu_userq_enabled(dev))
>> +        return -ENOTSUPP;
>> +
>> +    if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>> +        wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>> +        return -EINVAL;
>> +
>> +    num_syncobj = wait_info->num_syncobj_handles;
>> +    ptr = u64_to_user_ptr(wait_info->syncobj_handles);
>> +    syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
>> +    if (IS_ERR(syncobj_handles))
>> +        return PTR_ERR(syncobj_handles);
>> +
>> +    num_points = wait_info->num_syncobj_timeline_handles;
>> +    ptr = u64_to_user_ptr(wait_info->syncobj_timeline_handles);
>> +    timeline_handles = memdup_array_user(ptr, num_points, sizeof(u32));
>> +    if (IS_ERR(timeline_handles)) {
>> +        r = PTR_ERR(timeline_handles);
>> +        goto free_syncobj_handles;
>> +    }
>> +
>> +    ptr = u64_to_user_ptr(wait_info->syncobj_timeline_points);
>> +    timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
>> +    if (IS_ERR(timeline_points)) {
>> +        r = PTR_ERR(timeline_points);
>> +        goto free_timeline_handles;
>> +    }
>> +
>> +    num_read_bo_handles = wait_info->num_bo_read_handles;
>> +    ptr = u64_to_user_ptr(wait_info->bo_read_handles),
>> +    r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
>> +    if (r)
>> +        goto free_timeline_points;
>> +
>> +    num_write_bo_handles = wait_info->num_bo_write_handles;
>> +    ptr = u64_to_user_ptr(wait_info->bo_write_handles),
>> +    r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>> +                   &gobj_write);
>> +    if (r)
>> +        goto put_gobj_read;
>> +
>> +    /*
>> +     * Passing num_fences = 0 means that userspace doesn't want to
>> +     * retrieve userq_fence_info. If num_fences = 0 we skip filling
>> +     * userq_fence_info and return the actual number of fences on
>> +     * args->num_fences.
>> +     */
>> +    if (!wait_info->num_fences) {
>> +        r = amdgpu_userq_wait_count_fences(filp, wait_info,
>> +                           syncobj_handles,
>> +                           timeline_points,
>> +                           timeline_handles,
>> +                           gobj_write,
>> +                           gobj_read);
>> +    } else {
>> +        r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
>> +                            syncobj_handles,
>> +                            timeline_points,
>> +                            timeline_handles,
>> +                            gobj_write,
>> +                            gobj_read);
>> +    }
>> +
>> +    while (num_write_bo_handles--)
>> +        drm_gem_object_put(gobj_write[num_write_bo_handles]);
>> +    kvfree(gobj_write);
>> +
>>   put_gobj_read:
>> -    for (i = 0; i < num_read_bo_handles; i++)
>> -        drm_gem_object_put(gobj_read[i]);
>> -    kfree(gobj_read);
>> +    while (num_read_bo_handles--)
>> +        drm_gem_object_put(gobj_read[num_read_bo_handles]);
>> +    kvfree(gobj_read);
>> +
>>   free_timeline_points:
>>       kfree(timeline_points);
>>   free_timeline_handles:
>>       kfree(timeline_handles);
>>   free_syncobj_handles:
>>       kfree(syncobj_handles);
>> -
>> -    if (waitq)
>> -        amdgpu_userq_put(waitq);
>> -
>>       return r;
>>   }
> 
> The rest looks good. In my RFC I found a way to not duplicate the various fence walks between the counting and waiting, but yours works as well.
> 
> Regards,
> 
> Tvrtko
> 

