Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DF3C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 13:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C63510E6F5;
	Tue, 13 Sep 2022 13:14:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673FA10E6F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 13:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9ggBiNF6sQtTR4GfxGNSD992+kGdFqatoF0lVXaEXvImc8imlLEVyErlUSDHrKt5GJutRysX0ytZUQzodZHSo3Te7rPva8jUUHjcQevCYsfq6RUrJTl2cJbXk/N0OmJ/wNiqrTI+tb0H5bnklYvC+Ws3BFC+lBs4X9mtftVeidL3iMs72RBPG83XL4U7/DH4I6BSRYkccl2YM0LqfD3gBdIjZLFnjRO2Nne9ctwusvxiOUKPFl/xf9W72trVLTVMcxmPKotuej/4COxeYKJrZTh+UM98A8GrEH04yBeYSOUy/dODkat4T/ldsWL8vjXbDzUjp8cTJjkkLxvV30Gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfsnd4nTke9mFiIg8YJhOGVgL9YbAHwGDJdqlp4M4fI=;
 b=EPvd3n4RdXbOC7BBl3b79jc+a954QwJwK+YDUkIeneCEkstvbEQTVIxDrfGi4lmK6xoDx/u1a383Pm5HBk77jKYBH4tSYAt3EciA5Y9FSynBwBGW0+uj4bAogUQFR7zfTuwk68m8AHxIEVmJSqmO1LHTyRZtLpg2N4iYaVsKrQag946TnXBJZTJLtELXLGV1pT9H9snVpFpH1coyM6ZpyJLrFqgL+PKjvKlCp3qDh7LpB1w24B0osxORNQzu4XVIzWEgjTiCV2L+pcASxTG4D6UtMMVWfBnI2MwYvCkkgbKJ5Wns/B6QDnbClIX3mSuvY8H1kHUlGUHv6eJWCrFQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfsnd4nTke9mFiIg8YJhOGVgL9YbAHwGDJdqlp4M4fI=;
 b=2Pb3AVBlQKNHInKWRpIN2FxVmEL3SRdzBeiVhlk/n5h1QfXgpTAgsPNFJ98evDnEH7XdzYqa9fpXhHJAZbzGApCYRxKXI04AdobC3u77GLDYjOBKENVzECDIdQQjek0KUVjt+jsvXRLn+/GTYTLPU6v1EP4m17Yos7eyDnwdb7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 13:14:14 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb%2]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 13:14:14 +0000
Message-ID: <cb58869b-a341-ce6c-c595-7542a7614ca1@amd.com>
Date: Tue, 13 Sep 2022 09:14:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220912175817.17985-1-Philip.Yang@amd.com>
 <6e223900-7b8a-8ec6-e08d-aee0697a1aa0@amd.com>
 <4b34d62a-b34d-1ab9-a3cb-032a1b6e580e@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <4b34d62a-b34d-1ab9-a3cb-032a1b6e580e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f06527-f500-414e-5140-08da9589db04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cu/Hx1pSfkOv+qBShLEmE/KJe8WJ+4lPT7kZcdYZJnV+RkQCHm3OqA2ytJGpwrbdUDbgOLid1H5SeyXqCOr6FejATVf3BVYyecRUQP2ARbqnLInMm3txyytU2fwlzmUHOJjcqHc/uex9PTZF2JyXJxxWeXRZ1CzLvoQdXpcS8IxMtQMHpPnvUgZU6m3G2BWK/NSwnZhkycx0/d8Dq8z0rJR6zwCwidbqOzwb7wvLAgEPfsbwgK+uYLSBwAwzrjKIVeM9iEFWl+nvI0JJcnPiQk2cfSO6wiWCeTVSNvSPA6CvHHJfxDwkgcGp4lg0JOTFCZZDB7IBRGk7ql/7+x07r2tS7muhrKaf7JXEQNOnTv6upgeTgqOAoHPTnJ2yFYzyiOvtKXON1h0/dnqDCGQPs6/ymx76lsYW7oahvJZ93uEx/RsqOR/KPZz+0A4flF4E7WeL8plhkWSmXHvUQc59ne6DJ43Yeo5KbvDymcM4PwjMUJzmLBHp7i6yjvKcYgMAnYdwrRwpVIHthpMbieYQgXZgWKv84deu+gGidmG/4wgn0NPDxgFYC+t0NRvp/BrV3HtZ2f2XEPar5+kmUA8VuyFjlRpMMgXnvfzF+l5Hv74rVTkdU5vBnZ6Obs9olentkUoa1JtgrKyIScGxdHBltk2LSiDUfO8HMp64E//Gkg8+Bbk6Itg/AXTJziHVKMN79FymDkanuAbEqNu+mZGHG3hTtSh9EsbOqDzxP+rTjmqbTTombVK/JWj2/+/m4yeXz78EWl41NP0NZ6nnZ/yO4Dl9c0GYKvk3xDN76lKwUQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(316002)(6506007)(6512007)(36756003)(8936002)(31686004)(478600001)(26005)(8676002)(66556008)(38100700002)(66476007)(83380400001)(2616005)(2906002)(66574015)(186003)(5660300002)(41300700001)(53546011)(110136005)(31696002)(66946007)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5Jelg3RllZcVM2TnM1U1hFSUpMb0JSU3VBRlg3bXlwMWZVWFlGRHBObjVq?=
 =?utf-8?B?L1JQemNKcmRjYmVzaE5IZWtqZnJmTkV3UzZlWlpnRU03bmpINUR1ZXBOVjgr?=
 =?utf-8?B?dDJsMkNWYTA1UUhpa2NIZTdZRmkxNEJOTFQzMzZSOE5oYkVqb2RMTG9qYWta?=
 =?utf-8?B?V1o3VmxqbUM3YVRtQW9KeUYxcVRDZUtveVFaL2xQcTIxNDlmWUdDaFBjcUdl?=
 =?utf-8?B?Zk5IL1pYeHpxN1dNc002cTNLTjRUR0RWZllBdWQ5L1VWYk51V2F5dXVBR1ll?=
 =?utf-8?B?dlhPM0xhR0VmMHdDQjNDZEp6LzdNUkxyUDB2YW9wTjZtVzZvZ0dQbHVaWk5N?=
 =?utf-8?B?bTFtMEI4S3VveUxJWXJKR0FhK1BPa2YxTU9wZU8zWTNTMFJzZS8zTXZYa21y?=
 =?utf-8?B?b3dDbDgzbENRcjJnb1ZpR1FxUnp2UlhQbGw2SHlDdXJMZlFZR3JMZHRiS0FS?=
 =?utf-8?B?MU94Qjk5T05uVXB1YlZVNS9JSzNIR3JSSkJta05WekZpNTlaWnoxMkNxbVdy?=
 =?utf-8?B?RUJGVHRyMGZQT3B1NHREdTlJczBoTnFqZHpuOEUwSFB1V21WM3o2c3R6bmRG?=
 =?utf-8?B?RFFmUGNBMGpqYXhEWXQ4amNsNjdQMDNzQUpVME0wZ1VBbFJ2VDRLWG9FUjI4?=
 =?utf-8?B?NmxBYlJxNjUrT1FPYk0wUHppemdEeG1BS0oyQ2RBTmM1bmF6VHFhTCtEQWx1?=
 =?utf-8?B?NEJoVFVES3h4MklJZUUxRjlqdndwWDlTVHhGVjIycDFLczNITUlGMDNtKzcr?=
 =?utf-8?B?Sm9FMlZQaW5IQlRMaHY5Z0FTRDJTdVpBMHFidDhtNUVoWXVMTzlYb3FId2x1?=
 =?utf-8?B?U1ZFSEowUzdvaW9mdU5qU3QwejNUcEpEdUpVNVVwMUVuNHp6VFFmS1JzZnZG?=
 =?utf-8?B?WURRZWNMdkdha0VURC9Od2RndGkvL0VsSllHeUd2QkNaVjNsbnREQzN4TG9o?=
 =?utf-8?B?ZWVrN0ZOazkyWnVFSkFCWjhrZzhXcGMwVFAycElPQU1JSlN3VFhiN1JZalhj?=
 =?utf-8?B?ci85SVBQNldRMEsyUUJTVTE2OHExbVV3azUwNm51SFpzaHhsM2V6N3pNeU13?=
 =?utf-8?B?ZjlFSHM2Nk5VcDJTVlNHd1UzaFptZWZGL0Q2RWxNRmNtSS80R3o3T3Y1Ukox?=
 =?utf-8?B?MW04ZHVmcTllOTdsSlVicjdJbWFpbmhQUHRXZlU3VnZRdEJsVktJYTNjYmZv?=
 =?utf-8?B?OElRbE9lWDVjWGpOaEo5dzZJZWVkWkc0M3lxSjVEamxzdzRNNlpHK3hRb21p?=
 =?utf-8?B?UjRodHNZVXRWU0JvYkNsQmtNSUtsdEFvejFEc01Db09jQlRFNUptL3NTcHJl?=
 =?utf-8?B?d1RsYk5FYmI1aGFhaEFQdFFPbjJ6amlZbDhXYTRweVQ5Nm1YWTIxekVyT2sx?=
 =?utf-8?B?WVRuYmJtb1g0L3UzVmthMzVuLytVaUdSVi9oSDVuVHN6MHNGdjBKcnZqSkpL?=
 =?utf-8?B?cmFqbmFRZmRUdGo3aklIZ0syK2J5ZHJ1a0VQYVd2WSsydThHNlloSE5lVGhs?=
 =?utf-8?B?RkRzTWszR2JVS2ZqQ2Q0UTNLQzhXTGRBcGtLcWRURWxoZ20wVVVvTytqay94?=
 =?utf-8?B?UlN4Z3dqeTFwNzVVQi9mRnEzT1A3cjdXaVQ1Z1lVUi9IQXZBQXJXRkNOU2Ey?=
 =?utf-8?B?bWt6ajI2OXI0UHZuM2xacmxCck1HQkk4dC9WQkNWcnVVVnI1eWJDeEIyMWl2?=
 =?utf-8?B?eW4xVEwwYzdUSzhvL2d2SVNMTUsxYzVmYzVLc0NEamNQYUovcmlKQXNxbThS?=
 =?utf-8?B?bVhObGdINm9kUWJQQXZuQ1JoNUYyM3hpNHdGQ3lzdmw3N3dFSEJiZng2YkV2?=
 =?utf-8?B?d3FQQWFzS0xzRnBlMDJ5Y0pCUHU3bHRJWVIrcjFoc3ZNMGRLblhQdVJOdDNx?=
 =?utf-8?B?bDVkRG41VjhSK1cyR1ZqTHpQSWRINm9oNWJWZkdBaWtXQXZOVE9MblpCQkpz?=
 =?utf-8?B?UHpUbnBZN09ua3hseXplREVqTWgreVJSdUE1QktXRzZsT3dSZ0xWa1ptZzZm?=
 =?utf-8?B?aUw1WHVxS2Y3SUE2YUVrdnV6WFZNSXdKZlFNOHZSRFlmTUQ5WXd5SzNBZFQ0?=
 =?utf-8?B?TFVyRVEycDlrQVdTWEZTVFEvYTVkNmFmNzc1cjRWaWJOYktjQS9sZzFPUlRk?=
 =?utf-8?Q?tjxo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f06527-f500-414e-5140-08da9589db04
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 13:14:14.5304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js3IzyP3unc3qif2oo0EYMeIdorA9YIriTNYt8Md51wJw5MA4O0B/5ZLLYmXvDhj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
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


On 2022-09-12 14:59, Christian König wrote:
>
>
> Am 12.09.22 um 20:48 schrieb Felix Kuehling:
>> Am 2022-09-12 um 13:58 schrieb Philip Yang:
>>> Free page table BO from vm resv unlocked context generate below
>>> warnings.
>>>
>>> Add a free_bo_work in vm to free page able BO from vm->bo_freed list.
>>> pass vm resv unlock status from page table update caller, and add vm_bo
>>> entry to vm->bo_freed_list and schedule the work if calling with vm 
>>> resv
>>> unlocked.
>>>
>>> WARNING: CPU: 12 PID: 3238 at
>>> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>>> Call Trace:
>>>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>>>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>>>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>>>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>>>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>>>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>>>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>>>   unmap_vmas+0x9d/0x140
>>>   unmap_region+0xa8/0x110
>>>
>>> WARNING: CPU: 0 PID: 1475 at
>>> drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
>>> Call Trace:
>>>   dma_resv_iter_first+0x43/0xa0
>>>   amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>>>   amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>>>   amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>>>   svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>>>   svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>>>   __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>   unmap_vmas+0x140/0x150
>>>   unmap_region+0xa8/0x110
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 51 
>>> ++++++++++++++++++++---
>>>   3 files changed, 55 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 59cac347baa3..add3b08ffde9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm)
>>>       spin_lock_init(&vm->invalidated_lock);
>>>       INIT_LIST_HEAD(&vm->freed);
>>>       INIT_LIST_HEAD(&vm->done);
>>> +    INIT_LIST_HEAD(&vm->bo_freed);
>>> +    INIT_WORK(&vm->bo_free_work, amdgpu_vm_pt_free_work);
>>> +    spin_lock_init(&vm->bo_free_lock);
>>>         /* create scheduler entities for page table updates */
>>>       r = drm_sched_entity_init(&vm->immediate, 
>>> DRM_SCHED_PRIORITY_NORMAL,
>>> @@ -2244,6 +2247,7 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm)
>>>           amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>>>       }
>>>   +    cancel_work_sync(&vm->bo_free_work);
>>>       amdgpu_vm_pt_free_root(adev, vm);
>>>       amdgpu_bo_unreserve(root);
>>>       amdgpu_bo_unref(&root);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 9ecb7f663e19..c8c59c66ca2f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>>>       /* BOs which are invalidated, has been updated in the PTs */
>>>       struct list_head        done;
>>>   +    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>>> not hold */
>>> +    struct list_head    bo_freed;
>>> +    struct work_struct    bo_free_work;
>>> +    spinlock_t        bo_free_lock;
>>> +
>>>       /* contains the page directory */
>>>       struct amdgpu_vm_bo_base     root;
>>>       struct dma_fence    *last_update;
>>> @@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct 
>>> amdgpu_vm_update_params *params,
>>>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>>                 uint64_t start, uint64_t end,
>>>                 uint64_t dst, uint64_t flags);
>>> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>>>     #if defined(CONFIG_DEBUG_FS)
>>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>>> seq_file *m);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 88de9f0d4728..12471ef126a9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -624,12 +624,22 @@ static int amdgpu_vm_pt_alloc(struct 
>>> amdgpu_device *adev,
>>>    *
>>>    * @entry: PDE to free
>>>    */
>>> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool 
>>> unlocked)
>>>   {
>>>       struct amdgpu_bo *shadow;
>>>         if (!entry->bo)
>>>           return;
>>> +
>>> +    if (unlocked) {
>>> +        spin_lock(&entry->vm->bo_free_lock);
>>> +        list_move(&entry->vm_status, &entry->vm->bo_freed);
>>> +        spin_unlock(&entry->vm->bo_free_lock);
>>> +
>>> +        schedule_work(&entry->vm->bo_free_work);
>>> +        return;
>>> +    }
>>> +
>>>       shadow = amdgpu_bo_shadowed(entry->bo);
>>>       if (shadow) {
>>>           ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>>> @@ -641,6 +651,33 @@ static void amdgpu_vm_pt_free(struct 
>>> amdgpu_vm_bo_base *entry)
>>>       amdgpu_bo_unref(&entry->bo);
>>>   }
>>>   +void amdgpu_vm_pt_free_work(struct work_struct *work)
>>> +{
>>> +    struct amdgpu_vm_bo_base *entry;
>>> +    struct amdgpu_vm *vm;
>>> +    struct amdgpu_bo *root;
>>> +
>>> +    vm = container_of(work, struct amdgpu_vm, bo_free_work);
>>> +
>>> +    root = amdgpu_bo_ref(vm->root.bo);
>>> +    amdgpu_bo_reserve(root, true);
>>> +
>>> +    spin_lock(&vm->bo_free_lock);
>>> +    while (!list_empty(&vm->bo_freed)) {
>>> +        entry = list_first_entry(&vm->bo_freed, struct 
>>> amdgpu_vm_bo_base,
>>> +                     vm_status);
>>
>> I don't see where you're removing the entry from the list. You need a 
>> list_del_init here.
>>
>> If you're relying on the list_del call in amdgpu_vm_pt_free, that's 
>> not safe because it's outside the spinlock. This could end up 
>> corrupting the list if another thread is concurrently adding to the 
>> same list.
>
> It's much easier to use list_splice() to move the list to a local head 
> and then traverse it with list_for_each_entry_safe() and free up 
> everything.
>
Use list_del_init can fix the race, it is simpler to use local list head 
and the traverse it. Will send out new patch.

Regards,

Philip

> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>> + spin_unlock(&vm->bo_free_lock);
>>> +
>>> +        amdgpu_vm_pt_free(entry, false);
>>> +
>>> +        spin_lock(&vm->bo_free_lock);
>>> +    }
>>> +    spin_unlock(&vm->bo_free_lock);
>>> +
>>> +    amdgpu_bo_unreserve(root);
>>> +    amdgpu_bo_unref(&root);
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>>    *
>>> @@ -652,16 +689,17 @@ static void amdgpu_vm_pt_free(struct 
>>> amdgpu_vm_bo_base *entry)
>>>    */
>>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>>                     struct amdgpu_vm *vm,
>>> -                  struct amdgpu_vm_pt_cursor *start)
>>> +                  struct amdgpu_vm_pt_cursor *start,
>>> +                  bool unlocked)
>>>   {
>>>       struct amdgpu_vm_pt_cursor cursor;
>>>       struct amdgpu_vm_bo_base *entry;
>>>         for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>> -        amdgpu_vm_pt_free(entry);
>>> +        amdgpu_vm_pt_free(entry, unlocked);
>>>         if (start)
>>> -        amdgpu_vm_pt_free(start->entry);
>>> +        amdgpu_vm_pt_free(start->entry, unlocked);
>>>   }
>>>     /**
>>> @@ -673,7 +711,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>>> amdgpu_device *adev,
>>>    */
>>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm)
>>>   {
>>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>>   }
>>>     /**
>>> @@ -966,7 +1004,8 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>                   if (cursor.entry->bo) {
>>>                       params->table_freed = true;
>>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>>> -                                  &cursor);
>>> +                                  &cursor,
>>> +                                  params->unlocked);
>>>                   }
>>>                   amdgpu_vm_pt_next(adev, &cursor);
>>>               }
>
