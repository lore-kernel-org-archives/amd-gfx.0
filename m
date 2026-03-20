Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73280108B8F1
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 10:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D3410EAE4;
	Fri, 20 Mar 2026 10:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yfa9CncK";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49A210EAE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 10:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Al+zMyouUbZ2kZsvzGCroi7K4ELUEdwUp4yRhS+s9xeXi77ki5zXrjQ9XUOXLFowNcAo8m+wk5aQV7Y9mUXn7FE18AJE4hMpJn0SwvZHTyXJ24PhJ9sv/GUW5PR2sEm+whbBTlLD6H+W19v5+/+RsofvTw77XIRXN+0dbgLIirZ/grWIRhfPNvpXnpAsGQdqdBZ2EvNp91dLgE8x3AT/T3bm6j7si7mUmiECzqgYBgYPN+dJss/NlfMFft34KMK4s2zu903HRSFJIs8xa4O0Ap5TEqHY0c4TzOn/pbrApt8V1/Nr1KC1LFyGrKNHN488zALBy7fkL12F7mjYfUSXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSgD53UbUA3t0EK8xjInk1E5qK2VHrXMUI5B0dszwJ4=;
 b=jeDpxFN+zA1EN85YTcsp9of54oV3ofdL1aP4HCAuPscOxbsr0zOhKlgjGsT5F/YQRmPthHoRngfVsGAl7GOESoQErZefjU/nImJelYIBxWmAnxDZIPwzRc74QDnKmEk+T7x2kIGeGsGC440DWyjCn1i9ULrM+jGE8WDwD6nYWpOby+hK2eXLv2IKs9Go9qb+KUABgrHgMmNzE/wit8cX8OUS8QfOtrmVSKlw0qmDEJdig0T+fn3CDC+iIUQA987NqwDQs+KiXP3I6MF59rs5o/I3xvg6k0+pheKf/M2nCcllTGxd3WDkZqRd7wTt+iRr7KFxsMsb2P7ZwnbRvXtnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSgD53UbUA3t0EK8xjInk1E5qK2VHrXMUI5B0dszwJ4=;
 b=yfa9CncKGsM1z4GZrqU+A5QDmSQKbmhFNUnCkllny7w+jKurdpqsecitIVyOKsgh81hH93IPvzZeMz+TnuvAZ4SxZzW7ki+C9kM6uzYWfaHC8phfvY0w4YfMK9uJRE5D8+QGaKAXYk2sKAwCGe1lXi/D6ju3ZfsPrwIp6ypRqyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 10:57:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 10:57:11 +0000
Message-ID: <9481ee5c-fc2d-4b65-b3bc-cdcdb3180136@amd.com>
Date: Fri, 20 Mar 2026 11:57:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: add mutex lock/unlocked version of
 amdgpu_userq_put
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Liang@rtg-sunil-navi33.amd.com,
 Prike <Prike.Liang@amd.com>
References: <20260320094111.3640176-1-sunil.khatri@amd.com>
 <df195a01-e228-4f14-9e20-ecb63dc9d653@amd.com>
 <21c8b934-7973-47f7-9a13-77c7b18530d2@amd.com>
 <99f813b0-54e2-40d0-9fce-00d1f1f52641@amd.com>
 <78e16a87-de53-448d-94f6-13c7fa99596b@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <78e16a87-de53-448d-94f6-13c7fa99596b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ebc95a6-68c8-458f-20b2-08de866f7010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: CKAypRNTLkQ3Hwy9GV4rUjg9Tzhjzt1m1aCoJg+ZSG3V8l+grFkmAavwYPLBFV4SlLcCZNvOXqCRyz9cfQQgtIVYEP9KedDFVRZb440wSP8FNSUjSK2pwW0hJ8odpgoADGFujrDjgpUVzzM2oSAyOVDZS9kAVntRCgekYUhRkDriw52K5Qnp3Yb/9IKppK++fVTYHelybzcJFcuc456M8MSl1SpnScU5EalSavFeAloO0Z1dw2ubPOp8cp6cAUPolLy+tF9K22ogvtCH3kX8ZdsHEJ6w9bkECoNMJSmtBzCGFd/ErW4giigbv2UvCJRdMPhHL5+fL/EXeZUrQP1T3DLBqtsINYxUjmSp+TwFzKY5CkzEISHvAQfD0/TwvRpp1ymMK1EAxSMtOCpTnCHtx3ON+LDDR7khLxiIeI2zNP7v01iwIcyzpF0lJVauPMcYzGih0JkWwDz9D6E/FMj3sOwSS1DJPSczRpBIk+mtMsT0QJaRXWtYwp+dD17dFp/2nLgUdU3jbpCw/L+qmKPTGJls0tFTzdK+3crNCq2rwaWVqyDDSWJkrznzmgKPAP9sFdzTQquA//Z2ilYWrAYPocAp28Bwy8teC/1rWSVnIBLIuPoaGL/5uMHMtr3dM53JiVUBuz/2XwPJOD/VwhLdgKjQt+MDj7/5tedD5y39vV4W0D0PiCei67DzyyjeVN768Zn+IkJqoXYUGqAivhgZFbwG8Hxq5snily7jgAFYiic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNZSjBRZENUSVV1Y0V1U0VHSGVwcHhuemlUdEo1MldKZWxncWFISGVMMFZ1?=
 =?utf-8?B?Rk1TNDNyODlWYm5MaUNONWlVaHJYNkhITVJwTWFsUUxHUHNjWDBEcVFFNE9X?=
 =?utf-8?B?cmNYdzVWWGJkNkE1VVBqTXAxUXRUZmh0bmJWWE1Xc1F2ZTNjcEdXZFlVTGlI?=
 =?utf-8?B?bmJ0eDBUdDEzd09tMW5NZk42U2VGQ0pxRFBwdmlmdWJXUjFRV1hPYnZBVEpM?=
 =?utf-8?B?RjFRRTZiMW80bVlhWjFZV1lkRmZLeGFDZ2t2elp1YWYrQTBFTkZER1EvRE4w?=
 =?utf-8?B?WTYrV1h6WUpUOHlJOStBQ3ZlczVTR041ek4relNJOHUwYkR3V3JkNHNMOEd2?=
 =?utf-8?B?R1dkNmpJRUU2UGw1dG11MjdBc1NQYzNycWgwbE5nRHNkSHdwb2NvWkFudkU1?=
 =?utf-8?B?dVZNZzVOdksyZU1FeWRQellLbGtWTi9nVVZEUlF3b3VlSUJreGhlbE1ybkR2?=
 =?utf-8?B?citKeDlUaFg3VEg1NUZKZFdhOW5ZVTBjbUZqeG1WTkVjNGEwKzNQNytyd0RJ?=
 =?utf-8?B?UG5nd0JSUlZPK0tsc1dwbTJzTzd3NEphYS92eXdyeWoxcUxqQkRYeG9Va2Rl?=
 =?utf-8?B?UTFJNllNQTBtOXFpR25DUVF5SHc2dkdFTStCTy8wUlhNNWFWcVJSU3lqU3Yw?=
 =?utf-8?B?QVVJaTA3czJUN01OYXhDNGtxcXhoTUhMMkVEZmtpenk0cUIzRlI4VXFLM3g0?=
 =?utf-8?B?UW5PbUVDeC8zSEpnU1Nrc2xWdC9xUDFLNVBkb1BPMlQzVGpyOWdkaXM0SmVu?=
 =?utf-8?B?SlIyTnhHSzhCUlNZcHdkK2h0c2hIeElzL3Rmb3c4dnVJLzFDdERWbGhVWWJM?=
 =?utf-8?B?WDY1TGhScnRRdElyOXRPV20xV2VRM05OYm1sb0NDQk8wL0w5S0l3a0hmbWJx?=
 =?utf-8?B?MFVQaFQvSFpLb280RC9ObkRvZUh0UGRaTDFQa1BsNHNidUR5azdybGMzWS9s?=
 =?utf-8?B?Z1gxa2NiQUY2LzdRSnFOdTJPNEZDTUVOUmJKLzdRMUIwazZKQUptbmdBYU9Q?=
 =?utf-8?B?SFpBRGJxSXdzZi9kbkxQV28yWTlhNk8zVU8rVnBhWHA5dXEwUnZSbXB5ampB?=
 =?utf-8?B?ZEp1RFpqazhKN1FtSGxjVHhLRlowQlFkSE5lRDJLN0Q5R2NQYnB5bmhGV2E4?=
 =?utf-8?B?ZVk1WGV1Z0ZIWllTRDl4aTFQT2wrcjdEY2p4Y1pGUDd6dXhrTzVwRFc0UHVq?=
 =?utf-8?B?TGRHYVhRRzQ5SUtIL3VSblBtdEJFQU81RHhVNVNhVHNYQjMxN05oMFkwcTU1?=
 =?utf-8?B?eit3cDhoOHBMWWJYUWc5WnNzMHUrK0JOUmhicWQ4aW0zM1I0RFE0NUNxQjRM?=
 =?utf-8?B?dk9oaHRqNEQ2dGI3MUo1WHFwWmxwd0pvaEg4OVJDQkVEWEg1S1J3ZzJNZDVi?=
 =?utf-8?B?WHhSVW1uTjRSQlZLNFVwditjaG5yVllMc1dzQ1RQaEpSdlFhWWtOMmxRbXdN?=
 =?utf-8?B?UXFzWFJDNmNrc044dE5WcHBXQ2k2V3hoeU92cHlXQWtnd3R2YUoxV3RNaXVG?=
 =?utf-8?B?TlRiZi9FbC9RbEJBY2lHMTNUcFJCUGhOZkZZNzQvbjRQN1FqRU1hQXNFT1pk?=
 =?utf-8?B?eFY3RExuem1KUzZxZGdKR1JyVkwxUDkzRmxDb0JyMFlPczgwdEd3SFozT2Ur?=
 =?utf-8?B?Si9EdVg1eWtxelJMbDFvbGlWSE5oZEtScW93TE1ZMExnSWFmUk1YVVF1MUV6?=
 =?utf-8?B?aW43cWR5VUhtU1JGeUV4SGF2cVlhcUVXOTNJeUI5UUkyTnVmMDEvTVRRQjFj?=
 =?utf-8?B?ZzZacjRuU1pEU1pDQ1N3SGJ6RG9BaTVwa2ZHRFNjU1h5cjhIRGdvdUhsR2Uw?=
 =?utf-8?B?a3M2VDlVVEZhbm1MUzVJK2ZueDgrbXRYNmxuVXMxQWY4aUh2VUpGb2VDM0FV?=
 =?utf-8?B?NjNRazJyRGZaWUczajV3QS9SVGhBM3hoZWpqYUoxTHoyTW5pbGRSc1lNRWtw?=
 =?utf-8?B?OFNEMGhvYldvV25sZ290aVF3WmF5bTQvTWowZHpQZUl2amNQVER6OTdLVnR6?=
 =?utf-8?B?VDdiRVBVSWtUM1BVN3F3UW14U2ZxblFXMmZjMHRabGR4OGZxeHN5QzIxNGFN?=
 =?utf-8?B?V04xREs4aEJrN2RUUnRBN3lnRjZZNHRub3ZyWXpPWDZiQ1lLQkdEMTRkdksz?=
 =?utf-8?B?aGpOZitCc05ZYlFhQkJVeGtwUk83ZWNIME05QnE1U3Uwdmgva1JMUjZ1U1d1?=
 =?utf-8?B?SUx4VGpISjlUaWhocWRHWHNQbEJncmNSOS9nblJ4NHR4VmV1eThPUTRXZXNE?=
 =?utf-8?B?UHhTb0ZCMnpOVUNmRHN4eHRud0t4TXR6RXprSVQ1d2ZvQlk0b2FRM0kxR2po?=
 =?utf-8?Q?tyWit9gab4OGDXAw/o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebc95a6-68c8-458f-20b2-08de866f7010
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:57:11.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V21HnZ8r54JAIh9KZsMu9nWhe/PvRwfogBE9c4epwBtIq/ArCRiDS38akYvMbGi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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

On 3/20/26 11:53, Khatri, Sunil wrote:
> 
> On 20-03-2026 03:43 pm, Christian König wrote:
>>
>> On 3/20/26 11:02, Khatri, Sunil wrote:
>>> On 20-03-2026 03:16 pm, Christian König wrote:
>>>> On 3/20/26 10:41, Sunil Khatri wrote:
>>>>> There is a possibility of deadlock when last reference to a queue is
>>>>> put in certain situations where mutex is already help when calling
>>>>> the amdgpu_userq_destroy.
>>>>   From functions
>>>> As far as I can see that is illegal to begin with. Why are we doing that?
>>> This is to fix the deadlock that prike shared and many other places where deadlock could still be caused.
>>> There is a possibility of amdgpu_userq_put being called for last reference from amdgpu_userq_restore_worker or amdgpu_eviction_fence_suspend_worker via amdgpu_evf_mgr_shutdown
>>> and all these functions already hold the userq_mutex and on last reference when destroy is called it again takes userq_mutex and causing deadlock.
>>>
>>> Thats why when we are dropping the reference we pass the information of the handled could be called with lock already taken and hence the handling.
>> Well that sounds like completely broken handling.
>>
>> Why are dropping an userqueu reference while holding the lock in the first place?
> we are doing at withing the locked state in most of the place in the code.
> few examples:
> static void amdgpu_userq_restore_worker(struct work_struct *work)
> {
>     struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>     struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>     struct dma_fence *ev_fence;
>     int ret;
> 
>     mutex_lock(&uq_mgr->userq_mutex);
>     ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
>     if (!dma_fence_is_signaled(ev_fence))
>         goto unlock;
> 
>     ret = amdgpu_userq_vm_validate(uq_mgr);
>     if (ret) {
>         drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
>         goto unlock;
>     }
> 
>     // Here the restore all is going through all the queues one bye one by doing get and put

That is ok, the question is why the heck is doing that get/put? See we need get/put because we are *not* holding the lock.

When we are holding the lock no get/put is needed at all.

Regards,
Christian.

> and doing the restore of each queue. Now during put if its last reference due to race with another thread in putting we will
> call the destroy with locks taken which causes deadlock.
>     ret = amdgpu_userq_restore_all(uq_mgr);
>     if (ret) {
>         drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
>         goto unlock;
>     }
> 
> unlock:
>     mutex_unlock(&uq_mgr->userq_mutex);
>     dma_fence_put(ev_fence);
> }
> 
> Another example:
> static void
> amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
> {
>     struct amdgpu_eviction_fence_mgr *evf_mgr =
>         container_of(work, struct amdgpu_eviction_fence_mgr,
>                  suspend_work);
>     struct amdgpu_fpriv *fpriv =
>         container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
>     struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>     struct dma_fence *ev_fence;
>     bool cookie;
> 
>     mutex_lock(&uq_mgr->userq_mutex);
> 
>     /*
>      * This is intentionally after taking the userq_mutex since we do
>      * allocate memory while holding this lock, but only after ensuring that
>      * the eviction fence is signaled.
>      */
>     cookie = dma_fence_begin_signalling();
> 
>     ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> 
> 
> /* Here in userq evict we do a ref get and put a various places while the mutex is already taken */
> 
>     amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
> 
>     /*
>      * Signaling the eviction fence must be done while holding the
>      * userq_mutex. Otherwise we won't resume the queues before issuing the
>      * next fence.
>      */
>     dma_fence_signal(ev_fence);
>     dma_fence_end_signalling(cookie);
>     dma_fence_put(ev_fence);
>     mutex_unlock(&uq_mgr->userq_mutex);
> 
> }
> 
> Regards
> Sunil.
> 
> 
>>
>> Regards,
>> Christian.
>>
>>> Regards
>>> Sunil khatri
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> So based on the thread where it could be
>>>>> locked we pass the locked information in the destroy functionality
>>>>> to avoid taking the lock again.
>>>>>
>>>>> Cc: Liang, Prike <Prike.Liang@amd.com>
>>>>> Suggested-by: Liang, Prike <Prike.Liang@amd.com>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 52 +++++++++++++------
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
>>>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 +-
>>>>>    3 files changed, 40 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> index ced9ade44be4..9482664e9c2c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -617,13 +617,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>>>    }
>>>>>      static int
>>>>> -amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>>> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
>>>>> +             bool locked)
>>>>>    {
>>>>>        struct amdgpu_device *adev = uq_mgr->adev;
>>>>>        int r = 0;
>>>>>    -    cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>>> +    /* It safe to unlock since we are in destroy and the queue ref is only this */
>>>>> +    if (locked)
>>>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>>>    +    cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>>>        /* Cancel any pending hang detection work and cleanup */
>>>>>        cancel_delayed_work_sync(&queue->hang_detect_work);
>>>>>    @@ -657,13 +661,27 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>>>>            queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>        }
>>>>>        amdgpu_userq_cleanup(queue);
>>>>> -    mutex_unlock(&uq_mgr->userq_mutex);
>>>>> +
>>>>> +    if (!locked)
>>>>> +        mutex_unlock(&uq_mgr->userq_mutex);
>>>>>          pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>>>          return r;
>>>>>    }
>>>>>    +static void amdgpu_userq_kref_destroy_locked(struct kref *kref)
>>>>> +{
>>>>> +    int r;
>>>>> +    struct amdgpu_usermode_queue *queue =
>>>>> +        container_of(kref, struct amdgpu_usermode_queue, refcount);
>>>>> +    struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>>> +
>>>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, true);
>>>>> +    if (r)
>>>>> +        drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>>>> +}
>>>>> +
>>>>>    static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>>>    {
>>>>>        int r;
>>>>> @@ -671,7 +689,7 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>>>            container_of(kref, struct amdgpu_usermode_queue, refcount);
>>>>>        struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>>>>    -    r = amdgpu_userq_destroy(uq_mgr, queue);
>>>>> +    r = amdgpu_userq_destroy(uq_mgr, queue, false);
>>>>>        if (r)
>>>>>            drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>>>>    }
>>>>> @@ -689,10 +707,14 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>>>        return queue;
>>>>>    }
>>>>>    -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked)
>>>>>    {
>>>>> -    if (queue)
>>>>> -        kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>>>> +    if (queue) {
>>>>> +        if (locked)
>>>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy_locked);
>>>>> +        else
>>>>> +            kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>>>>> +    }
>>>>>    }
>>>>>      static int amdgpu_userq_priority_permit(struct drm_file *filp,
>>>>> @@ -978,7 +1000,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>>            if (!queue)
>>>>>                return -ENOENT;
>>>>>    -        amdgpu_userq_put(queue);
>>>>> +        amdgpu_userq_put(queue, false);
>>>>>            break;
>>>>>        }
>>>>>    @@ -1007,7 +1029,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>>                drm_file_err(uq_mgr->file,
>>>>>                         "trying restore queue without va mapping\n");
>>>>>                queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>>>> -            amdgpu_userq_put(queue);
>>>>> +            amdgpu_userq_put(queue, true);
>>>>>                continue;
>>>>>            }
>>>>>    @@ -1015,7 +1037,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>>            if (r)
>>>>>                ret = r;
>>>>>    -        amdgpu_userq_put(queue);
>>>>> +        amdgpu_userq_put(queue, true);
>>>>>        }
>>>>>          if (ret)
>>>>> @@ -1258,7 +1280,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>>            r = amdgpu_userq_preempt_helper(queue);
>>>>>            if (r)
>>>>>                ret = r;
>>>>> -        amdgpu_userq_put(queue);
>>>>> +        amdgpu_userq_put(queue, true);
>>>>>        }
>>>>>          if (ret)
>>>>> @@ -1298,17 +1320,17 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>>>>            struct dma_fence *f = queue->last_fence;
>>>>>              if (!f || dma_fence_is_signaled(f)) {
>>>>> -            amdgpu_userq_put(queue);
>>>>> +            amdgpu_userq_put(queue, true);
>>>>>                continue;
>>>>>            }
>>>>>            ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>>>>            if (ret <= 0) {
>>>>>                drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>>>>>                         f->context, f->seqno);
>>>>> -            amdgpu_userq_put(queue);
>>>>> +            amdgpu_userq_put(queue, true);
>>>>>                return -ETIMEDOUT;
>>>>>            }
>>>>> -        amdgpu_userq_put(queue);
>>>>> +        amdgpu_userq_put(queue, true);
>>>>>        }
>>>>>          return 0;
>>>>> @@ -1366,7 +1388,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>>            if (!queue)
>>>>>                break;
>>>>>    -        amdgpu_userq_put(queue);
>>>>> +        amdgpu_userq_put(queue, false);
>>>>>        }
>>>>>          xa_destroy(&userq_mgr->userq_xa);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> index f0abc16d02cc..2a496e74ec6a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> @@ -116,7 +116,7 @@ struct amdgpu_db_info {
>>>>>    };
>>>>>      struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>>>> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked);
>>>>>      int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> index 18390d37a7e0..10e08cb6bd13 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> @@ -612,7 +612,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>>        kfree(syncobj_handles);
>>>>>          if (queue)
>>>>> -        amdgpu_userq_put(queue);
>>>>> +        amdgpu_userq_put(queue, false);
>>>>>          return r;
>>>>>    }
>>>>> @@ -914,7 +914,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>>            r = 0;
>>>>>      put_waitq:
>>>>> -    amdgpu_userq_put(waitq);
>>>>> +    amdgpu_userq_put(waitq, false);
>>>>>      free_fences:
>>>>>        while (num_fences--)

