Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565A3C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 09:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A305810E245;
	Tue,  3 Jan 2023 09:12:20 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3625A10E246
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 09:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bt+o4GQnyveEJPYZ16+oCwkleeLPuZ91Zszczi2vg3ycsnmKgC4unOAynn74lbCMs08RB1KFZdFzoFHdBrjLqctfYYABBbQUFh2MG7DZ2Y82vCVnh9vpV/uNcP/562BgjQKLldmE10TZbC2aP7+2oPjPY3tGoKygodvnK1CPklrVGA1zuNtquJ6OLl6UTQjJ2Qt46xeahqxQAV83XFs9Ft56qukN6HvLSYYFPt9OiixkXbdkS272kuQhXOHFZGz+xNiqEQ3Xja7nZ6ed1fqkP7UkrGb0DokWtPWzn4+9k6QNpK8f0yfwOhV8BESYWy8EfC8ch1l9+zPE81Ji6kfFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI3Oh/5BhS4CUP5vFUIVIAS8G0HwOOSY4sxDuSVD2yo=;
 b=c01gIay/8u8Du/VtwO4Ej53K+h3qjApFcRNCdTIUa71sxhu1S4U/WZQ/+p4RThhIn78QeGIGTSSxFPUxDOHEoE0BSU3Vvbbr/kqwEIxK+pdUem5QB13QlaZw1kUFhLINmfgk+QkVSYw//5Kg8zgJNF6hJTsDd4Bhq4I/zGhe2wSnhmstd8GryhEg3q1GA8yqURufVgYeXGSVfF2ZUXAhJnBQ1826BKkVDetT605fSwgMRTMlSCQUXIlZPVQUrqp+rA+Z/8+TsWK4sGZa3Qjrx06hmHjlJ9m0fPyzUX4ByhA6oOmBWompWf7dOSmJG0j7RWatHgnhVaw2vwy1qcrWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI3Oh/5BhS4CUP5vFUIVIAS8G0HwOOSY4sxDuSVD2yo=;
 b=2K/bfn1daZsXlVRqOiFZkV8jW6v5k3+yq8RcZKclIEZIiakiavoLq433OVdeZV9lM2MQLhN1rizcf/JrevrtuK0AQW9Djph6H7T3t2r/1AB6GO+gdiQ8hUcwMNdpBqeaiXo4+0CaZ2hsl1fD0hCDubRCGanxKitNMYEeJPToejw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 09:12:14 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:12:14 +0000
Message-ID: <a39eab00-ac3f-a217-6ba7-de31680fc4af@amd.com>
Date: Tue, 3 Jan 2023 10:12:01 +0100
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
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <d859657f-05f3-5362-be99-b8b792c969a2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 85002d79-573b-4d8f-cfdc-08daed6a9a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUJwZ8M/CzHZl1GEbKqp4GrP3t/F5BklKxZ6i+hWFngltaoC1HDmr1yL2uEiBhqam+d13XYK+MfQJiUUqg7xbi+CulBnjw0cMvNvdKrkAbx99YqLkRUUNJglwB7+sNk1rL0Sf+e17c+4dDU2Mi+rpz9cI5ZTpBNHeHjD5ZC2cQ89PLWzfKhYgmNe852eokru3QjYIJzBmR8MpaIGZ1dxiLgUb+JKu8VIRLH6OelxjgOuc4/C4FtbU4a90F6IJBR+rfvXFEc8v5kbpvQotY+etVCulE3+kkqnPwaf3tvOvo3OBTbwKW8+O37WM6vfusRvZpgn93D63g+P3dWsQ+C2XcqQTGAQVR5VYbZLapDq/dSIXj7be9/6x/Fun6En9eOMfV1EAWxL2RykzjyUtVWY0h5szaXrsYQgLMuWShxp0VGcq1plGFh2IQyxX6rjOpMis6V9bNaukSr/sg5ev0RiQlEZ5Q8MvQmt0ja2w8vwh8tjo2OdbJjPZIGwsPEdMxJ1tYaCVvmni386hlJw97nz1KPkUnYBBIEcMaPGEsAF2koiTModIByKHPVwtRU5O363ObKoEngm6awgOUZc8TGlaYHvUqxm1DeW8Ka2b/gMAuH2qwkCo7AzuB5tIJQN06qwtJhyF5zjZ37t2FqKpFQKFvZpkmWZ24VJko5QOuSoDZ9ITS1tQU/rZTRXpthVM2dqE3XPePlSx6ljEC3VfQ32mF8lPK4yT2kazwqkr31iBK1R+5rSevsB1cDDOksl7oN/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(6666004)(6512007)(26005)(186003)(66899015)(31686004)(2616005)(53546011)(6506007)(478600001)(6486002)(66946007)(8676002)(4326008)(66556008)(66574015)(8936002)(41300700001)(66476007)(30864003)(83380400001)(5660300002)(2906002)(44832011)(38100700002)(86362001)(31696002)(316002)(54906003)(36756003)(22166006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZQV1BvaXdRbU5BbjAxQWRDd1BDK3E5U1pRK09Tb0tMTUVjSHc4dm9DbVBS?=
 =?utf-8?B?KzdWQVg5blp4Q3JFMU5PNTYrOHVWUWdVUm1YMWhzWHRvUHdOUVBLTkVIQTF0?=
 =?utf-8?B?THdxblBwRTBUNXJzZUU3OTNPeExMbzVZQXZYNklyMnQxcjBGNlVXOXFjaXpC?=
 =?utf-8?B?ZWIycDVtZktzWTljbW5PQkVaRzFSSjZzTkhTQ2xZWHRTbDBKc0EyakNiZFVv?=
 =?utf-8?B?WFBlTWRHZk1hV2wvamNsU1NCY1c3ZkFJRm1RQzYvb0Z3bVpFcGJ2ZlArU0JC?=
 =?utf-8?B?My9MdkZGWXhTTUdDaHlMOG9WV1NFckp0KzBpRFVIblFDTEw2TkxETUZxRURI?=
 =?utf-8?B?ZWpXSVhNTU5iSnNXOVhIRnVtekNkTkVQV0J2dnZlRUVpS1lQN1AyVjU5WlBY?=
 =?utf-8?B?d29xQ2w0Tlp4T0kxak85Q2dVMWMrbG9vOXBYMnR1OUMrT3p3M0VWYjUzWW10?=
 =?utf-8?B?anpiSFBBN2JNMWFhdTl0S3FaejJFUUdUTTErSW50SXZoY0taYUFxQ3lUNTd2?=
 =?utf-8?B?Z0tpV0NmZFdKRDF1eWVBcXIvdGFRNE40K08wM212bGgycVZFQVl2MHV4bWg2?=
 =?utf-8?B?SDkvc25TYTBsK3JZR09KazdXT1M2eDMxWGxwd2RHV1dtdkcyZVVoUE51L0pr?=
 =?utf-8?B?ZmlKSE5QSHdkd0o0N2tUeEtYNFhjN0QvY3ExVFNJaWFHb1JrZFMzeFZWTFBy?=
 =?utf-8?B?ck5PbnV1Ymw4aW82ZEhNQzFhVFYvNVgrcGo5enZERThrL3NvSFkwRjRKMG81?=
 =?utf-8?B?Y1B0OER5ZUtvL1NlZm03WTNxYmlKdEtGTjc3Q0Q4VS9UZVltVGhiRnVWcGQ1?=
 =?utf-8?B?VVdYOXo4RnJlSnFKbkl5YlA4cllUMEJ3T0N3Yk52Rnd6YmhjVDdRL0VMYmRM?=
 =?utf-8?B?U29QQTFpNGt3MDlEUm14US80SkZwZE5lQnljNkx4M0ZLTHliUEh3OU11TC8z?=
 =?utf-8?B?VmV0eFArWGFER2VEM3IvOUVwUjlLNzM2VXNSR1d6NS9YRUVrOGZCNTRIaEx1?=
 =?utf-8?B?QjRrUFRLc3BaU2UwbUhQN1FpYjhpc1RLeEQ2R084Vjd3RW9mWGUyQ2NWOVNB?=
 =?utf-8?B?Z2dncVhTY0U2aGtEVjRzQ3RES0hzUVh4c3lPRHVLckF6RmJLQmhiZGhNNVVQ?=
 =?utf-8?B?YmVNeGkwZGpEdHUzeXlOaXVVYUJST0ZsQkNBSkkrZjhoRmhQUFJFYk9zbS91?=
 =?utf-8?B?V0VjQ0VuNzQvSk03ajBETi84aVF6ZEVhNWR5VFkrbWJKSllKNjBLZmlyd1Ir?=
 =?utf-8?B?RUhHOWV2eU8wWDA4Y2M4L25VSkxmNkthSnRHR0tQTTBtTmplZTNCZ08xYnV6?=
 =?utf-8?B?c1I4R1pOZnE5ems3eTBwdzd0UTE2TlpuSi9UMm1IRUUrWFpnYmxOWGZZcE9p?=
 =?utf-8?B?aWhYOUtmUk1GQXBBUUdSVlIxdUhUdUQxM0M4ekFOS1ZOTTM4T3NQSDd6bG8r?=
 =?utf-8?B?VjlacXY5SGlBTWtKV2NmZ3luTEZicitKQVFwZktqMGRxV2sxak9IVFo2dEZB?=
 =?utf-8?B?RC9NL2cwQ0dGWWlCOWk2c2ltU2JpN3ZPZ2R4WjdIblczL1ZtRHVKQjh4VTNJ?=
 =?utf-8?B?ZCtvWXJVZGRkOWx5QTdwK3JoYkgvdUtRdEI1bnA1SU5yVFNtekZMMSttZnQx?=
 =?utf-8?B?VTRHUDRnaTA3SU1nRG10UlBaV1JhL3ppM3RiR1h2Vm02cjdHZDNEaXBaWHBr?=
 =?utf-8?B?LzE5MGNWSmRsckNzbFhrNnRkbldRRjVMd2ZxbkNHOEZiYnZHT0EzcUtScHIy?=
 =?utf-8?B?SEhVcmdhWHRIdk51MlBvYzdQcjJBMXoyekZtdVlIUzI5NkhYUFVkYTZYT2RP?=
 =?utf-8?B?M01YQzBWZFIxaVlQVFpvYUxQQkhFcjNueEtsVHJaTzd0YTNqTTdaT3FBeGhm?=
 =?utf-8?B?bzNqdWFKSzh2V0pCRm4yU0tyeTFlWFI2SWVUYUM5Zm5NcTNrajk4KzJlQzlL?=
 =?utf-8?B?TWNBYkxwVVhHVGU3eWpXM2VhcjVmbElqOHBNU1NRSHJKWUFDNDUvTlFoemEz?=
 =?utf-8?B?ZXRLN0FsK3JZMUI5czFwSXZsUXZ6d0RBcGFhUEJLWWVmbEt5bUdmNldqZE4w?=
 =?utf-8?B?VnVMSzM1MExJekhsWkc5K0ppRzVqbzdjNXNNOFd6N09xNW5VeDA1WXNOT3g1?=
 =?utf-8?Q?4aQeEweFZvFD+zvImw6osirWQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85002d79-573b-4d8f-cfdc-08daed6a9a2b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:12:13.8674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyBtqXecwsih12OPwKKRa9I3v7Y+4+lGnpEEjgrVpXz8mNY50BNPiBBGbALzgiicpKWRzWluDjpilVt2qXaE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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


On 02/01/2023 13:39, Christian König wrote:
> Hi Shashank,
>
> Am 26.12.22 um 11:41 schrieb Shashank Sharma:
>> [SNIP]
>>>>         /* df */
>>>>       struct amdgpu_df                df;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>> index 0fa0e56daf67..f7413859b14f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>>>       unsigned long            ras_counter_ce;
>>>>       unsigned long            ras_counter_ue;
>>>>       uint32_t            stable_pstate;
>>>> +    struct amdgpu_usermode_queue    *userq;
>>>
>>> Why should we have this in the ctx here???
>>
>> We are allocating a few things dynamically for the queue, which would 
>> be valid until we destroy this queue. Also we need to save this queue
>>
>> container at some place for the destroy function,  and I thought it 
>> would make sense to keep this with the context ptr, as this is how we 
>> are
>>
>> identifying the incoming request.
>
> I have absolutely no idea how you end up with that design.
>
> The ctx object is the CS IOCTL context, that is not even remotely 
> related to anything the user queues should be doing.
>
> Please completely drop that relationship and don't use any of the ctx 
> object stuff in the user queue code.
>
Historically the workload submission always came with a context (due to 
CS IOCTL), so we thought it would make sense to still have its relevance 
in the new workload submission method. Would you prefer this new 
submission to be independent of AMDGPU context ?

- Shashank


> Christian.
>
>>
>> - Shashank
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>   };
>>>>     struct amdgpu_ctx_mgr {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> new file mode 100644
>>>> index 000000000000..3b6e8f75495c
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -0,0 +1,187 @@
>>>> +/*
>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person 
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the 
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without 
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following 
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be 
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +
>>>> +#include "amdgpu.h"
>>>> +#include "amdgpu_vm.h"
>>>> +#include "amdgpu_mes.h"
>>>> +#include "amdgpu_usermode_queue.h"
>>>> +#include "soc15_common.h"
>>>> +
>>>> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a, 
>>>> sizeof(__u64)))
>>>> +
>>>> +static int
>>>> +amdgpu_userqueue_index(struct amdgpu_device *adev)
>>>> +{
>>>> +    int index;
>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>> +
>>>> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, 
>>>> GFP_KERNEL);
>>>> +    return index;
>>>> +}
>>>> +
>>>> +static void
>>>> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct 
>>>> amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>> +
>>>> +    ida_simple_remove(&uqg->ida, queue->queue_id);
>>>> +}
>>>> +
>>>> +static int
>>>> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct 
>>>> drm_amdgpu_userq_mqd *mqd_in)
>>>> +{
>>>> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || 
>>>> mqd_in->doorbell_offset == 0) {
>>>> +        DRM_ERROR("Invalid queue object address\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || 
>>>> mqd_in->wptr_va == 0) {
>>>> +        DRM_ERROR("Invalid queue object value\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= 
>>>> AMDGPU_HW_IP_NUM) {
>>>> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (!CHECK_ACCESS(mqd_in->queue_va) || 
>>>> !CHECK_ACCESS(mqd_in->rptr_va) ||
>>>> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
>>>> +            DRM_ERROR("Invalid mapping of queue ptrs, access 
>>>> error\n");
>>>> +            return -EINVAL;
>>>> +    }
>>>> +
>>>> +    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct 
>>>> drm_file *filp,
>>>> +                            union drm_amdgpu_userq *args)
>>>> +{
>>>> +    int r, pasid;
>>>> +    struct amdgpu_usermode_queue *queue;
>>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>>>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>>>> +
>>>> +    if (!ctx) {
>>>> +        DRM_ERROR("Invalid GPU context\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (vm->pasid < 0) {
>>>> +        DRM_WARN("No PASID info found\n");
>>>> +        pasid = 0;
>>>> +    }
>>>> +
>>>> +    mutex_lock(&adev->userq.userq_mutex);
>>>> +
>>>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), 
>>>> GFP_KERNEL);
>>>> +    if (!queue) {
>>>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>>>> +        mutex_unlock(&adev->userq.userq_mutex);
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
>>>> +    if (r < 0) {
>>>> +        DRM_ERROR("Invalid input to create queue\n");
>>>> +        goto free_queue;
>>>> +    }
>>>> +
>>>> +    queue->vm = vm;
>>>> +    queue->pasid = pasid;
>>>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>>>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>>>> +    queue->queue_size = mqd_in->queue_size;
>>>> +    queue->queue_type = mqd_in->ip_type;
>>>> +    queue->paging = false;
>>>> +    queue->flags = mqd_in->flags;
>>>> +    queue->queue_id = amdgpu_userqueue_index(adev);
>>>> +
>>>> +    ctx->userq = queue;
>>>> +    args->out.q_id = queue->queue_id;
>>>> +    args->out.flags = 0;
>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>> +    return 0;
>>>> +
>>>> +free_queue:
>>>> +    amdgpu_userqueue_remove_index(adev, queue);
>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>> +    kfree(queue);
>>>> +    return r;
>>>> +}
>>>> +
>>>> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct 
>>>> drm_file *filp,
>>>> +                              union drm_amdgpu_userq *args)
>>>> +{
>>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>>>> +    struct amdgpu_usermode_queue *queue = ctx->userq;
>>>> +
>>>> +    mutex_lock(&adev->userq.userq_mutex);
>>>> +    amdgpu_userqueue_remove_index(adev, queue);
>>>> +    ctx->userq = NULL;
>>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>>> +    kfree(queue);
>>>> +}
>>>> +
>>>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>> +               struct drm_file *filp)
>>>> +{
>>>> +    union drm_amdgpu_userq *args = data;
>>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>>> +    int r = 0;
>>>> +
>>>> +    switch (args->in.op) {
>>>> +    case AMDGPU_USERQ_OP_CREATE:
>>>> +        r = amdgpu_userqueue_create(adev, filp, args);
>>>> +        if (r)
>>>> +            DRM_ERROR("Failed to create usermode queue\n");
>>>> +        break;
>>>> +
>>>> +    case AMDGPU_USERQ_OP_FREE:
>>>> +        amdgpu_userqueue_destroy(adev, filp, args);
>>>> +        break;
>>>> +
>>>> +    default:
>>>> +        DRM_ERROR("Invalid user queue op specified: %d\n", 
>>>> args->in.op);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    return r;
>>>> +}
>>>> +
>>>> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
>>>> +{
>>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>>> +
>>>> +    mutex_init(&uqg->userq_mutex);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
>>>> +{
>>>> +
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h 
>>>> b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>> new file mode 100644
>>>> index 000000000000..c1fe39ffaf72
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>> @@ -0,0 +1,50 @@
>>>> +/*
>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person 
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the 
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without 
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following 
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be 
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +
>>>> +#ifndef AMDGPU_USERMODE_QUEUE_H_
>>>> +#define AMDGPU_USERMODE_QUEUE_H_
>>>> +
>>>> +#define AMDGPU_MAX_USERQ 512
>>>> +
>>>> +struct amdgpu_usermode_queue {
>>>> +    int        queue_id;
>>>> +    int        queue_type;
>>>> +    int        queue_size;
>>>> +    int        paging;
>>>> +    int        pasid;
>>>> +    int        use_doorbell;
>>>> +    int        doorbell_index;
>>>> +
>>>> +    uint64_t    mqd_gpu_addr;
>>>> +    uint64_t    wptr_gpu_addr;
>>>> +    uint64_t    rptr_gpu_addr;
>>>> +    uint64_t    queue_gpu_addr;
>>>> +    uint64_t    flags;
>>>> +    void         *mqd_cpu_ptr;
>>>> +
>>>> +    struct amdgpu_bo    *mqd_obj;
>>>> +    struct amdgpu_vm        *vm;
>>>> +    struct list_head     list;
>>>> +};
>>>> +
>>>> +#endif
>>>
>
