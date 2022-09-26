Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DA9C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63BA10E2BE;
	Mon, 26 Sep 2022 15:25:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6549510E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nsw3PW/eTtAkX9Cm5o9gtAYNSyXHTrPpqz9Nt3uxwdgLdxR1hYkDPsGcB5XxP4oGpH8jZh6WyxNNa2iHZmIrx1ZGVbvv43g5Rb2kHeiOxArPCRLXmPKYXEoqkbyr9X/Lrr9goVWOGRmQXoBlEdk+SE3qjtXdmGzNsgFa0NefKTUNSfOFYCxrmMxCilW/JT0i+662d8FVoFL3Kxwrp9TOvF4Akkx5TpKySMjL/3v7o04MsOoF5SAkCFZbomsJxLeREvJHjcReSXmh01fNQWyp6HS7Tm89GKJiQ1RLGwv800a0MQRmGWfUDI48zMMc4afO/WnJvycr6RajsYiSXL3Ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhKdUXP/ypLUBVpwHqC5IcbSuSbT3qKwfb23juIAB58=;
 b=NdnoMDcejlRajigiiuQNNLmadHUIV8b5IuMafqPmwyP7+SvkS9U3aJ9igs75xOgoSPIYDCb+OMDg5PhdvX6Kc9w6/Ssx8FfZtblAGOtNIsKBw+WXW3KWx1vC41pZHnBgA7C4TCs8+Cf15OfC5eiMEHf7p5xEKNgIiU7Van3JSlOs9O+KtsBmdUEaJur/jtT7lASz6ODGxV0yEYJXw8pIPOOnoTFbgjkhhmHL9YqgXjzDE/uwqPwmckXp22EIa8KuAxZUNnRaAVHq1mCL0EPeBiiwMYgc/PCVGzACc9Mu2rQmzyQIxvX7ABkf2rCemz2MmfsgVmFLBzHr/JnMptY7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhKdUXP/ypLUBVpwHqC5IcbSuSbT3qKwfb23juIAB58=;
 b=LnTNqXiuWjSjdCPgd5Ys7oURZWb8x6Vo4dJ6iiBruygITzjiCQi0TIEb+VGKAoFgGtjQoYy/wBC4kMIqHT8YqSRX4LIS7LbMJVtH/u+4VqruseHUNLLqS3Bvvx33wLqSTEWRkQeNga5Cc6i0IzgTil1aUZp4mMSJTkpDvgCROgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 15:25:28 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c%9]) with mapi id 15.20.5654.024; Mon, 26 Sep 2022
 15:25:28 +0000
Message-ID: <c359de6c-6245-1c3a-caa6-9e26bab56a78@amd.com>
Date: Mon, 26 Sep 2022 17:25:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926150252.18635-1-shashank.sharma@amd.com>
 <20220926150252.18635-2-shashank.sharma@amd.com>
 <5e13829e-369b-80a1-5226-c3f0b62534a0@amd.com>
 <55293735-fee0-5e81-73cb-0215bc9cc989@amd.com>
 <48afef1e-b318-1f33-f35b-f098b7e76722@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <48afef1e-b318-1f33-f35b-f098b7e76722@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 896d00bd-7789-438c-6e2d-08da9fd3576c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FS9IyHPtR2lzR9Bk8rIgj3LussNclZOIMk+nei8UV7Lvby2s+KspWSahHCQ6NTxtpGOXNcSCxitax/1GzVbLCe2A1UsrwfgS69131Px6+Q2d5T+AZWJYepn0pSz7ZgdgLaw0budLvRsXF0jS8uL58w+pmW9OWEbPjMjxu9vaK3c9/ls9pmTH8otUiELfJd7TrdBWefNVUt5ryMubrqb6aTpZ/Aovp57raTUoW4YJrAawQo/5vzS9DPSTDKUrs+nUw/b8QOnqPDCnb/e9Rlx5Qj0ROfQTcNhswSO8psR/dcj/WNhDOCE/7Qmsl6sC5A7vWilMr8xF82G6yRwsb32HFPSQGq9I+GqMvkn2pTUQAXUqYz6mNte36BC9GFa2WB2AhnPwIStY58rdgSGO8VBvkkIWl1xG82rM7RMVJqadjy3FJ3qsBnyMWqdchchafJzk0TYL0LfiStnA8DXg1hczhawe4gZtbK2m5D/SnHX2S8BEKUUbtNJPWfjLp3L4u7eArQd+rtIauEf6DHhYdEQBJuSJ7OHg6VqRYbhEY1lWT9Gh4lBrn3VW/6QHP4ueyoXiGCsN2/MK1VBzWWSGNb05jw2D4p4IoXDwzK2tFosZSvjqd96pUgkEJGu2yFtbwNGeMkhF+Lbc54ZaIoNSXD0MigqVS31oR9f4WwcAZjjViUidFJPdqip+eD0y2n/xyjqBNNjHZjqS/g4GPpqNPhOhpcmZ0mAoGGEEnhUUJThNkTvXJxOvQQ2vCPil11vKf+NEMniNqLnJakjG7HGNBGnIyFtFGAYnD4kraCADm3ocFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(110136005)(38100700002)(41300700001)(66574015)(6666004)(66476007)(66556008)(4326008)(8676002)(5660300002)(66946007)(6512007)(26005)(86362001)(31696002)(53546011)(8936002)(6506007)(186003)(316002)(2906002)(478600001)(2616005)(36756003)(6486002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekQzVGhtWEtQemQrdi9kd0JqMitPck1tT2w2QVo4d04vM2NSRW05ZWtWM0dk?=
 =?utf-8?B?UWhsQ1A3a1VaQm9pZTVpL3cxdXM0T2VxMk04blFTSVRnWU16bytjK3IxYjgw?=
 =?utf-8?B?M3BVVWFPSERsd3d1blV2d3llMnBkVnl3c2lTWGxlaDBON2I1dFA1Y0o5UFF2?=
 =?utf-8?B?c3BSU0lSalFiSGlneTFvWGI4SGpIOU5Ia3NHbFNId3pvQW42LzNlQnltYXFH?=
 =?utf-8?B?RkgxcHc2WlVyNS9oUXY0Y3ZzSzU0MVczLzlpQVA0RU8rVTBXVzFGU1R0RXcz?=
 =?utf-8?B?ZVhyQkxjS2ZTeEtrUHd6Wml3aCtpeXQ1dC9renVnb3NuYXhnY2dlWUkySXBJ?=
 =?utf-8?B?RWFpODhVaGRORmJEelBNN1pockVEaVFtK0lQYU5JV1JEdlVMRnNEMUpPZGp6?=
 =?utf-8?B?WlFUUVRHZXk2V0RJUGFCWmR2eVEvNFU4S3huZnV2QkhIL1R1VVNKTFlxdk9Y?=
 =?utf-8?B?SXdEdzUwVHFLNjA2eTdVQ0x6cjkzejhFMzI3a05xdGxGNkZqVkNUMU1IbzRP?=
 =?utf-8?B?QnpiQ0RtdkltbmYxTU5ZRHhTK1ZXcmN5aHc4ODQ4RndVenI0Rms4T1hDOHEw?=
 =?utf-8?B?anhsL25YTmllQjV4eTZFU1Fmb3VVaEpzcysxRmtBeFdCMkpXU3FVQnZBZUxK?=
 =?utf-8?B?SVBGY09QYmZ3MXV4S0FkMjN6bEtaS0Nja2crOHE2RTcrVHhWVWdBOVlqQ050?=
 =?utf-8?B?QnNyMlNkUXpwSk9vQjF5RU5xWXMzNWtDVmk4ajJYTGxpYVR3enRncDlZSGFw?=
 =?utf-8?B?QnFJVUVyQ29La2FvU0dCNXE1N2NyTmljanZsSDYzL2VPTE16azZzZVo0dmM1?=
 =?utf-8?B?a0VzRG00Rkt4aEJBM3lJRVp6UU1QR2VYMytuZTZTU3dIZ0ltQzZLeWV2NDlv?=
 =?utf-8?B?MVNTU3pKRWo5ZHFzMzhXSFlpQWFvbHpabm9Pa3RoUFNKYURTRG1NdDhsanlU?=
 =?utf-8?B?YkZmaVVqWWlWWE41aVVLTWtCK0QxVk52M3g1ZmhxWDBWWmt3YXFCL3NUaW1r?=
 =?utf-8?B?YUVvTmZHQ3BCUjN4N2NxYlBXak96V1liOVA3Znh0WEZUbUFyenNCWE5ENkgw?=
 =?utf-8?B?MUdHT3drQlA5dEtHZE9EdkhIbFRVQUxYL3pXc2l1Y01qRFhxVWYybEl1b1Zp?=
 =?utf-8?B?YWU1blViODJ0bkErVi9MU2M1WjdBWGxGNWdsTzl4QzVhT1h6ZWJmMmdmeFNv?=
 =?utf-8?B?akxQWGVMaFZsdEZPZnRtSWtwclJlN1ZuUjIzZWFDV2Y2cmFJNUw1aGp0WWhL?=
 =?utf-8?B?MUExaFVIOGRnYmJ2UFR2aDNQOTd6OXdGNy9aYmJWbk9IVW1oTGUvYVgxbzhx?=
 =?utf-8?B?dG1zSFZYQnU1VS9FU0c5QlpmWVEwY2lSS1oxT3RkbjF0YmpUTW5weHZLQmY5?=
 =?utf-8?B?TTJjUktYSXJvVFVkUis4bFBra1ZsdmFOTW11OXhYeUhrczdPZUtodUVrNXg0?=
 =?utf-8?B?UmtpbDYwQ0x6SDRvd01hMzR1VnlSdlRtOGw0MUJ0VjlCa2puVElxek5zTlRL?=
 =?utf-8?B?b3grSkl5U2dybEZYU1VhSy8yVUtmVm1mUk1lU2hNMGZRK1F4d2ZRb2dkTDcz?=
 =?utf-8?B?V0Fjc0c2UXRzTmRHWnE1N2ZMR3hFMGZNQ2s1dVlqcWhpR3UydTBSOHUzOEF5?=
 =?utf-8?B?QlNJK0d2NExXSzNqTjYrajkwMDREZ1VCTXd6UEhMRDlTT0xnSlNXZEliMDBu?=
 =?utf-8?B?VEZucGF5Q2dXS0FXYkFVSTZYdVVzVXl4NlRyUXZDTWZXREM2bHMrR09mdEFH?=
 =?utf-8?B?VTR1R1JKTEtNclpiYU1rVFpHVTIxc1ZyUzZXaCsyNnlPUXRYUm8yZlQyNEp0?=
 =?utf-8?B?QTJKYS9CWTVzSmpKc1FmdTRUQnFJb29ickdJM21MQlMwREhnNnlNQjAxVFRS?=
 =?utf-8?B?RGZrbjdyQWp4ZmxhZlM3TTBOdUgrUWtBQTZ6MnhER0xVTkdEUFVWSC9OMTR4?=
 =?utf-8?B?TEFvQks2eWlGQTFaS1QweWx4a0FuaVg0NGFzNkpQTnpVUHdabEM2WkkzZFBh?=
 =?utf-8?B?bit6ay9XWnJoRnRtNkZ6KytadGh0Ny9pSE1oSklsNVpJdnl2NVhpbi9lYXA1?=
 =?utf-8?B?M2YvRHRKZmxCTmpYeGNQOUZydmMyUkRCS2Y0SFA1bDFjaWcrcjdFcGZMZ01r?=
 =?utf-8?Q?n1b4iL4KLjJfZi4N6tnoNkpdU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896d00bd-7789-438c-6e2d-08da9fd3576c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:25:28.3266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDCzW1+SpaiE5ZmSgeTP6aIZyuAHjDYrZEsB3tSKRzShnxEt+jmUzLShZIkCKbcBKOtu8/kXZa9Jiv1oQF/Xwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/26/2022 5:19 PM, Christian König wrote:
> Am 26.09.22 um 17:14 schrieb Sharma, Shashank:
>>
>> Hello Christian,
>>
>> On 9/26/2022 5:10 PM, Christian König wrote:
>>> Am 26.09.22 um 17:02 schrieb Shashank Sharma:
>>>> Allow the user to specify a workload hint to the kernel.
>>>> We can use these to tweak the dpm heuristics to better match
>>>> the workload for improved performance.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   include/uapi/drm/amdgpu_drm.h | 18 ++++++++++++++++++
>>>>   1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>>> b/include/uapi/drm/amdgpu_drm.h
>>>> index c2c9c674a223..da5019a6e233 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -212,6 +212,8 @@ union drm_amdgpu_bo_list {
>>>>   #define AMDGPU_CTX_OP_QUERY_STATE2    4
>>>>   #define AMDGPU_CTX_OP_GET_STABLE_PSTATE    5
>>>>   #define AMDGPU_CTX_OP_SET_STABLE_PSTATE    6
>>>> +#define AMDGPU_CTX_OP_GET_WORKLOAD_PROFILE    7
>>>
>>> Do we really have an use case for getting the profile or is that just 
>>> added for completeness?
>>> To be honest, there is no direct use case for a get(). We have 
>> self-reset in kernel to clear the profile, so this is just for the 
>> sake of completeness.
> 
> The problem is we usually need an userspace use case to justify 
> upstreaming of an UAPI.
> 
> We already had a couple of cases where we only upstreamed UAPI for the 
> sake of completeness (set/get pair for example) and then years later 
> found out that the getter is completely broken for years because nobody 
> used it.
> 
> So if we don't really need it I would try to avoid it.
> 
> Christian.

Makes sense, I can remove get API as UAPI and just keep it kernel internal.

- Shashank

> 
>>
>>> At base minimum we need a test-case for both to exercise the UAPI.
>>>
>>
>> Agree, I have already added some test cases in libdrm/tests/amdgpu for 
>> my local testing, I will start publishing them once we have an 
>> agreement on the UAPI and kernel design.
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE    8
>>>>   /* GPU reset status */
>>>>   #define AMDGPU_CTX_NO_RESET        0
>>>> @@ -252,6 +254,17 @@ union drm_amdgpu_bo_list {
>>>>   #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>>>>   #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>>>> +/* GPU workload hints, flag bits 8-15 */
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << 
>>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << 
>>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << 
>>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << 
>>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << 
>>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << 
>>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
>>>> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)       (n >> 
>>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>> +
>>>>   struct drm_amdgpu_ctx_in {
>>>>       /** AMDGPU_CTX_OP_* */
>>>>       __u32    op;
>>>> @@ -281,6 +294,11 @@ union drm_amdgpu_ctx_out {
>>>>               __u32    flags;
>>>>               __u32    _pad;
>>>>           } pstate;
>>>> +
>>>> +        struct {
>>>> +            __u32    flags;
>>>> +            __u32    _pad;
>>>> +        } workload;
>>>>   };
>>>>   union drm_amdgpu_ctx {
>>>
> 
