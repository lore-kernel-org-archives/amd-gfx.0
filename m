Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3890DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 13:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681AA10E2AE;
	Thu, 29 Sep 2022 13:37:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A9810E2AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 13:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F76PsasFM0nFz2TuMgmxqWr/oqR9S+yKCYd2yC+4SmzOEF8Ha28NNixIePiJONs1gCARC40AGzVPLfglQfFKHuTBid5xnXeZuClHSIc+17yAKimHK/nMx7vBEeh9HlpXMsVOFlJ6HyB3d2Tcm12RAUILWzj/NQxbtFYJMgTCm1SR7qtON85Rzp9nrPHbBWnk70MwSTfyDDgQ8zkTz7BQ5inWeyeLduu9bi2GSMA9jQKc76WXCli5j287u5h+CPzc3N3/RnXSTxAKc5imsi//qSTWln3M4gPIgIqgN+YE8uTgC6dR25J1i25PlTTsh/nCLnemo5QVt59Ku6YgSy5EcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+9jiQ/L6leruY9k92TmfKC5vHHfBmF7rRM1Pi+7VMY=;
 b=LUXVBfCyXt2al+MxVz35osAXoot9kwEMUI3tcInR67O33NPlPYHcl1cwHHuApawycblMIHxHFh7jo/fj3c6uBxPYqxPOlpU7rH+658yAcM1WDeH0oiLJBAGhXv7M6w55oDLwPSG+5eB7GTH8UthTynAe5pllbZ7xWqS3lwzDAmIb3Lh6bl+MAj81GpSdx2M+XBmo2GBB839o3/zwCDj6We980STyGoNGNQEwi2v12udJUrv1/hbwg9zWgHUcq58HRsanHUsoXnM2CLWTyAgAEJGVTf5vhWAmILKZGS0+EL8Fu/6J1gPjXdlqfxCAp24bRSPoI1xR7P8qVwtWg0eUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+9jiQ/L6leruY9k92TmfKC5vHHfBmF7rRM1Pi+7VMY=;
 b=LfTao42tOxjTY+sjeeHvRIUjmk9g83ukJIhfUqwybcukNediTHUOmmBp6No81QO/OH4gbaD7vfZYlavwAc1oPwQx8n+I5H3T2n9nfE2oapAAOCpzwAWl04UFNHrjAsM8+BQ288JguGit+T4yFjjHNEHsY2Fzv4FjBFdCCXfQBFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 13:37:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 13:37:43 +0000
Message-ID: <4cfb549b-9a76-f950-119d-e6e345841d5c@amd.com>
Date: Thu, 29 Sep 2022 19:07:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
 <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
 <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
 <05b4b97e-422d-dc00-bc3f-4dd04758a3c9@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <05b4b97e-422d-dc00-bc3f-4dd04758a3c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7081ae-9036-43d7-8204-08daa21fc953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cnli5I9tvyZsHNJYMRRXxLJEqTc/6CBx2ENN7aBLNIgB+FoC2yvB4nsD8BDnS1gATnuAyByjkD2uJAcIkuT0GfpALKTe3vwZ8TyewAUP2JzldmEUtxktrSwOw4ulmMETcq3z20GK1BhTW7F6FVKEzbj+A1ilzAIng1TyuBMB8QKNXfQ9O3XJ51o10mzSk6r9S+JTNaphlfMPIbcoBJon1CP5frec1N9OcWrUaBAs6IpwUyDfyV/Wmn0G67ibEyC/iYonYJUjfHyaktJc93ZOT0e2m5a2Dp8MpT0OIdReA3f8tyqGj3C3zW9StEGUSzpck1Etbx22XkgsrlhM8cymCxb+MIVrruREO5E39GcN0FRgeak9okXUDc5/oCRle7oul5qdRk208n7zw4o0PQD3mK+88jIM2FN5rNdAXbu8oJyD3fNzg6fMalx8ldA00HWmdfPVzbs5gx/FKM+9yi3uJyTwkNKGMr4lFkKHcMKgNlKa3e2Vs2hP9WLh+CAysnevD1aC51ivm/tiKTHgCd3eTtiSz2ceTkTOtxWLi7542Ixnn6jqYPzVV+XDjOzS1tcB9cqn+6Uoh3+TNi+HdhzU1NXgG098ne2p/HUHfjQD2I6JOW/fdXeXN4E+xk49KrhhHz8qJHH192xpNITr+tu7e+K+Qutau5IQj4UJotvRDV4SafEhJszDZb4N9KhIsrj2KKzlAhlJJAYD8aAD9psDB2ut4qSc1gqry++F3vX//CEmDgDojrxkwZie/PHZxm4mnbMfUagwHiL+so8jwcvarWOT9LjK9jRl4mEx0sylqQUANDIgC25oBkjVvWxNf0FaOUAjjEUwSMNIeLQKln7Pe7OOgq7FZjb7zcwV1S2sZbLzXsgKK6VNBFKyLgywTU9z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(31696002)(86362001)(83380400001)(36756003)(38100700002)(316002)(966005)(6486002)(110136005)(8936002)(30864003)(66946007)(2906002)(4326008)(8676002)(66476007)(66556008)(41300700001)(66574015)(186003)(5660300002)(478600001)(6666004)(54906003)(53546011)(26005)(6512007)(6506007)(31686004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnBPajduUmozMDJxMzlvOWFYWlc0RVdnOTJlbGh1c0pzT3NoUnU4dWlXNmFV?=
 =?utf-8?B?TkFnTjM1Q01jMWsyUHZST3ppT3ViSXBCTUkxNVBjV21ra2dFR2JoWUE0czd1?=
 =?utf-8?B?aWZoMkgvZ2t3bUV1VzBMMXU1MkR2dzAxSWYxQmdMMjdNcUhhZ3ZBdlJER0Z2?=
 =?utf-8?B?K1RuSTlBOHBjeE5BYXZITUxyQUU3dDNMTEhoQ0lycUhIMnV3dTVORmRlL0JG?=
 =?utf-8?B?UjJkWktOd3krdWRDa1hmUzd0RHZHRHhwck5DOWdQdlVubUtsU1MvQXlaNUhF?=
 =?utf-8?B?dE5TemdFUkVWdnFwUmdvNXM4OG0yaVFFMHRxWEFUVGl1aStjd09sNUJhNndw?=
 =?utf-8?B?ZVl2NFNrMFlvS296OFAyeE9wb3RyNHB6Wko1bHNxT0d3OHh1WFhseVo5WUk1?=
 =?utf-8?B?VVJiRXNtRXBwN243RzNocDV2amJhZjdJZkxSblpUYjBqQnpHR3RXRSt1WmE1?=
 =?utf-8?B?UXhmaWFwZzhpTitsWjJHZ25GS0lmendJUkQzbU9Ia0lFd2pUZHR6WHA1dHdu?=
 =?utf-8?B?WUJoTWlyanYrOVc4ZTFRY1o1cC9DOFFmSGxRb1c3RytKR01EeXdQYUYzem5F?=
 =?utf-8?B?OFdzV0w0TU8weThqNlRiL1JqM2cwMWVoKzk0b1pBaG5XZHRIVllLb1QvSTFp?=
 =?utf-8?B?bXBzN2FVV1ZqOHA1c3FNOVhlN2JSLytySk8xc3VqV1F2d3U1OVRzOUQyY2tB?=
 =?utf-8?B?dEhKRDFtaTFLVzNIbXBtRHBpbHFoeDFHRlE5M2Q3U21pMlFWdS9mV1RodHg5?=
 =?utf-8?B?WU00NEdTWHFCWnp5QzlYMiswYlpKdDRmMXdaREsxU1BNWW84SEdhR3ZwM1c1?=
 =?utf-8?B?aTFkQ1lWekdMUzhqdjdNTThISStMUE9zT3dnaWY2ZG54U1NrNmJURVJNbHpv?=
 =?utf-8?B?Q1g2QW9MaTNnVllGb0pkWXZIdWF4TnVYYlRFVkhhUjdMWmZ2RzBQWFNMVWtL?=
 =?utf-8?B?NmtMNlVtRnlxamptYnh4a0h4S3ZHZVdjcHNiOXJCMUVkcXZyVmVjK3liK3ZU?=
 =?utf-8?B?anVOdUdzbGd1Q3VtS0RxdlpVTVhFOUFGTzBTQUMzTmJyTy9WZEZITXZMWDBp?=
 =?utf-8?B?aTEvWUIvdk51QzU0OHNua3l2M3ltY0l6QURMQmd3ek51WlY3dXA0aUkrcERv?=
 =?utf-8?B?ZkNIMEM1WitGejNyV05TaGpWY0JERU5Rb0F6dWVhZG9aY2ZWL2FMdFQ1Y0hG?=
 =?utf-8?B?WG0vQ3F2cFNKNW5jMTBNUk9Ja2dTYTc3ZWdnd0hTdU5zTW9pa3NIRHZJWEFj?=
 =?utf-8?B?eUZGalBUUmdGRlc0ODd2QUplR0NVS2ZLdGpnd0p3R1VKMVlBSVNhK0tlQysw?=
 =?utf-8?B?d0g0bndqdTdRWnlCNWlMWlQyZEo2N2RnZ3pxUlVIbGMzcmc3OHNHWm0zZVFr?=
 =?utf-8?B?ZU1ndFBrRTR0YzBWWlpWVW02QTZaSjFhTDRGOWp4NG9jT0FmUERoTzVaSW04?=
 =?utf-8?B?YXpQNWdaWDd3RS9BRnl3RnRxcHo4YWdwY1hhbStRWHk4S1psM2FOVDlROGVK?=
 =?utf-8?B?a1NDUlE5VHBDRU1jVGdGb2hodFhtTkpPdjF0M2dMQ0ZsQURwMHJ4c2tWWEYv?=
 =?utf-8?B?UU1tUUQ4ZzB6MXFETVJacUs3c0JZVHB5WHdWZnpham9YNVp1ZkZiaE9RSHBY?=
 =?utf-8?B?VER2NkJLNjZ5R0t1YnpJK1JtK2NpVjV1OFVaTEh5d1lkYWdpSkY2eVZzMjZG?=
 =?utf-8?B?ZG9mNU9uWHdGUUVxdC9jNCtvbDN5OHNnWStwWUZOYUhsMkZleThuaitaY0Ny?=
 =?utf-8?B?RzByM0wvc0V6blZiaElMMHhlaTRRUm5FelhuMEpzNGg4ZHBYR3dtMEdNTyt1?=
 =?utf-8?B?bEVONjROQkQ5M2lLVThxVmpidC9QQUI2ckJSMzVyTk5taFpwNmgxSm5XUURu?=
 =?utf-8?B?SnF4S2dWZUR1U3YwMzlGSEtwOHlaZnhwSjY4eXI0UXAzcXVyb1h1SWk4ZFMv?=
 =?utf-8?B?YVRQK3loeUd4Nnc0UGJNT1lDZERnd3BxMVhsV05INDlsb2xTTDZWV2RNRVJo?=
 =?utf-8?B?UElsb1VHcHJnaEtoZXhOZ3p0ZFdncmJ0SXVUbVdaaDc1S2lqUzZpQmVBK3oz?=
 =?utf-8?B?c3F6Tmo3bW5pZkUxTWlGWUEvc3MxTWw2Z09YSEFPTisrcTJTeXc3T2Q0RUxm?=
 =?utf-8?Q?P6SQU6mq42eYfaSWQnEzF1Qem?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7081ae-9036-43d7-8204-08daa21fc953
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 13:37:43.6100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgc1TAOGLbnbFr+g+TCJMnYk6Y8cxLNcJ+ZWFaSrtivZIvl52PNDZwKhuH6tHMkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/29/2022 6:50 PM, Sharma, Shashank wrote:
> 
> 
> On 9/29/2022 1:10 PM, Lazar, Lijo wrote:
>>
>>
>> On 9/29/2022 2:18 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/28/2022 11:51 PM, Alex Deucher wrote:
>>>> On Wed, Sep 28, 2022 at 4:57 AM Sharma, Shashank
>>>> <shashank.sharma@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 9/27/2022 10:40 PM, Alex Deucher wrote:
>>>>>> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>>>>>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>>>>>>> Hello Felix,
>>>>>>>>>
>>>>>>>>> Thank for the review comments.
>>>>>>>>>
>>>>>>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>>>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>>>>>>> compute mode, while submitting compute workload.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>>>
>>>>>>>>>>> Feel free to add my acked-by, but Felix should probably take 
>>>>>>>>>>> a look
>>>>>>>>>>> as well.
>>>>>>>>>>
>>>>>>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>>>>>>> about the interaction of compute with graphics or multiple 
>>>>>>>>>> graphics
>>>>>>>>>> contexts submitting work concurrently. They would constantly 
>>>>>>>>>> override
>>>>>>>>>> or disable each other's workload hints.
>>>>>>>>>>
>>>>>>>>>> For example, you have an amdgpu_ctx with
>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>>>>>>> process that also wants the compute profile. Those could be 
>>>>>>>>>> different
>>>>>>>>>> processes belonging to different users. Say, KFD enables the 
>>>>>>>>>> compute
>>>>>>>>>> profile first. Then the graphics context submits a job. At the 
>>>>>>>>>> start
>>>>>>>>>> of the job, the compute profile is enabled. That's a no-op 
>>>>>>>>>> because
>>>>>>>>>> KFD already enabled the compute profile. When the job 
>>>>>>>>>> finishes, it
>>>>>>>>>> disables the compute profile for everyone, including KFD. That's
>>>>>>>>>> unexpected.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> In this case, it will not disable the compute profile, as the
>>>>>>>>> reference counter will not be zero. The reset_profile() will 
>>>>>>>>> only act
>>>>>>>>> if the reference counter is 0.
>>>>>>>>
>>>>>>>> OK, I missed the reference counter.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> But I would be happy to get any inputs about a policy which can be
>>>>>>>>> more sustainable and gets better outputs, for example:
>>>>>>>>> - should we not allow a profile change, if a PP mode is already
>>>>>>>>> applied and keep it Early bird basis ?
>>>>>>>>>
>>>>>>>>> For example: Policy A
>>>>>>>>> - Job A sets the profile to compute
>>>>>>>>> - Job B tries to set profile to 3D, but we do not allow it as 
>>>>>>>>> job A is
>>>>>>>>> not finished it yet.
>>>>>>>>>
>>>>>>>>> Or Policy B: Current one
>>>>>>>>> - Job A sets the profile to compute
>>>>>>>>> - Job B tries to set profile to 3D, and we allow it. Job A also 
>>>>>>>>> runs
>>>>>>>>> in PP 3D
>>>>>>>>> - Job B finishes, but does not reset PP as reference count is 
>>>>>>>>> not zero
>>>>>>>>> due to compute
>>>>>>>>> - Job  A finishes, profile reset to NONE
>>>>>>>>
>>>>>>>> I think this won't work. As I understand it, the
>>>>>>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>>>>>>> profiles. Disabling the 3D profile doesn't disable the compute 
>>>>>>>> profile
>>>>>>>> at the same time. I think you'll need one refcount per profile.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>      Felix
>>>>>>>
>>>>>>> Thanks, This is exactly what I was looking for, I think Alex's 
>>>>>>> initial
>>>>>>> idea was around it, but I was under the assumption that there is 
>>>>>>> only
>>>>>>> one HW profile in SMU which keeps on getting overwritten. This 
>>>>>>> can solve
>>>>>>> our problems, as I can create an array of reference counters, and 
>>>>>>> will
>>>>>>> disable only the profile whose reference counter goes 0.
>>>>>>
>>>>>> It's been a while since I paged any of this code into my head, but I
>>>>>> believe the actual workload message in the SMU is a mask where you 
>>>>>> can
>>>>>> specify multiple workload types at the same time and the SMU will
>>>>>> arbitrate between them internally.  E.g., the most aggressive one 
>>>>>> will
>>>>>> be selected out of the ones specified.  I think in the driver we just
>>>>>> set one bit at a time using the current interface.  It might be 
>>>>>> better
>>>>>> to change the interface and just ref count the hint types and then
>>>>>> when we call the set function look at the ref counts for each hint
>>>>>> type and set the mask as appropriate.
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>
>>>>> Hey Alex,
>>>>> Thanks for your comment, if that is the case, this current patch 
>>>>> series
>>>>> works straight forward, and no changes would be required. Please 
>>>>> let me
>>>>> know if my understanding is correct:
>>>>>
>>>>> Assumption: Order of aggression: 3D > Media > Compute
>>>>>
>>>>> - Job 1: Requests mode compute: PP changed to compute, ref count 1
>>>>> - Job 2: Requests mode media: PP changed to media, ref count 2
>>>>> - Job 3: requests mode 3D: PP changed to 3D, ref count 3
>>>>> - Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref 
>>>>> > 0,
>>>>> PP still 3D
>>>>> - Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref 
>>>>> > 0,
>>>>> PP still 3D
>>>>> - Job 2 finishes, downs ref count to 0, PP changed to NONE,
>>>>>
>>>>> In this way, every job will be operating in the Power profile of 
>>>>> desired
>>>>> aggression or higher, and this API guarantees the execution 
>>>>> at-least in
>>>>> the desired power profile.
>>>>
>>>> I'm not entirely sure on the relative levels of aggression, but I
>>>> believe the SMU priorities them by index.  E.g.
>>>> #define WORKLOAD_PPLIB_DEFAULT_BIT        0
>>>> #define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
>>>> #define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
>>>> #define WORKLOAD_PPLIB_VIDEO_BIT          3
>>>> #define WORKLOAD_PPLIB_VR_BIT             4
>>>> #define WORKLOAD_PPLIB_COMPUTE_BIT        5
>>>> #define WORKLOAD_PPLIB_CUSTOM_BIT         6
>>>>
>>>> 3D < video < VR < compute < custom
>>>>
>>>> VR and compute are the most aggressive.  Custom takes preference
>>>> because it's user customizable.
>>>>
>>>> Alex
>>>>
>>>
>>> Thanks, so this UAPI will guarantee the execution of the job in 
>>> atleast the requested power profile, or a more aggressive one.
>>>
>>
>> Hi Shashank,
>>
>> This is not how the API works in the driver PM subsystem. In the final 
>> interface with PMFW, driver sets only one profile bit and doesn't set 
>> any mask. So it doesn't work the way as Felix explained. If there is 
>> more than one profile bit set, PMFW looks at the mask and picks the 
>> one with the highest priority. 
> Note that for each update of workload mask,
>> PMFW should get a message.
>>
>> Driver currently sets only bit as Alex explained earlier. For our 
>> current driver implementation, you can check this as example -
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1753 
> 
> If you see my last reply, Since Alex's last message, we are very clear 
> on this point. And also as PM FW is already picking up the one with the 
> highest priority, we don't have to worry about blocking profile change 
> calls via different contexts. In this way, every job will be executed at 
> at-least the requested priority power profile, or more than that.
> 
> current power profile P0.
> Job1 came, requested power profile P2=> PM FW changed profile to P2.
> Job2 came, requested power profile P3=> if (p3 > p2): profile changed to 
> P3, else it will stay at P2. So Job2 will still execute at P2, which is 
> more aggressive than P3.
> 

To be clear your understanding -

Nothing is automatic in PMFW. PMFW picks a priority based on the actual 
mask sent by driver.

Assuming lower bits corresponds to highest priority -

If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose profile 
that corresponds to Bit0. If driver sends a mask with Bit4 Bit2 set and 
rest unset, PMFW will chose profile that corresponds to Bit2. However if 
driver sends a mask only with a single bit set, it chooses the profile 
regardless of whatever was the previous profile. t doesn't check if the 
existing profile > newly requested one. That is the behavior.

So if a job send chooses a profile that corresponds to Bit0, driver will 
send that. Next time if another job chooses a profile that corresponds 
to Bit1, PMFW will receive that as the new profile and switch to that. 
It trusts the driver to send the proper workload mask.

Hope that gives the picture.

Thanks,
Lijo

> So we don't have to block the PP change request at all.
> 
>>
>> Also, PM layer already stores the current workload profile for a *get* 
>> API (which also means a new pm workload variable is not needed). But, 
>> that API works as long as driver sets only one profile bit, that way 
>> driver is sure of the current profile mode -
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1628 
>>
> 
> Yes, I had seen this API and its high level API while I was exploring 
> the code, and I found this written to support sysfs based reads and 
> write, and is not useful for a context based scenario.
> 
>>
>> When there is more than one, driver is not sure of the internal 
>> priority of PMFW though we can follow the bit order which Alex 
>> suggested (but sometimes FW carry some workarounds inside which means 
>> it doesn't necessarily follow the same order).
>>
>> There is an existing interface through sysfs through which allow to 
>> change the profile mode and add custom settings. 
> 
> Same as above, this sysfs interface is very basic, and good for 
> validation of power profile change, but not for job level pp change.
> 
> In summary, any
>> handling of change from single bit to mask needs to be done at the 
>> lower layer.
>>
> 
> I still don't understand how does this series handle and change this 
> mask ? This part is still being done in 
> amdgpu_dpm_switch_power_profile() function, which is a dpm function 
> only. Code in this series is just calling/consuming this function from 
> the scheduler.
> 
>> The problem is this behavior has been there throughout all legacy 
>> ASICs. Not sure how much of effort it takes and what all needs to be 
>> modified.
>>
> 
> As mentioned above, we are just consuming 
> amdgpu_dpm_switch_power_profile() function. So if this function is valid 
> for all these ASICs, I think this wrapper will also be fine.
> 
> - Shashank
> 
>> Thanks,
>> Lijo
>>
>>> I will do the one change required and send the updated one.
>>>
>>> - Shashank
>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> - Shashank
>>>>>
>>>>>>
>>>>>>>
>>>>>>> - Shashank
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Or anything else ?
>>>>>>>>>
>>>>>>>>> REgards
>>>>>>>>> Shashank
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Or you have multiple VCN contexts. When context1 finishes a 
>>>>>>>>>> job, it
>>>>>>>>>> disables the VIDEO profile. But context2 still has a job on 
>>>>>>>>>> the other
>>>>>>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>>      Felix
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 
>>>>>>>>>>>> +++++++++++---
>>>>>>>>>>>>     1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>>>>>>     #include "amdgpu_ras.h"
>>>>>>>>>>>>     #include "amdgpu_umc.h"
>>>>>>>>>>>>     #include "amdgpu_reset.h"
>>>>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>>>>       /* Total memory size in system memory and all GPU 
>>>>>>>>>>>> VRAM. Used to
>>>>>>>>>>>>      * estimate worst case amount of memory to reserve for 
>>>>>>>>>>>> page tables
>>>>>>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>       void amdgpu_amdkfd_set_compute_idle(struct 
>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>> bool idle)
>>>>>>>>>>>>     {
>>>>>>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>>>>>>> -                    !idle);
>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (idle)
>>>>>>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>>>> +    else
>>>>>>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (ret)
>>>>>>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>>>>>>> compute mode\n",
>>>>>>>>>>>> +             idle ? "reset" : "set");
>>>>>>>>>>>>     }
>>>>>>>>>>>>       bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device 
>>>>>>>>>>>> *adev, u32
>>>>>>>>>>>> vmid)
>>>>>>>>>>>
