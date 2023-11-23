Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9018C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 19:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C97110E33B;
	Thu, 23 Nov 2023 19:08:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFC410E33A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 19:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRBlVfpMlDZ4PE60S/eDNxOm8ng0oufi48+Lk+q1pYxDKqLvUfAapSgF1tx9e7A2+6c3oK5l8lsmFKLscQLRwH3a/NbH57KAe/CP9M/ZZrTRfNqpXTTAYzXU/6OJtwz4TkZJce2Ew6AUqlOCRdj4SANrMghxPHRMuCKyuMsqBpsG1C4qhJq41J0bGSw+JIOd2N4Yb+6zaqZSBErMhbZv+3Ommr+XeUyU9sxVyIJbG9vKJ8x+uaipdOkDIGxpVuDiGBfhU7Pe3FKZRcsT5zpGWH3YTNK/B5tGb6e1zduM4m6jPo5g6Ry5p06QvF4b3sVEYpsW55KllkVXS1B5qOFzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr+ufcilPqaq8OOuEsqnJeOSV9EZbj5AJuT8kFB/AEw=;
 b=PEuxgYo7vUZg56ZgOPfhwWO4DXM5cu4KvzBAz5VBeOCjgd6cl4X90+8YodnkbmsAyh5S6J+z0OQKVKpO9VCMna/vv8ycLIp7aiwY+J3z2O8LX71uHf45/A/SPZiafzI8/IaE/lySPco7tkzGqyumRdIHnr77WJTrmj8vHeueclZvrextgwZSD+zgFGivt02UpDBcnYmmgZM3xRx83GPY3L4+jZU4ilsprPceQRtDM8Jx5rMmQ/aPgwiRDVFrkmYR5QVq/ILV/7B6ygsewcXZbSZ6Zad7PFzj1E6/PhT2Ot7haFmwOgQZ6ZYZdrqvq0fCjIMvTlSBFqq4L4wLW3aW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr+ufcilPqaq8OOuEsqnJeOSV9EZbj5AJuT8kFB/AEw=;
 b=eUvs9f73fgiZCdWo93Z099WWBeDTSsClri/NGF5NnVS3ZO9NqylqWfRr3uraxXod4ypv/d9FyKkpWbUEKjTX6NJRB2Wc7YCgBRKAJyAlUitDe8hP/d/teGkG2fExAWH8Z9aR2np9swxpli9U+fhcqTmM/1tT3wRjP/9bvGcodhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 19:08:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 19:08:49 +0000
Message-ID: <d4fce6da-370a-4c9e-b6b5-ef2b875b9eb2@amd.com>
Date: Thu, 23 Nov 2023 14:08:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] drm/amdkfd: enable pc sampling work to trigger trap
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-21-James.Zhu@amd.com>
 <6738fe40-7051-4b5c-9151-3eb7428c9d00@amd.com>
 <9b4c3574-a341-483e-95ef-6be9784a59a5@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <9b4c3574-a341-483e-95ef-6be9784a59a5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: debe7565-d71d-4288-eb31-08dbec579f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Pps1+U5GKEKnsJiUsYhaeCEz/5lApmEzQeXBafmL7DR2HrlqW6vw+NUdVX78A6zBkRcyiH6gkCTullUkqQeM5EvMd11vcLlv71yNOkQ6tmM5jtFOetgiisCbd37D2Jx6nNT13tJMDVtHDrYddOuy+KDfnm+M4yJS+0J7czogyWQfq57Hy0Z43it8XENHLbSCuvBjc2SogdCPjYAr/Shf9QD6mhJz7pWqDBJogNlLgWG7jKDwEczM8IAahIwv2Wr/nQvc7I/CvY8bblLn4drv9SM96Z7um+mjx+7zG+lkUaG9g34yx40zpWEBkhiKiSxfX3kupDCNsfzU/WNP/2DqzMSjAUzyWpu2Jm7BgFrIRKu6NVt7XEYxLv2LPOBB9imQdDMRr0fjal1EPkPSVTiBEyjLs4t1ROLi5LmjFmqi93iKviUXo/E4xzmWUpBENYizM2x82ru8QXlWMknPjHoXw/E+JQ7iAX2LfO+/7kCtXD2oz/rInGuqDVeKFGBUUy3cFNQgityDdfK5dY/WKL1AZ9epTc+QHmphLqYbmqy2H0kh3RaFccrwb1ZYkrwAKZPHQ8tYfTVO/Bp9Y3XNAzhQBa6Qs8Bc+kW1qM7pMpHuEBDwY9meowm2xZr7cuEmwRRZjBj5DxxQMg6EA3P+QRwSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4001150100001)(5660300002)(44832011)(2906002)(4326008)(8936002)(8676002)(41300700001)(66556008)(66476007)(316002)(66946007)(110136005)(6666004)(478600001)(6506007)(6486002)(36916002)(53546011)(31686004)(26005)(2616005)(6512007)(38100700002)(83380400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NMWmdzdGhNek9taFVyTExzNlowcEVVS29paWhlekFrNloySk9pQUZSSGJh?=
 =?utf-8?B?VGR2bTVVMG5INnhWMXFBNEVCL0sxc3V1NWFCTmF4Wk45ME11bnlGUkxnalpt?=
 =?utf-8?B?QXg2TDNyU2ZuQllrdCs3NWJRSDhCWnBoSUR4NDI0VmV3aGN1Z29ZdCsvZ3Iv?=
 =?utf-8?B?ek9NdTM5dFJxbFJXcWprM29KcDJFWWpsVTdtSVhQaEUrZ0dCemxFc2N3cERh?=
 =?utf-8?B?TlI1SVZndlVFdmpIRXBhNWkxeVlQOFYvdTJmWjVkK0Z1T0hIT3cyVHlOUDJD?=
 =?utf-8?B?ekhjUmJVbUZTT2QvZ3kxZTBqRC9WQWpZMFVjanJXQklqSFFhaUhka2hsTnRB?=
 =?utf-8?B?QStjT0twektxTTlYN1JOMkpiMFp3MmZrdVRCaGd5emJ3K2FsMWhHQjVUek9i?=
 =?utf-8?B?NWJsaVYxZUVUYkdKMzFmdWQvcW9PT3d6SVpKV05JVDkwRWk5MUIxdTNWWTFk?=
 =?utf-8?B?NDRCbXJzcVlOcEpJUndjZWthcFZ6UjFyaXJYNFVpVGRQSHpTY2dZbTl3RUQ3?=
 =?utf-8?B?SWVLbXNhN2tGQzlLY2Q4ZmlwUDc5dmQxdU8ycVgxY3Zqd0RzQmVpVEpBM3ZZ?=
 =?utf-8?B?WEpjYjRGY1czYllWWTJNNVJuYk01TXJiOXZ2NTZuSzk5ZktnUkRHbFh1TlBy?=
 =?utf-8?B?YjJjclp1ZjZoOGlmVTJwc0kvZW9UQmlEemZBdzZVMmxXZmcvWWcrMENmSG1m?=
 =?utf-8?B?N1NuL0lLYVg3cU1aTkdYVE5RWmlIV3htY240Z2FydFpjM1NTTXZXUHR5WlNt?=
 =?utf-8?B?MXVpMEJId0ErN0MvdS8yUktjL29Dc09BcGt5b0wydGJhd3grR1BkM1hvNkV4?=
 =?utf-8?B?eHdmMmh0UTlrT1FYYjZ6SUJYbTNnU2xPMkJteDYvMW80SHl2OHZXeFlKeGl6?=
 =?utf-8?B?RHF4bE5lbmU0OVVWS2FpRm1PQ2dFaE84UmVCQ1o5ZHBWMHpXaFV3S2lsVFNr?=
 =?utf-8?B?QUVGUEd2N1d4NFBiSCtVUmMycmRJVVN4YmJRYnZaVng2VmV4ZjJ3MzhlSHhJ?=
 =?utf-8?B?cWhFSnVyb0FJNlhiVFBpV3Fsb3NtZGxwSmE2Rm1nUis5WFN3N1JKbVRmdEpk?=
 =?utf-8?B?K1I5N1hNNU9RaVJ0KzdtVHltWlpHZGRtcisxbEdWM2tSOEk4QnR2dG4yZ0Zw?=
 =?utf-8?B?OHBwS1dQZW8zMmRJSFMyUzRudHYvTW1pelN6RVVTS01Zdlo3bnVEOTZpU2hY?=
 =?utf-8?B?V1JObVpGTk5hWGFNRXdkUFVZUUdpT1N1VGI5RzhibFk4R2svTjAvNFplUUVz?=
 =?utf-8?B?QndxQXZVaDY5ZytGYUhHM2RTRFpCSHpPRnFEdWdubURVUDVCQWFzUS9tRktx?=
 =?utf-8?B?M0tMOTZzUkR2cnRPU3ZabU1sRDJhTU8rQk15ME1iQmY3MHIwQWNMUFZNMmkr?=
 =?utf-8?B?bzZIQkQvOGl1SkprUkhWcHBBL1hmTmNSV29BYS9wT0hGTTNCZW1BMXo4ekMw?=
 =?utf-8?B?S3VlZ1RmU2xBemQrbmJGdnpsZWRUSGZTM1VHWGJHNEt1bjF0Y3dZM1NzN0tN?=
 =?utf-8?B?elZOazcwZUlzd1V1b0lISmxjNDBLVThqa1h5c2ZuWVZrWmovaThSMXhSV1kx?=
 =?utf-8?B?TzFYb1A1QklkUi9BQ1B6WUcrcmE1aGt4VThqK3d0Um1GTFoxM0xQYnQzeEsz?=
 =?utf-8?B?b3NtOVpHVTFkTDRCQ0ZGWUJES1kxZU1VaHFNakY1UFNFYUEzdENKZzNiS21Y?=
 =?utf-8?B?ZkgrR21VWm14OWxLYXlEZklOY2phMkIrZWlOSFBhVDV5M1VHV2Zqb2hsR0pK?=
 =?utf-8?B?TXFYUkZkWW94RjI4ckpyejFiSm5HdHZwOEdscVVqdTNVc1NkWityejljc1Aw?=
 =?utf-8?B?M0xzZzV6OFlmenEzWWNaSGIvQ3RFaG9nZjlCMjBMbzhFWmZVYkRsR29ZcWIx?=
 =?utf-8?B?eUd3MnkrcTBBbnJVME0vOWZ3aHJ3MlpKZVVsem5JZ3BhRVZ3S2RDUmVobC9W?=
 =?utf-8?B?RWRMUWlZK2Z2QUY4cXNjT1FPRFBKM0tGRkRqTVNjMjJqNytGTUs1Z1NPTzlN?=
 =?utf-8?B?Z2R4NjJXeHNmQkV3ZHBuRHpGMGRqdjROMHJmdWFpWDRvWHU1SGJzc3dYYlpY?=
 =?utf-8?B?b0F6NFNiZU1LTStoRm9pQ3FlQzE2Y1Jhc1JaMHpqam5NdXU1Wm14K1dVSU9I?=
 =?utf-8?Q?WW1aef1b54VvCkT84UZM9nGO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debe7565-d71d-4288-eb31-08dbec579f8d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:08:48.7672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1/6CGg3JcS+LJ9njTGk7kw6hTDgWmHEnwZenK98aQUQy4zwyj64CmwtCOIOMK+5+nTC0gVv7x6fVPcd1ZuSew==
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

On 2023-11-23 13:27, James Zhu wrote:
>
> On 2023-11-22 17:31, Felix Kuehling wrote:
>>
>> On 2023-11-03 09:11, James Zhu wrote:
>>> Enable a delay work to trigger pc sampling trap.
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  3 ++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 39 
>>> ++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  1 +
>>>   4 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index bcaeedac8fe0..fb21902e433a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -35,6 +35,7 @@
>>>   #include "kfd_migrate.h"
>>>   #include "amdgpu.h"
>>>   #include "amdgpu_xcp.h"
>>> +#include "kfd_pc_sampling.h"
>>>     #define MQD_SIZE_ALIGNED 768
>>>   @@ -537,6 +538,8 @@ static void kfd_pc_sampling_init(struct 
>>> kfd_node *dev)
>>>   {
>>>       mutex_init(&dev->pcs_data.mutex);
>>> idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
>>> + INIT_WORK(&dev->pcs_data.hosttrap_entry.base.pc_sampling_work,
>>> +        kfd_pc_sample_handler);
>>>   }
>>>     static void kfd_pc_sampling_exit(struct kfd_node *dev)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> index 2c4ac5b4cc4b..e8f0559b618e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> @@ -38,6 +38,43 @@ struct supported_pc_sample_info 
>>> supported_formats[] = {
>>>       { IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
>>>   };
>>>   +void kfd_pc_sample_handler(struct work_struct *work)
>>> +{
>>> +    struct amdgpu_device *adev;
>>> +    struct kfd_node *node;
>>> +    uint32_t timeout = 0;
>>> +
>>> +    node = container_of(work, struct kfd_node,
>>> + pcs_data.hosttrap_entry.base.pc_sampling_work);
>>> +
>>> +    mutex_lock(&node->pcs_data.mutex);
>>> +    if (node->pcs_data.hosttrap_entry.base.active_count &&
>>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.value &&
>>> +        node->kfd2kgd->trigger_pc_sample_trap) {
>>> +        switch 
>>> (node->pcs_data.hosttrap_entry.base.pc_sample_info.type) {
>>> +        case KFD_IOCTL_PCS_TYPE_TIME_US:
>>> +            timeout = 
>>> (uint32_t)node->pcs_data.hosttrap_entry.base.pc_sample_info.value;
>>> +            break;
>>> +        default:
>>> +            pr_debug("PC Sampling type %d not supported.",
>>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.type);
>>> +        }
>>> +    }
>>> +    mutex_unlock(&node->pcs_data.mutex);
>>> +    if (!timeout)
>>> +        return;
>>> +
>>> +    adev = node->adev;
>>> +    while 
>>> (!READ_ONCE(node->pcs_data.hosttrap_entry.base.stop_enable)) {
>>
>> This worker basically runs indefinitely (controlled by user mode).
>>
>>> + node->kfd2kgd->trigger_pc_sample_trap(adev, 
>>> node->vm_info.last_vmid_kfd,
>>> + &node->pcs_data.hosttrap_entry.base.target_simd,
>>> + &node->pcs_data.hosttrap_entry.base.target_wave_slot,
>>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.method);
>>> +        pr_debug_ratelimited("triggered a host trap.");
>>> +        usleep_range(timeout, timeout + 10);
>>
>> This will cause drift of the interval. Instead what you should do, is 
>> calculate the wait time at the end of every iteration based on the 
>> current time and the interval.
> [JZ] I am wondering what degree of accuracy is requested  on interval, 
> there is HW time stamp with each pc sampling data packet,
>>
>>
>>> +    }
>>> +}
>>> +
>>>   static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
>>>                       struct kfd_ioctl_pc_sample_args __user 
>>> *user_args)
>>>   {
>>> @@ -101,6 +138,7 @@ static int kfd_pc_sample_start(struct 
>>> kfd_process_device *pdd,
>>>           } else {
>>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
>>> + 
>>> schedule_work(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>>
>> Scheduling a worker that runs indefinitely on the system workqueue is 
>> probably a bad idea. It could block other work items indefinitely. I 
>> think you are misusing the work queue API here. What you really want 
>> is probably, to crease a kernel thread.
> [JZ] Yes, you are right. How about use  alloc_workqueue to create 
> queue instead of system queue, is alloc_workqueue more efficient than 
> kernel thread creation?

A work queue can create many kernel threads to handle the execution of 
work items. You really only need a single kernel thread per GPU for 
time-based PC sampling. IMO the work queue just adds a bunch of 
overhead. Using a work queue for something that runs indefinitely feels 
like an abuse of the API. I don't have much experience with creating 
kernel threads directly. See include/linux/kthread.h. If you want to 
look for an example, it seems drivers/gpu/drm/scheduler uses the kthread 
API.

Regards,
   Felix


>>
>> Regards,
>>   Felix
>>
>>
>>>               break;
>>>           }
>>>       }
>>> @@ -123,6 +161,7 @@ static int kfd_pc_sample_stop(struct 
>>> kfd_process_device *pdd,
>>>       mutex_unlock(&pdd->dev->pcs_data.mutex);
>>>         if (pc_sampling_stop) {
>>> + 
>>> cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>>> index 4eeded4ea5b6..cb93909e6bd3 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>>> @@ -30,5 +30,6 @@
>>>     int kfd_pc_sample(struct kfd_process_device *pdd,
>>>                       struct kfd_ioctl_pc_sample_args __user *args);
>>> +void kfd_pc_sample_handler(struct work_struct *work);
>>>     #endif /* KFD_PC_SAMPLING_H_ */
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index badaa4d68cc4..b7062033fda4 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -263,6 +263,7 @@ struct kfd_dev_pc_sampling_data {
>>>       uint32_t target_wave_slot;  /* target wave slot for trap */
>>>       bool stop_enable;           /* pc sampling stop in process */
>>>       struct idr pc_sampling_idr;
>>> +    struct work_struct pc_sampling_work;
>>>       struct kfd_pc_sample_info pc_sample_info;
>>>   };
