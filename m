Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4B1FED3C0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 13:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0129F10F58F;
	Fri, 24 Apr 2026 13:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JBCti8RK";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF6C10F58F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 13:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI6HWKsUpE/nZRkFp/NXDqwTtxaWJIUbiFJOraOXCxS2858X8vtBdOK/OAB1BY9fwu32jx0jv+6tnmzgtwE/jbsSU4rqqJrD1QJB97/7O93of3cZiS2an06NbG70XgGC74nne1O1uQtbFNAnMlwofZ5svxY56cBZLoRTqXWrOucjpNmcq9taWL/2X3sqlFr+P/vmQG/Y0Dhwgl5gju2r4Dwmln6x5z40qJ/TcxxPFWAUmYvyf35VAYSXP8jY3LpabaP7hNsOfh1svsbT0E7QH2t7FHONKsqG15zQF8qWRM3XUhaL7r8zvBPkLSjKiQCG3POeRDSiZtwPR8AAVpppMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iTVyree3FnOkpwfjlJ6bzLJWw/S4BbkMXf0fv+kPUA=;
 b=TIivCKrQkM42u893OwPDE82NOHF/TR+SuNHpeelUxFtwgBYIXfw+o1iKAKFVtFViiPVgOYgjRMKzc+jziD+wGK6PTjhfy48vXaVLLb7chwqb/QGP0ZAIZ5U1Cpz6MP5vhkwp4a5Yn67FikmMZhiljC/QS9GjRexi36/Jb3iH7gZ+84ypkSqcZLoJ9giDA3fv+SLy8xGcEs8zs6iBMJYzxtnUOsWp8MunSusKJBTsvw56pMAkHwWQNmPzgrQfKgpwFrvN7WWUOcHQqueSkXhKhS4JnZMzEGYrmSddTvdH6VesuFtthDlAaGFe/oKUHcqeYth5+M2/gLV0mceTEzCajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iTVyree3FnOkpwfjlJ6bzLJWw/S4BbkMXf0fv+kPUA=;
 b=JBCti8RKU/EOLusnMmaJgJaGxFjcXjgqIhJSkjwVUgz6pJ2ZAieuZlU8djlg6CbD7v2KBjKcNnKA8WZxQj35pU6AMupsynS/Pcqc6hp/mdurIfNlzD2qMVsxyynBzTlBid3qiUwfc6/q17tBzbnLl5+m81yrOM91IebxXHd7LUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Fri, 24 Apr
 2026 13:02:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 13:02:27 +0000
Message-ID: <fead91ae-a962-4124-88fb-ac746cfc525c@amd.com>
Date: Fri, 24 Apr 2026 15:02:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
To: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-4-christian.koenig@amd.com>
 <DS7PR12MB60051B45E53E61949D874CDDFB2A2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <03e6c28c-5c16-4e5d-8c26-a214f0aef012@amd.com>
 <PH7PR12MB60002D0F42DB677AC0C2F40AFB2B2@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB60002D0F42DB677AC0C2F40AFB2B2@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:208:a8::46) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce30b24-3989-4f97-dd97-08dea201bc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: v/Waw8wQzUYZwpqa+XPUj+dQ1KIfynSt/JDXjYeovchUqlhz2SABd3fRZcsEcq1VODgBysRY2gEuJbhMrx5vlaF9jkBLxyh2YMLFJ9I2QB/npL4X+ArYoKHVnBgi/L9HPP6MCBxrKf/kasDRh9KfyLHD/mwXg8SplASJ5FXPpOrzm8b8obvxKrkF2XGfLgqp8zffR2xz7UDqeuP2K9zRu3ARju79Mh/p/XfG/X8jwXjXp51sKUPgfYaA7Krg//zhHQLW8nYa+0zMpbGngrGpwMkrzlFKWlBsoObY0Cl/sX1CXOilOjNvdx4cHGRLIAsHaDPdA8sQyfSbFUBlo30c31Peq6X5bq3Vg4iRrF5GMwF7K0lKFj7Z9CqgTebIZYCM9qeaktsq/P4aEgydCeMzeTchXkk7oypkEJ2Us02St6/1v5ETat8YGN1hh7mpe/1NRbcFkEFG41uGPdGVpgaSo/+5J0FV/Hxe6SMZnnpYON3Dv6C1DOpPIcFXEU+F3llLCbqq8k0ITiDpQzPMlVQ03EckWoorkc6MMie8IE9w89+adSx/6skG9Z/s5wLW4wliMD2mmFavmm2CEob8OUBF1QM8CkFE3cIOVVHMfwgmq6LGaKYjJap5zliruWpHPeS0K37umAxtlpy/qMSHqNBWfXSSwnCzTuU0zTqW2i8hK9cieDI7X2fzIj+j9A4j+1uX0TWrX+AZLqtJ+yn2R2SR2IVynW0L2pzeAebgUMqLzf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXc0ZGhENElWMDQ5TnFhWFFoMkdkNFZyQy91T25lbXR6UE93TUhnK1lMYTFO?=
 =?utf-8?B?ei9UWjU3ZFdGNWZhdVJjV0ljN3R6Zkxrc2lPYUdKenRjeGN6U2k3SEFmc3Rj?=
 =?utf-8?B?cW13MHRsSjA3dHluODJhdFMrbUJOM25zQUQ4aXMzaUZpZ3B1WmhTbjRUS1Nv?=
 =?utf-8?B?TVovS2Iyd0VuOUFCTnZ0VWVPWnhqQ2ZrdlZqTkE0QVlwY1VyTzJTcUJ2T3J2?=
 =?utf-8?B?Q2VubTREcXhjYlFUaHFzbTYydFErSVc1Sk5uSGRqOFd1bWl3UlNvdUhHRGE4?=
 =?utf-8?B?eFEydG4vTEtaTXFpODZsa01Pd3d6amFtNlpFN1FXU0xvdS9EM2dtdmlkV09s?=
 =?utf-8?B?U3RWTmV5YjdkaGZmYUUxajhJMjR6YjFVOUFubU5JNGU4SGVxMkQ4bGtMYi96?=
 =?utf-8?B?NkhmaWNzVFp2dHhQSEdNQ3JFNDhhd0x3UHg1cXVUVEovOWI3SXg0MWd5UW1W?=
 =?utf-8?B?YzNYR2FHbmQ0VmlWUG5lR0U4b0dxMUJwenBSeVR6SUkwWlIwM1o2T1NIeDB1?=
 =?utf-8?B?b2tIK1BBeVdYUlJ1OW9VVGxrRFVFcTMwSnljQ0loWXRpczVmWjBZalhDZjd1?=
 =?utf-8?B?aFJSL3ZYcllBNG9iazN5V3UzM3hqQjZwZ0lTMzl5b0YyeGNSNXJZVzArV1Ra?=
 =?utf-8?B?YVpGOFRETWtsS24xeG9zcjEvaVE2Q04ydUgreVZsdHc4Mldib2JKOFZ2ZXlr?=
 =?utf-8?B?amRwaTdva2NpRFBtNGFTUHVwSWozMzFHQ2UvNGh4ZFR4NStEbzRHMmpiSStZ?=
 =?utf-8?B?aEFweSs0c0tPemFocUxNVG9ndGZDVExsSEI3anEwMk5DdkE5bGgreXphcmhU?=
 =?utf-8?B?eFZmNDB1bjFCaXpVazI1WFNNdysybGo5TVVkVmhDRkZrMDNVWWdWT1JTc0ll?=
 =?utf-8?B?WEptcko5TUt1dHVKMFUrdGpGYjFsTFFydmRXWHl3MUN6SG1QU2xHWnV3S2hv?=
 =?utf-8?B?QTd1bjVkbEVPZm4xRkV4RnRSMHFiZTh0RzMxcjFIRUtuZmpwRUgxVEFhaGN5?=
 =?utf-8?B?WmlKeDZxZDVXb1R5aFZ1MDAwMFg3aUoyNFNON3RTcTRRL0JTamc4YnRtMi94?=
 =?utf-8?B?ZEtJc0dmd1JKSXJhQ1NOeldhNmFITFJtWDdzSWNKeVVMdDEyNTRGUUk3KytP?=
 =?utf-8?B?RmtYTFVlVEVHck9DNXNicTVmamdhWWlaamU4dFI2QXdTQm1GSHM4S3dLdDlo?=
 =?utf-8?B?blBBaWV1alVielNpVmVWUy9zZnZiRy9NT285QjdFcmJQODN6ZGhORjZHUFhH?=
 =?utf-8?B?N3JNdXpheWNFa1pSVUFJa2xBWjBrYXRRdXhBQ25Jc2dFYk96d09Ob294eXlB?=
 =?utf-8?B?Z3RDMXl3UUd3WmlxQzlpSlg3UHBQY1Z2UWxsZXZRZ2oybitRbUp5Uy9iTDBw?=
 =?utf-8?B?SlBYK3YyK1dNVktvbXFzbGxmQXJDMzJYenh1RmtWZ1NlVDlYRVRtdlQ5SzNU?=
 =?utf-8?B?dmxyNFlKd3pYekl0V0RQeVIrSEJxSlpRY3BkTWRoWWlMOWVaWWZLbGFDcUNv?=
 =?utf-8?B?eG9adGhyeVUzd2dtcmN6ME50RERMMXpBaGoyV2ZUZURHZnpzSHpMd05Bbko5?=
 =?utf-8?B?cXBqREJJdHNrYnY4Y1prZy9ZZGFoSWIvK3BpQUNiR1ZXWXpWU3FOZVgycjY3?=
 =?utf-8?B?d1dNUmdFUElpRk5paU4vZ0RGNGdaaEc3alhtcE56bFNzM1JwM0orNVBrVC9L?=
 =?utf-8?B?U0dzejVJRGVDaE5ma2taSlJHQ1VHZGV3cU91cExzZmViOS93REl5WHlRd0JP?=
 =?utf-8?B?aFZ5bWw4MmlCZ2lDOTBVNEl0RnVyMnV0WmVRcTZydWN1RHUrSjVZQkVYYXow?=
 =?utf-8?B?YVhqWGVHclBqQWdscklYM3Fnbk41OVdCN2o4V00xMUJGMHlqMUxML3pRVmFU?=
 =?utf-8?B?VHQyM2YxUXFua015ZDd4N2NEaHlxcXZrKy9RVjZKLzF0a212WnFIbFlwWW9D?=
 =?utf-8?B?RWRqcVY4anY0V29TdCt0ZnJzTXEzR25VMDhKaUdIdTVUZFNTU2R4cnBKdXBE?=
 =?utf-8?B?OVBqc0JpNTRnZlFpZXFJSnFvTGlZRVRIaDdmU0EydEREUDE5WjFBLzhnTmpE?=
 =?utf-8?B?N3BscjkxSElYRXFwVzlxVXN6ejZCdWV6Ynl3UUpvdDZUektPWXJRZCtaVytM?=
 =?utf-8?B?cEhtYVRyVzhrSFAvbUdpcWh6aVJ4KzhoQjZEeFhVWUYyUGtQMitUVklPa29z?=
 =?utf-8?B?M0dFRkJYYkRCRDQyTjhlWUEvSWtlNDdrd1JpMi9GWmVZK3gxUlMvYWgyTFZQ?=
 =?utf-8?B?b1BNNUM0TUF6OFBPWjlvK2dXcnNNdExoMzlITlY0dVdTZzU3dG1vVkkwQ1BH?=
 =?utf-8?Q?urcSDGppAgLiWUOO4G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce30b24-3989-4f97-dd97-08dea201bc20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 13:02:27.0103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiMweKr9cpXYvb/biNMa8IUfsbQdGYB7pDFaw73/2lbaAXrtNIwbJByhrHinpGa+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
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

Hi Prike,

On 4/24/26 10:01, Liang, Prike wrote:
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, April 23, 2026 6:48 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
>>
>> Hi guys,
>>
>> On 4/23/26 11:58, Liang, Prike wrote:
>> ...
>>>> -static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence
>>>> **userq_fence)
>>>> +static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>>>> +                                 struct amdgpu_userq_fence **pfence)
>>>>  {
>>>> -     *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>>>> -     return *userq_fence ? 0 : -ENOMEM;
>>>> +     struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>>>> +     struct amdgpu_userq_fence *userq_fence;
>>>> +     unsigned long count;
>>> We must initialize count; otherwise, it may contain a garbage value,
>>> which can cause amdgpu_userq_fence_alloc() to fail and, in turn, make userq
>> fence emission fail.
>>
>> I've got the same comment from both Sunil and Prike but as far as I can see  and
>> that is actually incorrect.
> This patch breaks the userq fence emit path, causing desktop boot to fail. Initializing count only works around the amdgpu_userq_fence_alloc() failure, and it doesn't address the root cause, which is that xa_find() cannot initialize count when fence_drv_xa itself hasn't been set up yet. Instead of just initializing count, we may need to check the return value of xa_find(), and if no wait fences are pending, skip retrieving the wait fence array entirely.

Yeah Sunil and I figured out what was wrong here.

I was looking at the xas_find() function and thought that xa_find() would be just a wrapper around that.

But that doesn't work like that. So I not only need to initialize count, but use the xas_fine function directly.

Thanks for pointing that out,
Christian.

> 
>>>
>>>> +     userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
>>>> +     if (!userq_fence)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     /*
>>>> +      * Get the next unused entry, since we fill from the start this can be
>>>> +      * used as size to allocate the array.
>>>> +      */
>>>> +     mutex_lock(&userq->fence_drv_lock);
>>>> +     xa_find(&userq->fence_drv_xa, &count, ULONG_MAX, XA_FREE_MARK);
>>
>> The count should be initialized here. But could be that this doesn't work.
>>
>> Did you guys got a KASAN warning or something like that?
> I didn't see the KASAN warning. However, the underlying problem is that when fence_drv_xa hasn't been set up, count remains uninitialized (garbage), which eventually causes kvmalloc_array() to fail when allocating fence_drv_array.
> 
>>>> +
>>>> +     userq_fence->fence_drv_array = kvmalloc_array(count, sizeof(fence_drv),
>>>> +                                                   GFP_KERNEL);
>>>> +     if (!userq_fence->fence_drv_array) {
>>>> +             mutex_unlock(&userq->fence_drv_lock);
>>>> +             kfree(userq_fence);
>>>> +             return -ENOMEM;
>>>> +     }
>>>> +
>>>> +     userq_fence->fence_drv_array_count = count;
>>>> +     xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>>>> +                0, ULONG_MAX, count, XA_PRESENT);
>>> We may need to assign the userq_fence->fence_drv_array_count the exact copied
>> number from the xa_extract().
>>
>> Interresting point. Why could that differ ?
> Generally, xa_extract() should return the same number as count, but when there's a retry entry, the actual number of copied entries may differ from the wait fence array capacity indicated by count.
> 
>> Thanks for the comments,
>> Christian.

