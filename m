Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B595C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 20:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1362610E332;
	Tue, 28 Nov 2023 20:24:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2328E10E32A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 20:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxP/vyxpSlE8js+uL7a3NQWSbZj6rILjyi031AW7EMTPFIl7eTwkMFinBBlIW5JrukHIVYcXtT9pSNJATZblznSRVPo47qrugyV2/fdEmt9lZevuTfcQk+65LvswFljMmBLns/DFogBHuDuNPwLkrYfMbubTLxQFM1VZ/MwaZ3O+QWvg622EN69HwwBHjmwWQmBSxbZhp+wbNXHYAEy4jPfMgANg88pXDBxUiHuby58Dn6yaw4UMJgUQAcyOA4t410kiKtY7Tlm40KobDi9poX65MDRmFrsAOMDOIqdTkdelddKvgDpUJmjzJ6LcHLcdBLJ1+CX0fnhrRPdxgsLHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYwCNGsmxOOTzLvMZ1p1eIzZ2WTvaILO71owWoFexp4=;
 b=OMPM3/znjXtBgKCBn/5k5WN16hmJfd7LIe2SsC1h7VGu0Do+bVfWU9vk8kaApITyY6cNvGG1437rjwYVbrmrSAkwMpEEunyqRHvgdq+MdVG2Q5tJdmoLoBA2Tb5miUt7WH+LcvGPNYjkHkatmtQ/a7I21yYQbU+eEJr8m+neFwdE8Cmnm27FjS8/G3vu9RkSXHI4PxDJGQc8PQxwYkAmaa4QdQT6tabH4xWnaBDBu2YfZ4IrbcrGXl8DJ4ReJvAHySsNcq79PfpKuGhPNraoUx7upy4rJ8vVN3iO/qxn84cY18buXSCBJxELxdY/911wfup9U3AR/ZeMHuJsMAyVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYwCNGsmxOOTzLvMZ1p1eIzZ2WTvaILO71owWoFexp4=;
 b=jTdkZ+Xfbp60kYS+nEmwUFGyM7Qd5SdcZX5qrPQ+U9ejXMepp23sfcJA38RqkjPWeamZLumo/Og4hYE8vmqLogO3k6VveSP4E88mbBYRPUsbAXaJe0lsjNnGu8yAcQyjXLjOnuG1YWKvaEV2t55PlBe6S5ANv/tpmRb/jeh3iE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 20:24:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 20:24:53 +0000
Message-ID: <a59048dc-e59f-43dd-8de2-6bfe37de83f6@amd.com>
Date: Tue, 28 Nov 2023 15:24:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231123225506.986511-1-Felix.Kuehling@amd.com>
 <86ef31b9-3638-6b84-fcc8-c52b2346239f@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <86ef31b9-3638-6b84-fcc8-c52b2346239f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 142b27e9-6077-45b3-14f5-08dbf0501476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6l5EFBsz7bwkesxZAdpeMfle5y4lQOrVBW//tgWIZYUmmb52i0Gb2SN5J3pZMtY6qkXz4dSJv0kt8ZggMSeSzfhtyEyfe1RKRYGZ0yEVpwAMD8uEEjfNd4eZ6Ce6Guaowqw+2SklXU4ivfE4wPrlFY2+mV54Mp7mcQNX6cIV1ShrSrI64SmYL4iX56YUeY5t70ysyTvZjKgYCAJc1wP1F7aoHvPsD+NIZCJTLj/GumA5iYsMU1h4AgKl8z73Uub92aPw8zg/50OsMsbjnbNmec/od8IxVeOLOHA8or/GkmC2xuhJBvn0899ImHkiOQ78uHR7NJyRO2sKD4eP9oLbLofumzyU4Gso0ITl1gV78ZY5XTxnJJf/yYz9WKQjDox02tCfxaTHxAQOxx+XcEMyXq00xtwORC4JRRlMxP6akLh+lj9m7q0G/3c6Uvb4PPBS001bO2kGTmS+L5lf9u/KAS673aGGUyk3kNUZPmrvRFJRoUclRPHb+9yiAvxeqiBRgOyl2cwrIkYnYYNJ1HJRuztyQYMxc/MsyC4DZfrz6JXpuj+XkHAop8zfR+0XjKeckDUi+ZEb73ecYBB2Qe53Sfv89PqgC35vy6fBjWFMHmBbaBCWX50H0Jw15CX2cFgO9BMdluyhlQJDy5PGH6faKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(31696002)(8676002)(45080400002)(4326008)(6512007)(53546011)(6506007)(316002)(66946007)(66556008)(478600001)(6486002)(30864003)(36756003)(38100700002)(41300700001)(31686004)(4001150100001)(86362001)(2906002)(26005)(44832011)(66476007)(2616005)(5660300002)(83380400001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVSUVVZSHBDWVcrdExha3BCem1UYWNXYXg5RWRIOGx0TEs5eGN5OWFYSDF0?=
 =?utf-8?B?UlJnaUhyS1ArLzk0bVBhYUc4alpBeHJkMGJEbjd3QVVuaDVaanhHdUc0TklW?=
 =?utf-8?B?SzU5bGo2eHVtbzVBWVBhSlhoWjNXdE14UUFTMi8zTlV3S0dnSHhJVTI5VUNO?=
 =?utf-8?B?YmtRUTBkallFaXJyU0loWTljN2NUckE5ck9TUXUxSG5VTXc4dTlBeWx5M1ZH?=
 =?utf-8?B?TldHb1VYNnFjNlREVU1DVTF5TXBmNmtZQzEwR0dpdkFjeENTSllRSnc3UmJ1?=
 =?utf-8?B?aWVCMkJLTFN2cnZoN1B5a0IxRmxyQ3J5dk05ZkFFcnp2M0xOd3lvM3FwVzBF?=
 =?utf-8?B?V3B5TlI1S1ZBNzJVakgxN2xlcE45cFUwTlpMeEYxZjJmcm5yT0tDTlhZTDB5?=
 =?utf-8?B?NDBZZlRkQkpGU05LMUF5MVZ3OVREaVh3aTlTNTViUmJJNUVXdGZyQkVBOTZm?=
 =?utf-8?B?dklNdVRtdFlQRER6MUlEVFpobkN1Y20yVkJuY0E5Q2FJVnJNU3ZSR0ZvZnUr?=
 =?utf-8?B?RmhDekFMRmhYb1ZsN3pKTnZjK0tMU1o5dm5ITDQ1M1loNWFQL3U4NW5Fc2xq?=
 =?utf-8?B?ZXVFWGVoN2VKM0FobWYvSEtvNkNMeC9VeEtJQ3Fuc1hlb0NBVlpTeUFzaDFs?=
 =?utf-8?B?U1B0dVFEVy9JZFp0S0FacmowbUwxTjZVT2ozejBhQUF4U3NUN2JPbEE2eFlH?=
 =?utf-8?B?RG1OS0dxVUVXbEV1cllGbzRCQmpGRUxLNnFXL3lCS1NiSXBFYnR2R3l3azdx?=
 =?utf-8?B?WHFjbndUZEppTklKU05EUDRYcHhkSmZzUHY5R3dXSWZkaFJpWTltUXh6S3No?=
 =?utf-8?B?LytObE54TjNwVTloV1JzUTU1eFljWTlBTlFnSmJVd2dEN3crcStCeUhUVERl?=
 =?utf-8?B?NDlnNG1KeTV0YkNqUnd3UTdiR2o0UHRVME5MTkoxRWZ3MFBPTmNwUjJQRGhl?=
 =?utf-8?B?YWZFdWdFdjlGNWRmbjMxZThNYWtiaHFtcWhkdEFyYU02czdBaUp0dWJPMVJG?=
 =?utf-8?B?b1I2MjhCMWcvd09aK0ZReHF5VEZjUHdTUkxOUXYxcjJhY29yM1BXTmZ6cWFV?=
 =?utf-8?B?UmdlaTQzaWhpNXU3ZWpxRHk3QVVzaU1xK1lheUM0STdJaFVsbklvOVZTMDBY?=
 =?utf-8?B?MUR1aFR0MUgxaEo4VUlOdVgxWTMxRmlFNlpqNHN4amJTTHFjKzM1TkhoUzV5?=
 =?utf-8?B?Y245T0pzSXRsMm84T0ZlL3VwQVRPbVpCRC9zeFo1OU1GVGVNTkxVTllSNGVa?=
 =?utf-8?B?bThuV0ZpenZ2ZzY1amdnT2h4ZmdGOXl6RmhBNlp1OW9oZ1oxaWN6U2xabFRJ?=
 =?utf-8?B?WDVmOFlidVJYWnFSUVZ2ZmYzM0s0TFBGME0vRUQ5YUpXb2UxSDlna0JxQ3pY?=
 =?utf-8?B?cHM3ZXRRaFBrSGxKZDNUVmcva2l0VkgrQnN1TFdVR2hUQkVsOXRPV2ZhUmRh?=
 =?utf-8?B?NjZ1eDJrSzZjT0ZqVElscUJGR2NaclFOcHQ1SGFBTU00ZGFNTzI3ZHprNC9l?=
 =?utf-8?B?S0wzTSs5TlZMME1MTFFFaFYrT1VSZExiSHN5RUo4V3QrOEFkcE9RU1RlZmZu?=
 =?utf-8?B?Q0tFWGY1cFpPMm5vMGNwV1hsbWZPcW55TCtGcC90S2lWTktNT3JMMGo5cFB3?=
 =?utf-8?B?bUNEN2pCWS9mNEQ3WkFjbGlRMWgvVlI1RWQwMjMzWkJJV0FwQ3g0dUYxRlo1?=
 =?utf-8?B?MHQ5QjJod2hzdDMzRnNtakVNQkVRNGw5L1RXRmliQ09MSWVLR2tCamdPeVpZ?=
 =?utf-8?B?QUZEb25hNE9URjNBb1FTTmVUU1dPTWs0QzZtNWRrY3g5YUo2c242ZjNTV1hS?=
 =?utf-8?B?YkkxMW80TVpjVGxpblRBUVEwSEdHa3hpOEE1VmhQSHlOQkJHY2ZlYUpqWTdm?=
 =?utf-8?B?YVR1bW5GaWtNQmVWWXR4NG1WaDR5NjI1VnBpbTV6TUxGKzUzV3BzZ0g0MUVz?=
 =?utf-8?B?aDE0czdzMFMxc1ExNVp4K3NuNlF3TW41RzlMa09tb2ljN1BZRDhHbFFDNDhh?=
 =?utf-8?B?OUo2dDA1dWU1OFg4WjYvSzlRdlRVTzhxZDA4QnhxOUZYckVzeTJkRnhJMzQv?=
 =?utf-8?B?RnUxSkRMUG5IUUhQbUVRNGRCeDJpbVc2V2ZaN2tmL1ZwVGpvYktoQWpqS0Fq?=
 =?utf-8?Q?ZAG8JYqIpSLSVLlN0qdwbmOGo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142b27e9-6077-45b3-14f5-08dbf0501476
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 20:24:53.5647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ros9KGmOnTOajU+72+DVlE5ZG+YsbHoT21NmeGK5Njeu6p3fdwAjBetkq/hr6uF73PIIW01RzJ3Smc0qOWfaBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-24 8:40, Lazar, Lijo wrote:
>
>
> On 11/24/2023 4:25 AM, Felix Kuehling wrote:
>> Make restore workers freezable so we don't have to explicitly flush them
>> in suspend and GPU reset code paths, and we don't accidentally try to
>> restore BOs while the GPU is suspended. Not having to flush restore_work
>> also helps avoid lock/fence dependencies in the GPU reset case where 
>> we're
>> not allowed to wait for fences.
>>
>> A side effect of this is, that we can now have multiple concurrent 
>> threads
>> trying to signal the same eviction fence. Rework eviction fence 
>> signaling
>> and replacement to account for that.
>>
>> The GPU reset path can no longer rely on restore_process_worker to 
>> resume
>> queues because evict/restore workers can run independently of it. 
>> Instead
>> call a new restore_process_helper directly.
>
> Not familiar with this code. For clarity, does this mean 
> eviction/restore may happen while a reset is in progress?

I'm not sure if anything would be able to cause an eviction while a GPU 
reset is in progress. I don't think it's likely. Any actual migration of 
BOs would need to wait until after the reset is done anyway. In case of 
suspend/resume, evictions happen because all the VRAM gets saved to 
system memory.

Suspend/resume and evictions depend on the same helper or worker to 
restore BOs before reenabling user mode queues. GPU reset needs the same 
helper to stop user mode queues to ensure that applications don't 
continue running with potentially corrupted data. This patch removes 
some synchronization between different users of these common code paths 
to fix deadlocks in the suspend/resume and GPU reset scenarios.

Regards,
   Felix


>
> Thanks,
> Lijo
>
>>
>> This is an RFC and request for testing.
>>
>> v2:
>> - Reworked eviction fence signaling
>> - Introduced restore_process_helper
>>
>> v3:
>> - Handle unsignaled eviction fences in restore_process_bos
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 68 +++++++++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 87 +++++++++++--------
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
>>   3 files changed, 104 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 2e302956a279..bdec88713a09 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1431,7 +1431,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
>> void **process_info,
>>                     amdgpu_amdkfd_restore_userptr_worker);
>>             *process_info = info;
>> -        *ef = dma_fence_get(&info->eviction_fence->base);
>>       }
>>         vm->process_info = *process_info;
>> @@ -1462,6 +1461,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
>> void **process_info,
>>       list_add_tail(&vm->vm_list_node,
>>               &(vm->process_info->vm_list_head));
>>       vm->process_info->n_vms++;
>> +
>> +    *ef = dma_fence_get(&vm->process_info->eviction_fence->base);
>>       mutex_unlock(&vm->process_info->lock);
>>         return 0;
>> @@ -1473,10 +1474,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
>> void **process_info,
>>   reserve_pd_fail:
>>       vm->process_info = NULL;
>>       if (info) {
>> -        /* Two fence references: one in info and one in *ef */
>>           dma_fence_put(&info->eviction_fence->base);
>> -        dma_fence_put(*ef);
>> -        *ef = NULL;
>>           *process_info = NULL;
>>           put_pid(info->pid);
>>   create_evict_fence_fail:
>> @@ -1670,7 +1668,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
>>           goto out_unlock;
>>       }
>>       WRITE_ONCE(pinfo->block_mmu_notifications, false);
>> -    schedule_delayed_work(&pinfo->restore_userptr_work, 0);
>> +    queue_delayed_work(system_freezable_wq,
>> +               &pinfo->restore_userptr_work, 0);
>>     out_unlock:
>>       mutex_unlock(&pinfo->lock);
>> @@ -2475,7 +2474,8 @@ int amdgpu_amdkfd_evict_userptr(struct 
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
>> @@ -2810,7 +2810,8 @@ static void 
>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>         /* If validation failed, reschedule another attempt */
>>       if (evicted_bos) {
>> - schedule_delayed_work(&process_info->restore_userptr_work,
>> +        queue_delayed_work(system_freezable_wq,
>> +            &process_info->restore_userptr_work,
>> msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>             kfd_smi_event_queue_restore_rescheduled(mm);
>> @@ -2819,6 +2820,23 @@ static void 
>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>       put_task_struct(usertask);
>>   }
>>   +static void replace_eviction_fence(struct dma_fence **ef,
>> +                   struct dma_fence *new_ef)
>> +{
>> +    struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
>> +        /* protected by process_info->lock */);
>> +
>> +    /* If we're replacing an unsignaled eviction fence, that fence will
>> +     * never be signaled, and if anyone is still waiting on that fence,
>> +     * they will hang forever. This should never happen. We should only
>> +     * replace the fence in restore_work that only gets scheduled after
>> +     * eviction work signaled the fence.
>> +     */
>> +    WARN_ONCE(!dma_fence_is_signaled(old_ef),
>> +          "Replacing unsignaled eviction fence");
>> +    dma_fence_put(old_ef);
>> +}
>> +
>>   /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for 
>> the given
>>    *   KFD process identified by process_info
>>    *
>> @@ -2844,7 +2862,6 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> **ef)
>>       struct amdgpu_vm *peer_vm;
>>       struct kgd_mem *mem;
>>       struct bo_vm_reservation_context ctx;
>> -    struct amdgpu_amdkfd_fence *new_fence;
>>       int ret = 0, i;
>>       struct list_head duplicate_save;
>>       struct amdgpu_sync sync_obj;
>> @@ -2974,22 +2991,35 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> **ef)
>>       /* Wait for validate and PT updates to finish */
>>       amdgpu_sync_wait(&sync_obj, false);
>>   -    /* Release old eviction fence and create new one, because 
>> fence only
>> -     * goes from unsignaled to signaled, fence cannot be reused.
>> -     * Use context and mm from the old fence.
>> +    /* The old eviction fence may be unsignaled if restore happens
>> +     * after a GPU reset or suspend/resume. Keep the old fence in that
>> +     * case. Otherwise release the old eviction fence and create new
>> +     * one, because fence only goes from unsignaled to signaled once
>> +     * and cannot be reused. Use context and mm from the old fence.
>> +     *
>> +     * If an old eviction fence signals after this check, that's OK.
>> +     * Anyone signaling an eviction fence must stop the queues first
>> +     * and schedule another restore worker.
>>        */
>> -    new_fence = amdgpu_amdkfd_fence_create(
>> +    if (dma_fence_is_signaled(&process_info->eviction_fence->base)) {
>> +        struct amdgpu_amdkfd_fence *new_fence =
>> +            amdgpu_amdkfd_fence_create(
>> process_info->eviction_fence->base.context,
>>                   process_info->eviction_fence->mm,
>>                   NULL);
>> -    if (!new_fence) {
>> -        pr_err("Failed to create eviction fence\n");
>> -        ret = -ENOMEM;
>> -        goto validate_map_fail;
>> +
>> +        if (!new_fence) {
>> +            pr_err("Failed to create eviction fence\n");
>> +            ret = -ENOMEM;
>> +            goto validate_map_fail;
>> +        }
>> + dma_fence_put(&process_info->eviction_fence->base);
>> +        process_info->eviction_fence = new_fence;
>> +        replace_eviction_fence(ef, dma_fence_get(&new_fence->base));
>> +    } else {
>> +        WARN_ONCE(*ef != &process_info->eviction_fence->base,
>> +              "KFD eviction fence doesn't match KGD process_info");
>>       }
>> - dma_fence_put(&process_info->eviction_fence->base);
>> -    process_info->eviction_fence = new_fence;
>> -    *ef = dma_fence_get(&new_fence->base);
>>         /* Attach new eviction fence to all BOs except pinned ones */
>>       list_for_each_entry(mem, &process_info->kfd_bo_list,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index c10d050e1a61..71df51fcc1b0 100644
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
>> @@ -1642,6 +1643,7 @@ int kfd_process_device_init_vm(struct 
>> kfd_process_device *pdd,
>>       struct amdgpu_fpriv *drv_priv;
>>       struct amdgpu_vm *avm;
>>       struct kfd_process *p;
>> +    struct dma_fence *ef;
>>       struct kfd_node *dev;
>>       int ret;
>>   @@ -1661,11 +1663,12 @@ int kfd_process_device_init_vm(struct 
>> kfd_process_device *pdd,
>>         ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
>>                                &p->kgd_process_info,
>> -                             &p->ef);
>> +                             &ef);
>>       if (ret) {
>>           pr_err("Failed to create process VM object\n");
>>           return ret;
>>       }
>> +    RCU_INIT_POINTER(p->ef, ef);
>>       pdd->drm_priv = drm_file->private_data;
>>         ret = kfd_process_device_reserve_ib_mem(pdd);
>> @@ -1908,6 +1911,21 @@ kfd_process_gpuid_from_node(struct kfd_process 
>> *p, struct kfd_node *node,
>>       return -EINVAL;
>>   }
>>   +static int signal_eviction_fence(struct kfd_process *p)
>> +{
>> +    struct dma_fence *ef;
>> +    int ret;
>> +
>> +    rcu_read_lock();
>> +    ef = dma_fence_get_rcu_safe(&p->ef);
>> +    rcu_read_unlock();
>> +
>> +    ret = dma_fence_signal(ef);
>> +    dma_fence_put(ef);
>> +
>> +    return ret;
>> +}
>> +
>>   static void evict_process_worker(struct work_struct *work)
>>   {
>>       int ret;
>> @@ -1920,31 +1938,46 @@ static void evict_process_worker(struct 
>> work_struct *work)
>>        * lifetime of this thread, kfd_process p will be valid
>>        */
>>       p = container_of(dwork, struct kfd_process, eviction_work);
>> -    WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
>> -          "Eviction fence mismatch\n");
>> -
>> -    /* Narrow window of overlap between restore and evict work
>> -     * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
>> -     * unreserves KFD BOs, it is possible to evicted again. But
>> -     * restore has few more steps of finish. So lets wait for any
>> -     * previous restore work to complete
>> -     */
>> -    flush_delayed_work(&p->restore_work);
>>         pr_debug("Started evicting pasid 0x%x\n", p->pasid);
>>       ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>>       if (!ret) {
>> -        dma_fence_signal(p->ef);
>> -        dma_fence_put(p->ef);
>> -        p->ef = NULL;
>> -        queue_delayed_work(kfd_restore_wq, &p->restore_work,
>> +        /* If another thread already signaled the eviction fence,
>> +         * they are responsible stopping the queues and scheduling
>> +         * the restore work.
>> +         */
>> +        if (!signal_eviction_fence(p))
>> +            queue_delayed_work(kfd_restore_wq, &p->restore_work,
>>                   msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
>> +        else
>> +            kfd_process_restore_queues(p);
>>             pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
>>       } else
>>           pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
>>   }
>>   +static int restore_process_helper(struct kfd_process *p)
>> +{
>> +    int ret = 0;
>> +
>> +    /* VMs may not have been acquired yet during debugging. */
>> +    if (p->kgd_process_info) {
>> +        ret = amdgpu_amdkfd_gpuvm_restore_process_bos(
>> +            p->kgd_process_info, &p->ef);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    ret = kfd_process_restore_queues(p);
>> +    if (!ret)
>> +        pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
>> +    else
>> +        pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>> +
>> +    return ret;
>> +}
>> +
>>   static void restore_process_worker(struct work_struct *work)
>>   {
>>       struct delayed_work *dwork;
>> @@ -1970,24 +2003,15 @@ static void restore_process_worker(struct 
>> work_struct *work)
>>        */
>>         p->last_restore_timestamp = get_jiffies_64();
>> -    /* VMs may not have been acquired yet during debugging. */
>> -    if (p->kgd_process_info)
>> -        ret = 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
>> -                                 &p->ef);
>> +
>> +    ret = restore_process_helper(p);
>>       if (ret) {
>>           pr_debug("Failed to restore BOs of pasid 0x%x, retry after 
>> %d ms\n",
>>                p->pasid, PROCESS_BACK_OFF_TIME_MS);
>>           ret = queue_delayed_work(kfd_restore_wq, &p->restore_work,
>>                   msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS));
>>           WARN(!ret, "reschedule restore work failed\n");
>> -        return;
>>       }
>> -
>> -    ret = kfd_process_restore_queues(p);
>> -    if (!ret)
>> -        pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
>> -    else
>> -        pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>>   }
>>     void kfd_suspend_all_processes(void)
>> @@ -1998,14 +2022,9 @@ void kfd_suspend_all_processes(void)
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
>> @@ -2017,7 +2036,7 @@ int kfd_resume_all_processes(void)
>>       int ret = 0, idx = srcu_read_lock(&kfd_processes_srcu);
>>         hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>> -        if (!queue_delayed_work(kfd_restore_wq, &p->restore_work, 0)) {
>> +        if (restore_process_helper(p)) {
>>               pr_err("Restore process %d failed during resume\n",
>>                      p->pasid);
>>               ret = -EFAULT;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index b23ba92a794c..42b5279c7010 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1871,7 +1871,7 @@ static void svm_range_restore_work(struct 
>> work_struct *work)
>>       /* If validation failed, reschedule another attempt */
>>       if (evicted_ranges) {
>>           pr_debug("reschedule to restore svm range\n");
>> -        schedule_delayed_work(&svms->restore_work,
>> +        queue_delayed_work(system_freezable_wq, &svms->restore_work,
>> msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>>             kfd_smi_event_queue_restore_rescheduled(mm);
>> @@ -1947,7 +1947,7 @@ svm_range_evict(struct svm_range *prange, 
>> struct mm_struct *mm,
>>               pr_debug("failed to quiesce KFD\n");
>>             pr_debug("schedule to restore svm %p ranges\n", svms);
>> -        schedule_delayed_work(&svms->restore_work,
>> +        queue_delayed_work(system_freezable_wq, &svms->restore_work,
>> msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>>       } else {
>>           unsigned long s, l;
