Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DCDC00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 18:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D88B9AF41;
	Fri, 12 Aug 2022 18:11:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B19089143
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 18:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp2OH9C1ZdCpjsiwr6mPsieyIMaM4WyzcPX+K+i8Kv8Sg8ifJ+UPdDe9t49HlAdA//AGEQEVAeVPWiLwoeZggWGlAzNlZG8eMXuqsq7C05rj8/EEpQXZMwJYQEJ+SLVRUOfcNY5tMW/8vY4taSKUsiNz6r8BHBFlyobxxs41HAoqi3yDJ9ESpE7ZDPEiVakwM4SeksnqsS1rXzpRw3V8kyESv4dIvuTrbE5uKfyHf4tgQEFeTj8nFIsVYAuQd5uDNSpPfpv0qgvCChbR8MF3KbCmqnz3balFUfno6iqpwX4hUDnviw+HmWhhh0Wo0vFYwcDSiFqBVdxtNwNurG8Fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlFkAQHs4dVE/hQlJYcRk94ncwY1neizxYEd3usgPp0=;
 b=K5BiJo28Ep5xIV9G77kKVFuVe4Ao6FjFE1r7cfI2JJEFl2gbwlzSYQsSkO1JLWE2RVjBRrdUbF3Pia33kM3r0gtTX8mu252E0Mgj5p8aj1WpOmOGWe3e5c5KffcnzBMiIot9wQmRz3W935Oxrekn+QHTZgiMGuE/NNnvxlVCjqK/9lCPvDc/4NHLcoqhf2IdUTQxAeO6Dd4536VIloGrRAUblJ767eI9aJPS+R5QxvHzS4iivogs2ztzVTUfC/gye6vOxzBMTQj12Qmt0TUHhag4SSRGFr+F5aX3wgie7J7W/ncxYRmRnRkAhnCW5QLddjxZOuA/djSi+VKaFBblKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlFkAQHs4dVE/hQlJYcRk94ncwY1neizxYEd3usgPp0=;
 b=XfvYJIGanuWK0mMEtHqyhmzBCq4SIz7k8qifQJ9d56CMfiKqJsbJQijnOB+eKYydXE9hjM3kHnmU+XXVgTX8vmndxvX032AX4FIim6k0YqqDneZ3/kUSQOSzvCPW0Rz64Frxvjhy15lELPLJRyg8HhtYqKOBurfORy7VlOf5ycw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 18:11:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 18:11:00 +0000
Message-ID: <0d45fb6d-800b-8291-1726-be83ef1af044@amd.com>
Date: Fri, 12 Aug 2022 14:10:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Try to schedule bottom half on same core
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220810234109.935228-1-Felix.Kuehling@amd.com>
 <20220811190433.1213179-1-Felix.Kuehling@amd.com>
 <da05c04a-c484-e2a0-8019-27f415f0a726@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <da05c04a-c484-e2a0-8019-27f415f0a726@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:610:5b::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a0ba703-ebb6-4207-b1bc-08da7c8e02d6
X-MS-TrafficTypeDiagnostic: LV2PR12MB6015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSTwDRgQOQxlh/C0ncIIz9F+sS0LWDtwwiZuJlAV5PI8QAO8amnagB/emdp4GbIPz1YFo2KnkHl3Bc0Cly0V6NumBl1yTes4Q8O5nePAfquEqbdlsPEd/RMT45mWAPz4oWLJ/oKRglnJ21ABjCKea+SarbV6Ln4iD/SwctvSGM0mp0Bit7BkNLfUDeNDZuUu7enfe9FvNyPSPaGpUYCVtVSseNYSHQYaWSDm+VizTsDivSLxQzkLPIYP3XouQxd50Q0CPtCr6wlbashnl15dzYyr8x3Lp7WO+iKaUgofIH65NQ0/fcAuxGlL8EbeUUpGO/0YOo1VsBZo3ItL99L1vIjXAj+6CJU9AzXXRW4f0UDgex6H97K8LfYvGeXoXmhFL1naqcDShuzO+po7kmU0V0WRufyTk+LXhxGhGLgqxE4bNJ9W2rhpcmNSz/CA0guQifTyRKHMqe+rwWzT5ExYtuqT9+O/3/pr/gkOdtiyTd3PcJTcoN7OcDqe9qM1twhJFPNW0Czc819g1cV4QuKfU7bk0sKNrxlhJI5gAuQA0xtCroNrzANTckDoVZRgTF7i7AkAc857Jtj+oO+iSrb8fEBwvKoWKXvZGk/7VvKJ9TakGJg0Z4zrTKHFFqUDxdeomIGYbGDkLjRecZ7rEnXO6hOtK/BmnOvf3v8RYINN+A+ipmJz3irnxdHSBqOtCKnWy+PQhhDdO0X/6mwAhZAX/+HMG+1sIsnjhxPPuo7iYYB2kYVJ59uZu3qMLvVdwxTSFNHpt29sj+vC1FG3WZ9BhO03dwBVo8AaVe+rK3Y+snMg+m0+EZnF/puRiqhbZr1iSWnfM2Uqd2EO3EpG08t/1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(316002)(6486002)(478600001)(41300700001)(2906002)(4326008)(8676002)(44832011)(66556008)(5660300002)(66946007)(8936002)(38100700002)(66476007)(31686004)(36756003)(31696002)(86362001)(186003)(2616005)(26005)(6512007)(83380400001)(36916002)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVBSR1hEL1hMcEIwZTZLS1BMejlvOUFYZ2Nrb1h4b3Rvbk9HVEoxT2Z2R09v?=
 =?utf-8?B?K2ZUT2Y4YWFCamQzUTh4Q0hXSEFzblQyaWdsTHZqcWFNR3MwLzRVblhTMGk5?=
 =?utf-8?B?RTZWTmE3a0tZMXV4UHB4OUFLRDh1NlJXUlR0dGpBTUZoNHU4S0ZMS0xGZG9q?=
 =?utf-8?B?NGNVRS9VZGwyOTNpK0taMUdmOXpxRGYzQ0FHMkwxSnltZjE2clQrMlczTWlY?=
 =?utf-8?B?YVIzNkxmSU44WjdVT2FKYWVVNk43RmRiVDBwRTY1N09zUWxDUDBqZ3FPMmxT?=
 =?utf-8?B?TmJtN1FTVVMzL29pcVlvcnpWbEs3ZW1aZENxUEpUSFdYUXU3ZC8xSTZ2S0NY?=
 =?utf-8?B?R3MwYUl0VnVZU0ZpK05CUkFjZDFtQk9ZRU9ub0RkcjdKRkI1Z0NlVjZpVFBW?=
 =?utf-8?B?UmpPRWRrblBrSjBURTF3ZDMrUVpycTQ1MnVLWUhvN1RKZGhXRzFWcXo3N0l1?=
 =?utf-8?B?U3U0TWNZZkMvS1ptNmlzUnJoQlZ0a3hBTXZOcVE1QWszdjJVeloyZGZCOWtW?=
 =?utf-8?B?K3A4TWptc1c4YUtFZW4rZmE0eEN3ZHQ5QXpuc3ozYWRlQThNTDNhNXQ3K09Q?=
 =?utf-8?B?K2ljQ05jWjFpaXFFakd6YjVmV25YVDBlNFBmS3VaS25qT2xubjFNdlNuLzhL?=
 =?utf-8?B?T05wZ3ZrVjJzSGs4MGx0Ty9xWmJGdmtYZ1g4UWlmdzlCb25hajF1Q2NGTU1j?=
 =?utf-8?B?MGx1cTdwcnB3ZXI4U0x4R1dJVFdOOG9EWTJ1NjBHM3djSjcxRmc2Nzd2dkl2?=
 =?utf-8?B?UkpVKzk1K3paVDhQVmVwd1V6Kyt3eFZDS0JEZ05Vb0VrMDV3ZjFIS1JQcHFa?=
 =?utf-8?B?Wng3U0FTWXI5UkNFamhXYTNkWWpQa2dWc0xEV1A0YWZzWWpuZXBvbjlaQmdK?=
 =?utf-8?B?b1FSaTNCMlJvWnZzUEdVSnZGU0IzTDVTUE5HMnV0aTlIUTJnT2U0NkNjSzcv?=
 =?utf-8?B?QnprbU10UVd1OHIrQk9JM0JqaVNjMVpsZ2JwcXpyQnJOUHgwL1JSUml3a1Ew?=
 =?utf-8?B?QUh1VXJxTnZ6OHNOUXl1TUtzWGk0RTZ4bllRTlpYV1JVd3ltRHNSd3N5d2li?=
 =?utf-8?B?VkxaR0licmp3VXprVSsxbHN0WmdybFZZR1hOL1pCamxWN0V1V1BsOEhSTlBz?=
 =?utf-8?B?aFVDc0FjeHRacUg1M2t5WSt4c1ZER0p5UEx6YmMyWXI2WFZJMUphZVlGNjhE?=
 =?utf-8?B?b3JNS2MxQ2dlMzNjb1d1cHIzOFp3NUdzYXowKzc1YW5TTHo3YkIzWStRMndM?=
 =?utf-8?B?WkVaMlA2ay9pMiticVM4Y24vbytzTGI4Wmd3SDhTZ2J6MG9uN0RCMmhmV1lk?=
 =?utf-8?B?WjlZeFQ3a3J4VFB6RlZmWEFNb29hYWRGNnk3U1B4YVJCYjVXOWM2VU00cXhD?=
 =?utf-8?B?SmU5OXNvUTFsYWIzK2h1RXVuOGtmL1VPa3Q5Sks5NEJoUEJhWUQ5M2gySHhD?=
 =?utf-8?B?LzNDeHJncHh1UWhEaWkrMGI1N0MvYkNsSE01V25FSGtISjVxWHhCNHpFT0lh?=
 =?utf-8?B?ZHJCR1pMbXY0cGhjejBWUWRxcFl6SVh2ZVRBbWxTSUpIdUt0V0lPSWJMSG11?=
 =?utf-8?B?ZTRVbWlrVW1ySHdhUXhQd1FPSEdjeHFwT3JlQVBTZlpZTkxZcFEveXduWjFm?=
 =?utf-8?B?a3IxNzFiaDI1UmdGV1Z3ZmhTYUY3NWhUUyswZnk0eHFPN2pIczhOQmRMeHhN?=
 =?utf-8?B?UmRwd0tZOFViQUptUVJhSUFPZmRZWG94T1p1ZVpCb0RiRUppd0h1YXJFbUlr?=
 =?utf-8?B?M1Z6dWFSempDUEpBdWt0SVQxdURsZW9iRkI5VW1kWER2WXA0bmU5dC9OUm9E?=
 =?utf-8?B?c1IvaVVRbnVSUzdMMXNFNGEvQ0Nld1VYN0VmU3h2K2xBd0ZMZ0V5YTNjbDNI?=
 =?utf-8?B?VVdpZGhJODdjSEhPSHpyd0ZBMUk4eFdOWFYzN0t3dVRWNVFuQlJrMnEzNWRH?=
 =?utf-8?B?NDdKU0lYWHljbGF2dWxuRytQNndlWlJwMGp2TlFLcEFheCtEcGNpZ1JMVU8y?=
 =?utf-8?B?WDdzM2w2TFl5ZmFDVG9nMTNoa0FIVGZGdkkzYjMzeWt5YTlqM1hWSkk4M2ow?=
 =?utf-8?B?eExaYTRCTXJhOWxDaGM4NlVVVVZIbFFOTVVPVjNoanpGenVxNVdDMEkxYzQ0?=
 =?utf-8?Q?YPGyHml0OmezsueMqPEeVHE3T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0ba703-ebb6-4207-b1bc-08da7c8e02d6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 18:11:00.2577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm56HklUOUzejBly+Zkgfk4kvl5aWv+y18Ap06+trlbjKvXCr/IzqmxryfrRTVZZMs51w/h6Rx5rRZ2myGhhrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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
Cc: nicholas.curtis@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-08-12 09:55, Philip Yang wrote:
>
> On 2022-08-11 15:04, Felix Kuehling wrote:
>> On systems that support SMT (hyperthreading) schedule the bottom half of
>> the KFD interrupt handler on the same core. This makes it possible to
>> reserve a core for interrupt handling and have the bottom half run on
>> that same core.
>>
>> On systems without SMT, pick another core in the same NUMA node, as
>> before.
>>
>> Use for_each_cpu_wrap instead of open-coding it.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> nit-pick below, looks better to use new_cpu as iterator, either way 
> this is
>
> Reviewed-by: Philip Yang <Philip.Yang@amd.com>

Thank you. I think I prefer cpu as the iterator and new_cpu as the 
variable that holds the CPU we choose to schedule to.

Regards,
   Felix


>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index f5853835f03a..4d1284714e7a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/bsearch.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>> +#include <linux/topology.h>
>>   #include "kfd_priv.h"
>>   #include "kfd_device_queue_manager.h"
>>   #include "kfd_pm4_headers_vi.h"
>> @@ -801,13 +802,24 @@ static inline void kfd_queue_work(struct 
>> workqueue_struct *wq,
>>                     struct work_struct *work)
>>   {
>>       int cpu, new_cpu;
>> +    const struct cpumask *mask = NULL;
>>         cpu = new_cpu = smp_processor_id();
>> -    do {
>> -        new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
>> -        if (cpu_to_node(new_cpu) == numa_node_id())
>> +
>> +#if defined(CONFIG_SCHED_SMT)
>> +    /* CPU threads in the same core */
>> +    mask = cpu_smt_mask(cpu);
>> +#endif
>> +    if (!mask || cpumask_weight(mask) <= 1)
>> +        /* CPU threads in the same NUMA node */
>> +        mask = cpu_cpu_mask(cpu);
>> +    /* Pick the next online CPU thread in the same core or NUMA node */
>> +    for_each_cpu_wrap(cpu, mask, cpu+1) {
>> +        if (cpu != new_cpu && cpu_online(cpu)) {
>> +            new_cpu = cpu;
>>               break;
>> -    } while (cpu != new_cpu);
>> +        }
>> +    }
>>         queue_work_on(new_cpu, wq, work);
>>   }
>
>     for_each_cpu_wrap(new_cpu, mask, cpu + 1) {
>         if (cpu != new_cpu && cpu_online(new_cpu)) {
>             cpu = new_cpu;
>              break;
>         }
>     }
>     queue_work_on(cpu, wq, work);
>
