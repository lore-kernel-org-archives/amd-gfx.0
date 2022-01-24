Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F72C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D54989E3F;
	Mon, 24 Jan 2022 17:07:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022B589E3F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GizPccgKDq0k2ndUDJGDQQKUFD01Op76piLIeEzMHYyxd0Q73ncNQ4EF+8VOxnqUxNeSFsV2DE9ds0nem2jK3+hs26rD33Xjle88ro2V7hjP/OqV72QTETfLBz1qhd2nIYw7of1pbN1YesE5vsqIhMsUufG6fLlHbN4o77lqEc6PrSRqje+q1GFs/zPnRDWm3GclMXNxMoRcY8Q7XadvslC4zIqJVlnuGL2HGEln5OT0nQ7qRdudbyyA0NWv8fW7zGolEFmjrcptVJGAGgPIPAv1dkiIeQT4E3Lfe/JTzgSBSMVMIcwfTNbPhP7BPIEL102vVSX5PGGzXuvbNVu5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLr7zv6UXAHKjFKobWhF5q8szeJnkHxYA4k1I3MOTpY=;
 b=ceWXdVH7996hy8LH03GqtI0luN49zfolE1ZHBxoF3+I3GdMTVxrNzHHJ36viKx37nGJiSFIOuslqAcUpzZoCnRGnuqgh5JNzoTacvyFdispFSq4YvzdZWnE7L5rE2rr3fXyw2dAUKjGn0+SIXfiaiJw+xD0V4W5v2QMGy95rWv1lZysBMQvjRoHYcG3Fn5McO2mvHmln0eNRjouPqxGV3Oep36Vt0rRN/B360AyGa+LI1u7d9gv0QiFJ4IC23qHBhkllfcGxfn9Tki08U8l9lhIsXTDWo0pxa0dSX1URwBweE89Cb269yRuql1143+XLDcX/WOBJMopBb1nRo1la5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLr7zv6UXAHKjFKobWhF5q8szeJnkHxYA4k1I3MOTpY=;
 b=bcDWt9uXOJxSV0/jv44B0VQXB3hHcJk1Op/73L7zyaVvVGmu5B7BZtezHojoZ155nyTx/H33SqlONJE92c6cI2SjAaO2hjuzhwDRTxMByRixw/4QH25/NJW2dnGwRn4PT5P0t1wZUqJX5/hCmxtRkzl50Vx79Q75IuhuwaEfziU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 17:07:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:07:29 +0000
Subject: Re: [PATCH 3/4] drm/amdgpu: add reset register trace dump function
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <ba6e97b5-17e0-819a-fb2e-5c4515995156@amd.com>
 <fa8d13a4-ccbe-6e8c-5c97-9c4d7f1134f6@amd.com>
 <26aeafd9-307e-f8de-501d-5efabd67a450@amd.com>
 <c47c2450-7008-4419-795d-f9e6be64061a@amd.com>
 <f2211cf8-f159-9668-7e3f-7587063ca075@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4f75535f-d909-8418-00ba-97cb559812ec@amd.com>
Date: Mon, 24 Jan 2022 18:07:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <f2211cf8-f159-9668-7e3f-7587063ca075@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR0202CA0046.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f611ae99-c36d-4d59-60a3-08d9df5c0074
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2540D429EAFD7C71F75895CF835E9@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmJKlWJFzZGlC4pL7/dygTVkRkE8SqEl60l9w8sBQcmZhB5Eyo5RV57yrdARa/2P4YTjUjZSn3zsMQIrMYqk1hlKbTic0c3YbGdt7mr3xJ2N4i9LBYpkdaKgTqxN7AwTgH0RzAXPabQsYAAPzg9ikbOxnV15S6TCbpRsun1BrTdBP/EVbpWY9MHwf0vAW/+jZQmHoE9f9ulGKvb/JTiq1Zu7BtuwQJSJRIysQd8rz3z1uBcuTPobM59XFJA8ElgIuLJHLusEpqJVqW2Q+OebwMsVpi6WiJpXDYnee1v+1nw8cNCRwB1N2Q5t+TDBcgiPNxbQa+ZxBiUjdA3ND/b+7fNY2PcIAsNlxlUH9yDzwt5F1a/KHFPQlvyz7Y833aws6v8tvkP0aOtj+QrP8RoO6ngkGnGCA9Re5Np3XF/E2XTYvzaBF1hZkRrMol8HqNDFWrq0Q/cVQzf8oelY5crP/jgZ54kezvkrOlSjQssfaHUsE2tSuEkrrXdvvyL6DDSq/iHkc6dWe5aIZMZNIBOA/b5+L9pxB4/pW1rz0+0zNuqANfTDdm313a+Q3TfYyMjFvEZgwDaPZgWoRG10hfi2WnS/eMHyTpwshtkrjthyzEMh/abpECNwkqfOwzoI7zjRUB/vdj4X2/e+usFqtK8IC/Go4OObW1BX9s9igB/5DkEmItWTETNCIcJVXTfy0Nl7iJdJJEKKZ/fhsnX4WLrt+/u9ihUp1PeSZdlvrcy84DI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(36756003)(6512007)(66946007)(66556008)(5660300002)(31696002)(54906003)(66476007)(2616005)(6486002)(6666004)(31686004)(38100700002)(83380400001)(186003)(2906002)(508600001)(53546011)(6506007)(8676002)(86362001)(8936002)(316002)(66574015)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1o4bmxLeDV0SHlrUU9OcURGN1BmNVUyYlpoWTNRaDVtRVBZa0dwZkpHenhY?=
 =?utf-8?B?WGVZM2xvUm8wcnNDRmc2bFQ2SjdXZHI4RTczUW9OUS8xWlprZ2wrOVdnL1VS?=
 =?utf-8?B?U1hBeEVDODZnby91SncrMDAzYndHYTN0c0dyV3BQa3NRTHEwZHozc1BpTnRl?=
 =?utf-8?B?b1VweWR6L0w1TjJock91cHY2bzhaUWl1M2p1Syt4L1RmZFVScHJwVkIydlpn?=
 =?utf-8?B?em4xa3U5N09FV2Q2eVJsYTJINlJqa0JPdWtEd2tWU1JCZWQrcWo0d2VOWmJ6?=
 =?utf-8?B?enFrUDBkbjM5SXVUK2pURlJ0TTZFeWp6djhySjhmSURwcXpzZ2djSWliQi83?=
 =?utf-8?B?M3NoYzFVdjFnU2lEam9sYVh4SmQyZHU2T1lwMzlHQnZvTUYzUkpjWmZhcFlZ?=
 =?utf-8?B?MEVDamZxZDdzS1N2UGNrRzczcGdDZm1iWDZwbjQ3R3ZwczhvRFN3bGpFWHFZ?=
 =?utf-8?B?UVpOb3JWVEpRWlgvK2FXb1pwK09nM3ZXbzRPQzBhTlF4anlmc29oN2Rpb251?=
 =?utf-8?B?WWpYalQwOEdrWVo1aXVHMUxXeG9pVXdhRGIxdG1oZGZVSzZsR1ozTHVJWDVa?=
 =?utf-8?B?Q1FmQ2FUbXNsRHBCUGhsRllPSlNmSnRzVHNBYjFGVGQrRXYvQlhLRDlEMlBp?=
 =?utf-8?B?bU1lZXBaK3dmQVFjM2IvY1Zkamo5eHhsN3Qra2V6cm1Pdy9ZcVlzWGVHSTkw?=
 =?utf-8?B?RG83K0xFb3FsYVFMajh0OU5selNuWjQzSUJYYlZkcXVrZEE5M3YzRENMdVR2?=
 =?utf-8?B?OWFzY3pyeCsyMm0zVExWQVhuS2Y1RHUwRzlaNEdRRCs5dGt5MGJwSW5tTG02?=
 =?utf-8?B?MWV0eUhpU3JJdzZ1NERQUXRwUVBWSUxzaHBjdkE2ZDlZVjdDTHNMeURjMGJK?=
 =?utf-8?B?alMzL3A2ZFdnNWJua2JDYU14dGVKbE94MVRraHhDVDcwUGdRbWdtZUR5a1Av?=
 =?utf-8?B?VmRaVklwb3JXQlZEcVlBMFVjeFZEbTNDYXNHOVBna2NJQklBS1FGL1VudVBz?=
 =?utf-8?B?RlM5cXZ5TDhoS2crZFNxK2R1YU5EWkU1Tzh4Kzhhd3J4ejZpZG1YeE96ZmtL?=
 =?utf-8?B?S251ZlAvaWpSVHUxdVdQK1ZoYTlFS1FUQXduMjBieWNDT1RiajF6SkZZdDVX?=
 =?utf-8?B?SFRnQjRDTHcyeUd1ZEF6SjNoV2I2NUNzOGZ1L1lHcnVoTzNEVGVFVGR6VXFO?=
 =?utf-8?B?MlkxT3ZKNTcvVk1jZjh4UTJ2QTFxUGh3N0hhcEtjNk1QVlFoMGZ5S0h3d05i?=
 =?utf-8?B?YVRSckQveUo2NnlmR2xtQkFLQThtbHFidHRSQzVGZWwvb2dtZVVHN0pNSGJ2?=
 =?utf-8?B?OEdyOWJCY1BBeHc2UFdPZGkwZ093S2FoTk1iWUdyS0hML0dJckVGVlNiUERk?=
 =?utf-8?B?SWNyZ0ZuTk5MVFZMNWhFeHhac2MwdjVsTFBSRndSRndvNHpqcjFwSDZKaGQ0?=
 =?utf-8?B?aENPcEdrUGV3cVdNOGNESytPUENIWG5oT0w5NkRnazFXdUZQTEtXWFpESzli?=
 =?utf-8?B?NDZlaEdDUlRLY3JCeXU2ZTVVWE5aSkR0QjFNMEIyK1kwZHltdkRMTTlERXBL?=
 =?utf-8?B?UUlCNC82UkVyN05qR0d2KzNHMk0vOG44Z0pveXl6L1B4NDdLUVEwWlpyaVlF?=
 =?utf-8?B?UWdxZGRBaFB6N0lNRnBLUUovV2pXanR3SjQvT1VqRjR3bk9VV3hwMFNkb2ly?=
 =?utf-8?B?ZHhJbG5pOFZibWFjL3pyeHJVZEU1UHpOTGk0N2JHQmFta1BMVitTZDhOcFU0?=
 =?utf-8?B?NTdQQVdmTDRGZm1veFJ1MUVicDB0SmNTd0x1bmxoOFludVJKbjVYSGNha0px?=
 =?utf-8?B?b0o2WEJCYmcrSWs4LzUvSGVoaWZrQnFyWGlSYitXYjFPRWRZZ3J2dTRIeGdx?=
 =?utf-8?B?UVgzN3FuanlrSDBPNlU5VHdtMmJGVm54dVRsNlhURnNpZkxEdFdQaTVIN0lm?=
 =?utf-8?B?U3Q0cG92TjBQMStIekZTRk5VdW9vTnU2amZCdS8weDYrcTA5cDdkSW15b3k0?=
 =?utf-8?B?M29TaWNUNTkxcjVpMG9TYVVwNDdaTUxjRlEyK2RGdnBLSTM1NTlOb0VIczR6?=
 =?utf-8?B?UHFKeW5UMm1UYVpEUEovVGZWQjN2ZGlBVGJLb3U3Tnd4RE9mWDN2OGY3RERq?=
 =?utf-8?B?eGNKbmEyZTRvdFYvM1JEMjhGVkJXeGNwTE91aTZMSHJxdWVmMkxZZ3lHZ0FR?=
 =?utf-8?Q?BWnUmhQJ6GbXuikLFRG21JQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f611ae99-c36d-4d59-60a3-08d9df5c0074
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:07:28.8654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QlqcsFphSAZGWaZIhmd+LCxMo7KK2a1wBegbVJJ44lsV/+agPNSDux1JvZW/VMk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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



Am 24.01.22 um 18:00 schrieb Sharma, Shashank:
>
>
> On 1/24/2022 5:48 PM, Christian König wrote:
>> Am 24.01.22 um 17:45 schrieb Sharma, Shashank:
>>> Hello Christian,
>>> Thank for your comments, please fine mine inline:
>>>
>>> On 1/24/2022 8:15 AM, Christian König wrote:
>>>> Am 21.01.22 um 21:34 schrieb Sharma, Shashank:
>>>>> From 1c5c552eeddaffd9fb3e7d45ece1b2b28fccc575 Mon Sep 17 00:00:00 
>>>>> 2001
>>>>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>> Date: Fri, 21 Jan 2022 14:19:10 +0530
>>>>> Subject: [PATCH 3/4] drm/amdgpu: add reset register trace dump 
>>>>> function for
>>>>>  gfx_v10_0
>>>>>
>>>>> Implementation of register trace dump function on the AMD GPU resets
>>>>>
>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  8 ++++
>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 53 
>>>>> ++++++++++++++++++++++-
>>>>>  drivers/gpu/drm/amd/include/amd_shared.h  |  1 +
>>>>>  3 files changed, 60 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> index d855cb53c7e0..c97b53b54333 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> @@ -537,6 +537,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>>                __entry->seqno)
>>>>>  );
>>>>>
>>>>> +TRACE_EVENT(gfx_v10_0_reset_reg_dumps,
>>>>> +        TP_PROTO(char *reg_dumps),
>>>>> +        TP_ARGS(reg_dumps),
>>>>> +        TP_STRUCT__entry(__string(dumps, reg_dumps)),
>>>>> +        TP_fast_assign(__assign_str(dumps, reg_dumps);),
>>>>> +        TP_printk("amdgpu register dump {%s}", __get_str(dumps))
>>>>> +);
>>>>> +
>>>>>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>  #endif
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> index 16dbe593cba2..05974ed5416d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> @@ -46,7 +46,7 @@
>>>>>  #include "v10_structs.h"
>>>>>  #include "gfx_v10_0.h"
>>>>>  #include "nbio_v2_3.h"
>>>>> -
>>>>> +#include "amdgpu_trace.h"
>>>>>  /*
>>>>>   * Navi10 has two graphic rings to share each graphic pipe.
>>>>>   * 1. Primary ring
>>>>> @@ -188,6 +188,12 @@
>>>>>  #define RLCG_ERROR_REPORT_ENABLED(adev) \
>>>>>      (amdgpu_sriov_reg_indirect_mmhub(adev) || 
>>>>> amdgpu_sriov_reg_indirect_gc(adev))
>>>>>
>>>>> +#define N_REGS (17)
>>>>> +#define DUMP_REG(addr) do {                    \
>>>>> +        (dump)[i][0] = (addr);                \
>>>>> +        (dump)[i++][1] =  RREG32_SOC15_IP(GC, addr);    \
>>>>> +    } while (0)
>>>>
>>>> Those macros need an AMDGPU_ prefix and maybe some better names.
>>>
>>> Agree, @Amar pls check this out.
>>>>
>>>>  From the design POV I'm really wondering if it wouldn't be better 
>>>> if userspace defines the registers we want to dump in case of a crash.
>>>>
>>>
>>> I am not so sure about it. This means we have to communicate with 
>>> the userspace and get the list of registers it wishes to see, do I 
>>> smell a new IOCTL or DRM property ? I also feel that we have better 
>>> filtering tools for a trace event in userspace than in kernel.
>>>
>>> What do you think ?
>>
>> Just a writeable debugfs file should probably do it. We have a list 
>> of known registers filled in during boot (just reg offsets) and 
>> userspace can read/write the file to update it.
>>
>
> Ok, so in this case, what would be our state machine ?
> 1. gpu_reset happened
> 2. uevent_sent from work queue
> 3. userspace goes and writes into debugfs files
> 4. kernel collects the desired register values
>
> 5 (a). kernel send the trace_event with desired values
> 6 (a). kernel sends another uevent to indicate trace_event
>
> Or
>
> 5 (a+b). kernel loads the reg values via debugfs itself.
>
> In both of these case, wouldn't it be too late to collect register 
> values by the time userspace list arrives at kernel ?
>
> Or do you have a better state machine in mind ?

1. system boots, kernel loads a default register list to dump.
2. Userspace optionally updates this register list.
....
3. GPU reset happens, we dump the registers into the trace log.
4. We send udev event to signal the GPU reset to umr or other tool to 
save and store the trace log.

Regards,
Christian.
