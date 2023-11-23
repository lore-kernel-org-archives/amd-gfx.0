Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C10FC5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 19:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2789F10E332;
	Thu, 23 Nov 2023 19:02:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F5210E332
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 19:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOlkEzW8WuzzKGB/sKXxsn1dpedW+Ad4PHfBZzCud7Tcz6wJvtpkmsHt5xxPuviIyDKcx6EeXWp2Oi+EQiDrCQFkTd5hyBMZ/vVak7om7SpfTl9YS4MFtPu5WjmcvJWS0o/xTuKVctTY8LdBEIoqltRk4eGKCdGPym5U+NXm6ahIriU56wA97flQa8GdbIVHn+DtitmQwgNd0ZemPPQ41vqdJEiR5dRNaCAjGMBQlZtQZe3uDbGyKvcq7Q9Mbv8J3ZXR15rqE5owaRP0IzAIGNeNKoTwgo7zWVJYIouixhyFRUkyFP6LReuRfQ5BKNLfga0yaAbc/7PDsX1TIXk+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5ApDx2U9EW2QLje/n9nFs996xngezKB9tiEwJmhLEs=;
 b=ghhUy4Um8iMmfFq4BpyPcM/9DgnZVySZWfRKf6kaTxloPFUK6d8GEzqQjr5Hd6eEmpNBkAcUP2Qho0A0RnhSd+T2qfoJ8I/cePPJdK/UIaGmm+mcy61+2VKeIUeVhapTg4okiWVAiYWexhiV0WX2D3/tMjZ12F8cJ4pneJzwWC9p1xN1CwsnGFkTXw/vwuCdOyWAJSH0S9gG6NGybDGDPdkpMi+3PmQabZ4DQKJjLzHDrUXdnynuGfiphrMbGoSR9nt1vp2+wCiDsOr53f/QUhHhSQyNB1T2tK4eFP4FX5Yrb2H0y2MKedtGvaentBLrBbPhpnMooCMULyPfrJ1GPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5ApDx2U9EW2QLje/n9nFs996xngezKB9tiEwJmhLEs=;
 b=XNnFABUNqDoDYJwq2AdxI8hDGnZ5CzfO5PkjLhWtOlluuvwrxaUncZmqigOKcbSjP4sUIIPGoh+U8YSK5cBvbMXBUnIKPsfTeUQ0goH2mGIzRC2385sWWIZyBq5WAT76s4mNX3OA+HfrZNdVX6VmU+NA3BtCnqjoBaQiJqZVxi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 19:02:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 19:02:33 +0000
Message-ID: <5c8d90e1-11aa-49fe-9cc0-96e5123294a5@amd.com>
Date: Thu, 23 Nov 2023 14:02:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] drm/amdkfd: add queue remapping
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-22-James.Zhu@amd.com>
 <dc13740d-666d-4296-8f77-062c6f32374a@amd.com>
 <f24bb157-8c36-44a8-9ffb-128c21377500@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f24bb157-8c36-44a8-9ffb-128c21377500@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc7a7cf-6461-4215-5ca6-08dbec56bfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDoKNDOR48DYQLwqzm1Rka7CgYXYbns+icu5rWJCGzddWXveo5QfKySle37BCYXEyilX8LX/vIIEJGH499Jt3zDs9+zLtCM3ksE2FhwYZp5249N2gXC68weLrAoNE6RM32DhHvUG/gfikvNoqKFRLGFAKXIoK7yIpVBXGfKzi4YThu38uu8gl/Tkgzs3zW9Yb7QU+AG65BPv3MKb354XVmbuueklh4kVyQvZae266DdOL2Cm3keOIbcj6H8cRHGxGxTyu1dnYZFEfYCni0tw79eoJ55ifU+KHL9G8sQq5MRHsEoKL03lQpU8bOX9wk+OUwUlV4QFsduVFimjPchN8vSMnlLn76aUjVWiYuUvdU1hLQPWWUBkKFv4IhYD3dnpWpqdA+eCT3QCUgr1BWyRnavJOtPqW8LYJ68iVGy1ewOz3osMNUS09mR04QGXmDK1U9DAEtaUsBGAZPw0GVj3BYze1oLqBX2FykqW0UAhGunu9/doVDBWQUfoarMWohmITB092MGnp0gDjBbIg0DsOs+36qBpc6P7L+gd5lJWCSw9nHp6c/bYOJxznSBISNq/8gIWOYX7WGvLU2B5Nw1UOKf1rJRUICBvpaw7vbPGY+ovYmNICCP/9fOpJzTIP2Yz74/XLSMYATzqsef5sxc+ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4001150100001)(5660300002)(44832011)(2906002)(4326008)(8936002)(8676002)(41300700001)(66556008)(66476007)(316002)(66946007)(110136005)(478600001)(6506007)(6486002)(36916002)(53546011)(31686004)(26005)(2616005)(6512007)(38100700002)(83380400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZUVUpXcWRiMGpNTGxKK3JRcWIrMFRuRzRDeDhheHJ4NFJyVjE1THd5WGd3?=
 =?utf-8?B?bEE0c0dBR1pjSWgvTTl4RUQ0M015djE4MFVUQ0RKWHZzV1dONGl1YjVWNXBG?=
 =?utf-8?B?aUZPVmcrZm8vRGd4SjdPN0N6NnF5RVNUSzhkRkpGWk1XaTFwVFRZdzRHb1c1?=
 =?utf-8?B?VTh0OXcyUnVxTUVFZzBLOHc1WDIvdlhMcWRJemN4cno4VHpHWmJNK2k1WG55?=
 =?utf-8?B?Q1Z0UUNrTDMvS0tSYlBxL2dNSDNyaEtpdG9CMEM4Mk1rYVQ1RVhEam5FeEQr?=
 =?utf-8?B?VVdNRHpzMVFFV0FGT2V5ZElHdmI2YVZzSzZ0QWtsRmhKWmhvNDJ2SXEzODc1?=
 =?utf-8?B?QmN4aXRFMnNqRktjRHhveHpLQk5XTFhjaGR4U09VWUxlTDlObDJDNitOdGJR?=
 =?utf-8?B?MjBoeUtZQmx5azBWMkZ3emw1R09weS9nc2RVakcyNVNmSHg1VUsyZ0M5NUxv?=
 =?utf-8?B?aytZN1VPTi81SE1tUHQ1cGN2aGM5dWdHY3VDQ0kxMEh2SmZCNWVDOTlIc3J6?=
 =?utf-8?B?Y2lpOWZNaTVGbmlUWEZZdmpvNFI2VlRhcEtmL1ZCMVcwQjlTWE1aK1VzNDBq?=
 =?utf-8?B?SXpwSFBqVXNOWUR0bUEydnRrUGxQU0ZqT0FBOERwbTIveUNnRkhSRUx3OHA0?=
 =?utf-8?B?cUVQS0JaZnpvTU9nNHlkcGo2RUdxRlFKbFdJbXVlcG5XaUwzNVVSTjEvdWlu?=
 =?utf-8?B?V1hUNWNIZ0JEQnVWdjN3NFhxZG9TN1ZUUDN1UUl6TWdRc2k4Nkk2eHA2RUdH?=
 =?utf-8?B?K3pHUnBiaHdWcGhHSEJ2MFY5Q3pnVGhObmJlaDBLaG1PUHNSRHNiTmZBOXZ5?=
 =?utf-8?B?Qm1yREozVEd0ZVdiT1h1dUpJM09mUlQxZ2dhWE9ObGtxc0J4U2NwdHdmS1BH?=
 =?utf-8?B?K2tvckdWNFZ2OWdVNUZzZENIa09tWjhyNHk0dnVsVlFOaWtPd00vb3hYeXZy?=
 =?utf-8?B?NHc1RmNPMytjKzVLMVEyVTlVQXQrZ2VUOXF4elpQZ05oakdyMVRLQmlndHp4?=
 =?utf-8?B?OXV4NzdCKzJramV2NTMzeWdXTTJtSnJQUytWREFrQkd0RWM3Z2VHLzk4bjM0?=
 =?utf-8?B?QzUrZ3RMMmRua3JmNzFxa3FJMmZFcVJtczNoMlVWTklRSUxXTEtZUG5pTXJY?=
 =?utf-8?B?ZkprZ1dhS2M4KzhRZUx4TVo0WDdrdFdhWE9FemxNV1lZSWUvbnpCNDZ1d2Yx?=
 =?utf-8?B?anR6L1RwZ1hBTVIzVEJPd3BoRkw5d0hhd1U4Q29EckVSdjMzVW1xZHV5bzk2?=
 =?utf-8?B?OHdZQVNmaUcvaDg5TktyZEd2eFNBS3d4UmtXYTAvbDFDQU95TkRKYlByeTlH?=
 =?utf-8?B?T1AzVitGekt1bjRJanE1dU9hZDJ0UksxVHBVditUd25QVzUxYlNBTVlMbG1y?=
 =?utf-8?B?bGR6RTVDdk54UUNxT3lwT2M1ME1qTC9OVU1CRG1mbVhVc2VSZ2dYTVhvcnlQ?=
 =?utf-8?B?OHY5RW9lMGJmTExsNDZ0QjhvclZ4TDlRUHFpRHpTaFRpTEo4U1QwcU9BcThP?=
 =?utf-8?B?RFd0NkdjQlIxZHJDbFJTZ2dzeHNnUG1MYmtmZG9HMXNDQjZaRDFla3dudmtR?=
 =?utf-8?B?dWFJbFgzSWZFdFY1SGJLYnBZRVNsbzE3dHBud09Ya3ZoZGhjbjdQMDBwZjNp?=
 =?utf-8?B?MFYvaHNmNEZBaURlbHY3TFZTd09aTi92Znl0OEx2cXdvdHpHS1lDaTJ3WkRi?=
 =?utf-8?B?c0t5SmViVnlva285WkFmU3pNak13b0k1QlhNYXUzL0N1bjBuTHhQVEZ0REZY?=
 =?utf-8?B?bHdublNJTU12T25rYWdDcjVUbC96Y1E0Mms1QVF2eTRXQnlFVDJrRHJvbktj?=
 =?utf-8?B?QnJEWmN3T3p6bmVtR3B1dGxXOG1iVEdhUWRRZXZsMSt5cnN3RW9QZ0o0dGFB?=
 =?utf-8?B?T3o1dzJROSszclBHbjdReThNNmlWRG1RcjFKalMvUW5UN0R4aGRrOHZZT0tv?=
 =?utf-8?B?SnpJU0tnUmZDV21NSU1SOFN5bHJSRTNZbXJGM0J1L1VzWmJybEdSZ0hRRTha?=
 =?utf-8?B?MmZ6WmVoR0NpM2lsTlg4RUI1TDZvaU4zcVY1R1RUU2loTUd6S0d5T3VHLzdJ?=
 =?utf-8?B?UVBYaDZ2R1c4blhVOGhLUjAvNXp2T1VuUmNTNUNzNEx1ZHhpVjcrNXh6aVRS?=
 =?utf-8?Q?zTr3M4bxQpQ3on852SlySiw70?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc7a7cf-6461-4215-5ca6-08dbec56bfc8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:02:33.3395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsPrgKe/W8+WQZkffVEx8LQnooQ1bb59JNN5ZnAcwMYV+qjTjOYfqZpa4/BasJm2kLzIlQX00BeiqnnGTMKQkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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

On 2023-11-23 11:25, James Zhu wrote:
>
> On 2023-11-22 17:35, Felix Kuehling wrote:
>>
>> On 2023-11-03 09:11, James Zhu wrote:
>>> Add queue remapping to force the waves in any running
>>> processes to complete a CWSR trap.
>>
>> Please add an explanation why this is needed.
>
> [JZ] Even though the profiling-enabled bits is turned off, the CWSR 
> trap handlers for some kernels with this process may still in running 
> stage, this will
>
> force the waves in any running processes to complete a CWSR trap, and 
> make sure pc sampling is completely stopped with this process.   I 
> will add it later.

It may be confusing to talk specifically about "CWSR trap handler". 
There is only one trap handler that is triggered by different events: 
CWSR, host trap, s_trap instructions, exceptions, etc. When a new trap 
triggers, it serializes with any currently running trap handler in that 
wavefront. So it seems that you're using CWSR as a way to ensure that 
any host trap has completed: CWSR will wait for previous traps to finish 
before trapping again for CWSR, the HWS firmware waits for CWSR 
completion and the driver waits for HWS to finish CWSR with a fence on a 
HIQ QUERY_STATUS packet. Is that correct?

Regards,
   Felix


>
>>
>>
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 
>>> +++++++++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c          |  3 +++
>>>   3 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index c0e71543389a..a3f57be63f4f 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -3155,6 +3155,17 @@ int debug_refresh_runlist(struct 
>>> device_queue_manager *dqm)
>>>       return debug_map_and_unlock(dqm);
>>>   }
>>>   +void remap_queue(struct device_queue_manager *dqm,
>>> +                enum kfd_unmap_queues_filter filter,
>>> +                uint32_t filter_param,
>>> +                uint32_t grace_period)
>>
>> Not sure if you need the filter and grace period parameters in this 
>> function. What's the point of exposing that to callers who just want 
>> to trigger a CWSR? You could also change the function name to reflect 
>> the purpose of the function, rather than the implementation.
> [JZ] Just want to create a general function in case that used by 
> others. I am fine to remove passing filter_param/grace_period
>>
>> Regards,
>>   Felix
>>
>>
>>> +{
>>> +    dqm_lock(dqm);
>>> +    if (!dqm->dev->kfd->shared_resources.enable_mes)
>>> +        execute_queues_cpsch(dqm, filter, filter_param, grace_period);
>>> +    dqm_unlock(dqm);
>>> +}
>>> +
>>>   #if defined(CONFIG_DEBUG_FS)
>>>     static void seq_reg_dump(struct seq_file *m,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>> index cf7e182588f8..f8aae3747a36 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>> @@ -303,6 +303,11 @@ int debug_lock_and_unmap(struct 
>>> device_queue_manager *dqm);
>>>   int debug_map_and_unlock(struct device_queue_manager *dqm);
>>>   int debug_refresh_runlist(struct device_queue_manager *dqm);
>>>   +void remap_queue(struct device_queue_manager *dqm,
>>> +                enum kfd_unmap_queues_filter filter,
>>> +                uint32_t filter_param,
>>> +                uint32_t grace_period);
>>> +
>>>   static inline unsigned int get_sh_mem_bases_32(struct 
>>> kfd_process_device *pdd)
>>>   {
>>>       return (pdd->lds_base >> 16) & 0xFF;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> index e8f0559b618e..66670cdb813a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> @@ -24,6 +24,7 @@
>>>   #include "kfd_priv.h"
>>>   #include "amdgpu_amdkfd.h"
>>>   #include "kfd_pc_sampling.h"
>>> +#include "kfd_device_queue_manager.h"
>>>     struct supported_pc_sample_info {
>>>       uint32_t ip_version;
>>> @@ -164,6 +165,8 @@ static int kfd_pc_sample_stop(struct 
>>> kfd_process_device *pdd,
>>> cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work); 
>>>
>>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
>>> +        remap_queue(pdd->dev->dqm,
>>> +            KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, 
>>> USE_DEFAULT_GRACE_PERIOD);
>>>             mutex_lock(&pdd->dev->pcs_data.mutex);
>>> pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
