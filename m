Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3F8C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 15:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF3810E0E4;
	Mon, 30 Oct 2023 15:16:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B83910E0E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 15:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsnIS4odXSEcqmmtZpkWU6BscY701QPucNJxegClOZLqxPCFkM9WpOsyQGJ5HUtCFhWosvXAD47N9UQSurdTu/IgTcI/4CZ1LktXiWRaFe7n1lpcLo5KNgt+opxehiS1NMdyD21dKa8Q19CCjiMETP9OfIYPPnJRKKdfFbwUGWRZNHadTuKT7dS3MaT450ymPtBu+ptQyiPS3Uns9MlPiZezMu21HAKdeqU83fuRco/JtqFd6XsXih2cpg/iGUue7EpPnhZfEUlJx+QdxO5SXRwtiTOm+vJJfZ1h2bf8OCBhTRJ+waJWnq5WZc01t33y/8F1RVO0/JjP5ciFUUwn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXOWE2tLnPk2MQinE2D4Mve13XzncUA1rpbiJLJKMSc=;
 b=JqWNaue7bhIYE3LyoaNyJVq7x7yuDb/oD17lHy8XnwFkpnL1sXVdEiiUKaxDn49pnLInjQiOcfFjaImyhNok+NjUqbLDg+TQqgfKraOyHm6srEoH1YR6myvqDbz5sR2w5D5rNWM6UcrrD4Hh9QHQKPmi2s6tKl5L2yiqnR22AMXHtRugI0gqiSC5Vd/A9V1T/TM2B59NY3VDQ2qSb9/CRcXSXtNWu5pTZHoQcdFb1TJx6ITfBegP3viZdJWzNEvwUMdv80oDU2dU/eh1ZzJQeOHkODUEHILrZuGeyjt/0fkr93+Pcwv2Bx5FWNQDfK1MvLQSVLM+JU1YITnwww2h5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXOWE2tLnPk2MQinE2D4Mve13XzncUA1rpbiJLJKMSc=;
 b=CL1t58hdi+4QWCkRV2Km1ePb429QxTiTJ3fc67DTpDMGs0AH5z/cS7IiE4ZpXHkLAp1vbxHFH+qmDMAZs/Uq+d4DhjqiVx6lMCvMN2NtJ1nRjrIHh9QoEKPqhfgfcNOhEYo6GuX5pVqm5qJti5x/N4G3llXEjLsiyPoj6FEY5+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 15:16:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 15:16:22 +0000
Content-Type: multipart/alternative;
 boundary="------------IcL8KoAt6epM1V42TZRuQU7S"
Message-ID: <da7010c1-6b11-41f6-986d-796539073451@amd.com>
Date: Mon, 30 Oct 2023 11:16:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdkfd: Run restore_workers on freezable WQs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
 <8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com>
X-ClientProxiedBy: YQBPR0101CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: c88da6e6-c4f7-4f65-a565-08dbd95b2d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcSBhI7ATMQn4qW6zuyDbT6UjyQAk+jwsfj+oxk+r5LxmP3O/mSb74dw6Ww0LlDIHEtYqz5iydSTmduOqSjha+Qowa7I2ipCmVaFOC2H337Sz5apoFId4PGLXyUBzV7Ie4ZlcfKB/LeZV4EygxThzlcCPji635rjQgdDk9ddzpEGcWaWo9sZ3RUbeKUOf34ypgRyT20PGSZL8cEXdh4QLgFWytYoDv9R1RhPW+d2Xb2kUHPJ1X+sWfaDCOtwOzHmIkFAN9zmlphhcymnlUbBlHKG49Dg7JGhrgY+l7Rr0kIOz1eg0UJv8ueNci7oafHjBcPLub5RhqBy8IAFm3tpsIwh14CuHBkW7nb+gjvqp9MQiaG8fRoo6zysNf/kPZJisHGZjGfcJY9hdgfOnpje6qapP8KcmeoADx78Se9NZRZvLI3Dk25TvOEeKXzSKL8E13FHfNnLmkgDUZ1/ntoiwhWZPwDWXwfQU15DiHxB7yPQEN0bZVPVdBfaHyAG/lM42cuA+eqwPzeDFYYiN5cVf1O7GVoprDGREDEMT3rysEHldznwgoTUR8YqzuZJ+gjMqqURloWRW0pL8Q9vaPbedlMQF6a2OGia7TJC+NRZGLgYLcTHpQfJKGNvIhWpT125yxHKK30miGLHlrqj7YNR2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(6486002)(478600001)(6512007)(6506007)(33964004)(53546011)(45080400002)(8676002)(8936002)(4326008)(66476007)(66556008)(66946007)(316002)(44832011)(5660300002)(2906002)(41300700001)(30864003)(4001150100001)(83380400001)(66574015)(26005)(2616005)(86362001)(31686004)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZTV3ZXMENVWlJwVXpVaFg5Q2dRZlNHNzF6Nk4zM2xxQXFtZlV1TURsRGJl?=
 =?utf-8?B?SXA3YWlwdFJaYmpLSjkxM1B1R2RyWVpDZWk3bEFjYWw4Y1lWU2dCOWxvR1pi?=
 =?utf-8?B?aDFMOTBia1BiQ0tsQkVZNHBvSjZQNERkbUl4U2ZvQ2JueHZ6ZUVrQWVNTTZF?=
 =?utf-8?B?QXlqdHkzYW5qTlV6T1FoSDRLMXdaYmhzR0d1N05lc1BLTEtnWW9ZdVErWnpX?=
 =?utf-8?B?cGJ6NXVCNEMyeHphaHJJcUZvcnFjd3prb1dhUFlSVW5YV2tMcWZDK0RiYmRC?=
 =?utf-8?B?WjJvdjdNbzIwaTBoMkViMmJ4bTNRWC9EVTNaSVU4OEdkUVJtanRLaDQ3NFRq?=
 =?utf-8?B?OEVtRFpYdEhyT2doU3hyK29OS090aUdzNVBBT1BvL3NMbUNBcWlLWUxKVkFW?=
 =?utf-8?B?OGlOcWZhSC9YbXY3MkIwNUltWFNFUXlwRjg4Sit6R0ZDL3ZDQitjRytsd1l3?=
 =?utf-8?B?bWozYytmTE9ydmZtT2wrRzIvcW1qTXJiVTRsSTZML3VMeTdjRlRYN2NmTWNi?=
 =?utf-8?B?YkJvanBXemJMSnljbHFQaTRyaDNRKzNzZy9FUjdYNDJ0MTYxUkI3MCtTKy92?=
 =?utf-8?B?ZWJsbXR5bldhaVkydXgxV1FleW5hdHNjSEVRR2ZNRUJtSnFCOXZwRFNEamFD?=
 =?utf-8?B?WGNxL01mTkJpOU1hUnh5amxGOHdOVzVxVWwwK3JsVC8xMDVOYjVycUhmdk1F?=
 =?utf-8?B?bW9oTFZYN0FFY3U5QTRPdnBpMlFzNlhxbkFBcnhxQVQ2YXk0dXlNZjJPYTln?=
 =?utf-8?B?d2hob2p2Yk1UeXQraEtBdjVhTzNMbmpYcms0TGhPWGdMTWY5WEhmS0l5ci9m?=
 =?utf-8?B?RmNUQjNtM3FRdjlQWHV3YlV2L1dROUtXRDBCZ0tmWkljZFZVaWplNHVyeVpE?=
 =?utf-8?B?TzMxR2krY0J3eFJ6MTVUNEovRlJoSnJZem5KL1BhU1U5K09JbkpXWFhpTkpr?=
 =?utf-8?B?aUpMclN2RWdmRldYeTIzSVZWVU1IVFNCVFByciswMmNKNVdOQ1lWSk4wY0Ry?=
 =?utf-8?B?c2V6bTZDdENveER4WDJRZFdoejA1aUF2dFUwd0dUNmcyRUczbGhIR2pmS25B?=
 =?utf-8?B?aWdGYm9pNXBTNGg2QzFsdElZSkR4UGtjM2hndmRwVXpVQmZOYk10SUhCektE?=
 =?utf-8?B?S0hZK0ljcXh5Mzh5NWFYZFN2K0ljM3R5VGptNzVTRHBCellhUHBocVF1RnE2?=
 =?utf-8?B?UjNKMlk5Ym53MEpFY054RHB3ci9NQ2p2VzRXWkl0STJhMnBqeUFRTzQwajZI?=
 =?utf-8?B?dVlpODA1d01NTW5VdWdvdW5ud0dWVlRDTmZTVWNaWWMxOUdXZ0RxckNlOTFl?=
 =?utf-8?B?WFdBd2lodFN0WDJKRDA0T1RSODEvN2JWMmlEME91U3J5YTV4MjE1b2E0bkFG?=
 =?utf-8?B?NThOT2dFY3pVUy9melJwWm80ekpMaG5vNmFpVHRicmFRNHRpYTNUTnBSK0dC?=
 =?utf-8?B?WFZxU2d0dHhpcGJHSjB2T3JEMW1aamg0UndzWUt4a3YrSy82ZW9ZUTYzZGFW?=
 =?utf-8?B?c3l6d21WQjdvM3FRWWZIdnF6WXd4bzF3WlhRVm1YbHl6azZmUk93T2EyM2FJ?=
 =?utf-8?B?SkM4Ri9wYUE4WXZFajNhTDd1ZGNtcGhLd0ZTUC8xSzdTcHEweGlLeURhTU9l?=
 =?utf-8?B?T1U2KzNNdnpCTFQvUmFkMTF3NXVwNVpuYm4yM2oxaDU5T000YjlnVlBjSWlY?=
 =?utf-8?B?RjdXREN3UmlmclFRVDNTd1hRRERydHF2NXhuUXZaZlNKcU9Vc2s3TTZ5TFdH?=
 =?utf-8?B?YXRZM0pDcUtxS01ETlhvb05NM1RETHlYdDV6K0pqbm42WFVMRlljWU1iZ0dV?=
 =?utf-8?B?NmtQZS9naFNLZzZCdmtWNmlZTzhsckNWVy90MnhZakJ6ZFdJQ2Z0Wk8wSFZX?=
 =?utf-8?B?Z3dmYnFFcnRFYTc2Y3hGYjljT1J0M2k2WW1YYWZSa2lZdjZ1Y1EvajVKSW9N?=
 =?utf-8?B?V2k4QVJzZlhSMGI4YUdUaFIzTXlGZ0k0dVJzekk5MjF0QkJBbUVaNTZNdUlV?=
 =?utf-8?B?VHVkQjAvelFTR3kzMEZvV05zUnZaT1BUVk1zMk02anRYZXJ1T0N6bEE3OVhV?=
 =?utf-8?B?b0V4VDhKdjA5cmR6aVZhSWMvZjZ6YVRnd0VYTGFSNnJQL1RWYk5nT2pzOWFX?=
 =?utf-8?Q?vKdaRoTNWN5F56kvSYOHF6eWy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88da6e6-c4f7-4f65-a565-08dbd95b2d2b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:16:22.8237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IE1Ik+Cd3YX9bR8VOsD9a8FTOAXqZIMQuatVUmwl1mQ699TWSJ6mT3u/eRATpro3hbQssAXR1xpFpZYsXzqeMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------IcL8KoAt6epM1V42TZRuQU7S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-10-30 4:23, Christian König wrote:
> Am 28.10.23 um 00:39 schrieb Felix Kuehling:
>> Make restore workers freezable so we don't have to explicitly flush them
>> in suspend and GPU reset code paths, and we don't accidentally try to
>> restore BOs while the GPU is suspended. Not having to flush restore_work
>> also helps avoid lock/fence dependencies in the GPU reset case where 
>> we're
>> not allowed to wait for fences.
>>
>> This is an RFC and request for testing. I have not tested this myself 
>> yet.
>> My notes below:
>>
>> Restore work won't be frozen during GPU reset. Does it matter? Queues 
>> will
>> stay evicted until resume in any case. But restore_work may be in 
>> trouble
>> if it gets run in the middle of a GPU reset. In that case, if anything
>> fails, it will just reschedule itself, so should be fine as long as it
>> doesn't interfere with the reset itself (respects any mechanisms in 
>> place
>> to prevent HW access during the reset).
>>
>> What HW access does restore_work perform:
>> - migrating buffers: uses GPU scheduler, should be suspended during 
>> reset
>> - TLB flushes in userptr restore worker: not called directly, relies on
>>    HWS to flush TLBs on VMID attachment
>> - TLB flushes in SVM restore worker: Does TLB flush in the mapping code
>> - Resuming user mode queues: should not happen while GPU reset keeps 
>> queue
>>    eviction counter elevated
>> Ergo: Except for the SVM case, it's OK to not flush restore work before
>> GPU resets. I'll need to rethink the interaction of SVM restore_work 
>> with
>> GPU resets.
>
> It also sounds like the restore work is some high level work and 
> shouldn't interact with the lower level GPU reset.

That was my hope as well. Just trying to think through to make sure I'm 
not making any incorrect assumptions.

Do you know if there is anything preventing a TLB flush using MMIO from 
messing up a GPU reset in progress? That's the only thing in the SVM 
restore work that tries to touch HW directly.


>
>>
>> What about cancelling p->eviction_work? Eviction work would normally be
>> needed to signal eviction fences, but we're doing that explicitly in
>> suspend_all_processes. Does eviction_work wait for fences anywhere? Yes,
>> indirectly by flushing restore_work. So we should not try to cancel it
>> during a GPU reset.
>>
>> Problem: accessing p->ef concurrently in evict_process_worker and
>> suspend_all_processes. Need a spinlock to use and update it safely.
>> Problem: What if evict_process_worker gets stuck in flushing 
>> restore_work?
>> We can skip all of that if p->ef is NULL (which it is during the reset).
>> Even if it gets stuck, it's no problem if the reset doesn't depend on 
>> it.
>> It should get unstuck after the reset.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 49 +++++++++++++------
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
>>   4 files changed, 44 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 54f31a420229..89e632257663 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1644,7 +1644,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
>>           goto out_unlock;
>>       }
>>       WRITE_ONCE(pinfo->block_mmu_notifications, false);
>> -    schedule_delayed_work(&pinfo->restore_userptr_work, 0);
>> +    queue_delayed_work(system_freezable_wq,
>> +               &pinfo->restore_userptr_work, 0);
>>     out_unlock:
>>       mutex_unlock(&pinfo->lock);
>> @@ -2458,7 +2459,8 @@ int amdgpu_amdkfd_evict_userptr(struct 
>> mmu_interval_notifier *mni,
>>                          KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>>           if (r)
>>               pr_err("Failed to quiesce KFD\n");
>> - schedule_delayed_work(&process_info->restore_userptr_work,
>> +        queue_delayed_work(system_freezable_wq,
>> +            &process_info->restore_userptr_work,
>> msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>       }
>>       mutex_unlock(&process_info->notifier_lock);
>> @@ -2793,7 +2795,8 @@ static void 
>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>         /* If validation failed, reschedule another attempt */
>>       if (evicted_bos) {
>> - schedule_delayed_work(&process_info->restore_userptr_work,
>> +        queue_delayed_work(system_freezable_wq,
>> +            &process_info->restore_userptr_work,
>> msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>             kfd_smi_event_queue_restore_rescheduled(mm);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 9cc32f577e38..cf017d027fee 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -919,6 +919,7 @@ struct kfd_process {
>>        * during restore
>>        */
>>       struct dma_fence *ef;
>> +    spinlock_t ef_lock;
>>         /* Work items for evicting and restoring BOs */
>>       struct delayed_work eviction_work;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index fbf053001af9..a07cba58ec5e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
>>       if (!kfd_process_wq)
>>           kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
>>       if (!kfd_restore_wq)
>> -        kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
>> +        kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
>> +                             WQ_FREEZABLE);
>>         if (!kfd_process_wq || !kfd_restore_wq) {
>>           kfd_process_destroy_wq();
>> @@ -1460,6 +1461,7 @@ static struct kfd_process *create_process(const 
>> struct task_struct *thread)
>>         kref_init(&process->ref);
>>       mutex_init(&process->mutex);
>> +    spin_lock_init(&process->ef_lock);
>>       process->mm = thread->mm;
>>       process->lead_thread = thread->group_leader;
>>       process->n_pdds = 0;
>> @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct kfd_process 
>> *p, struct kfd_node *node,
>>       return -EINVAL;
>>   }
>>   +static void signal_eviction_fence(struct kfd_process *p)
>> +{
>> +    spin_lock(&p->ef_lock);
>> +    if (!p->ef)
>> +        goto unlock_out;
>> +    dma_fence_signal(p->ef);
>
> This needs to grab the internal lock of the eviction fence, I'm not 
> sure that has correct ordering with the newly added ef_lock.

Hmm, the only thing we could get a circular lock dependency would be, if 
we took the p->ef_lock in a fence callback. I don't think that ever 
happens, because even the eviction work runs on a worker thread (exactly 
to avoid such lock dependency issues).

Anyway, I could try to move the fence_signal out of the critical 
section. The lock is only there to ensure that exactly one process 
signals and frees the fence.

	spin_lock(&p->ef_lock);
	ef = p->ef;
	WRITE_ONCE(p->ef, NULL);
	spin_unlock(&p->ef_lock);
	if (ef) {
		dma_fence_signal(ef);
		dma_fence_put(ef);
	}


>
>> +    dma_fence_put(p->ef);
>> +    WRITE_ONCE(p->ef, NULL);
>> +
>> +unlock_out:
>> +    spin_unlock(&p->ef_lock);
>> +}
>> +
>>   static void evict_process_worker(struct work_struct *work)
>>   {
>>       int ret;
>> @@ -1916,8 +1931,11 @@ static void evict_process_worker(struct 
>> work_struct *work)
>>        * lifetime of this thread, kfd_process p will be valid
>>        */
>>       p = container_of(dwork, struct kfd_process, eviction_work);
>> -    WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
>> -          "Eviction fence mismatch\n");
>> +    /* If the eviction fence is not valid, we're probably in a suspend
>> +     * or GPU reset cycle. There is nothing to do in this case.
>> +     */
>> +    if (!READ_ONCE(p->ef))
>> +        return;
>
> This evict process work is high level I don't think it should have any 
> dependency on the GPU reset.

Right. This is not here to avoid issues, just a short-cut to avoid 
unnecessary work.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>         /* Narrow window of overlap between restore and evict work
>>        * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
>> @@ -1930,9 +1948,7 @@ static void evict_process_worker(struct 
>> work_struct *work)
>>       pr_debug("Started evicting pasid 0x%x\n", p->pasid);
>>       ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>>       if (!ret) {
>> -        dma_fence_signal(p->ef);
>> -        dma_fence_put(p->ef);
>> -        p->ef = NULL;
>> +        signal_eviction_fence(p);
>>           queue_delayed_work(kfd_restore_wq, &p->restore_work,
>>                   msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
>>   @@ -1967,9 +1983,19 @@ static void restore_process_worker(struct 
>> work_struct *work)
>>         p->last_restore_timestamp = get_jiffies_64();
>>       /* VMs may not have been acquired yet during debugging. */
>> -    if (p->kgd_process_info)
>> +    if (p->kgd_process_info) {
>> +        struct dma_fence *ef = NULL;
>> +
>>           ret = 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
>> -                                 &p->ef);
>> +                                 &ef);
>> +        if (!ret) {
>> +            spin_lock(&p->ef_lock);
>> +            WARN_ONCE(p->ef, "Eviction fence is not NULL");
>> +            WRITE_ONCE(p->ef, ef);
>> +            spin_unlock(&p->ef_lock);
>> +        }
>> +    }
>> +
>>       if (ret) {
>>           pr_debug("Failed to restore BOs of pasid 0x%x, retry after 
>> %d ms\n",
>>                p->pasid, PROCESS_BACK_OFF_TIME_MS);
>> @@ -1994,14 +2020,9 @@ void kfd_suspend_all_processes(void)
>>         WARN(debug_evictions, "Evicting all processes");
>>       hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>> -        cancel_delayed_work_sync(&p->eviction_work);
>> -        flush_delayed_work(&p->restore_work);
>> -
>>           if (kfd_process_evict_queues(p, 
>> KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>>               pr_err("Failed to suspend process 0x%x\n", p->pasid);
>> -        dma_fence_signal(p->ef);
>> -        dma_fence_put(p->ef);
>> -        p->ef = NULL;
>> +        signal_eviction_fence(p);
>>       }
>>       srcu_read_unlock(&kfd_processes_srcu, idx);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index fe937670c927..aa6c34127be9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct 
>> work_struct *work)
>>       /* If validation failed, reschedule another attempt */
>>       if (evicted_ranges) {
>>           pr_debug("reschedule to restore svm range\n");
>> -        schedule_delayed_work(&svms->restore_work,
>> +        queue_delayed_work(system_freezable_wq, &svms->restore_work,
>> msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>>             kfd_smi_event_queue_restore_rescheduled(mm);
>> @@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange, 
>> struct mm_struct *mm,
>>               pr_debug("failed to quiesce KFD\n");
>>             pr_debug("schedule to restore svm %p ranges\n", svms);
>> -        schedule_delayed_work(&svms->restore_work,
>> +        queue_delayed_work(system_freezable_wq, &svms->restore_work,
>> msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>>       } else {
>>           unsigned long s, l;
>
--------------IcL8KoAt6epM1V42TZRuQU7S
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-10-30 4:23, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com">Am
      28.10.23 um 00:39 schrieb Felix Kuehling:
      <br>
      <blockquote type="cite">Make restore workers freezable so we don't
        have to explicitly flush them
        <br>
        in suspend and GPU reset code paths, and we don't accidentally
        try to
        <br>
        restore BOs while the GPU is suspended. Not having to flush
        restore_work
        <br>
        also helps avoid lock/fence dependencies in the GPU reset case
        where we're
        <br>
        not allowed to wait for fences.
        <br>
        <br>
        This is an RFC and request for testing. I have not tested this
        myself yet.
        <br>
        My notes below:
        <br>
        <br>
        Restore work won't be frozen during GPU reset. Does it matter?
        Queues will
        <br>
        stay evicted until resume in any case. But restore_work may be
        in trouble
        <br>
        if it gets run in the middle of a GPU reset. In that case, if
        anything
        <br>
        fails, it will just reschedule itself, so should be fine as long
        as it
        <br>
        doesn't interfere with the reset itself (respects any mechanisms
        in place
        <br>
        to prevent HW access during the reset).
        <br>
        <br>
        What HW access does restore_work perform:
        <br>
        - migrating buffers: uses GPU scheduler, should be suspended
        during reset
        <br>
        - TLB flushes in userptr restore worker: not called directly,
        relies on
        <br>
        &nbsp;&nbsp; HWS to flush TLBs on VMID attachment
        <br>
        - TLB flushes in SVM restore worker: Does TLB flush in the
        mapping code
        <br>
        - Resuming user mode queues: should not happen while GPU reset
        keeps queue
        <br>
        &nbsp;&nbsp; eviction counter elevated
        <br>
        Ergo: Except for the SVM case, it's OK to not flush restore work
        before
        <br>
        GPU resets. I'll need to rethink the interaction of SVM
        restore_work with
        <br>
        GPU resets.
        <br>
      </blockquote>
      <br>
      It also sounds like the restore work is some high level work and
      shouldn't interact with the lower level GPU reset.
      <br>
    </blockquote>
    <p>That was my hope as well. Just trying to think through to make
      sure I'm not making any incorrect assumptions.</p>
    <p>Do you know if there is anything preventing a TLB flush using
      MMIO from messing up a GPU reset in progress? That's the only
      thing in the SVM restore work that tries to touch HW directly.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com">
      <br>
      <blockquote type="cite">
        <br>
        What about cancelling p-&gt;eviction_work? Eviction work would
        normally be
        <br>
        needed to signal eviction fences, but we're doing that
        explicitly in
        <br>
        suspend_all_processes. Does eviction_work wait for fences
        anywhere? Yes,
        <br>
        indirectly by flushing restore_work. So we should not try to
        cancel it
        <br>
        during a GPU reset.
        <br>
        <br>
        Problem: accessing p-&gt;ef concurrently in evict_process_worker
        and
        <br>
        suspend_all_processes. Need a spinlock to use and update it
        safely.
        <br>
        Problem: What if evict_process_worker gets stuck in flushing
        restore_work?
        <br>
        We can skip all of that if p-&gt;ef is NULL (which it is during
        the reset).
        <br>
        Even if it gets stuck, it's no problem if the reset doesn't
        depend on it.
        <br>
        It should get unstuck after the reset.
        <br>
        <br>
        Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; |&nbsp; 9 ++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 49
        +++++++++++++------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +-
        <br>
        &nbsp; 4 files changed, 44 insertions(+), 19 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index 54f31a420229..89e632257663 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1644,7 +1644,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(pinfo-&gt;block_mmu_notifications, false);
        <br>
        -&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;pinfo-&gt;restore_userptr_work,
        0);
        <br>
        +&nbsp;&nbsp;&nbsp; queue_delayed_work(system_freezable_wq,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pinfo-&gt;restore_userptr_work, 0);
        <br>
        &nbsp; &nbsp; out_unlock:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pinfo-&gt;lock);
        <br>
        @@ -2458,7 +2459,8 @@ int amdgpu_amdkfd_evict_userptr(struct
        mmu_interval_notifier *mni,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to quiesce KFD\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        schedule_delayed_work(&amp;process_info-&gt;restore_userptr_work,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_delayed_work(system_freezable_wq,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;process_info-&gt;restore_userptr_work,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;process_info-&gt;notifier_lock);
        <br>
        @@ -2793,7 +2795,8 @@ static void
        amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If validation failed, reschedule another attempt */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (evicted_bos) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        schedule_delayed_work(&amp;process_info-&gt;restore_userptr_work,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_delayed_work(system_freezable_wq,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;process_info-&gt;restore_userptr_work,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_queue_restore_rescheduled(mm);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 9cc32f577e38..cf017d027fee 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -919,6 +919,7 @@ struct kfd_process {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * during restore
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *ef;
        <br>
        +&nbsp;&nbsp;&nbsp; spinlock_t ef_lock;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Work items for evicting and restoring BOs */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work eviction_work;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index fbf053001af9..a07cba58ec5e 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd_process_wq)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_wq = alloc_workqueue(&quot;kfd_process_wq&quot;, 0,
        0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd_restore_wq)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_restore_wq =
        alloc_ordered_workqueue(&quot;kfd_restore_wq&quot;, 0);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_restore_wq =
        alloc_ordered_workqueue(&quot;kfd_restore_wq&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WQ_FREEZABLE);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd_process_wq || !kfd_restore_wq) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_destroy_wq();
        <br>
        @@ -1460,6 +1461,7 @@ static struct kfd_process
        *create_process(const struct task_struct *thread)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_init(&amp;process-&gt;ref);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;process-&gt;mutex);
        <br>
        +&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;process-&gt;ef_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;mm = thread-&gt;mm;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;lead_thread = thread-&gt;group_leader;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;n_pdds = 0;
        <br>
        @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct
        kfd_process *p, struct kfd_node *node,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        &nbsp; }
        <br>
        &nbsp; +static void signal_eviction_fence(struct kfd_process *p)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; spin_lock(&amp;p-&gt;ef_lock);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!p-&gt;ef)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock_out;
        <br>
        +&nbsp;&nbsp;&nbsp; dma_fence_signal(p-&gt;ef);
        <br>
      </blockquote>
      <br>
      This needs to grab the internal lock of the eviction fence, I'm
      not sure that has correct ordering with the newly added ef_lock.
      <br>
    </blockquote>
    <p>Hmm, the only thing we could get a circular lock dependency would
      be, if we took the p-&gt;ef_lock in a fence callback. I don't
      think that ever happens, because even the eviction work runs on a
      worker thread (exactly to avoid such lock dependency issues).</p>
    <p>Anyway, I could try to move the fence_signal out of the critical
      section. The lock is only there to ensure that exactly one process
      signals and frees the fence.</p>
    <pre>	spin_lock(&amp;p-&gt;ef_lock);
	ef = p-&gt;ef;
	WRITE_ONCE(p-&gt;ef, NULL);
	spin_unlock(&amp;p-&gt;ef_lock);
	if (ef) {
		dma_fence_signal(ef);
		dma_fence_put(ef);
	}
</pre>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com">
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; dma_fence_put(p-&gt;ef);
        <br>
        +&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;ef, NULL);
        <br>
        +
        <br>
        +unlock_out:
        <br>
        +&nbsp;&nbsp;&nbsp; spin_unlock(&amp;p-&gt;ef_lock);
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; static void evict_process_worker(struct work_struct *work)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;
        <br>
        @@ -1916,8 +1931,11 @@ static void evict_process_worker(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lifetime of this thread, kfd_process p will be valid
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = container_of(dwork, struct kfd_process,
        eviction_work);
        <br>
        -&nbsp;&nbsp;&nbsp; WARN_ONCE(p-&gt;last_eviction_seqno != p-&gt;ef-&gt;seqno,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Eviction fence mismatch\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; /* If the eviction fence is not valid, we're probably in a
        suspend
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * or GPU reset cycle. There is nothing to do in this case.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; if (!READ_ONCE(p-&gt;ef))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
      </blockquote>
      <br>
      This evict process work is high level I don't think it should have
      any dependency on the GPU reset.
      <br>
    </blockquote>
    <p>Right. This is not here to avoid issues, just a short-cut to
      avoid unnecessary work.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Narrow window of overlap
        between restore and evict work
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * item is possible. Once
        amdgpu_amdkfd_gpuvm_restore_process_bos
        <br>
        @@ -1930,9 +1948,7 @@ static void evict_process_worker(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Started evicting pasid 0x%x\n&quot;, p-&gt;pasid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_process_evict_queues(p,
        KFD_QUEUE_EVICTION_TRIGGER_TTM);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(p-&gt;ef);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(p-&gt;ef);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;ef = NULL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal_eviction_fence(p);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_delayed_work(kfd_restore_wq,
        &amp;p-&gt;restore_work,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
        <br>
        &nbsp; @@ -1967,9 +1983,19 @@ static void
        restore_process_worker(struct work_struct *work)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;last_restore_timestamp = get_jiffies_64();
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VMs may not have been acquired yet during debugging. */
        <br>
        -&nbsp;&nbsp;&nbsp; if (p-&gt;kgd_process_info)
        <br>
        +&nbsp;&nbsp;&nbsp; if (p-&gt;kgd_process_info) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *ef = NULL;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
        amdgpu_amdkfd_gpuvm_restore_process_bos(p-&gt;kgd_process_info,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;p-&gt;ef);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ef);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;p-&gt;ef_lock);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(p-&gt;ef, &quot;Eviction fence is not NULL&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;ef, ef);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;p-&gt;ef_lock);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Failed to restore BOs of pasid 0x%x, retry
        after %d ms\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid, PROCESS_BACK_OFF_TIME_MS);
        <br>
        @@ -1994,14 +2020,9 @@ void kfd_suspend_all_processes(void)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(debug_evictions, &quot;Evicting all processes&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_for_each_rcu(kfd_processes_table, temp, p,
        kfd_processes) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;p-&gt;eviction_work);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_delayed_work(&amp;p-&gt;restore_work);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_process_evict_queues(p,
        KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to suspend process 0x%x\n&quot;,
        p-&gt;pasid);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(p-&gt;ef);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(p-&gt;ef);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;ef = NULL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal_eviction_fence(p);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srcu_read_unlock(&amp;kfd_processes_srcu, idx);
        <br>
        &nbsp; }
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index fe937670c927..aa6c34127be9 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If validation failed, reschedule another attempt */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (evicted_ranges) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;reschedule to restore svm range\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;svms-&gt;restore_work,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_delayed_work(system_freezable_wq,
        &amp;svms-&gt;restore_work,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_queue_restore_rescheduled(mm);
        <br>
        @@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to quiesce KFD\n&quot;);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;schedule to restore svm %p ranges\n&quot;,
        svms);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;svms-&gt;restore_work,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_delayed_work(system_freezable_wq,
        &amp;svms-&gt;restore_work,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long s, l;
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------IcL8KoAt6epM1V42TZRuQU7S--
