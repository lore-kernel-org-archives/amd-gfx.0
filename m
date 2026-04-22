Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514F9F9EDF3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 15:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44A310E079;
	Wed, 22 Apr 2026 15:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A5mYDC73";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8230C10E04D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 15:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBSFjk+0gnT0wiFkkSFRhDcVXGE6SyVpbujjdhN/VQFAnbttAL5f2lM5QyW+mkvh/xOZalpWmfxA5n3pjBgu36A7H4J/FClAMklWKT25GB0E1vaHVCZghscUG6d8oPdy6xoUOkyTJBvfHLMeuUXWy+XuKdR3phykAoM4Oq9WmjYLg/YRMjmHPOGmT89+DCHWoT5rjRtiwwLBrq3qpOrt8Wfp1rdB1KTXzLXc9duEAQXuPf4ijV43Uh74x2DNoed2W8y0dXb7X2Ge6d9z3CUx1z4+rjqofUAU/8QtksjgWSPXZhiW8LJbgmh96SlnUE3FB2cLQardZTxvK6N5FH1Qaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6G8qXvpthy9aoboKxMR/Aiyi/dAfER9TA8sWidRxdE=;
 b=tcHYB+VoB0iXW91KCBMq5b+66LkbrdGElERn3Zh/FVZGK8u556gdC1iUXKFom/D12IN20L3vyFC6jzxKtfjhOax1s1VulMrpN4Hhtos+izogjzKdki0QywnzMwxVnt011JwquADBWyib5bdT2NE2D3ixj4TrUS54Hu5iGL+XLF5t1usd5/ZnpL256GVfxYRrWuCqvj9bXjckMjbBIdv1IIhGxyiKinI7gFeNG6sLe3ugIZNld4sWBMEplPOltxYiEZ8+mJab//0Si/kjKBVSorycXE73Z0VORfNrPazIc3uT927avpn6DjWAYQ7i8GrS3zXLdbLBEMRF9qoz6os4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6G8qXvpthy9aoboKxMR/Aiyi/dAfER9TA8sWidRxdE=;
 b=A5mYDC73hCoQmD6/coA5qnThIiTzJtvRkGvCEO8wV24DKVOXvB0ugfj8D5UUrqd1ARLGRSt9qDXrjRz1LEH5zuvutDCTVi9F/gK0iWw18Y40r15RCCzfieHDyuNwM3EqeuYhrltFaSlzgsPR9MiwakjtoJdWCYhLwpvUdGGaPug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 15:14:55 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 15:14:54 +0000
Message-ID: <ca86df2f-c4f5-434b-9801-6b8f2fefd90d@amd.com>
Date: Wed, 22 Apr 2026 20:44:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-4-christian.koenig@amd.com>
 <8fe38911-e8c0-40da-be4e-4d14983678a0@amd.com>
 <4689fb9e-64bd-4931-ad4d-fae6e9a08fb4@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <4689fb9e-64bd-4931-ad4d-fae6e9a08fb4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::16) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e08d72f-cd51-4fa1-dee0-08dea081e891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: isFWUI8axRv6nBdyRTuvlxywSY6UjOwhMQaR6ECcBwV8p0N6v71YReiJ58OX5XVsdE6wt8JlWe7hpm9a4Bck0xJ3vcuOw37d8tRv36lq686QaCiFoJPAVxaCTfdZiiy75+EPtS0DJqZKee7KFNQ2WmS24UlFdgdGtOpKuCbZE90w34WgNw2GZ0fefZMtR7mFG7AxwnQWxrhw0fajT1SXrydqarmbeHRlqBthzl2MU1NRcBv2aigXC4U8FVDvWbDsO2JzlcGkCDGkUX9kGMvimL7XCcDgUid5YppFg/Iw70ulHhnofnrQlZeMnxF7nlBl7MDY8W238GraL58cfYGYP6cHkd7z+GsmdghJqaRsCKRIC7yj2fILgelqcMISf+nulhQFO9B2lPlsFpCxn096pT0u/CGCO5ohCckmOCD0vhEXVudTlAJybjAcQJMyRpSlqcdHOIhONzbm5sBzn0wpCz6eAqPo+eZKQJ90TcGriD6mIHEGRGGw5EpqHKbeaiqZfwj+WygiOQ0pdV2Jv2IwDBVwl09Kw3hDyTPZt8ugLnmixnpvLX9YClYjoDDASvzLwB4QAwAwOm33qU73swwt83X+jhPo69CwZ0dVH9i972c14O2+GZonqPG76NZLdYYT0qyGErRvhDI1OXaRqIYOsUnPNRQZrIdtNtY5ltmL6zSSW7w2bk4tlDYaWkiLHEljzx8vnns+KLQFNkL7GRTindkMEKWOyhyN4zd6ttPqgxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNINUlBb1RwZXFZWXZVa3VsSVkyalVNS1lTbWh6QjRqbFIwUU9QTHVUemk0?=
 =?utf-8?B?RFNOZEl2ak5YZm0wdGUvYWlZd1FGMGVEQWh4aFhVVG1rRExWNzJydFBnR2xh?=
 =?utf-8?B?RVlGWkdVSUN0R1dqTWtUM1ZDcUQwQkQyNG1xeU10ZTU0dHg1bzlLelhHVG12?=
 =?utf-8?B?ZFhOaU1rdU44cVZMdXJSbGNydVNBdHh3Z0NWU1VKYk9FdE5EbHJVS2YzRzVW?=
 =?utf-8?B?TFVkL3ZsTVMrek9nVDMrRjZvVEJyeWttMHZURHdTb0dENWRJMzBzdWs1eXBi?=
 =?utf-8?B?WThDbjJNb1NMcG5ES1JHMTBUTzB5S1dpNnBVQU96dXkzQmNOTXBDNjhWMXls?=
 =?utf-8?B?MXcxcE9MUXlNUjUxYVc3Q1E0bU5QeC8zc0VlcnhjbVFRcndobEpUejVXYUZk?=
 =?utf-8?B?elF4NnVjb0thaVFpd0crMndxeXUvbFpzQzNYcVM0amorSXU0RjhsOThSYUQx?=
 =?utf-8?B?bWhlbVhlM2xMV0ZBNjg2aHJ6Nk13Ly9uVFBHcjdCZ0FLVmFFRkhSeU81clRV?=
 =?utf-8?B?eld3NEJTMWFoZkY0T0VscUxpVFFXVTltWTNXZVIxRWVDeko0aGxkZnhMdG8r?=
 =?utf-8?B?ekdQaTlUUEVwdjh0dTdhYmxTQ21oYlVFeEdaZjVrNzBwYXY4Tm56dEFYajNI?=
 =?utf-8?B?Qmk1OWRoWno2S0JIYzJxSFBXa1FIQ0ZEeDQ2U1ZMMzNFK2NSOUhJNDR4V3ZS?=
 =?utf-8?B?aDNrbzd4M09HVG1NOWhaN0NMRWNMdW5aOFg0OGRWMmE2cGpsSkdNMndtNU1n?=
 =?utf-8?B?Sy9OZS8vcHd3K3BhUHdXN2dGSkJBNCtraDVRQWtWRWtYYlBBUklvYzB2ZHdx?=
 =?utf-8?B?QjdGall0bWJWamdHREV0MjFGZitFVzhHSkhsS0xNbzVad245WjIvUlRBcW1t?=
 =?utf-8?B?aXZlVVMrRlpqOFUyb2YzZVV3TDJqckN5WlRHNUFqQkxHODY4RkN1dGY2bitC?=
 =?utf-8?B?ZVpSRnY0T1lpdS92WW02YldlQTBQeTJpQ3VFcXFRMXlqdGFEcU5VY1Bpc1Vp?=
 =?utf-8?B?TW00cjBldTBRUlFMNlMzQXJMRkZWQml6M1JlRm82bWNsTnFEbEFtN1JtTkEv?=
 =?utf-8?B?TEJNZElhRkxLY1BJTjlpZmJERUdRbWVrSTZ2YWI4bEtGb3ZqQjdUVStwaU80?=
 =?utf-8?B?MVNQTHVQSkVVdmsxR3RnZTROSzRIQnl2SWNZNjNzVGZJR2R1S3VGMTZSOVZj?=
 =?utf-8?B?L04zU0NLeTlIelNNRDY0ZlU5eTl1OW5zRmM4dzhrZTMxK1VtVlRoVUdnbEFp?=
 =?utf-8?B?MC8wa1ZOc0MrZEIrditIaVJzdDdrU0dFSjNkMGhWNUV4bHgrYjUwdW5uMHpI?=
 =?utf-8?B?UjhNQ045d2VxQU1Xb280Q2lGMXZuZk9maXY3NHV1WGpOai9qTFFqWEJtV0Zz?=
 =?utf-8?B?TlF3VmF1Rjhqc3lkRXVESEsyM3lxUXpYcEYvcUgzc3hnbGc1OGxiaWhQRjg0?=
 =?utf-8?B?MFB5a3ZXSmc5OGEvTVRHWlZpUGM0QS9xd1E3c2RjM0luMjVHeG0yV3dTOHA3?=
 =?utf-8?B?cGF3aTJ5eWJyVTRieDBtTE5tN05wSm55ZXFwVTAvUmcyY1VOVTd5UzdKQVNO?=
 =?utf-8?B?UmtzdXhaUXNONUhFVTdLdEs2MGFiVjJmRGRrNmVqTXUvcTh4SUV4TVJTR3lp?=
 =?utf-8?B?SWxwdlZuOHorVUlINDZoRUwyZ2Y1WnA1K09XZFNZSVpiZHJFcy9QQTk0TWFq?=
 =?utf-8?B?VFUyQmVsbXFLQ3hrWWdkTXdIalZ4QmlyOXFPT0JBTVlEdUtXSnMzN0s1UTU5?=
 =?utf-8?B?aUFiVlo3UEt5TngzM3dKZXErVUl5dnNzQzFmWFFWMTg0NjBUNXExNHh5OUF4?=
 =?utf-8?B?ZVUrWjZCdUxpRWN6SnUxTU9CVGxvcHZXMzd5dFppNFk3ekhFODNjMFdxU1RI?=
 =?utf-8?B?dTZJejY1QkpTN1ZsajZIUHZ5UVlUZmRZc1ZrTUx1MTByZVpWaDFyYmduRXdZ?=
 =?utf-8?B?NEtJOFBhcjNiNmZFMVI4N2RmTHpnQzJtL1RWMXJnVTBlNUhaLzVjZlk1QnJV?=
 =?utf-8?B?emdoRHUrejRnZStzakZtOXJCd3dOdCs0aWtKYjZCajFSNFBWWmgwc2t1Y1NH?=
 =?utf-8?B?TFVhWGcwTDBBakhSbXc2c0JCcGxNNXpodDJiNms1VG5UVy9uQmdUZjd3bmlK?=
 =?utf-8?B?Rlp6M0RyK0kzQlFxZ1ZhYzZ6R3JiRU94cFp1bkU5Z0tEbHFWSFVGWmZoWGZa?=
 =?utf-8?B?M2tSamt6ajA1K2FiUmRwNzJPVHpBTDVXQmFoaVFaRjFHcGgyWlN1ZTlmaWFa?=
 =?utf-8?B?ZTN5ZUhENjN1NWVXVVZzZkN0NUJkM2w0YWlpcDUwQmVCZ3hFVmpsK2hiUXYr?=
 =?utf-8?B?dFk1eFBXUDZ3dGZzZVJwY1lJQkN2K3U2TG9nNE1tbDhFazFPLzJpQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e08d72f-cd51-4fa1-dee0-08dea081e891
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 15:14:54.8620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sksP8DKpY4007W3ds4cecm47ULh6ryqr63m3xBB2aMS+Cb0Av59aSd7Q543n8FaMiRfsnCCtOxIP5LyirNgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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


On 22-04-2026 03:44 pm, Christian König wrote:
> On 4/22/26 12:08, Khatri, Sunil wrote:
>> On 21-04-2026 06:25 pm, Christian König wrote:
>>> This one was fortunately not looking so bad as the wait ioctl path, but
>>> there were still a few things which could be fixed/improved:
>>>
>>> 1. Allocating with GFP_ATOMIC was quite unecessary, we can do that
>>>      before taking the userq_lock.
>>> 2. Use a new mutex as protection for the fence_drv_xa so that we can do
>>>      memory allocations while holding it.
>>> 3. Starting the reset timer is unecessary when the fence is already
>>>      signaled when we create it.
>>> 4. Cleanup error handling, avoid trying to free the queue when we don't
>>>      even got one.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  12 +
>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 220 ++++++++----------
>>>    3 files changed, 111 insertions(+), 122 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index b632bc3c952b..174190a77005 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -793,6 +793,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>        }
>>>          queue->doorbell_index = index;
>>> +    mutex_init(&queue->fence_drv_lock);
>> we do want to destroy the mutex in case queue creation fails ? RIght now amdgpu_userq_fence_driver_alloc fails we goto clean_mapping and not destroying the mutex which is done in amdgpu_userq_fence_driver_free.
>> goto needs to be modified i guess to handle it.
> Good point, going to clean that up.
>
>> Apart from that LGTM. Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Thanks,
> Christian
>
>> Regards
>> Sunil
>>>        xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>>>        r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>>>        if (r) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index 675fe6395ac8..cb92789c1ed1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -66,6 +66,18 @@ struct amdgpu_usermode_queue {
>>>        struct amdgpu_userq_obj    db_obj;
>>>        struct amdgpu_userq_obj fw_obj;
>>>        struct amdgpu_userq_obj wptr_obj;
>>> +
>>> +    /**
>>> +     * @fence_drv_lock: Protecting @fence_drv_xa.
>>> +     */
>>> +    struct mutex        fence_drv_lock;
>>> +
>>> +    /**
>>> +     * @fence_drv_xa:
>>> +     *
>>> +     * References to the external fence drivers returned by wait_ioctl.
>>> +     * Dropped on the next signaled dma_fence or queue destruction.
>>> +     */
>>>        struct xarray        fence_drv_xa;
>>>        struct amdgpu_userq_fence_driver *fence_drv;
>>>        struct dma_fence    *last_fence;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 909bdccc2a92..b0543fa257ed 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -121,6 +121,7 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>>>        userq->last_fence = NULL;
>>>        amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
>>>        xa_destroy(&userq->fence_drv_xa);
>>> +    mutex_destroy(&userq->fence_drv_lock);
>>>        /* Drop the queue's ownership reference to fence_drv explicitly */
>>>        amdgpu_userq_fence_driver_put(userq->fence_drv);
>>>    }
>>> @@ -216,81 +217,77 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>>>        kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
>>>    }
>>>    -static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>>> +static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>>> +                    struct amdgpu_userq_fence **pfence)
>>>    {
>>> -    *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>>> -    return *userq_fence ? 0 : -ENOMEM;
>>> +    struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>>> +    struct amdgpu_userq_fence *userq_fence;
>>> +    unsigned long count;

we need to set the initial value of count to 0 to have a valid count 
value else it goes to some huge random garbage value. eventually leading 
to memory allocation failure and app crash.

regards
Sunil Khatri

>>> +
>>> +    userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
>>> +    if (!userq_fence)
>>> +        return -ENOMEM;
>>> +
>>> +    /*
>>> +     * Get the next unused entry, since we fill from the start this can be
>>> +     * used as size to allocate the array.
>>> +     */
>>> +    mutex_lock(&userq->fence_drv_lock);
>>> +    xa_find(&userq->fence_drv_xa, &count, ULONG_MAX, XA_FREE_MARK);
We are using that count value in below kvmalloc_Array and that fails and 
we return ENOMEM.
>>> +
>>> +    userq_fence->fence_drv_array = kvmalloc_array(count, sizeof(fence_drv),
>>> +                              GFP_KERNEL);
>>> +    if (!userq_fence->fence_drv_array) {
>>> +        mutex_unlock(&userq->fence_drv_lock);
>>> +        kfree(userq_fence);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    userq_fence->fence_drv_array_count = count;
>>> +    xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>>> +           0, ULONG_MAX, count, XA_PRESENT);
>>> +    xa_destroy(&userq->fence_drv_xa);
>>> +
>>> +    mutex_unlock(&userq->fence_drv_lock);
>>> +
>>> +    userq_fence->fence_drv = fence_drv;
>>> +    amdgpu_userq_fence_driver_get(fence_drv);
>>> +
>>> +    *pfence = userq_fence;
>>> +    return 0;
>>>    }
>>>    -static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>>> -                     struct amdgpu_userq_fence *userq_fence,
>>> -                     u64 seq, struct dma_fence **f)
>>> +static void amdgpu_userq_fence_init(struct amdgpu_usermode_queue *userq,
>>> +                    struct amdgpu_userq_fence *fence,
>>> +                    u64 seq)
>>>    {
>>> -    struct amdgpu_userq_fence_driver *fence_drv;
>>> -    struct dma_fence *fence;
>>> +    struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>>>        unsigned long flags;
>>>        bool signaled = false;
>>>    -    fence_drv = userq->fence_drv;
>>> -    if (!fence_drv)
>>> -        return -EINVAL;
>>> -
>>> -    spin_lock_init(&userq_fence->lock);
>>> -    INIT_LIST_HEAD(&userq_fence->link);
>>> -    fence = &userq_fence->base;
>>> -    userq_fence->fence_drv = fence_drv;
>>> -
>>> -    dma_fence_init64(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>>> +    spin_lock_init(&fence->lock);
>>> +    dma_fence_init64(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
>>>                 fence_drv->context, seq);
>>>    -    amdgpu_userq_fence_driver_get(fence_drv);
>>> -    dma_fence_get(fence);
>>> -
>>> -    if (!xa_empty(&userq->fence_drv_xa)) {
>>> -        struct amdgpu_userq_fence_driver *stored_fence_drv;
>>> -        unsigned long index, count = 0;
>>> -        int i = 0;
>>> -
>>> -        xa_lock(&userq->fence_drv_xa);
>>> -        xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>>> -            count++;
>>> -
>>> -        userq_fence->fence_drv_array =
>>> -            kvmalloc_array(count,
>>> -                       sizeof(struct amdgpu_userq_fence_driver *),
>>> -                       GFP_ATOMIC);
>>> -
>>> -        if (userq_fence->fence_drv_array) {
>>> -            xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
>>> -                userq_fence->fence_drv_array[i] = stored_fence_drv;
>>> -                __xa_erase(&userq->fence_drv_xa, index);
>>> -                i++;
>>> -            }
>>> -        }
>>> -
>>> -        userq_fence->fence_drv_array_count = i;
>>> -        xa_unlock(&userq->fence_drv_xa);
>>> -    } else {
>>> -        userq_fence->fence_drv_array = NULL;
>>> -        userq_fence->fence_drv_array_count = 0;
>>> -    }
>>> +    /* Make sure the fence is visible to the hang detect worker */
>>> +    dma_fence_put(userq->last_fence);
>>> +    userq->last_fence = dma_fence_get(&fence->base);
>>>    -    /* Check if hardware has already processed the job */
>>> +    /* Check if hardware has already processed the fence */
>>>        spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>>> -    if (!dma_fence_is_signaled(fence)) {
>>> -        list_add_tail(&userq_fence->link, &fence_drv->fences);
>>> +    if (!dma_fence_is_signaled(&fence->base)) {
>>> +        dma_fence_get(&fence->base);
>>> +        list_add_tail(&fence->link, &fence_drv->fences);
>>>        } else {
>>> +        INIT_LIST_HEAD(&fence->link);
>>>            signaled = true;
>>> -        dma_fence_put(fence);
>>>        }
>>>        spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>>          if (signaled)
>>> -        amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>> -
>>> -    *f = fence;
>>> -
>>> -    return 0;
>>> +        amdgpu_userq_fence_put_fence_drv_refs(fence);
>>> +    else
>>> +        amdgpu_userq_start_hang_detect_work(userq);
>>>    }
>>>      static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
>>> @@ -392,11 +389,6 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>>>        return r;
>>>    }
>>>    -static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
>>> -{
>>> -    dma_fence_put(fence);
>>> -}
>>> -
>>>    static void
>>>    amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
>>>                        int error)
>>> @@ -440,13 +432,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>        const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>>        struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>        struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>>> +
>>>        struct drm_gem_object **gobj_write, **gobj_read;
>>>        u32 *syncobj_handles, num_syncobj_handles;
>>> -    struct amdgpu_userq_fence *userq_fence;
>>> -    struct amdgpu_usermode_queue *queue = NULL;
>>> -    struct drm_syncobj **syncobj = NULL;
>>> -    struct dma_fence *fence;
>>> +    struct amdgpu_usermode_queue *queue;
>>> +    struct amdgpu_userq_fence *fence;
>>> +    struct drm_syncobj **syncobj;
>>>        struct drm_exec exec;
>>> +    void __user *ptr;
>>>        int r, i, entry;
>>>        u64 wptr;
>>>    @@ -458,13 +451,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>            return -EINVAL;
>>>          num_syncobj_handles = args->num_syncobj_handles;
>>> -    syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>>> -                        num_syncobj_handles, sizeof(u32));
>>> +    ptr = u64_to_user_ptr(args->syncobj_handles);
>>> +    syncobj_handles = memdup_array_user(ptr, num_syncobj_handles,
>>> +                        sizeof(u32));
>>>        if (IS_ERR(syncobj_handles))
>>>            return PTR_ERR(syncobj_handles);
>>>    -    /* Array of pointers to the looked up syncobjs */
>>> -    syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
>>> +    syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
>>> +                GFP_KERNEL);
>>>        if (!syncobj) {
>>>            r = -ENOMEM;
>>>            goto free_syncobj_handles;
>>> @@ -478,21 +472,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>            }
>>>        }
>>>    -    r = drm_gem_objects_lookup(filp,
>>> -                   u64_to_user_ptr(args->bo_read_handles),
>>> -                   num_read_bo_handles,
>>> -                   &gobj_read);
>>> +    ptr = u64_to_user_ptr(args->bo_read_handles);
>>> +    r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
>>>        if (r)
>>>            goto free_syncobj;
>>>    -    r = drm_gem_objects_lookup(filp,
>>> -                   u64_to_user_ptr(args->bo_write_handles),
>>> -                   num_write_bo_handles,
>>> +    ptr = u64_to_user_ptr(args->bo_write_handles);
>>> +    r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>>>                       &gobj_write);
>>>        if (r)
>>>            goto put_gobj_read;
>>>    -    /* Retrieve the user queue */
>>>        queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>>>        if (!queue) {
>>>            r = -ENOENT;
>>> @@ -501,73 +491,61 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>          r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
>>>        if (r)
>>> -        goto put_gobj_write;
>>> +        goto put_queue;
>>>    -    r = amdgpu_userq_fence_alloc(&userq_fence);
>>> +    r = amdgpu_userq_fence_alloc(queue, &fence);
>>>        if (r)
>>> -        goto put_gobj_write;
>>> +        goto put_queue;
>>>          /* We are here means UQ is active, make sure the eviction fence is valid */
>>>        amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>>    -    /* Create a new fence */
>>> -    r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>>> -    if (r) {
>>> -        mutex_unlock(&userq_mgr->userq_mutex);
>>> -        kfree(userq_fence);
>>> -        goto put_gobj_write;
>>> -    }
>>> +    /* Create the new fence */
>>> +    amdgpu_userq_fence_init(queue, fence, wptr);
>>>    -    dma_fence_put(queue->last_fence);
>>> -    queue->last_fence = dma_fence_get(fence);
>>> -    amdgpu_userq_start_hang_detect_work(queue);
>>>        mutex_unlock(&userq_mgr->userq_mutex);
>>>    +    /*
>>> +     * This needs to come after the fence is created since
>>> +     * amdgpu_userq_ensure_ev_fence() can't be called while holding the resv
>>> +     * locks.
>>> +     */
>>>        drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>>                  (num_read_bo_handles + num_write_bo_handles));
>>>    -    /* Lock all BOs with retry handling */
>>>        drm_exec_until_all_locked(&exec) {
>>> -        r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
>>> +        r = drm_exec_prepare_array(&exec, gobj_read,
>>> +                       num_read_bo_handles, 1);
>>>            drm_exec_retry_on_contention(&exec);
>>> -        if (r) {
>>> -            amdgpu_userq_fence_cleanup(fence);
>>> +        if (r)
>>>                goto exec_fini;
>>> -        }
>>>    -        r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
>>> +        r = drm_exec_prepare_array(&exec, gobj_write,
>>> +                       num_write_bo_handles, 1);
>>>            drm_exec_retry_on_contention(&exec);
>>> -        if (r) {
>>> -            amdgpu_userq_fence_cleanup(fence);
>>> +        if (r)
>>>                goto exec_fini;
>>> -        }
>>>        }
>>>    -    for (i = 0; i < num_read_bo_handles; i++) {
>>> -        if (!gobj_read || !gobj_read[i]->resv)
>>> -            continue;
>>> -
>>> -        dma_resv_add_fence(gobj_read[i]->resv, fence,
>>> +    /* And publish the new fence in the BOs and syncobj */
>>> +    for (i = 0; i < num_read_bo_handles; i++)
>>> +        dma_resv_add_fence(gobj_read[i]->resv, &fence->base,
>>>                       DMA_RESV_USAGE_READ);
>>> -    }
>>>    -    for (i = 0; i < num_write_bo_handles; i++) {
>>> -        if (!gobj_write || !gobj_write[i]->resv)
>>> -            continue;
>>> -
>>> -        dma_resv_add_fence(gobj_write[i]->resv, fence,
>>> +    for (i = 0; i < num_write_bo_handles; i++)
>>> +        dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
>>>                       DMA_RESV_USAGE_WRITE);
>>> -    }
>>>    -    /* Add the created fence to syncobj/BO's */
>>>        for (i = 0; i < num_syncobj_handles; i++)
>>> -        drm_syncobj_replace_fence(syncobj[i], fence);
>>> +        drm_syncobj_replace_fence(syncobj[i], &fence->base);
>>>    +exec_fini:
>>>        /* drop the reference acquired in fence creation function */
>>> -    dma_fence_put(fence);
>>> +    dma_fence_put(&fence->base);
>>>    -exec_fini:
>>>        drm_exec_fini(&exec);
>>> +put_queue:
>>> +    amdgpu_userq_put(queue);
>>>    put_gobj_write:
>>>        for (i = 0; i < num_write_bo_handles; i++)
>>>            drm_gem_object_put(gobj_write[i]);
>>> @@ -578,15 +556,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>        kvfree(gobj_read);
>>>    free_syncobj:
>>>        while (entry-- > 0)
>>> -        if (syncobj[entry])
>>> -            drm_syncobj_put(syncobj[entry]);
>>> +        drm_syncobj_put(syncobj[entry]);
>>>        kfree(syncobj);
>>>    free_syncobj_handles:
>>>        kfree(syncobj_handles);
>>>    -    if (queue)
>>> -        amdgpu_userq_put(queue);
>>> -
>>>        return r;
>>>    }
>>>    @@ -874,8 +848,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>             * Otherwise, we would gather those references until we don't
>>>             * have any more space left and crash.
>>>             */
>>> +        mutex_lock(&waitq->fence_drv_lock);
>>>            r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>>                     xa_limit_32b, GFP_KERNEL);
>>> +        mutex_unlock(&waitq->fence_drv_lock);
>>>            if (r) {
>>>                amdgpu_userq_fence_driver_put(fence_drv);
>>>                goto put_waitq;
