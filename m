Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9089CF99362
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 10:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3644110F092;
	Thu, 23 Apr 2026 10:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28op2TB5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EFA10F092
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 10:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtSR9wwZ+B0lr2pQZMjCdy0wbycu7qBu+U3uvIXlyAemzO3pHIr8GKor8yTgMe+HCZACQeim5L1Yn3A+o1GDwmnAjqy4OiO4NMybsy38MXB/H1SfUNFvnHeD13cOt/MyZmn+nGASuUJf4JofVgb5hkV2sR0jrI0PtYchmjxGIEkfDZJ7n8xOzwQhFuqu60tOvDyU3eh5RA1XWgiUkdKcnHxZ6liQKjRSFDqwsSTlmwt01+wpLctEsYivZmFwTqUd+SB6fX4ovcla2hkgJ++m4wmFDS1LJuTmhjgSRu631L6bs0GdiuhzYWsnoz7PwnnlLVgtM6oslqJSfqxp4ISu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgOoYGvKVocfRk36mk2AM+Ku+0n9Q5OZ4ujZ1yY98vU=;
 b=qLXNvOeQDCzhXx1sNmcxvi8ecV+oNKybb3xEswLAqY8w8d0MKSdjRrY3acLvJ0gpsFs0lEMA4A0uGRS33W3zIZ+E3awxfaZLTyrZSbvVxuk/2RZLmNJuFwdi/suyyKVtt/Quz3gyf/lAhrgXtKAbuugiyYzZ8toY9j7r6mo55RLzTghh2rXN4tkCcj08IacUgLY6itCN+p2vxeZfdJhc9oik6fl6Vz2PpFZVIFCNVfD+aOs0l0Z92QD873y4+Non3rCrcRGpvcgg0TGmlSuySS9wSvqvWNjZi0948FfffdMDa4CH+2oQLwVoC2m6Ai5KTlsUiW1Ie1nj2itnKeUEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgOoYGvKVocfRk36mk2AM+Ku+0n9Q5OZ4ujZ1yY98vU=;
 b=28op2TB562SM2jSpc3FzizGOaBBb6BGVPp5I56L4CDQIUrc/sfvhHNqNxTPOw/XNVHm6bJjlK07Dg0mJCU03IRCiJhLNAChG7yyuioZfXqM6t7IuPEiQ0QnY5Ga8zTZCBV+qgfuJgqj06YvRTVBRVoJtdCGUl9thKzGImqfUIbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 23 Apr
 2026 10:54:28 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Thu, 23 Apr 2026
 10:54:28 +0000
Message-ID: <001c1f8d-bacf-4519-927d-acfc9de6d059@amd.com>
Date: Thu, 23 Apr 2026 16:24:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-4-christian.koenig@amd.com>
 <DS7PR12MB60051B45E53E61949D874CDDFB2A2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <03e6c28c-5c16-4e5d-8c26-a214f0aef012@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <03e6c28c-5c16-4e5d-8c26-a214f0aef012@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b3e1a1-b465-4cf2-15bb-08dea126b0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: shl9xz/B1fsmm/BL8t3UMtI+SM/4vQFN8+nMztT58mxgUlcyPSFchFfFFpz9nNB7x+6EYTtOevSltou3Vkc5dTZxWLZH3WPEydMhXJ6WIpSBZP0AdDKftvIEJXfij8Z7maoeyKQtHEVls7MJOqk+QuoYdUHZ23PBXdTx5pUyFap7xw3QKgDgekdMSE942EMq3YNg+fiSybUUGLm62keim54EhFTPZP4lDhIOH2c7LbDH8vTwt1KJQELduy7u9lh9vhevt1zaIe48M0iDbm8wQ+kR98EHRuJuOZaYEuSw2Rf2A8OoIxMP+aXnTetmDa5xnYzix8fCtR+2rqR8QQBmzOAnNPGqFwwdYtJoeVxx1pOU80BbebWn2VIBCMfCIGh2plynnXRkQhkmXA2llM+48QB3lN2lee93uJcde53Z8ARJsQ4Tzv0yR75vXzKzwPMXCHE+ZpQxQeiKBhGUJZTBObqppV4QYYlATnfZNbHk9dky3AI/61gf5jF6yEeZuP6cVgpKQeeenckkbrcBhEZONUr8YVJR7TFwnd/XkFEuN9t2JHZl3SohdVpCeHErftvYnpmHlNd11/5WpsSmWHvtffW9AWK7nRsjwdDIufOi1rUzBfOc/Wf+l6rf2AFR7kg2d4pvCN93t5E1wmbPABkDzvMcnOJfHCWvuGNTh6rV7yOZl0hMZnoHXuRAlodsvkABESVkwfQWA+F3NLypwkSw/jwCKAbIZr9wpUu4yyVm0pc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5OU3BSTlU2Y044Sjh2RGpsTzBYTVA2cnk3ckVtdFM0MmlmRTRXWkx2TVJE?=
 =?utf-8?B?ZndUZndBaTNBQ08vU3lNbkRXcDFPNXllL3lwaStXMm9NeVNHSENpVStyY1E5?=
 =?utf-8?B?eWR3M2ErQWM1MXNBRGVCUHZiM0pYVUNzREljclp0SGNlc3FvNTV4ZW9uSnFC?=
 =?utf-8?B?V0g1bzFsS3RNQmpoMWUyOFIzWjR0S1ZzMEQzUUI0WDlDTWp0Q0Q1WVlBOUdY?=
 =?utf-8?B?eEg1b3Z2ZXNjYThIZUNyS0lRVnhoZlM3dzF3M1VIZ3hSL1IyZ0J5THpxTFpB?=
 =?utf-8?B?Tm11OG1xbEZ4cHZxTXVwSExIZmQ1b3d5RVdRUGdvRXUyRkhrcE9ITzFxekZM?=
 =?utf-8?B?aU12L0xJNUxtMHJxNXFIMUpLUVhpZk5BQ2ZWN0RrTFVFVGdJUDFkeXZtdHFu?=
 =?utf-8?B?QkhKN2NUWklOcDUzNHJ3S1ZNWXZ3T0JNVHRhWldtQVlHa2JQOG1GdW8zbTgv?=
 =?utf-8?B?VUxVUWNKLzEvNlFBYTQ1NzBVTGdzalUvTllsWkpFa2xBRFlpb3BWMzhTWG5O?=
 =?utf-8?B?YmtjQ2ZIT3g1NFhTWnZzNUpvUTVwUElSbGJTd0ZjK1V5cjljTnlwbjZOQnhk?=
 =?utf-8?B?UnpsOUltZGFKVVFlZVh1RFhMTk1ZL3A3c0g3Z0NCWjc5RlJYSFNHSjBNa3JU?=
 =?utf-8?B?ZkZxYXZXTWNlQUhCWEMzZ3c3QndDbDgvZGsrN1BuZGw2a3BlS3pCRHhjRmZX?=
 =?utf-8?B?TDlGY0dZQ1JYYzRvQUY1VnVVV1R6Mm1sMVpqUHZtQm9rdGtBQUU5WTRiUzAz?=
 =?utf-8?B?OGdKVUtTaDBMTDMwV3I5Ry82dmJoOGxXNlRORXVrbnRUeFJtTHc0R2RiazNL?=
 =?utf-8?B?bnlRaTZoSmNwT1hsZmhUOVp6Nldkc080QTNtQWI1ZjFRTjJEMnUweVY5Y3Z1?=
 =?utf-8?B?N0FVVmJ5bjUvNmE0eHIwWFpMdmJRdFJlZkUwdXBsUkR5NWpzdWRjUXpkYStB?=
 =?utf-8?B?Q1ZJV2YwUlFqSUk1MTFVOC9Oc1M5OVZSVG51ZlNmUHUwQjdCaUF4UVkzUitu?=
 =?utf-8?B?bk1sTVNjYVpqWXpsU0p0dEx3TStvbkJYTjVFTEEzQk1FZDJDazB0ZFNtOXJ6?=
 =?utf-8?B?VW5aandLd2NzbjVYeVdXWEF1TTJFUjhBck1WZVQ1bHJTOUJxWlJ4aTUrNjVa?=
 =?utf-8?B?eGR6QW13THA0QzJWa05VTDgweWNxRnU3RUZ2U0JTbklFMThTMXVobE8yd1F1?=
 =?utf-8?B?RVNDUE5SOVdXY21CYmZSVndRQXlPdW44dldSNDVUU2RvVDdrU3JhdzJqN0FR?=
 =?utf-8?B?UE9NWjNhaUJDZ0J0eG80S0RIUWRmQ1VvYndhS3VtUlp0Q2RJQi9xQkJ5NE9M?=
 =?utf-8?B?UEFXRll6bEw3ejJmNU9sTW0xQkQ3c2hVMWNwM1hUS3lNakdhZnNBZ05zZjZS?=
 =?utf-8?B?bUtVRjU2MEhaUUNsTFZTSWlhQWVPY2JWWmkwd3RJTElKSFVlakZMMXZRem45?=
 =?utf-8?B?VFkxRzlIZWt5STA4RStmVTM5cTNDb0p2ZWdEMVUvaDgvbVh2NE5wU1BuaUVU?=
 =?utf-8?B?aEdSQWFOOWdDMnB1QnRBeHJRUzVmNG84NVBWUGlzT3ZhZVlGejlaQ2NDYjVC?=
 =?utf-8?B?VEJ5cHp2Q0ZReEZIeHhraEVBRVpUN3FDeU9HOVhLN0VxYld1WExrckcydnNj?=
 =?utf-8?B?QkNZdzFTWmhCV0ZIUzArNm1FR1U0UnpPZkdES05JcitLOHUxNER0WVhtZGJj?=
 =?utf-8?B?MEUzRVJCNG41NWRQQi9vMzh5U2Jac0M2aUtzWFpDamx2dk8wNHBveHc5OHVm?=
 =?utf-8?B?OCtSVUMycWQyUTBLS0pUekgySW1oTGVGYlBWcjVaWTg2U3VCY3ZXNDFSRmNx?=
 =?utf-8?B?OG93c2VrVERBb010Y3kxcGM5dzc3SWt4UTBMYUNVQjJIWmorZkh1Vmw2M1NI?=
 =?utf-8?B?eWc3aVNsYmI3WVZkczB0YUo0T2FIUlI4UmZ1anBMTG1MbnZPS0JmNm1DMzJN?=
 =?utf-8?B?WEx0NnFodUI0Q0JtRXBzRWd2aHUxNHBuK3JLWlo0VEdQVlhNTmRvZk9HNWpE?=
 =?utf-8?B?UEpVU3daZ0ZHV1l4SU0wcU1RRGcwNjh2SVF2cEQ5WnVXU0xwd1dMTFVNWUJF?=
 =?utf-8?B?cExBc0tPZ3pYaTRzQUxRZWhUV1dMakRqcGNRSWlpSk0yaEFuRFVDRFQrRzhL?=
 =?utf-8?B?eDY4UWZ3MmcrS1NDQ2J1Mmxad2xQbkpSczRHSTMyM1k0dTgwc2RtRm5EZ09T?=
 =?utf-8?B?Wm5OQWZuazFsSVBFUkJ4Q1pBU1BqaFpya2JmOHQyR1pSUUtQRkw1NnVuN1Jl?=
 =?utf-8?B?eVFDRE9GMmJzSGlYNk9VUW1wbTlXb2NFYlh3SHpQTDRmTkdkK3JQYVNFSjNP?=
 =?utf-8?B?RTllQ2s2Qnd4Z01xR2VoOTNmRUZjT0JWL0lSZ2thVTlpSnNwUVkrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b3e1a1-b465-4cf2-15bb-08dea126b0be
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:54:28.2876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7isc10Nsu1Pxl5dIoquu7YF1RMK1wDfLzRs+zatUQK+yiJBon2HwQwZqAvj0ePomgmA9HyjoWfu6LWy5oYjCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B
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


On 23-04-2026 04:17 pm, Christian König wrote:
> Hi guys,
>
> On 4/23/26 11:58, Liang, Prike wrote:
> ...
>>> -static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>>> +static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>>> +                                 struct amdgpu_userq_fence **pfence)
>>>   {
>>> -     *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>>> -     return *userq_fence ? 0 : -ENOMEM;
>>> +     struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>>> +     struct amdgpu_userq_fence *userq_fence;
>>> +     unsigned long count;
>> We must initialize count; otherwise, it may contain a garbage value, which can cause amdgpu_userq_fence_alloc() to fail and,
>> in turn, make userq fence emission fail.
> I've got the same comment from both Sunil and Prike but as far as I can see  and that is actually incorrect.
>
>>> +     userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
>>> +     if (!userq_fence)
>>> +             return -ENOMEM;
>>> +
>>> +     /*
>>> +      * Get the next unused entry, since we fill from the start this can be
>>> +      * used as size to allocate the array.
>>> +      */
>>> +     mutex_lock(&userq->fence_drv_lock);
>>> +     xa_find(&userq->fence_drv_xa, &count, ULONG_MAX, XA_FREE_MARK);
> The count should be initialized here. But could be that this doesn't work.
>
> Did you guys got a KASAN warning or something like that?
I got application crash recieving -ENOMEM. The reason that count isnt 
initialized and as per information i gather xa_find need the starting 
index i.e pointed by count else it will start with whatever garbage 
value it have.

Regards
Sunil Khatri
>
>>> +
>>> +     userq_fence->fence_drv_array = kvmalloc_array(count, sizeof(fence_drv),
>>> +                                                   GFP_KERNEL);
>>> +     if (!userq_fence->fence_drv_array) {
>>> +             mutex_unlock(&userq->fence_drv_lock);
>>> +             kfree(userq_fence);
>>> +             return -ENOMEM;
>>> +     }
>>> +
>>> +     userq_fence->fence_drv_array_count = count;
>>> +     xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>>> +                0, ULONG_MAX, count, XA_PRESENT);
>> We may need to assign the userq_fence->fence_drv_array_count the exact copied number from the xa_extract().
> Interresting point. Why could that differ ?
>
> Thanks for the comments,
> Christian.
