Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0C4C04A6A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 22:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA4810E082;
	Thu, 10 Aug 2023 22:30:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B406F10E082
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 22:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5bkwfNe97oyGxFfT1l8zptZBJu//q9Vwj16Su3RaX+18qbXQbshxJ8QDFeotoA9cfEMiSB8JVlGVO9bW2esf8xI4HdrPFaQfUhaHLOXG7Xj4VGy7Vkfns8oM/henyHpsFo93mAVP5oi5AJqgemfLOB39RJbKaXsfFz5jQ94Y6/loWUlJFHfCaF8dIltcbw75JrbUeS8Ic7bClkHo9yg4Wb9DiL2nJndrhVDcN4TTU+IGf8uwutJa8aS0w6WArTRFPo6SdW9ShZ5r16wPvl6WgIbz7TlIcBolJ122rBVUFjM4d32+SgH2X8qN8VhKMRyZpETtLHjUy4T6ypqHk12cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoAM3G+Ug4Effyfo/b1MDSpThH+tgVzygrbXH/gSRsc=;
 b=fGMu0peiBnp2a0vpf/DfJ7LCQJEZkvF83SBnQZGddze7XErWur6pxDvKr+gJ40Y8sLB23yD1kzCgCsXT/cgC0ChPzCr92jUX4rnyQ9vjzLDxmcj/ke9IgDVtnlUj/QmH7FsSaz0r14YvJOFl9bsITra1MnDh/qVJ+17XOuYX7KXej21J5G9QtyiQcn/cgVlhmkhS7czE2Vuo1MnkUFlvxGwXZ3L8Lvg917GrUBm6TPnQ3DTJiF4LTVANq2UZoR6AmNs3OZOl0Cbeh2Yx3cfxcbu/T8u5OV5xDPjfGBaJkC27fTf80FIq2MQyhCGKxFhLBbLLXO++3KEPszzu66MdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoAM3G+Ug4Effyfo/b1MDSpThH+tgVzygrbXH/gSRsc=;
 b=G+VZjHq30tSSlz06/eUNAcTAd8PfiecvFmAxgZ+dVBl0DMmnLCOGXNMIDL6Bk1g67+i2R9Ccqf/ZbPT0oiM6H1+k+TdIfuk+CYcZvPha79jmGB9E9U/1mruhkmvKOObSq8Fn1kpMRJ7QrQMODruGbSEGhxi/6H0WCtnlGohK6kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 22:30:52 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 22:30:52 +0000
Message-ID: <c7430d1f-f17e-42dd-a644-53f9489be4b3@amd.com>
Date: Thu, 10 Aug 2023 18:30:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
 <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a6f589e3-4023-31eb-6df9-1118f48b39ed@amd.com>
 <aa5536b7-822f-3656-443f-46ac415659bb@amd.com>
 <CY8PR12MB7435457A27D5FADDB5B7D4578513A@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CY8PR12MB7435457A27D5FADDB5B7D4578513A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::22) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e36c49-0cb9-4a50-87e9-08db99f1744e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WhK3aPsMA2Nug6fXSEjGk/8ASSzrNehASY5r/ABKDc5jBykS5MRwmUTKB2S76dgOj+gE5AW7ib35vfafN8QPHwwCs6BIxg6JdbViHp3e5+hHBr7tQoVR1wQ9B/fcHoNHCelCiGDvN4jqZfuCvvtNezgyj1wPEYPVnjaCXyEFgPbIXxEuOkP0xE6tE6AhZya4FdpD1sNbljI5hdTXoDzVelyLq9MdL00hjXBId9qTMD9Rfkckd2W3kDfSj3IoNZBqxjaYIkddmQcV1mpm4jQKXAWH5T+rPQRwEpZoOCGrf3P4odBqdWhlZI+c0fLo7luj958JDt3hlwbuRKx9hNQr9Rtz0E1HEq+PgBZ76ED7x8ldh93F0YcYIsig5IoC6JsdZ7i1XGYuREuY0Q7qaBdlZdenQWlt6pju6wqtV1rXw9yQGVGVVC6miTHlJMdmL54wyd5sPV0Vw1TFF8Qp7y4RWxlwqRdB4GCXbeBUA2haRPUMZhVgoaYE6IdTmupEhqhgriwZoJkDmCrWK607sfGN56Ki714HjDzwd7UlXE/jrlTL1iT5PnTY99bUPYXHZB270KzNmpMUUCOl2tQilokNPcDW/G8L2aDmyy8zWLIsGAefoNvtA8PcBp+6GLW7ApvSHpKysMEAKRW6uM0q+AM/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(1800799006)(451199021)(186006)(66556008)(6512007)(6486002)(478600001)(66476007)(66946007)(5660300002)(316002)(6666004)(110136005)(31686004)(41300700001)(8936002)(8676002)(6506007)(53546011)(26005)(31696002)(86362001)(36756003)(38100700002)(83380400001)(2906002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajZFSThKWXNkUE1qUUN2OHpUNis3NnBKZWMvVDFvcHpWMEVIUys4TnA5eFNG?=
 =?utf-8?B?VmhuVnpBM1YrbUVab3lUYzdBWGM4Wk04cEhjcm9lNmhvczBMNSsyWkI4ZmVJ?=
 =?utf-8?B?aVI3b0ZCWGQzd0UrMU00T1dJaGR5M0dFZ0tnakw4eEpTZThnbHZMT2ZFNFhl?=
 =?utf-8?B?WHRTeXZteUkvT1pZMTVjalJ6Q2xDRktuU3dtZkpQRjBDWFBRWlpFdWJVa2py?=
 =?utf-8?B?Ym9ZU3V5elFyVXZza2l6MUdYbzcxekhwT215ZG1wNmRleDZHK1ZuUGJCRmhn?=
 =?utf-8?B?QWlVZnNEMU5vK3ViSkxPK0wybUxDNzFFZ2hsUG9vbWFLVUZnTHNKYzZCbVJP?=
 =?utf-8?B?bmVGSktVWFZpMGdReHo0UGVONXIwcThuTE1JWmlhS1I0ZjBsY01KMFpuZE1X?=
 =?utf-8?B?ZVQvczNrNnNHbm12V3REcWJqamVrK3ZwL1pocGt1bFg5UDNNUjgrNUxNMGQy?=
 =?utf-8?B?NnR0L2IyMmtYRFNQeFkrNm9SMXNGM1dBS2VTZFJBN1BHWU5ic0t4NkRsRFVY?=
 =?utf-8?B?OWJHRnJuUURLK0dSM29VMVNud1lOaXQxaFNPU0RqT1ZmZkJJMG5vYmRPYmVh?=
 =?utf-8?B?b2xBUFRFcVZaQkxRVXM0cGI4eWNhcWhaMGJLNFZ2UTBMc0lleFdFZHpKdmZ5?=
 =?utf-8?B?VlBwMVVQa1FpdUNPaVVZOURYdHQvV2tKWlg3dzBHcmRJeXRsVE5YeDA1N0Rt?=
 =?utf-8?B?QzR3NTVYUld2UEIvVXA2dmRMM3FYTjcwSXRldHp6WUFIaEtZSjE4ZWlDemF3?=
 =?utf-8?B?clB5TStxcnhCNFN6eWF4Tmw5QWdRUXl1enIrRzF5Q29UN2p4K2FZZTBKV2FU?=
 =?utf-8?B?Y1ZsVkV1cm1YOERRc2UweG9YN3luSWRjRWppNjQrWGNDWTVKeE9RODdYQkIx?=
 =?utf-8?B?SGd5MEdybDVKVm42a245eUt2azh2emxNOTJwQzd6b2hCVC9DeGdCOEFVT2Nk?=
 =?utf-8?B?ZU1Jell1VVRLMHlLemt2TEV6NDZFazZHL2JzbzlZc2VWSStQRFFpNHlWTWsr?=
 =?utf-8?B?aVlDUTFlTmlRclJFSGFwUmk4bXRNVUNUQ0djdjE3Q0ZoendHZjAxN0dTUGdn?=
 =?utf-8?B?MUJmYVBsTGN6dEVJV1hDWURSRkpHMG1RTmx3R1NHZnFnSW9meXZCbVBRenAx?=
 =?utf-8?B?aW1ZZXNmZ01Uc2cxNkJLTU02RExWbnFqWnM1RU5Pa2RBanhKZjQvaFlHeEh5?=
 =?utf-8?B?Tk0zLzFsdExVUHN5ak1ZSERXT2dJMFJIMlFvTERUa3ZDUS9zUWRRTk54OU5T?=
 =?utf-8?B?cUdoNXhWOTBlelhKVmc3d2dIMDVnVm5XaEw4TWF3MVNNSUpXK09NK2IwenZv?=
 =?utf-8?B?QlJEbWx5Z1lwVkhBKzY0NjNNSXEyZUZ3MjllNlFDalFkeDM2YmNLK3RSRzZw?=
 =?utf-8?B?Vko1VnhISE9PeFFSOUNBUFEwZnV2YllzSDBZMloxbnlYaUNPRjgwVjBwRVZN?=
 =?utf-8?B?NUNFbS9rYzMwWFlDVGE3YU5OVmpVaVMraE8xVm9yVmY4Q1JPM1ZuUU1EZGFR?=
 =?utf-8?B?bGpvT0RwSHU0RXR4bWFJOUNPcG1NaHRMdEx6VDk2bE9GQTZKTDNvV01WaEdq?=
 =?utf-8?B?cmFKNmRmM1FBdFdUd2ZTQ2tEYWNZUHVvaGdKUHlyM0IwQ093ZUFpL0VydXgr?=
 =?utf-8?B?VExheTQzcHBpazdmelpaMkczVEhqbGVxbFp2YTREUTgvL1YzSjdDWXhFUEdi?=
 =?utf-8?B?UjhLanlPc2h3QXJSSXBPc0xmMy9WVmUxekJ4TzI0QVZEYTdSaXo0L1pzQmNT?=
 =?utf-8?B?MzRHMEw1WHB3dVRtbjZCY3NTd3dYZHZSVDNsSVo2a1BjL2tFWVBOc2xKdnVG?=
 =?utf-8?B?NUxLZVlqQlU2dkZZdTFXZmJBRm5aQTVXMjk1cUg0UUcrYlgvTngzRHRGaWpQ?=
 =?utf-8?B?bE90KzJLTDZjblVWaWkwZytUTUo2NGgwWTdDaGZERUM0ODBQcnBkdG85K1hj?=
 =?utf-8?B?dHRSaWRBbmlWS2FINDFJVWZuS2FUbkNnanM4aEFKQ2NhL3JHT1FXOUtYWHBT?=
 =?utf-8?B?aXN3VDhUbHB0a0dmZ056ZXR4OTdxTFVWK3QyMkJYNmtTTjBLTUVMcnFldFQ0?=
 =?utf-8?B?cTRhWThiSHhUcWFjT2dFNFo2V1lsaEI5SVlNWXF0Y1IvWW0wVVA5S3ZxUmlB?=
 =?utf-8?Q?/mJJ9rcYqiJZSq9nv+a+QCxTr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e36c49-0cb9-4a50-87e9-08db99f1744e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 22:30:52.1608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW5wGJF3kCWVtR2XYwyrMtx29b0LBqP2YTIUKiLg7EkEafjpR/AVJUYi3b/wgTn4/61Ej5gryoVrCShb1AhOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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

I will change title to "drm/amdkfd: workaround address watch clearing 
bug for gfx v9.4.2". is it OK?

Regards,
Eric

On 2023-08-10 18:25, Kim, Jonathan wrote:
> [Public]
>
> Yeah this is a recent bug so this workaround is new.  More rigorous tests revealed this is probably a miss on the FW side.  We explicitly requested UNMAP_QUEUES unconditionally invalidate watch controls during the beginning of design to prevent any watch point racing.
>
> Note GFX11 MES calls are different on the surface but under the hood it's the same (registers get invalidated on unmap then get updated on map.  Only difference it's at the queue level).
>
> I'm fine with this solution but I think it'd be good to describe this as a workaround somewhere (as opposed to a driver issue) so that folks aren't scratching their heads later on looking at code for GFX11 and up and wondering why we don't nuke the control setting with the KFD for those devices.
>
> Thanks,
>
> Jon
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, August 10, 2023 5:56 PM
>> To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
>>
>> I think Jon is suggesting that the UNMAP_QUEUES command should clear the
>> address watch registers. Requesting such a change from the the HWS team
>> may take a long time.
>>
>> That said, when was this workaround implemented and reviewed? Did I
>> review it as part of Jon's debugger upstreaming patch series? Or did
>> this come later? This patch only enables the workaround for v9.4.2.
>>
>> Regards,
>>     Felix
>>
>>
>> On 2023-08-10 17:52, Eric Huang wrote:
>>> The problem is the queue is suspended before clearing address watch
>>> call in KFD, there is not queue preemption and queue resume after
>>> clearing call, and the test ends. So there is not chance to send
>>> MAP_PROCESS to HWS. At this point FW has nothing to do. We have
>>> several test FWs from Tej, none of them works, so I recalled the
>>> kernel debug log and found out the problem.
>>>
>>> GFX11 has different scheduler, when calling clear address watch, KFD
>>> directly sends the MES_MISC_OP_SET_SHADER_DEBUGGER to MES, it
>> doesn't
>>> consider if the queue is suspended. So GFX11 doesn't have this issue.
>>>
>>> Regards,
>>> Eric
>>>
>>> On 2023-08-10 17:27, Kim, Jonathan wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>> This is a strange solution because the MEC should set watch controls
>>>> as non-valid automatically on queue preemption to avoid this kind of
>>>> issue in the first place by design.  MAP_PROCESS on resume will take
>>>> whatever the driver requests.
>>>> GFX11 has no issue with letting the HWS do this.
>>>>
>>>> Are we sure we're not working around some HWS bug?
>>>>
>>>> Thanks,
>>>>
>>>> Jon
>>>>
>>>>> -----Original Message-----
>>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>> Sent: Thursday, August 10, 2023 5:03 PM
>>>>> To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; amd-
>>>>> gfx@lists.freedesktop.org
>>>>> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
>>>>> Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for
>>>>> gfx v9.4.2
>>>>>
>>>>> I think amdgpu_amdkfd_gc_9_4_3.c needs a similar fix. But maybe a bit
>>>>> different because it needs to support multiple XCCs.
>>>>>
>>>>> That said, this patch is
>>>>>
>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>
>>>>>
>>>>> On 2023-08-10 16:47, Eric Huang wrote:
>>>>>> KFD currently relies on MEC FW to clear tcp watch control
>>>>>> register by sending MAP_PROCESS packet with 0 of field
>>>>>> tcp_watch_cntl to HWS, but if the queue is suspended, the
>>>>>> packet will not be sent and the previous value will be
>>>>>> left on the register, that will affect the following apps.
>>>>>> So the solution is to clear the register as gfx v9 in KFD.
>>>>>>
>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-----
>> --
>>>>>>     1 file changed, 1 insertion(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>> index e2fed6edbdd0..aff08321e976 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>> @@ -163,12 +163,6 @@ static uint32_t
>>>>> kgd_gfx_aldebaran_set_address_watch(
>>>>>>       return watch_address_cntl;
>>>>>>     }
>>>>>>
>>>>>> -static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct
>>>>> amdgpu_device *adev,
>>>>>> - uint32_t watch_id)
>>>>>> -{
>>>>>> -   return 0;
>>>>>> -}
>>>>>> -
>>>>>>     const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>>>>       .program_sh_mem_settings =
>>>>> kgd_gfx_v9_program_sh_mem_settings,
>>>>>>       .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>>>>>> @@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =
>> {
>>>>>>       .set_wave_launch_trap_override =
>>>>> kgd_aldebaran_set_wave_launch_trap_override,
>>>>>>       .set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>>>>>>       .set_address_watch = kgd_gfx_aldebaran_set_address_watch,
>>>>>> -   .clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
>>>>>> +   .clear_address_watch = kgd_gfx_v9_clear_address_watch,
>>>>>>       .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>>>>>>       .build_grace_period_packet_info =
>>>>> kgd_gfx_v9_build_grace_period_packet_info,
>>>>>>       .program_trap_handler_settings =
>>>>> kgd_gfx_v9_program_trap_handler_settings,

