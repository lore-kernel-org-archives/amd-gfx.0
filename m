Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAE7C4708E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Dec 2022 15:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB3C10E32C;
	Tue,  6 Dec 2022 15:14:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2173B10E32C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Dec 2022 15:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V03lGRBT3dk4N9hsGSlSJ5Vddqo+bazPJVyo8fR1itThwcc3s4okw5YCsIq+UYSo+DO2RRNjhbOZR4EghmHlXwEj1zE/Nt+OWeSkt1p61DLdYrtzB+nzYAMNwr5zHXDalHAu3vwY9+cHuez8t2eu9zDzZ8Rf+5oAjHu5s4KcQQO4JJCReM67uL0MvEIiyDLzgZb4+du6Pa5QvmWQe1Tu4w1hbSEMtYHqjVqHynVISOaqYo5ncLvTVZh1mmS962+FhTdmCRjmvbuaYSH8/w7kw8nshzVZTmDmNAhKAgum4+NQfnhLsIdaH1Ni5CwkhAXvFfR3qF2EFvEdMiaOS9pVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV2qfPRfpEuZVnt8DK0LNfKWr3OEkEUlqsFxP9aURx4=;
 b=ZSH3u198AphOMuLGTl/e9KP+bEaZOyiDuFTPX0RhiiHNXVn40rrjgcO6DeAgwPMloG8uHCvwveGQFgi3MbVOMWWZjFcjwUJmbVJaD7KZgzTjN36QZtbN+162heIaBZ3z4WKEKksEwpXGXMji5Cw/si+gTl8OSzWpIdonMTk7l8vRzcTQorEEa2YvL/u0JRpROsK7JaDj41Gye9g7jF8ykTcIzthVGu1W7SfxvVOap0nib9zjRTJyi61RvgA1StgryIl2BC0Gx+IjQFo8O88PGkeskyOtzAepmSBXskqED18qhsh7MtXiklcjbm7RL/Pr6FNsBxOROiSVlB4vgB47Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV2qfPRfpEuZVnt8DK0LNfKWr3OEkEUlqsFxP9aURx4=;
 b=aLuybhzU+qkLPfW1WPhnZfZvo49+gvVxZNdD0q9P3ARb4dAWPTQbv1M/QhvtFP1VO4gBAMGn6VULvQPFfZlZQITec4S8s8HMFlB9kkspwpEXaSBwB1WmuhVV7IGhQfE4qgtPgtK/HA10pf/8WpIfJkF3mzIed9e5RWn3GqCU1Is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 15:14:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 15:14:35 +0000
Message-ID: <ee07b373-9de2-faac-320c-ee7b15048cd9@amd.com>
Date: Tue, 6 Dec 2022 10:14:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Another circular lock dependency involving fs-reclaim and
 drm_buddy
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
 <eb075cb2-1649-e149-6f53-c86a30f9fffd@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <eb075cb2-1649-e149-6f53-c86a30f9fffd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f3210f-79fe-43a9-144d-08dad79c95a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2d2z8dv4y5RYI9wxfACTiEBJLcZuLkryk1+filkeQOZP10vTyNHy52HNakfMsG8/0TV5ggbAbdyraRgutmz4oR99SXiMlxxtJ7p8bDtzN9Vb33aNdsjgZHmMhLH1cQYdJPD2D+JO5881ocrSG6RvIOZqHa9VXEXZwCtQ0/v0UPNsQnM/grDXTqsrokmMweXpe7TFaFPC5yVtmSHg7+MHKc+Fub/inSm3/Yhc2Rkzhwpb/vo7/PXy1B1Fo/WE3HbRF03rh+3nftQeyD9AyEOwm7v3cRbFk9jfLhIW8gyHiJ6kPnQO4YI5+nE+PB11U/j+wIg58ETr3o2rrOqdZr1vk8Xn4RpjBF0J9xQSlaQ+HgS4OsKDf3mgBfO+2fbkU0shZaeWCkZCRUPL9ZZqA0arLOix2E3s41ouRKW2WM8nR75FavNHcQsLittsk4/b3sCBsZNtZJ4a07LmnJLlOZju8Z0G6bpWwmHCyfuRrag7sc9rZbMg8Oa0LftEidhcD5WpU9oAEpPXUlW0sKFb8sWvANqAVDY7P/X8aTbYhrBSYJ1ird4wYq7Tw2ZNYmgcWeihI2O0v+YEuo3vaRXZKuO95uarTOcadQ1dqPM2e3nGAlgghmA70lnX+Q0PRqFzo3/A+qDwVSpNhg6qac86UtmvUR12Ees5i9aB0qRMuUZevKFxoX5Xj/IQd4eXRgJw5Wx6ctCBUf0l7TD3ner7sKB00kFlStwBkoyPUUGcmzxKNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(36756003)(5660300002)(31696002)(86362001)(8936002)(44832011)(2906002)(41300700001)(66574015)(30864003)(83380400001)(6486002)(66476007)(316002)(110136005)(2616005)(66556008)(66946007)(31686004)(38100700002)(8676002)(478600001)(6512007)(6506007)(26005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJqVEJHa0VuZkpqT29qY2NDZVk3ZzhNV2dRYjNoRUFjVFJpckJPYTcyYnpn?=
 =?utf-8?B?MHlpamorbHdNR3Ftenp3bDFsamlxdXFPSElBM2N6Tk9LbThGTzlZelZ1azVI?=
 =?utf-8?B?b1NKNkFtVlUvNWc0UXhNOXJycVhrWWVNaWZYL3RhWGZzZGE2TUV3eUltNkp5?=
 =?utf-8?B?SzZZUmo1TDNlMEl6Qk1PWlBWaGVQRkZROXhlbXhXY1B5Qy9WRkpDY3JwYzNY?=
 =?utf-8?B?WHRoNWd6RThOT2RhY2h0bGVydjBGWHpVT1ljOE5ndmpianhIRWF2SXQ1Mk5M?=
 =?utf-8?B?OVNYY2d6ZW5rWk1XMFVQbzBxc05HV0YzMGh5Vk1KdVlGcSt3OWp2VFpKYXlx?=
 =?utf-8?B?VXdxWlc4QXgxeVZJMDZST1orTEtLVDVlb1JRd0Y3L1R4UjRnNEQ0NDNNSTVP?=
 =?utf-8?B?MXNjeUxZSCtPRXp5K2VrUWttUUJXKzFKVy9VMGVuWVFnRlYwZ1ozZ0orZ3Av?=
 =?utf-8?B?SzE2SC9naXBabytDa1NlWk9ndlBhVjJCOCtka0pRM21IU0pzNGgraVJEYjdV?=
 =?utf-8?B?eWdlR1ZlaXZGT2Y5VUJRbEVRT0M2MUxkMDNKODdwRkdVaVc3bzhBdFhmTmhl?=
 =?utf-8?B?djhFemFYWHlHaGtEU2k2MUQvUWJsMzVCTUxQVHZHL254d0M4elpZcm4rQU4z?=
 =?utf-8?B?dFJ3SmtSaUhieE5uOGlWbVRNbnNmckNVSG9rUXU2blh0MENaSVVFNlMvU0Zq?=
 =?utf-8?B?LytaRkY2dHJOM2dZTXJjUU5KYVRvQ01PWUZERjFFV2RSbFRFTG1TUnJUZmtY?=
 =?utf-8?B?bGNkc0s5dHg4NncxbzQ1VmxHQlhvVHgzWkYxbTJrMkw0RStwdHpIYjBmZXZG?=
 =?utf-8?B?K0dsa1k0SHk0NzdUdXJ2azVKejJ1S29IVDdpL3VxY2hTRzZvYURhVmJlTFBG?=
 =?utf-8?B?TnlDU2JKSElleUJXZEZ6YXhCQy9MQmN4WFJJZndVbHIvQTM2UnluY2tkVFpa?=
 =?utf-8?B?REphNmdxVXZJK2l1cDd6ejVnd2FEWEk5VmVBVzBlejl2LzlsUjQwcEZESmJi?=
 =?utf-8?B?SXpoQjZJN2tWNzhCZUhXd2NuMDlNRloxVG5jN09rU0dWdWRoNU9qcnI1eUdN?=
 =?utf-8?B?eUlLZmdEdnR1VFZxeE5xWWh4eVNQb29oKytldDdxVXlmclBSS0REK1BlbllQ?=
 =?utf-8?B?bWF1TE9IUFNJTXlCVU1zcWw5ajg3WnhzeDNQc1dHTWwxNHJqUUNvZjExRjZu?=
 =?utf-8?B?QXMzUG9US2M0VHp6bnVMZkY1QldGb0l2aytpeHkzeDd6ZEU2QXJmUGdOb0hT?=
 =?utf-8?B?aWJnaVYrK3FscTlPT1hDMHN1b1Y3OWRTOGFQcWhzOXdSVnNrTXh6NS9lRkt4?=
 =?utf-8?B?aVpHRnJwWGg0UkV3VEh0WTVDWHBpM3ZmMW9XcXQrb3EwYzRVSW9sUHRQNUdx?=
 =?utf-8?B?S29uNXFWWFUwbndEaHN0SXpYdjVOMmxlM1FFRlg1UHFQMENnTFFXOFRYMGZn?=
 =?utf-8?B?ajYyZWpuZ3FDWXExRit3WnpiZ2FNbmVpTi9yWnloVFJTdDRuL1l1aXE1RjZ2?=
 =?utf-8?B?Vis4QUFHOUpZcWttSzJ6aTM4K0RkU1pSSEhlTFc0Mk9iejlFSi9BK0RkWFFo?=
 =?utf-8?B?ZC84Rk9EVlkvcXRiaW9yZko3aVRWei8yS1Zob2wwakw1QVNoSkdVNitRc052?=
 =?utf-8?B?eldSaEt6Z1Z6aXQ5OGVQZmQ4S09xUjJ6YktmK3l4TmhhLzRhYVQ2ZWFmUldl?=
 =?utf-8?B?MVpNeDA4RFFJSnhjVytyNFNYTnJsQkhxS0dOL2VSdHA5MytrVU1vd3ZtNlVV?=
 =?utf-8?B?a1VEUFdFbXFMT0xCeHRGaTJYWkpXcmd6SW1XT3BZVXZ6VkFiTzBZdXFSb2o1?=
 =?utf-8?B?TllPaWdCOEJoOGZjdUpoOWFycTZyT3F4V2U5OUs0Q3NvbkNYVGVaOWJKRVkx?=
 =?utf-8?B?bjk2VHhseSt6QVV4ek0ya1NPek9zZmtXalJCZE5Yb0haOEwyZDl4V1hXdkpY?=
 =?utf-8?B?T3R2S1dvNGdGSExHMWxwMXdIZ3AvdlhMRmVIUm9aQ3JNMHVFMXRHTWVub1pa?=
 =?utf-8?B?OHl1TmFhUWRZQStDSGNOWDViNWF3T2p5TEVKelBRUG1FUHpzYWU0MlBSSHpi?=
 =?utf-8?B?d0dQRTZxL1ZBQThIM3hkRjB1MWJ2MWg3WjR0cEI5TFVEcXhHa2h2ekswcU1V?=
 =?utf-8?Q?nhchVLcT/vLgueoEv52U5rMda?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f3210f-79fe-43a9-144d-08dad79c95a6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 15:14:35.3155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8GkFG9qIUEnrmDOEz2SehdcSTh13uXae++nmH3MdVoPN+uQPPORgfDEsgmcGjskXEblsuE4JH8BpiObmZ5Swg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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

Am 2022-12-06 um 03:20 schrieb Christian König:
> Hi Felix,
>
> to be honest I think the whole approach you take here and unmapping 
> the range with the lock held is highly problematic.
>
> Essentially unmapping is something which can run concurrently with 
> other operations and should never be blocked by such a lock. In other 
> words it is perfectly valid for an unmap to run while another 
> processor tries to map the same range.

I strongly disagree. When an MMU notifier invalidates a virtual address 
range, it must guarantee that the device will not access the current 
physical location of the invalidated range any more. Without the lock, 
another processor could easily overwrite the invalidated PTEs with valid 
(but outdated) addresses that the MMU notifier just removed.

This is the relevant paragraph in the HMM doc:

    [example of driver updating its page table ...]
           take_lock(driver->update);
           if (mmu_interval_read_retry(&ni, range.notifier_seq) {
               release_lock(driver->update);
               goto again;
           }

           /* Use pfns array content to update device page table,
            * under the update lock */

           release_lock(driver->update);
           return 0;
      }

    The driver->update lock is the same lock that the driver takes
    inside its
    invalidate() callback. That lock must be held before calling
    mmu_interval_read_retry() to avoid any race with a concurrent CPU
    page table
    update.


>
> That's why the same page fault can occur multiple times until the page 
> tables are up to date.
>
> When you get an MMU notification that range A->B is invalidated you 
> trigger invalidation of range A->B inside the GPUVM address space as 
> well and that's completely independent what's mapped there.

Not exactly. Because we're in a shared virtual address space, we know 
exactly what's mapped there. If the MMU notifier invalidates it, we have 
to coordinate with it to make sure we don't write incorrect addresses 
into those PTEs. In the example above, holding the lock guarantees that 
a concurrent MMU notifier will not return until after it has overwritten 
the PTEs we just updated. Alternatively mmu_interval_read_retry fails, 
which means the MMU notifier got there first and we have to get updated 
addresses with hmm_range_fault. Either way, the page table ends up with 
PTEs with V=0 before the MMU notifier returns.

Without holding the lock while writing the page table, we could end up 
with a mix of valid (V=1, but outdated address) and invalid PTEs when 
there is a concurrent validation and invalidation of the same virtual 
address range.

Regards,
   Felix


>
> Invalidating the mappings and eventually scheduling that they are 
> re-created is a separate step which should come independent of this if 
> I'm not completely mistaken.
>
> Regards,
> Christian.
>
> Am 06.12.22 um 01:04 schrieb Felix Kuehling:
>> We fixed a similar issue with Philip's patch "drm/amdgpu: Drop 
>> eviction lock when allocating PT BO", but there was another one 
>> hiding underneath that (see the log below). The problem is, that 
>> we're still allocating page tables while holding the prange->lock in 
>> the kfd_svm code, which is also held in MMU notifiers. This creates a 
>> lock dependency between the vram_mgr->lock and fs-reclaim.
>>
>> There are three ways around this:
>>
>>  * Do the page table mapping outside prange->lock (creates a race,
>>    contradicts advice in Documentation/vm/hmm.rst)
>>  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
>>    allocate page tables ahead of time somehow)
>>  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore (may cause
>>    memory allocations to fail in drm_buddy under memory pressure)
>>
>> I only mention the first one for completeness. It's not a valid 
>> solution. Neither of the remaining two options are particularly 
>> appealing either.
>>
>> Regards,
>>   Felix
>>
>>
>> [   83.979486] ======================================================
>> [   83.986583] WARNING: possible circular locking dependency detected
>> [   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
>> [   83.999044] ------------------------------------------------------
>> [   84.006088] kfdtest/3453 is trying to acquire lock:
>> [   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: 
>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>> [   84.023911]
>>                but task is already holding lock:
>> [   84.031608] ffffffffbcd929c0 
>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>> unmap_vmas+0x5/0x170
>> [   84.041992]
>>                which lock already depends on the new lock.
>>
>> [   84.052785]
>>                the existing dependency chain (in reverse order) is:
>> [   84.061993]
>>                -> #3 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
>> [   84.071548]        fs_reclaim_acquire+0x6d/0xd0
>> [   84.076941]        kmem_cache_alloc_trace+0x34/0x760
>> [   84.082766]        alloc_workqueue_attrs+0x1b/0x50
>> [   84.088411]        workqueue_init+0x88/0x318
>> [   84.093533]        kernel_init_freeable+0x134/0x28f
>> [   84.099258]        kernel_init+0x16/0x130
>> [   84.104107]        ret_from_fork+0x1f/0x30
>> [   84.109038]
>>                -> #2 (fs_reclaim){+.+.}-{0:0}:
>> [   84.116348]        fs_reclaim_acquire+0xa1/0xd0
>> [   84.121697]        kmem_cache_alloc+0x2c/0x760
>> [   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
>> [   84.133679]        split_block+0x4d/0x140 [drm_buddy]
>> [   84.139539]        drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
>> [   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
>> [   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
>> [   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>> [   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
>> [   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
>> [   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>> [   84.183600]        amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
>> [   84.190803]        amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
>> [   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
>> [   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
>> [   84.210813]        amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
>> [   84.218077]        amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>> [   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
>> [   84.231313]        local_pci_probe+0x40/0x80
>> [   84.236437]        work_for_cpu_fn+0x10/0x20
>> [   84.241500]        process_one_work+0x270/0x5a0
>> [   84.246805]        worker_thread+0x203/0x3c0
>> [   84.251828]        kthread+0xea/0x110
>> [   84.256229]        ret_from_fork+0x1f/0x30
>> [   84.261061]
>>                -> #1 (&mgr->lock){+.+.}-{3:3}:
>> [   84.268156]        __mutex_lock+0x9a/0xf30
>> [   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
>> [   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
>> [   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>> [   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
>> [   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
>> [   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>> [   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
>> [   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
>> [   84.322090]        amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
>> [   84.328793]        amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
>> [   84.335537]        svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
>> [   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
>> [   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
>> [   84.354808]        __x64_sys_ioctl+0x80/0xb0
>> [   84.359738]        do_syscall_64+0x35/0x80
>> [   84.364481]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [   84.370687]
>>                -> #0 (&prange->lock){+.+.}-{3:3}:
>> [   84.377864]        __lock_acquire+0x12ed/0x27e0
>> [   84.383027]        lock_acquire+0xca/0x2e0
>> [   84.387759]        __mutex_lock+0x9a/0xf30
>> [   84.392491] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>> [   84.400345] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>> [   84.407410]        unmap_vmas+0x162/0x170
>> [   84.412126]        unmap_region+0xa8/0x110
>> [   84.416905]        __do_munmap+0x209/0x4f0
>> [   84.421680]        __vm_munmap+0x78/0x120
>> [   84.426365]        __x64_sys_munmap+0x17/0x20
>> [   84.431392]        do_syscall_64+0x35/0x80
>> [   84.436164]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [   84.442405]
>>                other info that might help us debug this:
>>
>> [   84.452431] Chain exists of:
>>                  &prange->lock --> fs_reclaim --> 
>> mmu_notifier_invalidate_range_start
>>
>> [   84.466395]  Possible unsafe locking scenario:
>>
>> [   84.473720]        CPU0                    CPU1
>> [   84.479020]        ----                    ----
>> [   84.484296]   lock(mmu_notifier_invalidate_range_start);
>> [   84.490333]                                lock(fs_reclaim);
>> [   84.496705] lock(mmu_notifier_invalidate_range_start);
>> [   84.505246]   lock(&prange->lock);
>> [   84.509361]
>>                 *** DEADLOCK ***
>>
>> [   84.517360] 2 locks held by kfdtest/3453:
>> [   84.522060]  #0: ffff9a99821ec4a8 (&mm->mmap_lock#2){++++}-{3:3}, 
>> at: __do_munmap+0x417/0x4f0
>> [   84.531287]  #1: ffffffffbcd929c0 
>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>> unmap_vmas+0x5/0x170
>> [   84.541896]
>>                stack backtrace:
>> [   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 
>> 5.19.0-kfd-fkuehlin #75
>> [   84.555537] Hardware name: To Be Filled By O.E.M. To Be Filled By 
>> O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
>> [   84.565788] Call Trace:
>> [   84.568925]  <TASK>
>> [   84.571702]  dump_stack_lvl+0x45/0x59
>> [   84.576034]  check_noncircular+0xfe/0x110
>> [   84.580715]  ? kernel_text_address+0x6d/0xe0
>> [   84.585652]  __lock_acquire+0x12ed/0x27e0
>> [   84.590340]  lock_acquire+0xca/0x2e0
>> [   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>> [amdgpu]
>> [   84.602338]  __mutex_lock+0x9a/0xf30
>> [   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>> [amdgpu]
>> [   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>> [amdgpu]
>> [   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>> [amdgpu]
>> [   84.629353]  svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>> [   84.636742]  ? lock_release+0x139/0x2b0
>> [   84.641374] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>> [   84.647976]  unmap_vmas+0x162/0x170
>> [   84.652203]  unmap_region+0xa8/0x110
>> [   84.656503]  __do_munmap+0x209/0x4f0
>> [   84.660792]  __vm_munmap+0x78/0x120
>> [   84.664977]  __x64_sys_munmap+0x17/0x20
>> [   84.669499]  do_syscall_64+0x35/0x80
>> [   84.673755]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [   84.679485] RIP: 0033:0x7f32872eb97b
>> [   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff 
>> ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00 
>> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 0d 00 f7 d8 64 
>> 89 01 48
>> [   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 ORIG_RAX: 
>> 000000000000000b
>> [   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
>> 00007f32872eb97b
>> [   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 
>> 00007f32831ae000
>> [   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 
>> 000055e7570ad230
>> [   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 
>> 000055e75453cefa
>> [   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 
>> 0000000000000000
>> [   84.751584]  </TASK>
>>
>>
>
