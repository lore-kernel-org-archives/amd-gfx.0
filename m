Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1C4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8ED10E407;
	Mon, 24 Jan 2022 17:10:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94A010E387
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGwsjThicEbj138uf4JxbLW75zIfVsIrY+7gS0OGwylKQ+FRy7oeZYySc9K0XPg9TxxRqa6Y10qjYcJ9kzU6cjctGCSYLDIdQc9XyPKNfge0OuOY1byb+wm806/7ucnJeb8WQmOlaQPhDOTvkPmlJw1x2Wv6bITaEgjDpBFcOyLj7M+R1caH4J/xuZQjfNDwMn9+q/PtXaal6I/KOuk+movmYsV+Pxot7peTepN0OL+h7EB6U8MVrgXdE55388gJoIJRHGLCvwZwAHoWcfq8VGp84IlKF0orNfsjti8x1XCZOocrlaA0PxUfsYIV9DIaYlICab8kBnK0bXwJipIBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5BBFaJoCFAirG8v7f8nxSGPjd0fudIfTR9i36Com9A=;
 b=ZC7f0GjlEoNnumqGc7GMDZRCWl0vG2yN1ow9EQuGUrEdbscK+JpsWtXpAD4u2uNdH5xE4Ol+s+MaULqMTx2OWrcUzGtNeV8WzF48ccQ2dkiLqa9EVof2I6rjz+j34+cAzUPBhCcSij4R3a26TulgPooXEI+AjLv10BaHScKKSX/rABmHs3D9BWYrAyqsHCsV6sfohW9VEbNNwLUbwrSHbYPevgc5VSaWUnNGnSQ+SNGji+19aNB/yt0Rdzs10HfUBCpUgT9WxJyjudFI0iw4rFKsFrIylbze5WnPx/7c4Bmrh3is7HpmMMBUGJvTYAUxqYDqXfPFuF+cbWnBXcJ0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5BBFaJoCFAirG8v7f8nxSGPjd0fudIfTR9i36Com9A=;
 b=kpMJ5eGwdp0RXs/paT9puQj8+rrOP67bkVxsyyVLuVsvX5tmKhMDls5CjfNA1vVyCL2RJnYvXBmjuSzlTfu4/p0OUxePXZW1lQqajItzLjY+xc9EEBgQM09DTY6o7XvKsUTdfyWDJPi28ZGXd0UCJWmsjcTJM6kaEqSq3ye7BvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 17:10:18 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:10:18 +0000
Message-ID: <5d557607-1047-9785-26d7-8e9fdfaf664c@amd.com>
Date: Mon, 24 Jan 2022 18:10:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/4] drm/amdgpu: add reset register trace dump function
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <ba6e97b5-17e0-819a-fb2e-5c4515995156@amd.com>
 <fa8d13a4-ccbe-6e8c-5c97-9c4d7f1134f6@amd.com>
 <26aeafd9-307e-f8de-501d-5efabd67a450@amd.com>
 <c47c2450-7008-4419-795d-f9e6be64061a@amd.com>
 <f2211cf8-f159-9668-7e3f-7587063ca075@amd.com>
 <4f75535f-d909-8418-00ba-97cb559812ec@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <4f75535f-d909-8418-00ba-97cb559812ec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c350b088-a6db-488f-7a93-08d9df5c6577
X-MS-TrafficTypeDiagnostic: DM6PR12MB3355:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33559ECCD7C741E12610B967F25E9@DM6PR12MB3355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tg1NcPEpVbIMW4N3i8N1HxcViVjkycTMEuOFkR191Z3oUmhvggcCY6U2BGcvZUqac13LMt+T0e1ZCynRGZZkTJIEuhaO6rpcU1GrYQGyp1EAddHLf0FGypNtO0GnAlHuLjGeSyQv7CfISsPoNOHFbkyPAZWe56hapum+4DzSrc8JJZxACthdQlBQRyFVrZCJ3uQHrb7sRPdIU2lVhjuWBL7EY6x9xq8pZy6SR6jjwZnNMx5Rtk3KnmfmpBii+93eScIcTfBoEXQlCMsM/vwjH64/mBBBjcNddLG4mEY+hmow0CNbxMJ0H4CycVOYMJSD80wHekO2MCgJuleP63L7Ep82E+4fi8/zqA40Qw58tLzSlEIiZ0Ag1h1Wzkij1K7hR8wNTeBBeJWXxJfiMxsM4F2j7jVaz6rb7x/Zf9k6gcPrOUEdKcmVSsUxy7yedL/9aNmOGQMM2Nn27a54pXGumNp7OK474zkFuXyg0ybrQwP8xiZ9xwiQZe8f1of7TaqwBMuIXHYkeSpnSlji9rG2M9ehHOLJi6DyJCQw46ZLvTZ4FzWL5ez/ZW4hRtxLp3p2fzec3bE9+xISftvQkQMSgMBJ/ICA34TwowYFC+FLiVZnMPYu+Y661vT6ZQ7bvc3IO3kESIx6Tsmkv4aEps0jBj/RfeM4veYi43SLKDVKStJzFgTWwYuwQX1PdEwJlUiTK98Zs8dMzrOPVXr9o6hUeQeI0L1A/fIkzn9iKw8QBYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(8676002)(2616005)(8936002)(66946007)(54906003)(6506007)(2906002)(66476007)(66556008)(508600001)(6486002)(316002)(6666004)(6512007)(86362001)(66574015)(38100700002)(31696002)(53546011)(83380400001)(5660300002)(31686004)(186003)(26005)(4326008)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zjl2dUN5YTlDSjFCbm9leGdVRjhTM3RZNVQ1ZmNjY1FaL2FHSFdwSHphMy9J?=
 =?utf-8?B?dmcxTUsxdDJkWC9PNFp6TjF1T0dObjF5bE1KU1NtQ0tsK3pQczFGQUNNdXJ6?=
 =?utf-8?B?dnZTODI1U2pvNHlqL2pDdExaQTllUEMrS2p3OUxNQnpmVVVrd0JFREo5blhL?=
 =?utf-8?B?dWtyckRrTVlIVUMraWpuM0Y4RlkxMHVQaWEvZUhmNHZBMWp2QnVON2NmNGs1?=
 =?utf-8?B?UG5FMFloNVRKMWlpb1EzMlVoSmgzVGZ0N201RC84WndGbDdaMDd0Nk5jbmlZ?=
 =?utf-8?B?Nmp5TXdzUVphRHZTaUZBYW5kbC83cW90N0VlcDJJZ2JpYVprZ0t4VUIvOWtJ?=
 =?utf-8?B?MVBLdHVhS2FUU1QzVFR6SG5HMjNyRENWQmhaa3V6NUxzVDZQclN4QVhmcjJ1?=
 =?utf-8?B?ZkVaNWFPQWhSalJ3QnVLN3lHaSs0MnJiTzFLY2pZRDhER2lkSHZSOEs4N1hZ?=
 =?utf-8?B?WktJQlJkWmFWWkRQZFNvOUZMRkJQL1lRbWNhcWU2bys4c3FwOHJUYXhNSXlh?=
 =?utf-8?B?OURRTFhPazVWeEtyamVKaG4zekF3d29TNE1Iek5JNEo5ZTk0OEp0VVlRaXFz?=
 =?utf-8?B?ajhLaHhRNkdYNFBrYjd0TUFUMWJkbXJ1NS9LNmZvcFVXUWp1Yno0SHBhUlhO?=
 =?utf-8?B?WW5kTFhZQ2R1TldOZFBwcVd3S2R3cWVieFVZZFlLdDVrZUpZZHlUam16QjJo?=
 =?utf-8?B?TVZ1VlZJWjhKc29iTHdndE5ZeUxhMHlEM3N1WkVZZUxvTktiT0RtcE9IK2FE?=
 =?utf-8?B?YzJMZ3NOWkUrQWxUYWdIc0hnS25XNGxLRXFYOVBpdnZ6bm5LNG05REVKM0Nz?=
 =?utf-8?B?a0l1TDNNanYvbTN2YmhSeWhNeVpLbjc0MjV5eS8yOVdCemdkTFVmMmFlMUQr?=
 =?utf-8?B?VmFSS0g4MlN1ak1JRWE4RzZ2ZW45bnZDc01HYnJjalVuUGltdFVMY0t6Qy8y?=
 =?utf-8?B?ZU1YVkg3RTViS3pxeVVDQWdjK3NERmk3dFBJZWs4UjBZYWtIQUhCTTZhQUlX?=
 =?utf-8?B?TitkY1BpN05EdlNzOWpXY3FxMndkOTFIR3grcS9hMFpLTG9zN2J2eDFrMktn?=
 =?utf-8?B?WGg4L0lTUHdhekh5UFlXTXQ3dUgvY2hXRlRncy9nQlExelJBTm54Njk4TVAy?=
 =?utf-8?B?d3lzVUFkTGg0K1ZYdW44Zy92eHR4aWdtZzhJeUx6UCs2aDRCaWlzSnJ3cTUr?=
 =?utf-8?B?RkFhV1R0T0Ztb1FxMGV3SmUyY09Uc0dub0Flazl6MUFTNDhIV1JtdVJ2K0I1?=
 =?utf-8?B?OFE0SlRQbVRVMmRUTzZScVYyTVdORHRlNHV5OUI4MVB0dFFCdTJvWkJKUVBM?=
 =?utf-8?B?bjdLbjdiaE9JOTJjb0dUZDNPQ0pGUnhoMFI1T2pOOGJZNWtIcXdpNk4vS1po?=
 =?utf-8?B?dGFLQ2pBdUlWSDRWb0F3aHhFOE1raGxMTU91UWJrcnNPNlhTbUFaUEcrM1dJ?=
 =?utf-8?B?Q3FjcjBKcXNLbUdDVmN1V3VsM1ducEtuREtYV1pUTHNObHZySUtZSWYwdWcw?=
 =?utf-8?B?UE9rcll5UDdSS3F2Q3FBK3VkNkZMcDlzdS91bjgveitkSjNjTndXcWxRc25Z?=
 =?utf-8?B?dTdINFBKK245TGdjNmdzSS9uczY3K2RtZmUzR2dZWkVmNnp5S0grWHNLUi9S?=
 =?utf-8?B?QzdQOUdCM0xKVUhsc21RMXN1dWx4dXVIQm5aQUVDRnJqRFJXYmxWNWprWFU3?=
 =?utf-8?B?N2d6QmJHY0RoSXpMYzB6bWprbkI4cjVhRXhnSnBrL0RZM3Evd3BYdmpzb1cx?=
 =?utf-8?B?Qm5jSFBFWFdkTjdlaU4wRWttMkcrNVpFUlFFdEl0KzBGUThaTmM5ZG9UbUxs?=
 =?utf-8?B?MUZnTFcyUlFZK0kya1dORjZyQlpCQm5TcmY4S2VQYzBwK2NGb2J1U3BxT2xv?=
 =?utf-8?B?azN3Skg0Njhtay9yQmhFOHhab3FQaW5xWCtUS2ZEQ1ZYS2d2NndHeFM3bHVN?=
 =?utf-8?B?eDJRdThmMS9MVndZRWJHNmtFQWtDMmU4cnNJQXMyQ2hFd2I3K3dYV2cvc0Nu?=
 =?utf-8?B?SFBzdC9yTVhkbENYbitoYjZOUDMxMkExN0pQUlBjeUV5Q0k3Y2lRV2plN3ZS?=
 =?utf-8?B?Q0lCOHpNaUlYdDQ0UzZGUEVnRFVOZWQvY3ppZ2JMNTRNcU5HR3IwOVMzZEFO?=
 =?utf-8?B?RmxJSEoxQVF4TFNLUklHcDY0MmpHQWNwakdaL2xpbjNNZkpUYnBoOHczQ0Y0?=
 =?utf-8?Q?D0Lmt0E1R6qczlcy9o+ZqvE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c350b088-a6db-488f-7a93-08d9df5c6577
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:10:18.4137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQNclPXKcA9Q6VJmI5DPXNUaniPvf3CfSh0/1cHNl1lNpGX3y2h8XXQoNFiqq+AIrxTsCByCCMvYNzpFUTWDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3355
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 6:07 PM, Christian König wrote:
> 
> 
> Am 24.01.22 um 18:00 schrieb Sharma, Shashank:
>>
>>
>> On 1/24/2022 5:48 PM, Christian König wrote:
>>> Am 24.01.22 um 17:45 schrieb Sharma, Shashank:
>>>> Hello Christian,
>>>> Thank for your comments, please fine mine inline:
>>>>
>>>> On 1/24/2022 8:15 AM, Christian König wrote:
>>>>> Am 21.01.22 um 21:34 schrieb Sharma, Shashank:
>>>>>> From 1c5c552eeddaffd9fb3e7d45ece1b2b28fccc575 Mon Sep 17 00:00:00 
>>>>>> 2001
>>>>>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>>> Date: Fri, 21 Jan 2022 14:19:10 +0530
>>>>>> Subject: [PATCH 3/4] drm/amdgpu: add reset register trace dump 
>>>>>> function for
>>>>>>  gfx_v10_0
>>>>>>
>>>>>> Implementation of register trace dump function on the AMD GPU resets
>>>>>>
>>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  8 ++++
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 53 
>>>>>> ++++++++++++++++++++++-
>>>>>>  drivers/gpu/drm/amd/include/amd_shared.h  |  1 +
>>>>>>  3 files changed, 60 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>> index d855cb53c7e0..c97b53b54333 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>> @@ -537,6 +537,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>>>                __entry->seqno)
>>>>>>  );
>>>>>>
>>>>>> +TRACE_EVENT(gfx_v10_0_reset_reg_dumps,
>>>>>> +        TP_PROTO(char *reg_dumps),
>>>>>> +        TP_ARGS(reg_dumps),
>>>>>> +        TP_STRUCT__entry(__string(dumps, reg_dumps)),
>>>>>> +        TP_fast_assign(__assign_str(dumps, reg_dumps);),
>>>>>> +        TP_printk("amdgpu register dump {%s}", __get_str(dumps))
>>>>>> +);
>>>>>> +
>>>>>>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>>  #endif
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>>> index 16dbe593cba2..05974ed5416d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>>> @@ -46,7 +46,7 @@
>>>>>>  #include "v10_structs.h"
>>>>>>  #include "gfx_v10_0.h"
>>>>>>  #include "nbio_v2_3.h"
>>>>>> -
>>>>>> +#include "amdgpu_trace.h"
>>>>>>  /*
>>>>>>   * Navi10 has two graphic rings to share each graphic pipe.
>>>>>>   * 1. Primary ring
>>>>>> @@ -188,6 +188,12 @@
>>>>>>  #define RLCG_ERROR_REPORT_ENABLED(adev) \
>>>>>>      (amdgpu_sriov_reg_indirect_mmhub(adev) || 
>>>>>> amdgpu_sriov_reg_indirect_gc(adev))
>>>>>>
>>>>>> +#define N_REGS (17)
>>>>>> +#define DUMP_REG(addr) do {                    \
>>>>>> +        (dump)[i][0] = (addr);                \
>>>>>> +        (dump)[i++][1] =  RREG32_SOC15_IP(GC, addr);    \
>>>>>> +    } while (0)
>>>>>
>>>>> Those macros need an AMDGPU_ prefix and maybe some better names.
>>>>
>>>> Agree, @Amar pls check this out.
>>>>>
>>>>>  From the design POV I'm really wondering if it wouldn't be better 
>>>>> if userspace defines the registers we want to dump in case of a crash.
>>>>>
>>>>
>>>> I am not so sure about it. This means we have to communicate with 
>>>> the userspace and get the list of registers it wishes to see, do I 
>>>> smell a new IOCTL or DRM property ? I also feel that we have better 
>>>> filtering tools for a trace event in userspace than in kernel.
>>>>
>>>> What do you think ?
>>>
>>> Just a writeable debugfs file should probably do it. We have a list 
>>> of known registers filled in during boot (just reg offsets) and 
>>> userspace can read/write the file to update it.
>>>
>>
>> Ok, so in this case, what would be our state machine ?
>> 1. gpu_reset happened
>> 2. uevent_sent from work queue
>> 3. userspace goes and writes into debugfs files
>> 4. kernel collects the desired register values
>>
>> 5 (a). kernel send the trace_event with desired values
>> 6 (a). kernel sends another uevent to indicate trace_event
>>
>> Or
>>
>> 5 (a+b). kernel loads the reg values via debugfs itself.
>>
>> In both of these case, wouldn't it be too late to collect register 
>> values by the time userspace list arrives at kernel ?
>>
>> Or do you have a better state machine in mind ?
> 
> 1. system boots, kernel loads a default register list to dump.
> 2. Userspace optionally updates this register list.
> ....
> 3. GPU reset happens, we dump the registers into the trace log.
> 4. We send udev event to signal the GPU reset to umr or other tool to 
> save and store the trace log.
> 

Got it, let us rework in those lines.
- Shashank

> Regards,
> Christian.
