Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C101EC624B4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 19:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312C510E351;
	Thu, 23 Nov 2023 19:49:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4076010E351
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 19:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsbrAF8Rybet/nq7CEYkwU0JFcfJcVAkAb9fHEhPNl14Gr3EEY2F3ci+/YvhRoTJJgKExUw6rMzcl3jZH0+ES4Esr0SZhhQA7lERGdUYF5C+YuIhwGMTvPcs5zSH8gYVPhJcRqWtuo0rTGP6c3LpppLYrZRxzLmflrqc1aLH0Fuc+KPPUrraNjZLyjqOvETVInyeb/pZLLlxm4M+o5j+dQuZQNuNdzvvQefB8+d5lISgegdzqe8zTfHlorRIknvsS81aw3K/UEPEkXEPyGY7rCjZlK0vGLsFfLX6tCQyJoQ5cccH8f2nhBRruZxM5tY3UKrcrPRgYnco5p48hAGrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw9G6KMJ2bdIWR7bg2qlOfI/wCFSNFFbvvGhxX2kcu0=;
 b=E2y1Vnx5Y6TEtrjRehF2SY4lZrgWgkiE/6dLlo8/hBxlGvnKwnIpvmlvu3w7MzFWno2FW9v6Lj3M7CXQsXxTdqys3UMfLKNGfBreNvB2fSVu5ElhzgT2X8YfMZFV9eUvzsquXTtzLe5Vfu70QnQnncVcQmed5na/CnznPAos3kTh6E2Vd3A2c/v5foDJkXTnGRx8zXi2oGgzJLxyyZO/POAZToNFZUJmQWigAZmdfn+g9EpUqXg1JK+N1G5heIN5aHw3vqYZY9KF5gfrhF+yt83tHOSTbekge1ZlI5NE1yfYa1sLholHTWKRn4psEgtOBBuJXukvQCcrJBmihbCiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw9G6KMJ2bdIWR7bg2qlOfI/wCFSNFFbvvGhxX2kcu0=;
 b=ycV2j9amp+DFbRIXIpCihxYl1SmsArBEKtCvzAu/C6meVl5//jJ/Yqf6QU0ZwWPLqk9OKryJzSsxOcOj/K27iq9WcyZ0FZUw7cxQHV91KvlmLXOG4PEXGJQT0hzu7Lx5lYWKeoc8XnPtaD5DutbfpqvngBLTub8x1+Ql4ZnJI8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 19:49:23 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 19:49:23 +0000
Message-ID: <809c2a1b-fe75-4068-baa1-728508dd789b@amd.com>
Date: Thu, 23 Nov 2023 14:49:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] drm/amdkfd: add queue remapping
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-22-James.Zhu@amd.com>
 <dc13740d-666d-4296-8f77-062c6f32374a@amd.com>
 <f24bb157-8c36-44a8-9ffb-128c21377500@amd.com>
 <5c8d90e1-11aa-49fe-9cc0-96e5123294a5@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <5c8d90e1-11aa-49fe-9cc0-96e5123294a5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::38) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: fb630e9c-f75e-47ea-c409-08dbec5d4a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSdVGORBlb4BvN97af7yAjpdxSFQj7QvXjnHIrw/tiis2RyUsyx2wOLh36xO3qF7xpUGdOwFrPtMHHX/mFlzrycNadvV/SiFBoSfc1W+21xcQkWXr/d/zVn81jgj0HxfjFN8XtWafSCjqwJ9+C3iWNZgHw9DRupNsBIUQfPsxL2S1JBTCUR4B5+0UP5bNV6idmuDamTDnet1ajxCirak+G9CVtwDhvXW1ADXv5kAkUMUVVA/RAJKKOOZWpIqpsJwLoREAxaPDlAt+2viZC/AMx6NNkJJqygruoLPPYAI7T1h5hix+lSLdIS0imzjvpiT9VJBqh17urQ9l5p5+ycANuof6m7rHBOfW9+uwLmpwcblGTEtLP9n+Zpv6DG/RYv345ssrayqAa9XHjbKegfa0uAy3nRVO0tJUkSBuFaILsbAOmZMQGlyAb0jxQV4OrUnnHo/EOAUfLOwmt3lIoiQlWFDs5UsavJddeYj692r58vEkMfnr5LNpA2YPOPZPzQbu6JBDzR7BRWxs7iahbCFIZ+gIiL+Qx4VkVEtX000oj8O4zKG1zQ+lkM8agoRL167ZEAKIquIPFpYtZXr/5MA/WSLgIX5dAyRTcPqGhqrEYgmf2TS6IsDOzEhJKMV8zTz1J5KUlI1iY68CPD9WW4ijA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36916002)(2906002)(31696002)(66476007)(2616005)(8676002)(6506007)(83380400001)(4326008)(8936002)(6512007)(53546011)(66556008)(316002)(26005)(36756003)(66946007)(110136005)(6486002)(478600001)(38100700002)(5660300002)(41300700001)(31686004)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNGczJHVHRRU3hhRFVISDNoRjMrNllUcVlEcFIyZWN3ZE90RlNhQ0hBWlFl?=
 =?utf-8?B?VFVjL0JsTXp3T2htd0kxR2ZFdFNYNS9neFRjdTNKTVVjMGlsZlhRTE83TEpt?=
 =?utf-8?B?VGJVNzlIVUw1anoraXZuTlQrYU9zaUt0WEdHSEVodk5tUlNNdFNHWWlmTVZq?=
 =?utf-8?B?bkVrUkRrSDgvTExMenQzWWlZQVRyL1R3UXE3WDJTVFNKTUdndXNoMjFQUldS?=
 =?utf-8?B?Tlk5ZlBCOVM1RVNYbWM0eS9DYk5KbloxOGpqeFV6dWR0V213OGZHaVA2dDA4?=
 =?utf-8?B?VmxaWFVjUFUreUtoV3FRVHJMZjVldDk2QkkxWk10eGdTSlVsU24wMEVwcC9n?=
 =?utf-8?B?QVgreTVaNFFoYTM3dWhibVA3R080TmtPaHdIUkF2amo5U0Z2b1ZEcFVQOFpR?=
 =?utf-8?B?NmFVclZBVGg2WG1TUlEyL0p4aFVtRjV5QUVuNHhud0xDa0RnZFVDNmZ5cXZh?=
 =?utf-8?B?OFBDcHRuOWRreTQzeGpmL0gxcHArQ0dkdVU0RXM4VTRwUjdQbHlqWm5tV05Q?=
 =?utf-8?B?RDhjMXdnN0tiZ0d1SDdIMW43VUd1SHNHcmw5RU00RTVmbVE1SDhHTXVJNmxq?=
 =?utf-8?B?cnFURTNqN2p5RXlJdStYSjNDNnM3QzlpM1FLVFdZdDNxd1dPVEk2WGdCRE9l?=
 =?utf-8?B?S04vQ3NTN0NEMkxKazVFdXdReFJtcWpmbVZzWVZaT2RROFQ3bnFMYy9sTFNL?=
 =?utf-8?B?TU84aHdmK1h5OUk0VHVHS1FTU2Q4ckZ3TWV1OFVqOHpGN0llQ1gzc1V5d0w5?=
 =?utf-8?B?Wm10NU1naUlsRWhEUFdmb3BUU2JGWk5pMzRpRiswVXhHa1RTTkI5L2Y4TnBG?=
 =?utf-8?B?U2szWHNGekNMWlFzNkNnQ0tKU2pqSFVUdzdQdk03bk1RWEVjcGlXYS9QbTM0?=
 =?utf-8?B?cGFQbGo5alhnazVJT3BXNjNncDB3bEtYZ2VHODc0YlV5aG5Bb2RsaS9FTi9V?=
 =?utf-8?B?K3ZyWVRkb2t0K1VyTFlISGp4Qk05RHAyV3Z1cXBwNU8ydmU5Z25kR0h6UjM5?=
 =?utf-8?B?b1orR05vSWEvaHJsVExYcUdiMGd3R0pLYlkxVi9YTEF5akYyeGU5ZnFnd1B0?=
 =?utf-8?B?YmtwQWtiNmJmeFVTZi8xQ2dUbmtVRUdYRklYeVFXNGZnOFphb2ovbWwwelp0?=
 =?utf-8?B?K1QrcmZCcmxIT1NzODBqMThKU1V0UXM2TnhwYk1nY2VIdnFGYjNETmRYVTBV?=
 =?utf-8?B?RUVKMkVseE5GSm53enRKamRaWDhMaXAzS3lENmVjdW81UHdrSzAxSjF1Z1R1?=
 =?utf-8?B?NVYxbzRGeXR0bi91SlQrNWEvYkswRjI1QWw4RjNvTmVhYmpBZHAzYkNlbng1?=
 =?utf-8?B?cmpHaGVFdUZWSnJLR1RTWlBlWlkyT2orUkFxN3prYmZUakFlckl4WnFXVE51?=
 =?utf-8?B?SlRhajNxK1VjeVR6cDZYVExxU0x2NFppdHptNjB4aCtOWFNqWGRTYndBU3ht?=
 =?utf-8?B?Y1JiTlVlZ0xSMDUxM2VORkhPYXJ3WW5jVzVRTSt0V1BVYWl2amU2UHZPRVAx?=
 =?utf-8?B?SkM0b0hqYWRPMnBBUW9Ma0ZLclN2a3Q3K3NUVGw4Qk53ZWZla2poalBTeFJa?=
 =?utf-8?B?V3ZkcmpmcHJTVDRwblZwMzZ1THMrV3dwc3hqTDVnelViUk45TERmcVVKa3Nn?=
 =?utf-8?B?emRucnhZU1NsWWJaNXl4UzZldEsrdEZXejl1QnBVM3JOTnhaUkNUYnZhRmdo?=
 =?utf-8?B?eDVBRHNwT2cxbU9hMXBMMSt5Z1RrMVFPbktLaUZzL1VSbjhtZkY0Z1Z6ajN0?=
 =?utf-8?B?VFlseTV1QUVKWmJ6OGlGYlNPNnVxWERwclF5a0hHcVVtSDhVNUVPVW1IcVRG?=
 =?utf-8?B?cVY5NWNlck1iRHpXOFJ3WkF4cnVLU055WFNQb1lTclFUak9mdG5vc2VTQ2Fz?=
 =?utf-8?B?UjlOWWxSaGxiRFMyeS9qcG9vcm16VGNmUHg3WGdzSlh4NE5HVjZwS1BhV1lO?=
 =?utf-8?B?ZSs1Ym5DL3J6M2h5WXhXY0pRQkREcjBVUVZvNXpWdmtOLzlWaWhQSHJCZjYy?=
 =?utf-8?B?aUorWFdSQldUbUhTZlNGNDhJaHprK0RzZm9PRVFadVVHUXVwbXg1QkdkTlRl?=
 =?utf-8?B?ZVRsUzluSGRhejBMMDBrcVpPM2ZXOC8rSWJFVjl3bGQxMjVkY01GaEZZWjJU?=
 =?utf-8?Q?mr0irjmxT4ow96Bo/s8ADLRec?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb630e9c-f75e-47ea-c409-08dbec5d4a81
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:49:23.1345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsgcsdPTc7s97pHzCMDJtr+pu0u+RtxFxjKQO47UJ9bCBMy+lg2dqiwWyeQ+Y98S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-23 14:02, Felix Kuehling wrote:
> On 2023-11-23 11:25, James Zhu wrote:
>>
>> On 2023-11-22 17:35, Felix Kuehling wrote:
>>>
>>> On 2023-11-03 09:11, James Zhu wrote:
>>>> Add queue remapping to force the waves in any running
>>>> processes to complete a CWSR trap.
>>>
>>> Please add an explanation why this is needed.
>>
>> [JZ] Even though the profiling-enabled bits is turned off, the CWSR 
>> trap handlers for some kernels with this process may still in running 
>> stage, this will
>>
>> force the waves in any running processes to complete a CWSR trap, and 
>> make sure pc sampling is completely stopped with this process.   I 
>> will add it later.
>
> It may be confusing to talk specifically about "CWSR trap handler". 
> There is only one trap handler that is triggered by different events: 
> CWSR, host trap, s_trap instructions, exceptions, etc. When a new trap 
> triggers, it serializes with any currently running trap handler in 
> that wavefront. So it seems that you're using CWSR as a way to ensure 
> that any host trap has completed: CWSR will wait for previous traps to 
> finish before trapping again for CWSR, the HWS firmware waits for CWSR 
> completion and the driver waits for HWS to finish CWSR with a fence on 
> a HIQ QUERY_STATUS packet. Is that correct?
[JZ] I think your explanation is more detail. Need Joseph to confirm.
>
> Regards,
>   Felix
>
>
>>
>>>
>>>
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 
>>>> +++++++++++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +++++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c          |  3 +++
>>>>   3 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> index c0e71543389a..a3f57be63f4f 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> @@ -3155,6 +3155,17 @@ int debug_refresh_runlist(struct 
>>>> device_queue_manager *dqm)
>>>>       return debug_map_and_unlock(dqm);
>>>>   }
>>>>   +void remap_queue(struct device_queue_manager *dqm,
>>>> +                enum kfd_unmap_queues_filter filter,
>>>> +                uint32_t filter_param,
>>>> +                uint32_t grace_period)
>>>
>>> Not sure if you need the filter and grace period parameters in this 
>>> function. What's the point of exposing that to callers who just want 
>>> to trigger a CWSR? You could also change the function name to 
>>> reflect the purpose of the function, rather than the implementation.
>> [JZ] Just want to create a general function in case that used by 
>> others. I am fine to remove passing filter_param/grace_period
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> +{
>>>> +    dqm_lock(dqm);
>>>> +    if (!dqm->dev->kfd->shared_resources.enable_mes)
>>>> +        execute_queues_cpsch(dqm, filter, filter_param, 
>>>> grace_period);
>>>> +    dqm_unlock(dqm);
>>>> +}
>>>> +
>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>     static void seq_reg_dump(struct seq_file *m,
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>> index cf7e182588f8..f8aae3747a36 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>> @@ -303,6 +303,11 @@ int debug_lock_and_unmap(struct 
>>>> device_queue_manager *dqm);
>>>>   int debug_map_and_unlock(struct device_queue_manager *dqm);
>>>>   int debug_refresh_runlist(struct device_queue_manager *dqm);
>>>>   +void remap_queue(struct device_queue_manager *dqm,
>>>> +                enum kfd_unmap_queues_filter filter,
>>>> +                uint32_t filter_param,
>>>> +                uint32_t grace_period);
>>>> +
>>>>   static inline unsigned int get_sh_mem_bases_32(struct 
>>>> kfd_process_device *pdd)
>>>>   {
>>>>       return (pdd->lds_base >> 16) & 0xFF;
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> index e8f0559b618e..66670cdb813a 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> @@ -24,6 +24,7 @@
>>>>   #include "kfd_priv.h"
>>>>   #include "amdgpu_amdkfd.h"
>>>>   #include "kfd_pc_sampling.h"
>>>> +#include "kfd_device_queue_manager.h"
>>>>     struct supported_pc_sample_info {
>>>>       uint32_t ip_version;
>>>> @@ -164,6 +165,8 @@ static int kfd_pc_sample_stop(struct 
>>>> kfd_process_device *pdd,
>>>> cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work); 
>>>>
>>>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
>>>> +        remap_queue(pdd->dev->dqm,
>>>> +            KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, 
>>>> USE_DEFAULT_GRACE_PERIOD);
>>>>             mutex_lock(&pdd->dev->pcs_data.mutex);
>>>> pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
