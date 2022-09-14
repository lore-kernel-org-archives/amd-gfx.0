Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E0DECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 15:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E06D10E055;
	Wed, 14 Sep 2022 15:41:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACDC10E042
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 15:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBfwYefZxfV6gJGjZUtSiz86fSdAycjEIHEwUHOZPw9rSEyzIPXXcgEKplMKr3NExCGbWbjnPg18NbRf3mdc/EQsKHKt8vfvxY3z3Ak1xvM9oJH72VMQEC6vlYBC54tgNEZGMQ4v8ki00HGO2GPhB38leUhIUoZf6VhX3zGRIEFEAA5AvMbVOdnj3Q5WsSfukE0bSeLOs4m4U/5lyduT04J434p+yJyuB8UuegPhDbXmnHFjw0fWROQfDPwo9PjZiYDzItotBzkPwk6aizgMG7P3CkDLbYHKyA5curd3GRbfpaGZcGYPqKzLtvXdxBgT4wjCKvY0xP6zWlG+dk8c9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUgElIMGf9mXvI/VvTSMiH/VCvDQAvn0LTe8yc3topY=;
 b=iUkM/cZmeKyI7VSp6Cx2FxYXmi8/YiduF38V8TRD+1NI+ZZ7xArDEVwrDgXNSE5fLkS4tl7zgTVzpPcdd6b89E68iv72uVFKrJuzipb49mIdwCrZZh4LcXjnpK3l0W3ueMbXaHqHJL1tltC0RnfFsPzgoGCGuh/JgUt+xbNGIfOJtymXIARowBKjP4LiI4mQNWjf9KlEEBz+Yev/oXA6blFkzykKsYqpj77yO/SZkYy7hx43LSL8l241clpPeSFJ5mabooYGYQIkq90n1LvoN85WgXU1RD7ICCyNyBf6+ZvzDyiPZYoHzZLph33SlItuGt2fLFlLtIIkcMw2Qf69AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUgElIMGf9mXvI/VvTSMiH/VCvDQAvn0LTe8yc3topY=;
 b=G+Scfcnycc+fGe8yXI/ewlZT0JBdPn+BeHntkvBad5QojFCMIO5QZG5xpCpLka7AjGilOQjm7n3+/ap7quRghCbOfS9ilDpgGiQZk1LNdRtx6+REKVNTkEDAqo4efM7fohwPtqkbq0UjxJ9Pb1V5G4LMI+Alt/QQTqL8pRXmObk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 15:41:34 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb%2]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:41:34 +0000
Message-ID: <6867ffea-6e55-9bde-ce9d-6bacf2d932bc@amd.com>
Date: Wed, 14 Sep 2022 11:41:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220913200507.8849-1-Philip.Yang@amd.com>
 <918a0fb0-848c-df74-f2bb-fe85953d1cb3@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <918a0fb0-848c-df74-f2bb-fe85953d1cb3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:610:b1::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: aecf8d65-fdfd-499c-e77c-08da96679a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azUkjbzuIQ0jMohvD3Sxf+8pGGydyAEplj78AOxdxFf3qxwRA9wnrkkYjBJVjRTXV011LMqjEWiM+QnO5hGUM4LsHcl0D6s4ti8UqXn7UIubOzDrS1RbguhgRgTpp4prLjGHS9qpN+jiXcJTMB6M3f6TdhtTKwvS106iwIQoxya1iQ4SdNbZR8p5qKypm5jqpImUO54SQ2Vl5YJ7Q6PMYGBjGtTUYREMb8Y6DeN0ehEeVKh0VJIX3EXfD+AHGnUMoCGPG82A7wLHBVLlMDjIAuzM59m7DWfWRnYUH99AC/ZxEUJZGFogHjDFmgNayxDsIARGFow4tirRdWYozSj81pcOpSP9sqjMpRAaZn8uCRAMZHU0pgC03lV1NetDtxA4JrvUh4VJQUPvxczzjHpKJu/Cmye/xLYKlAVrijUNpm6PpiFdNgDlQQI3T509Av2gOztMRSejCp0TU1Fdo05QbDCXdyrZTuFchQo486USm5UyC+Il1KNNMdM3cfHu42KCLCr3fLHO7yp1xq7q9N7/J2HU3J1IQItM/DuTJJg4aAOzRH2pcygugA3RU/iur9ocqXpzzrC1ihQGgbJFq2fzy5sKky9Xc676zE8A3n7ZnklfPCYQIzjLVR3si8h+NjToJskAvkaavY5SsUP/s8kHPy0SluK5UPjVxzQ9ye57ikhqYgdyb9kqrkgEFVBQ9XlCAbyxv4PKKGqAmPcinMbTqo9jOFnM14246sNCNvDV3cak98uGtOo/a+tD9Q5IirLRFhZar5L76jlx3ogS1QVO2wuJZ1kYgvGqu3oDZoN0dIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(36756003)(66574015)(5660300002)(41300700001)(66476007)(4326008)(110136005)(31686004)(6506007)(66556008)(53546011)(38100700002)(478600001)(186003)(2616005)(83380400001)(8676002)(66946007)(8936002)(6486002)(316002)(6512007)(26005)(31696002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZYeUxhVStBcmFSK1BuZjI3amRrS1FVcWVQb0lVSjlWNVRNM2E5L0x3Q0Vr?=
 =?utf-8?B?ZlNBSFlxWVVsZEd4L0RkMTRWSldMYUVDSUhYWDdZcmppVjJjdDI1eGFaUW1Q?=
 =?utf-8?B?Um9IUDVwUnNWN3drbTVOM1hqclliQjVJSUpRb09ieUpjSGlaSEZ6blRwU0k4?=
 =?utf-8?B?d0paL3BISWhTdVN4VkhxclB0N2RNM0FMOHlBOWJhSXRoL0hTUVRmMk5MaHR4?=
 =?utf-8?B?ZVBPaG04OTNuKzJyN2c4bjc3QzlkRkRCV3ZGNVkydmFmWFAxOHJoazlDbkFl?=
 =?utf-8?B?VU5tYUtOMmE4VXNNbnZzK1NmVXh5WDJHbGRMSmgvNzJ3cnp3VnFRbFVvRjFq?=
 =?utf-8?B?R2s0cDlnMHQ1MllkZGxVekEvK2kxakVya25JV1dwS01BU1dOK1hSRytNem5M?=
 =?utf-8?B?QmRxWXVuQzhmT2hHdjFqNnRxM21RdHo3T1ordEt3cEtyN1YvUHN3alRtN1hV?=
 =?utf-8?B?TUVVZllaN3BJSXIyQ2VPK3BuWXQ3N2xkWTdQVjJBVkVaajhNcGdrRDJQelZE?=
 =?utf-8?B?M25sR2Rkc0J1cmljU2Rldkw5UThDRHo5QXAybXhVd3RyK1FkS3hVak5VMkRS?=
 =?utf-8?B?b21PR21ObTNSUzNTa3NtUjQ2aHlYSGswOXh2T3dNL3U5Mzl6Nm4vUGtab3Ew?=
 =?utf-8?B?Z3cwb1ErZUlFMkVDaFFaV2h4K1BtK2RrUEphaE01ZjRYTy8yWUtLalUxQWY4?=
 =?utf-8?B?T2ZTcGQwWitNNzBRZ2xxbzA5TGlDZ3lHZ0JjTm5WR0REYVVzUGVoOTJGeStU?=
 =?utf-8?B?SW81Ylkva3Mzek0vUnd0VUVNRmd5ZUdQSEIxTlJRNGRWWGtjOVZpNi80Uk1r?=
 =?utf-8?B?RnN1TVMrd2FDbjhvd21YWEYwTTA1Ly9GM3JaZHRoNXVsZXFxK29NQnAwNlIr?=
 =?utf-8?B?dmlsTzVBdzY3MjNGVkNha3FEQVpZOWR2NGZXRUlUZEltWFRaYitKTTBUNGp3?=
 =?utf-8?B?R3J4M3RncC9UaWZGeWU0cDNQb2IzU1dJOTYwMFNWMmNDbHNlZWdYaWtjSE1k?=
 =?utf-8?B?MDZLK09mYzQyMzZ2YlU2T3Jsa21BdVBpZXZ0VVhJUjVMNmFQQ2pqa0o3Y0xo?=
 =?utf-8?B?RzFoN2hlV0NSM0ZvUEt6S1hXVktmM0FVeXpkZThOelJGbytOeGFsU2Z6VHA2?=
 =?utf-8?B?VUhTOUtQMjlRaDc5Q0JseGUydlp6UXdmdHN0N0YzcUcrSlJldXJzRXI1ZzRo?=
 =?utf-8?B?ZFI2dGR6QU81dVVkdE1BazJjU2MyaWxoRENSalgrcFFVOUM5TmM4aThSZllJ?=
 =?utf-8?B?bzZZWTJTM0dQaFBST1lmVk5ucmlUQ1FoeWZqemE4Y2hRZGxhODV6c2hKVnNI?=
 =?utf-8?B?SUdiZldTNC9kMXZMT0FCdFNRRlhPQTA3cmEyZHRrWjRpSWMyODcvK3JMVnFE?=
 =?utf-8?B?dTdRUDVjZGo2Z3FuZ1ZueWJLTFdrdEZVbHZVVGZBYnBWdlVWc0E0dmd3dzdM?=
 =?utf-8?B?eE4vcGt2dnZnbFJ5bDcrdzRUWCtBRm5HM2k5ZXZVZmR1MEs5VytBMFE2SEdS?=
 =?utf-8?B?WStVYzZzWThiYXYwN2J4WjAzSVhqSXFybXVVMzFCcGNKUmlsU0QvU1ZtQUlI?=
 =?utf-8?B?TGl0MlRpVFNWVHplRHVIUXlnaEU4eG5qMGhuZzBPQWNzTXNEaXU4QlBHcWtC?=
 =?utf-8?B?bWV4NnE3aDBMYXEwUU1BNUdhZFdtRWREcDMzR0psV3lXeEszZDdhRk16YWpX?=
 =?utf-8?B?UjdFNmFhWUxFeTRLeFRNb0s2cW85RXJvOXhuM25pd1pQYTZxcmx6ZWJrSjVo?=
 =?utf-8?B?eGxWenV1eGtQWmJ6UkIxUGhQUlcrWDNWeU8vbmZhTkdDc2lsL3ZpazhmeDNv?=
 =?utf-8?B?YXlBVXFVTlN1cXNGUWJ5MUFPRkk0SWpjQ2NIbllia1lxeTlmcGRwRDdZcXo2?=
 =?utf-8?B?RDkvUWtOUFJUNmpPcXBCNXpRa0xPUHA4VTM2dlVQZHltUHVTTlhXVEFYK2Qy?=
 =?utf-8?B?ZXlPeWxOZjlmamM0clNZVloxQWxqU0JCbnc0QTRHMWdEUDRzZkZVdTlSMWlX?=
 =?utf-8?B?WnhJK1pocERaeDZrUXJ3VmN0RXRIdUZhNkUxbEFJVG9kYUtlaEc3cEs4Y0pi?=
 =?utf-8?B?VWl0cXRva2NlYWNZRHlmSGtMdFFIM0NWM2R0Skxpc29EN0s3YzdZQVA4c3lh?=
 =?utf-8?Q?Khc0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf8d65-fdfd-499c-e77c-08da96679a87
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:41:34.5849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbHH2vSY0dgvaljYvNb7aJCkAjhFaIHnNf8wfpRVGXqO8adRTZCI2JBdCuoe5HhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-14 05:10, Christian König wrote:
> Am 13.09.22 um 22:05 schrieb Philip Yang:
>> Free page table BO from vm resv unlocked context generate below
>> warnings.
>>
>> Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
>> pass vm resv unlock status from page table update caller, and add vm_bo
>> entry to vm->pt_freed list and schedule the pt_free_work if calling with
>> vm resv unlocked.
>>
>> WARNING: CPU: 12 PID: 3238 at
>> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>> Call Trace:
>>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>>   unmap_vmas+0x9d/0x140
>>   unmap_region+0xa8/0x110
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 47 ++++++++++++++++++++---
>>   3 files changed, 51 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 59cac347baa3..27e6155053b6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>       spin_lock_init(&vm->invalidated_lock);
>>       INIT_LIST_HEAD(&vm->freed);
>>       INIT_LIST_HEAD(&vm->done);
>> +    INIT_LIST_HEAD(&vm->pt_freed);
>> +    INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>> +    spin_lock_init(&vm->pt_free_lock);
>>         /* create scheduler entities for page table updates */
>>       r = drm_sched_entity_init(&vm->immediate, 
>> DRM_SCHED_PRIORITY_NORMAL,
>> @@ -2244,6 +2247,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>           amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>>       }
>>   +    cancel_work_sync(&vm->pt_free_work);
>
> We should probably not cancel the work here, but rather just wait for 
> it to finish.
Good point, will change to flush_work, and move it outside 
amdgpu_bo_reserve(root), as amdgpu_vm_pt_free_work takes 
amdgpu_bo_reserve(root), this will cause deadlock.
>
>>       amdgpu_vm_pt_free_root(adev, vm);
>>       amdgpu_bo_unreserve(root);
>>       amdgpu_bo_unref(&root);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9ecb7f663e19..b77fe838c327 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>>       /* BOs which are invalidated, has been updated in the PTs */
>>       struct list_head        done;
>>   +    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>> not hold */
>> +    struct list_head    pt_freed;
>> +    struct work_struct    pt_free_work;
>> +    spinlock_t        pt_free_lock;
>> +
>>       /* contains the page directory */
>>       struct amdgpu_vm_bo_base     root;
>>       struct dma_fence    *last_update;
>> @@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct 
>> amdgpu_vm_update_params *params,
>>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>                 uint64_t start, uint64_t end,
>>                 uint64_t dst, uint64_t flags);
>> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>>     #if defined(CONFIG_DEBUG_FS)
>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>> seq_file *m);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 88de9f0d4728..c6f91731ecfb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -624,12 +624,22 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>    *
>>    * @entry: PDE to free
>>    */
>> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool 
>> unlocked)
>>   {
>>       struct amdgpu_bo *shadow;
>>         if (!entry->bo)
>>           return;
>> +
>> +    if (unlocked) {
>> +        spin_lock(&entry->vm->pt_free_lock);
>> +        list_move(&entry->vm_status, &entry->vm->pt_freed);
>> +        spin_unlock(&entry->vm->pt_free_lock);
>> +
>> +        schedule_work(&entry->vm->pt_free_work);
>> +        return;
>> +    }
>> +
>
> I strongly prefer to handle this in amdgpu_vm_pt_free_dfs() or even 
> the caller of this instead and keep this here the low level free 
> function.

Agree. Will send out v5 patch.

Philip

>
>>       shadow = amdgpu_bo_shadowed(entry->bo);
>>       if (shadow) {
>>           ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>> @@ -641,6 +651,29 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>       amdgpu_bo_unref(&entry->bo);
>>   }
>>   +void amdgpu_vm_pt_free_work(struct work_struct *work)
>
> I think we could make this one here static if we introduce a 
> amdgpu_vm_pt_init()/amdgpu_vm_pt_fini() function. But not a must have.
>
> Christian.
>
>> +{
>> +    struct amdgpu_vm_bo_base *entry, *next;
>> +    struct amdgpu_vm *vm;
>> +    struct amdgpu_bo *root;
>> +    LIST_HEAD(pt_freed);
>> +
>> +    vm = container_of(work, struct amdgpu_vm, pt_free_work);
>> +
>> +    spin_lock(&vm->pt_free_lock);
>> +    list_splice_init(&vm->pt_freed, &pt_freed);
>> +    spin_unlock(&vm->pt_free_lock);
>> +
>> +    root = amdgpu_bo_ref(vm->root.bo);
>> +    amdgpu_bo_reserve(root, true);
>> +
>> +    list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>> +        amdgpu_vm_pt_free(entry, false);
>> +
>> +    amdgpu_bo_unreserve(root);
>> +    amdgpu_bo_unref(&root);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>    *
>> @@ -652,16 +685,17 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>    */
>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>                     struct amdgpu_vm *vm,
>> -                  struct amdgpu_vm_pt_cursor *start)
>> +                  struct amdgpu_vm_pt_cursor *start,
>> +                  bool unlocked)
>>   {
>>       struct amdgpu_vm_pt_cursor cursor;
>>       struct amdgpu_vm_bo_base *entry;
>>         for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> -        amdgpu_vm_pt_free(entry);
>> +        amdgpu_vm_pt_free(entry, unlocked);
>>         if (start)
>> -        amdgpu_vm_pt_free(start->entry);
>> +        amdgpu_vm_pt_free(start->entry, unlocked);
>>   }
>>     /**
>> @@ -673,7 +707,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>    */
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>   }
>>     /**
>> @@ -966,7 +1000,8 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>                   if (cursor.entry->bo) {
>>                       params->table_freed = true;
>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>> -                                  &cursor);
>> +                                  &cursor,
>> +                                  params->unlocked);
>>                   }
>>                   amdgpu_vm_pt_next(adev, &cursor);
>>               }
>
