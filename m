Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60EBC46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 09:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4425F10E3BC;
	Tue,  3 Jan 2023 09:23:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF0A10E3CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 09:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g38IlEbH/zuqNqDI9xEBBGDNXmaEFjFRABvDDFPcK0ByLDrJxA0YCTTSyYqF76Z7FFWQ+eh/Nq260h6ubM6pGZhcPnfslIv2D2yFccP1ZNSrmEMuo++Bk7rWV+2WqRiRStl+g9fcVyFFhz6UAiNtQx1yYXNGcYVhHibNUolyU5tzeHR1bh+HlX0GXOF1wdtWja0vxtSEehd7SofZOaMJ9x0nHZM9EFOjpZmHcXFd35PA3H6bDUBkpzemLdyG6FHSGMDPnUGy6YBivRaDDoKXX0EBm7rzjpnU9IQSqYLZrJYQUV0vuxmSK9J4fEH5ziIy+Q3ZlBz0fWGOSTBhyceGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9z9IxGb/RRbzt6V0fmN7tUjix04oUHNuRsqj2Gto5Q=;
 b=d38HDQ67AZ2h0UiiQRKTVwNKkNan+xnWAsmYl1hLpH/WMIaqITuHLkwB/lUxf+ulrBselcrl9xyrlPicuOpTbKALYALDhbL7/d3gL25HixxxClesYwg2do3XzL+x0WccPtyLQyxnpn0uc8H8ipjkVGKiVOg8E9ggHDK3SB8kXABG3yzYAYhIeifFnJKgrM3MuaGXHjJWcu526NAezIoaVTlQA/Y2Keprj4K3D3YXzXeu3E+kF4JOzobyga/9JiRmDmOtaHctlWJvshAdqE1Qs147BK/kZ+pcpxAEhS4BqLyFQGQDKILUoMdceUdw52xYwqQ5oLDWOIH8eJLUP9ST1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9z9IxGb/RRbzt6V0fmN7tUjix04oUHNuRsqj2Gto5Q=;
 b=yu4dQb3DWW+svy9JAdmunXOOT/ryYX6p7v8PrjsjqqKV8pDL1E7ba3h1cpy/ZaLMzAxUwn6ODfmRH38D7hXWJXkY3S6lIK/gSt5K3M5DRnGZ3yNApWAq5lNc6suxOUaovL3nVH5aUo+3wnZrfN5Fdn6wz2bkIyHN4JlzQVHtB1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 09:23:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:23:10 +0000
Message-ID: <92805757-f4f2-b7f5-7378-fecd05db6492@amd.com>
Date: Tue, 3 Jan 2023 10:22:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
 <fedb614a-6fcb-e2ff-0d79-1c15f18b92d1@gmail.com>
 <569ecf0d-59b5-b209-ccf0-2d3f648c9bf3@amd.com>
 <d859657f-05f3-5362-be99-b8b792c969a2@gmail.com>
 <a39eab00-ac3f-a217-6ba7-de31680fc4af@amd.com>
 <857effc7-9a67-02ce-f9e3-ae96053b1100@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <857effc7-9a67-02ce-f9e3-ae96053b1100@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c9043f-1c91-490f-52a5-08daed6c213c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vz5K+4u8QXX2WHwBxwZAvPJvHdY1OMBNh9TJ6tKZ2koxX3KADBM+hxPgc8iltw/RE6TMclVByE2BzGoWDrsaPw1vMFauegFOdAdaOjLvyqpzNHh9x5cr1dVYJPT36RVCXpANK+qaFFdwNmF/exWm6wBJc993BlP0Ounn2hHobsqXGQQ1cW3paOTWyLQbi+G+mecS2jopzxnkbGz/53qmr6J4uA/uOYEwDCGKSI/uevcYqnTPOhvsAvQxJBWqEnT8/DRQpH/2wgg+W5TzME1hkmi5keC7NZWcLFPAHw66D6dJi2mz1VSoOQK3R4ogR9C1oJObHX+51K1JV/B0UOhFrGCcE4XGAVS33dBruFM9pdvVRPkklcEirgpLLDppuj0n5yQyOndTDxV09tpSTlOv4MyGUi3BSIXFy3RqJriyw5t0GPfYqyN4GiUb79JXgv31GjONn63ywOZtlm4/8WCPtzFfaZlIqyGlGzWpX5NVRoSCgOxbVvw7+bPnLW1dwRffKqE5xJZmXbFWtPlArjAQ+E8PiuxxubYKXCd8gHGF6vzaURB6PcRrzDVmAOLg1GJ6DoUdM7y/mwwxa2jSoq2sceGU/RKCytEfJ5ONDGCiNwrNgeKCVtQvO5VnZVphdA55S3NTtKXCHjdkSeuIzWroAH7zReH7NYJYhTRP7ihYBa0qejuOhtx53xKx0wmj0gzSLPvw+GtVBlIIL7DSjf+AKF69Q+uIKdkdUb+Pq09q2eCJwjciBjgKHzQWp7QRTrPr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6506007)(83380400001)(316002)(44832011)(2616005)(31696002)(186003)(6512007)(26005)(36756003)(6666004)(478600001)(66574015)(66899015)(2906002)(54906003)(53546011)(6486002)(30864003)(38100700002)(66476007)(41300700001)(31686004)(66946007)(4326008)(66556008)(8676002)(5660300002)(86362001)(8936002)(22166006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZKb2piSGhpNXdTYy9ZRndyR1hqZWY2NGFYQWxoLzd2WUZGdkRVT3huMjA4?=
 =?utf-8?B?RFlHOTRoNmg5YytHaUo4N1JIcFZOVm9hUXU4U25ib1g2d0FURVNqMTZScU5y?=
 =?utf-8?B?cThGbHc0dEc0ZVIxZkVTZDhic25jYkZ6SUF6K2o2TEYvK3MxRUtLdW1BTUlk?=
 =?utf-8?B?aUh3MGhoa0lvUElZQzdkZ2hMVjhNbWZwZGhHNk43b1BYYmMwN1Y3VjJEUVhn?=
 =?utf-8?B?VXVZQnhSZnhFbVUycFErN0E4c1B2aFM5Z05kSnJxYlFzZWVFREFNZjYrb01E?=
 =?utf-8?B?TUFWNWpjUGVLU1NxZFpzQ3BESWFPRklEam9aalNEbklvRVhsUGZUS1Joc09N?=
 =?utf-8?B?UFQ1UGVRU08wQ0NJM0ZnL05Fcm9seHhUeFdMK0FIYXg5SW5XQ3g1M1E2Ylht?=
 =?utf-8?B?emxDbzhCdnZySU00QkxXRCtYckY1bHZla1ZKT3drTzdjTFlzSm44aFFqallm?=
 =?utf-8?B?U0x3d3ExRFFIK3NydTlRaFQvcGdhMVZmbktNOTl6alpoaDBMRHdNeWFzWW1H?=
 =?utf-8?B?Y1R5NHB3UUFwRzFJZmszVFJqeGxXcFQ5TzdVa0o4N0VJb1gwNXk4WTVoVjQ1?=
 =?utf-8?B?Wi9XeDdKWDBUZ3JnblZHTXh3cHkwY3hOOW1TS3VrV0RVYzcwYjdGK1VXQkhz?=
 =?utf-8?B?VlhQeks4UFdGaDhPdy92MlRJQThxbDNNeVFFL3ZwNmh6d2dPdzZESWl0WUto?=
 =?utf-8?B?azBXaHQ2MFdtK3BwVVN0cFoxb0tLckdUdS9XR0g3NDh0QW05MDhvQ29wakNt?=
 =?utf-8?B?dlMvSERQY1piaEdXZWZubk5iMUZjM0x5SUcyMXFjanhKZ0lQVkRmeE9ydnFL?=
 =?utf-8?B?MnpncDR1QjJuYXpsREtJRlVlOFh3clB0UTBpVjdWYUhvSFZsMG5pSGlodVRS?=
 =?utf-8?B?MWZvYTFqTTVwMzRKQVhPNjBmT1dhQVVKNjVONyt1ZzgxUUVWcEJHQkxibkFm?=
 =?utf-8?B?bHdQYmFnamhlQzlIZUZQSFZxZW9ncElMMmQ1ZlltWVkrR1E0U00xc3FJM2U5?=
 =?utf-8?B?ZXFEYzlKTXB3NjR2Qk8yajZrMHhBNnh2ei9LRlZiNStTL3Y0UFVRcFA4WGZH?=
 =?utf-8?B?ZC95TVpGTk5Hc0pxd25jd0hSNUFCaVpYZEJ0U2MrYVEyNWdGRDBZb0FHMUtw?=
 =?utf-8?B?Z1g3M3VydnozTkJ0S3JKbDg0ZTNNaDZpZVhMVWgvdnlCZ1IrMVNRRjNuRTFx?=
 =?utf-8?B?UGlZNGcwL2RoeHFTaWJmNmRrcGNTWnFyRWxDcVUraWZ3bElwQlM5TDQxVUdZ?=
 =?utf-8?B?N3ZzODU1M0Ftd3dIZkYxZE5tZmdhK05qbFdudHJJWXhZQXduWHNLK2Z1MUM1?=
 =?utf-8?B?OFRLSVIzdGJCRnBVRTBDYnVXcXN5MWtmVzNLMXQra0t6MHdKUDhBeFg4U1lH?=
 =?utf-8?B?R0xrZUtHVis3NzVHaXMxVWxZNllRRlNXUVNOYXYrTml1Q0RqQlhVUkI0UnpH?=
 =?utf-8?B?Wk45dFljYWVNblhZdTJJbnpIRDBvMDRROFh6T2RZR1U1Z1VHUEFhbXY3MVl1?=
 =?utf-8?B?MWxkUUVURVNTdklyRmZ5MFgxdGp4dEVmQmsrNVRYRkdhRE5oakY0VDA0UTRy?=
 =?utf-8?B?WGExdTZXYU1leGdVcWg3S3BldVIybklGbHk0Q2t1QzUrMVNBeDdVbUFJL2gx?=
 =?utf-8?B?RDJ5QjRkMGs2bENqWS93UWQ1ZTZzSFhmblgvZWRrMGlibzZ2WkhsNXhPOFVB?=
 =?utf-8?B?UnZnb2xzS0d2NUFpanlnKzdOWlgwckt0eGc2aHlDcklEeDcwSlpZOERVYjB0?=
 =?utf-8?B?eFZvZWdyTlozR1hIZ2JtNUVzMUVsM1hNcnRuaDBoc0VVOXU5bGdGYStweGRE?=
 =?utf-8?B?SDNxRGl2RUJDM2FNbmVIQ0lEMXlKRC9JNmkzckxuZFJFOUQ1ZW5EWjYrT2Fo?=
 =?utf-8?B?d0FMY2d1NzlzNWJLTDN2VndVeXBYVVFCMHVNZHJLcUxOOUZGdU94c20weWwy?=
 =?utf-8?B?eWJEd0xyazJjcnlqZElSRXk4Wk44Rk5YY2I4aitSbEx2WUZpL1dreFhJcFZM?=
 =?utf-8?B?OWJFWDJ4dDJzY05mNmloc2pGV2VNYnlNZ3FpUlRyNWFyUVlIZXdibmVBTW5w?=
 =?utf-8?B?UERBQ1BFZDdKUnlWRGhvaW44Y1hGNitlVHMvMTR6Q3pybnBpbFJzeUNDUFF0?=
 =?utf-8?Q?MAlMxZxUmxCXpGngZrHt8C0JQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c9043f-1c91-490f-52a5-08daed6c213c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:23:09.9323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwQEZQGiEoWEjisr1okO5py7en7LxTFprmhB2Dr2d4PqXZwq7w/gC+HH90VMy3zIlTw3uNRZtIegsgupP0ZIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 03/01/2023 10:15, Christian König wrote:
> Am 03.01.23 um 10:12 schrieb Shashank Sharma:
>>
>> On 02/01/2023 13:39, Christian König wrote:
>>> Hi Shashank,
>>>
>>> Am 26.12.22 um 11:41 schrieb Shashank Sharma:
>>>> [SNIP]
>>>>>>         /* df */
>>>>>>       struct amdgpu_df                df;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>>> index 0fa0e56daf67..f7413859b14f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>>>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>>>>>       unsigned long            ras_counter_ce;
>>>>>>       unsigned long            ras_counter_ue;
>>>>>>       uint32_t            stable_pstate;
>>>>>> +    struct amdgpu_usermode_queue    *userq;
>>>>>
>>>>> Why should we have this in the ctx here???
>>>>
>>>> We are allocating a few things dynamically for the queue, which 
>>>> would be valid until we destroy this queue. Also we need to save 
>>>> this queue
>>>>
>>>> container at some place for the destroy function,  and I thought it 
>>>> would make sense to keep this with the context ptr, as this is how 
>>>> we are
>>>>
>>>> identifying the incoming request.
>>>
>>> I have absolutely no idea how you end up with that design.
>>>
>>> The ctx object is the CS IOCTL context, that is not even remotely 
>>> related to anything the user queues should be doing.
>>>
>>> Please completely drop that relationship and don't use any of the 
>>> ctx object stuff in the user queue code.
>>>
>> Historically the workload submission always came with a context (due 
>> to CS IOCTL), so we thought it would make sense to still have its 
>> relevance in the new workload submission method. Would you prefer 
>> this new submission to be independent of AMDGPU context ?
>
> Well not prefer, the point is that this doesn't make any sense at all.
>
> See the amdgpu_ctx object contains the resulting fence pointers for 
> the CS IOCTL as well as information necessary for the CS IOCTL to work 
> (e.g. scheduler entities etc...).
>
> I don't see how anything from that stuff would be useful for the MES 
> or user queues.
>
> Christian.


I am getting your point, and it makes sense as well. But in such 
scenario, we might have to create something parallel to AMDGPU_USERQ_CTX 
which is doing very much the same.

We can still do it to make a logically separate entity, but any 
suggestions on where to keep this udev_ctx ptr (if not in adev, as well 
as not ctx) ?

- Shashank


>
>>
>> - Shashank
>>
>>
>>> Christian.
>>>
>>>>
>>>> - Shashank
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>   };
>>>>>>     struct amdgpu_ctx_mgr {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..3b6e8f75495c
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>> @@ -0,0 +1,187 @@
>>>>>> +/*
>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>> + *
>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>> obtaining a
>>>>>> + * copy of this software and associated documentation files (the 
>>>>>> "Software"),
>>>>>> + * to deal in the Software without restriction, including 
>>>>>> without limitation
>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>> sublicense,
>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>> whom the
>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>> conditions:
>>>>>> + *
>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>> be included in
>>>>>> + * all copies or substantial portions of the Software.
>>>>>> + *
>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>> KIND, EXPRESS OR
>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>> MERCHANTABILITY,
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>>> EVENT SHALL
>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>>> DAMAGES OR
>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>> OTHERWISE,
>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>> THE USE OR
>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#include "amdgpu.h"
>>>>>> +#include "amdgpu_vm.h"
>>>>>> +#include "amdgpu_mes.h"
>>>>>> +#include "amdgpu_usermode_queue.h"
>>>>>> +#include "soc15_common.h"
>>>>>> +
>>>>>> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a, 
>>>>>> sizeof(__u64)))
>>>>>> +
>>>>>> +static int
>>>>>> +amdgpu_userqueue_index(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +    int index;
>>>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>>>> +
>>>>>> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, 
>>>>>> GFP_KERNEL);
>>>>>> +    return index;
>>>>>> +}
>>>>>> +
>>>>>> +static void
>>>>>> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct 
>>>>>> amdgpu_usermode_queue *queue)
>>>>>> +{
>>>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>>>> +
>>>>>> +    ida_simple_remove(&uqg->ida, queue->queue_id);
>>>>>> +}
>>>>>> +
>>>>>> +static int
>>>>>> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev, 
>>>>>> struct drm_amdgpu_userq_mqd *mqd_in)
>>>>>> +{
>>>>>> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || 
>>>>>> mqd_in->doorbell_offset == 0) {
>>>>>> +        DRM_ERROR("Invalid queue object address\n");
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || 
>>>>>> mqd_in->wptr_va == 0) {
>>>>>> +        DRM_ERROR("Invalid queue object value\n");
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= 
>>>>>> AMDGPU_HW_IP_NUM) {
>>>>>> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!CHECK_ACCESS(mqd_in->queue_va) || 
>>>>>> !CHECK_ACCESS(mqd_in->rptr_va) ||
>>>>>> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
>>>>>> +            DRM_ERROR("Invalid mapping of queue ptrs, access 
>>>>>> error\n");
>>>>>> +            return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    DRM_DEBUG_DRIVER("Input parameters to create queue are 
>>>>>> valid\n");
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct 
>>>>>> drm_file *filp,
>>>>>> +                            union drm_amdgpu_userq *args)
>>>>>> +{
>>>>>> +    int r, pasid;
>>>>>> +    struct amdgpu_usermode_queue *queue;
>>>>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, 
>>>>>> args->in.ctx_id);
>>>>>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>>>>>> +
>>>>>> +    if (!ctx) {
>>>>>> +        DRM_ERROR("Invalid GPU context\n");
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (vm->pasid < 0) {
>>>>>> +        DRM_WARN("No PASID info found\n");
>>>>>> +        pasid = 0;
>>>>>> +    }
>>>>>> +
>>>>>> +    mutex_lock(&adev->userq.userq_mutex);
>>>>>> +
>>>>>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), 
>>>>>> GFP_KERNEL);
>>>>>> +    if (!queue) {
>>>>>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>>>>>> +        mutex_unlock(&adev->userq.userq_mutex);
>>>>>> +        return -ENOMEM;
>>>>>> +    }
>>>>>> +
>>>>>> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
>>>>>> +    if (r < 0) {
>>>>>> +        DRM_ERROR("Invalid input to create queue\n");
>>>>>> +        goto free_queue;
>>>>>> +    }
>>>>>> +
>>>>>> +    queue->vm = vm;
>>>>>> +    queue->pasid = pasid;
>>>>>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>>>>>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>>>>>> +    queue->queue_size = mqd_in->queue_size;
>>>>>> +    queue->queue_type = mqd_in->ip_type;
>>>>>> +    queue->paging = false;
>>>>>> +    queue->flags = mqd_in->flags;
>>>>>> +    queue->queue_id = amdgpu_userqueue_index(adev);
>>>>>> +
>>>>>> +    ctx->userq = queue;
>>>>>> +    args->out.q_id = queue->queue_id;
>>>>>> +    args->out.flags = 0;
>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>>>> +    return 0;
>>>>>> +
>>>>>> +free_queue:
>>>>>> +    amdgpu_userqueue_remove_index(adev, queue);
>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>>>> +    kfree(queue);
>>>>>> +    return r;
>>>>>> +}
>>>>>> +
>>>>>> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct 
>>>>>> drm_file *filp,
>>>>>> +                              union drm_amdgpu_userq *args)
>>>>>> +{
>>>>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>>>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, 
>>>>>> args->in.ctx_id);
>>>>>> +    struct amdgpu_usermode_queue *queue = ctx->userq;
>>>>>> +
>>>>>> +    mutex_lock(&adev->userq.userq_mutex);
>>>>>> +    amdgpu_userqueue_remove_index(adev, queue);
>>>>>> +    ctx->userq = NULL;
>>>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>>>> +    kfree(queue);
>>>>>> +}
>>>>>> +
>>>>>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>>> +               struct drm_file *filp)
>>>>>> +{
>>>>>> +    union drm_amdgpu_userq *args = data;
>>>>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>> +    int r = 0;
>>>>>> +
>>>>>> +    switch (args->in.op) {
>>>>>> +    case AMDGPU_USERQ_OP_CREATE:
>>>>>> +        r = amdgpu_userqueue_create(adev, filp, args);
>>>>>> +        if (r)
>>>>>> +            DRM_ERROR("Failed to create usermode queue\n");
>>>>>> +        break;
>>>>>> +
>>>>>> +    case AMDGPU_USERQ_OP_FREE:
>>>>>> +        amdgpu_userqueue_destroy(adev, filp, args);
>>>>>> +        break;
>>>>>> +
>>>>>> +    default:
>>>>>> +        DRM_ERROR("Invalid user queue op specified: %d\n", 
>>>>>> args->in.op);
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    return r;
>>>>>> +}
>>>>>> +
>>>>>> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>>>> +
>>>>>> +    mutex_init(&uqg->userq_mutex);
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +
>>>>>> +}
>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h 
>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..c1fe39ffaf72
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>>>> @@ -0,0 +1,50 @@
>>>>>> +/*
>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>> + *
>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>> obtaining a
>>>>>> + * copy of this software and associated documentation files (the 
>>>>>> "Software"),
>>>>>> + * to deal in the Software without restriction, including 
>>>>>> without limitation
>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>> sublicense,
>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>> whom the
>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>> conditions:
>>>>>> + *
>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>> be included in
>>>>>> + * all copies or substantial portions of the Software.
>>>>>> + *
>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>> KIND, EXPRESS OR
>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>> MERCHANTABILITY,
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>>> EVENT SHALL
>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>>> DAMAGES OR
>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>> OTHERWISE,
>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>> THE USE OR
>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef AMDGPU_USERMODE_QUEUE_H_
>>>>>> +#define AMDGPU_USERMODE_QUEUE_H_
>>>>>> +
>>>>>> +#define AMDGPU_MAX_USERQ 512
>>>>>> +
>>>>>> +struct amdgpu_usermode_queue {
>>>>>> +    int        queue_id;
>>>>>> +    int        queue_type;
>>>>>> +    int        queue_size;
>>>>>> +    int        paging;
>>>>>> +    int        pasid;
>>>>>> +    int        use_doorbell;
>>>>>> +    int        doorbell_index;
>>>>>> +
>>>>>> +    uint64_t    mqd_gpu_addr;
>>>>>> +    uint64_t    wptr_gpu_addr;
>>>>>> +    uint64_t    rptr_gpu_addr;
>>>>>> +    uint64_t    queue_gpu_addr;
>>>>>> +    uint64_t    flags;
>>>>>> +    void         *mqd_cpu_ptr;
>>>>>> +
>>>>>> +    struct amdgpu_bo    *mqd_obj;
>>>>>> +    struct amdgpu_vm        *vm;
>>>>>> +    struct list_head     list;
>>>>>> +};
>>>>>> +
>>>>>> +#endif
>>>>>
>>>
>
