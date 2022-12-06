Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E292FC352A1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Dec 2022 15:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DB510E14A;
	Tue,  6 Dec 2022 15:58:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 003FF10E12D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Dec 2022 15:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8jhZliFTUzELuvtlyhAIn0yiBmXrQI23B+9pqx+Wsh1ag4XzvvM4MZ1tjqEmqpSa4U7ZiZyYYHNw5w9oVd2jxtdZ2NCId8L3Sc5choD9b4nGKUxtonGLwclT2sWHkZKYsuuEwHVKXtstQTEnH7nmrAf5vxXwe8Jg3dpDpUIe7187fBbRjlGroqGU1vW9cwe0Aiaqdo9V4ieuyod5reMhRUkIJH+Q8xKfon7YX3maAyEwHHopMFmTTfEUJ2VcppH9RZuB0uiiUVI9k/qkbsv4vn+dSTMyg1bGBMYc6NDKhYoaw05rv3tAF0y9Xqg708mNTaczPuHYnPQwLoBDyPaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ4dvelyaVH9Bc264mTi/OPi87Mw8yrFpUzhiE4s1hE=;
 b=Y4bd4DfxlXHu6PvhZNQIdqCzqneLxVM7GPvtWv2TM8fYWOmj+NsStFrTdUIeSqQGwzY4drBfVUIncE2BDZtAAR9Hf8/DvXiRHDIsaaM6KvLdD9uelBY//iUCvbCquinavvdPh/1E66zWjlZXV/j5l71NKaYmeeP+mqMnUXsuhHjMgDXBTx9hhv3SFvUZVbmlpI6aXRLMX6Yw+YuE1CUpNoPT8jLG1QjWqom0N8WVZ10K4oSRuN7WZMwimONDHtsjDTSS0sVOKtGt6myexJgFvLLir6SOJ9/yRKeDzQhwVhh3QLhW7Bu65evyoMzmP1UeqBzaxXFBB0DAjAmm8UfFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ4dvelyaVH9Bc264mTi/OPi87Mw8yrFpUzhiE4s1hE=;
 b=o2fboTNfdvqbnXu/qi2GomBP0utX+1XBTUldWjatRW/vyTPbo6QcbAvX0SOnRkEv7vclXT2+S8ZCNnEPqc+9A1CSNDzoNzaxEJs1uGeUkAn40k2/m/bfnxTQyns5/W88lH7mIEev5ZDRJmJxw+d68w473Q97AMCZyvRvXe2afYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 15:57:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 15:57:57 +0000
Message-ID: <dd4979da-6abd-ba02-8840-d59b78a3020d@amd.com>
Date: Tue, 6 Dec 2022 16:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Another circular lock dependency involving fs-reclaim and
 drm_buddy
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
 <eb075cb2-1649-e149-6f53-c86a30f9fffd@amd.com>
 <ee07b373-9de2-faac-320c-ee7b15048cd9@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <ee07b373-9de2-faac-320c-ee7b15048cd9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fe4965-d8fe-4d6a-70b0-08dad7a2a45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05G7P9tRfykzHwNdAarTu12RvUwJclPulr3W3Bqt28nJvgdHN5rPA+v84DiiOYz8cBk4Br1joyd5Xq5YUqCABWdB48QX3aZB3AYGawcMXEfkq1386hNg0Q00glOdFpM/txN3EZ1/7oByq01EeE4LvvZeBcTVKAMSsgCvUDVZgc6w7OLAJwrHTmADraBwMom2D2Hv8BVbWtLFXmUe+xz0W6vR1IWiniJkRhqMwjCitJIso8TrX0iqU2g5yT3K2orQYmjHBfpYchvQZSgwKcUTlhA75mRubK15nGgBFUtXLnwbzDHFbGBqii2WhwcP8avkYsnZJstW3ZKaiP0eAud0PFPuYH+pEN6xx2l+aaX6+PIpsmPEllSdkNuEEDfYhcrOvK5YZppH0zXqhQcnu1Z/QBXQTswiS8dBlYDR1+3TUbIdxt2fIu1U/iaEPtuTfMCLXtkd/SYC2n/+OFmi5KrUZ+tLG0xUgiwThbvalXXAr0katchlXT3j429HDau8tkqTiHG5lwUbn56tp4kPtRvJ54DK+nU8JAnFZy/6ORg/WzOuBoTf4YZY8h/OpkkBtntSYwwS4AuXhhyCKOEJS1x/E7pj2DZsw1FiugNBv5A572UeOCGSjjgN/r55ZG3aaruEtCdxqWv/Gg8LXOid4zxl4UUUNcVMSk45W8za+bZQicGiu/OUpmR7wFCDwweD1HwOawRQMUwHRoTqZ67ZdmK4woIHBi5ekLuHNeWG2eq4OBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199015)(31686004)(186003)(316002)(6486002)(478600001)(110136005)(36756003)(86362001)(31696002)(83380400001)(38100700002)(2616005)(6506007)(6512007)(6666004)(66574015)(5660300002)(2906002)(30864003)(8676002)(8936002)(66476007)(66946007)(66556008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXBvUzRZWk1CQ3dTNFArOW1PdWUrc1d6YmpTRWJmd0hRZlQwcFdVL3piV0hj?=
 =?utf-8?B?TW1vNWxFRXdQbnJrMkZGbHN0Y0VQZmRZRFlrTGJLQXBmQ2o4SU1UcXlYYVFO?=
 =?utf-8?B?ZDlSWmF2azVlZUgzQUdYS2NhSlJNdlVnU1V4VzlYeHFoQmRLZGVpTFV4dVFW?=
 =?utf-8?B?N2pOcm9Zeml5cjBFSlVDZnB2NzVGTEd3dXM2c05mZldpbmpNeTRsTHlYcjRk?=
 =?utf-8?B?V1gzQW1kY2Robmw3TFEwNW9ZcFc1dnhtNE5zYmVBdGJveXFyZGFkRjJXaUJw?=
 =?utf-8?B?cmhWckN5ZUdiSDFrK0ZSWkFmbmdxblp6a3czRWtaVTJzVnBsbmdTOGs2cUlK?=
 =?utf-8?B?cHdIZktydEYxcmJseDk3U3VRaER3aEM4T0swSENvVW9LQ1NyOVlWMU00aFpz?=
 =?utf-8?B?WTNhSDdJTmRET0UxVE5rL2JNTU9sRWlNbnkxOWFUYk44YVVuODNjU1lNTnJF?=
 =?utf-8?B?QzV3WHBvdjlvRGFCSHdqVUhSY09BZk9OL1dpTDJkSjZzZEQ4OHlmSXQzR0tr?=
 =?utf-8?B?eDNwMFArcHl5bkxteFJjRVpHQUxCQ3haSXU1TnhESDVKS3lYUkppejYwUW11?=
 =?utf-8?B?ZGVacW40Y0I1dWpXN0VmVUMzUWdZQU0wdTdJVHZmVEErSG1SQWM1c3Uycm4y?=
 =?utf-8?B?eFZVcjdiQjVNeGgrakV0T1dEUWFGTFE2cXB1R3Y2VEJkUGtjRzlwK3VPMERt?=
 =?utf-8?B?L3JIelNBNXpsbkpDczRodGJkVkdONUtYR0tkV0VtNVIvb2tNdGRLZlc0eDhk?=
 =?utf-8?B?YllUaFhZeC9Tb2hXZTc4TzIrWmt6TS9jR21ScXB3T09FWGJjZnVWbm4vaERR?=
 =?utf-8?B?dDNGZEhoakkyVytySDg1REY3TlI0Y3BtekcxaUxuZitocTRGTXQ4aGVENzRL?=
 =?utf-8?B?K2xrMm94SmRVc29IRFFkaTV2T1NEYlh5bmtjYkNDNXRpSDkvemRreFRQaXRY?=
 =?utf-8?B?Z0l2dU15TnZtNVlHbDdZZHh0VDE1TEh3Z1A4VUNXTmQzSlo4L0xyN1dWaU1L?=
 =?utf-8?B?aGtKS2t1a3BXcTV1WWx5RWQwdm9qZDFmN1RxS05RNWhWZXMyajBQSEpVL0ZX?=
 =?utf-8?B?NlRaNC9VeGNrSnUzVGJKQktFQVJSTUQ2Sk84Qkt1UHZMcTc1eWZJWXhZbzZs?=
 =?utf-8?B?bUQ2MjBqTWZiOFppVXhwN2ZLWG95QWpRNHMrL2dEYXhHM3F1WkRnTDhYUVNF?=
 =?utf-8?B?Qm1tc2R6bncwK3YyUEhxZXd4RE1BNTl6M3NKR3BjWUxoakowSE9EbkdmMkpI?=
 =?utf-8?B?YjJmdDJST0swK3gzc1IyenYzZnVnRy9qRnM3T3ZvWjdFdis2VytGMlQ4VTlz?=
 =?utf-8?B?SHJNbmlPODBnT2ticnAzWTZBeWd1bFNTc2ZpQlhuRkVWTVJ4c0lJQmpsT3hj?=
 =?utf-8?B?cFJvTnRUb3MrdjZya1pkZW9BN1NmOWlFNUErbnJDK1A4QktnRXhUWlRYdmh4?=
 =?utf-8?B?dzAxNnZsZFhJS1ZUb2ZhU05tWHhoM0tSUUpXVjZuaWlPR3lpQk1yZnRXRGYy?=
 =?utf-8?B?R3h5d1pnS2pFb01nYkNxaFF3QzhDWER6UmYrcGxoVjJvT29oWnZMckIrR2Iy?=
 =?utf-8?B?VnROVklydWF3NVdzLzkyblhGQ0xsVm4wUUlPWDBVWkRVV2cwQVJpNVNHWXpz?=
 =?utf-8?B?Sm9kVEM4dXI3ZUpmUG5SUDlYb0NIL04vNnhxSXR1M0xwTzdOTEJaQm5Qankr?=
 =?utf-8?B?RW5JeDVLdlBHazFCUklteWoyMFdGL3h3b0FLOXRjSytQOUZpejZvUEtBcWps?=
 =?utf-8?B?aGo1eWNjSm4xeFVkUElNQUgyN01TWWx1Q0tRV0JXV01FS1lqenVVNFNNYWFn?=
 =?utf-8?B?bFlkVTJ1T242am55VHJVeklxZTh1Um9ZZkZvVmZ4MzNrMVcweU1pN2UrSmxE?=
 =?utf-8?B?dENuU1F1SlY5V2xuSmlTOFNkYlJmcHI2WTJQdEJYZzhZbmhneEE0aWVOUEtk?=
 =?utf-8?B?ZEEwUi9tOWtaNXBmSzJ0TVIyOUUrMlNXL215bUd2Ni9OcFE0WHN4QmZqaU9B?=
 =?utf-8?B?YUxScUd0b0FmVUwxT2IwcWtzQTRUWEp2d2VTU3JSSm54azBtVUx2c2k0VUd1?=
 =?utf-8?B?L1d2NmFJMDRxZDdxbUdOeGVwcE5MdGxhYjF4VDFHRGRlMXNVbWNaZEhPeWFr?=
 =?utf-8?B?aGNJOEE2N0dEVGZucncrckxBMkxPRHBzbVdrdUJRbU1UZXN5SnpSVzRyVEoy?=
 =?utf-8?Q?nXdZ0b5wZiz8mPdQ93P5I8T7yJj6iNANjIc/5XrTb45g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fe4965-d8fe-4d6a-70b0-08dad7a2a45b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 15:57:56.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncQX5mXovgwhXajNMYwiGCdlY4NARa5eNUe8RApJfy2PGv4rYr+VMztJ/0XEcjSQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

Am 06.12.22 um 16:14 schrieb Felix Kuehling:
> Am 2022-12-06 um 03:20 schrieb Christian König:
>> Hi Felix,
>>
>> to be honest I think the whole approach you take here and unmapping 
>> the range with the lock held is highly problematic.
>>
>> Essentially unmapping is something which can run concurrently with 
>> other operations and should never be blocked by such a lock. In other 
>> words it is perfectly valid for an unmap to run while another 
>> processor tries to map the same range.
>
> I strongly disagree. When an MMU notifier invalidates a virtual 
> address range, it must guarantee that the device will not access the 
> current physical location of the invalidated range any more. Without 
> the lock, another processor could easily overwrite the invalidated 
> PTEs with valid (but outdated) addresses that the MMU notifier just 
> removed.
>
> This is the relevant paragraph in the HMM doc:
>
>    [example of driver updating its page table ...]
>           take_lock(driver->update);
>           if (mmu_interval_read_retry(&ni, range.notifier_seq) {
>               release_lock(driver->update);
>               goto again;
>           }
>
>           /* Use pfns array content to update device page table,
>            * under the update lock */
>
>           release_lock(driver->update);
>           return 0;
>      }
>
>    The driver->update lock is the same lock that the driver takes
>    inside its
>    invalidate() callback. That lock must be held before calling
>    mmu_interval_read_retry() to avoid any race with a concurrent CPU
>    page table
>    update.


There is something massively missing here since that won't work at all.

The problem is that we can't allocate memory nor fault pages while any 
lock is held which is also held inside the invalidation callback of the 
MMU notifier.

Updating the PTEs will always need memory, e.g. we can't guarantee that 
we won't allocate page tables. Otherwise dynamic allocating tables won't 
work any more.

>>
>> That's why the same page fault can occur multiple times until the 
>> page tables are up to date.
>>
>> When you get an MMU notification that range A->B is invalidated you 
>> trigger invalidation of range A->B inside the GPUVM address space as 
>> well and that's completely independent what's mapped there.
>
> Not exactly. Because we're in a shared virtual address space, we know 
> exactly what's mapped there.

Yeah, but that's irrelevant. We are not allowed to use this information, 
cause otherwise we run exactly into the described issues again.

> If the MMU notifier invalidates it, we have to coordinate with it to 
> make sure we don't write incorrect addresses into those PTEs. In the 
> example above, holding the lock guarantees that a concurrent MMU 
> notifier will not return until after it has overwritten the PTEs we 
> just updated. Alternatively mmu_interval_read_retry fails, which means 
> the MMU notifier got there first and we have to get updated addresses 
> with hmm_range_fault. Either way, the page table ends up with PTEs 
> with V=0 before the MMU notifier returns.
>
> Without holding the lock while writing the page table, we could end up 
> with a mix of valid (V=1, but outdated address) and invalid PTEs when 
> there is a concurrent validation and invalidation of the same virtual 
> address range.

Yeah, I see the problem now as well. But I can't come up with any way to 
solve this.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Invalidating the mappings and eventually scheduling that they are 
>> re-created is a separate step which should come independent of this 
>> if I'm not completely mistaken.
>>
>> Regards,
>> Christian.
>>
>> Am 06.12.22 um 01:04 schrieb Felix Kuehling:
>>> We fixed a similar issue with Philip's patch "drm/amdgpu: Drop 
>>> eviction lock when allocating PT BO", but there was another one 
>>> hiding underneath that (see the log below). The problem is, that 
>>> we're still allocating page tables while holding the prange->lock in 
>>> the kfd_svm code, which is also held in MMU notifiers. This creates 
>>> a lock dependency between the vram_mgr->lock and fs-reclaim.
>>>
>>> There are three ways around this:
>>>
>>>  * Do the page table mapping outside prange->lock (creates a race,
>>>    contradicts advice in Documentation/vm/hmm.rst)
>>>  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
>>>    allocate page tables ahead of time somehow)
>>>  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore (may cause
>>>    memory allocations to fail in drm_buddy under memory pressure)
>>>
>>> I only mention the first one for completeness. It's not a valid 
>>> solution. Neither of the remaining two options are particularly 
>>> appealing either.
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>> [   83.979486] ======================================================
>>> [   83.986583] WARNING: possible circular locking dependency detected
>>> [   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
>>> [   83.999044] ------------------------------------------------------
>>> [   84.006088] kfdtest/3453 is trying to acquire lock:
>>> [   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: 
>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>> [   84.023911]
>>>                but task is already holding lock:
>>> [   84.031608] ffffffffbcd929c0 
>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>> unmap_vmas+0x5/0x170
>>> [   84.041992]
>>>                which lock already depends on the new lock.
>>>
>>> [   84.052785]
>>>                the existing dependency chain (in reverse order) is:
>>> [   84.061993]
>>>                -> #3 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
>>> [   84.071548]        fs_reclaim_acquire+0x6d/0xd0
>>> [   84.076941]        kmem_cache_alloc_trace+0x34/0x760
>>> [   84.082766]        alloc_workqueue_attrs+0x1b/0x50
>>> [   84.088411]        workqueue_init+0x88/0x318
>>> [   84.093533]        kernel_init_freeable+0x134/0x28f
>>> [   84.099258]        kernel_init+0x16/0x130
>>> [   84.104107]        ret_from_fork+0x1f/0x30
>>> [   84.109038]
>>>                -> #2 (fs_reclaim){+.+.}-{0:0}:
>>> [   84.116348]        fs_reclaim_acquire+0xa1/0xd0
>>> [   84.121697]        kmem_cache_alloc+0x2c/0x760
>>> [   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
>>> [   84.133679]        split_block+0x4d/0x140 [drm_buddy]
>>> [   84.139539]        drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
>>> [   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
>>> [   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
>>> [   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>> [   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
>>> [   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
>>> [   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>> [   84.183600]        amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
>>> [   84.190803]        amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
>>> [   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
>>> [   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
>>> [   84.210813]        amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
>>> [   84.218077]        amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>>> [   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
>>> [   84.231313]        local_pci_probe+0x40/0x80
>>> [   84.236437]        work_for_cpu_fn+0x10/0x20
>>> [   84.241500]        process_one_work+0x270/0x5a0
>>> [   84.246805]        worker_thread+0x203/0x3c0
>>> [   84.251828]        kthread+0xea/0x110
>>> [   84.256229]        ret_from_fork+0x1f/0x30
>>> [   84.261061]
>>>                -> #1 (&mgr->lock){+.+.}-{3:3}:
>>> [   84.268156]        __mutex_lock+0x9a/0xf30
>>> [   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
>>> [   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
>>> [   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>> [   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
>>> [   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
>>> [   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>> [   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
>>> [   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
>>> [   84.322090]        amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
>>> [   84.328793]        amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
>>> [   84.335537]        svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
>>> [   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
>>> [   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
>>> [   84.354808]        __x64_sys_ioctl+0x80/0xb0
>>> [   84.359738]        do_syscall_64+0x35/0x80
>>> [   84.364481]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [   84.370687]
>>>                -> #0 (&prange->lock){+.+.}-{3:3}:
>>> [   84.377864]        __lock_acquire+0x12ed/0x27e0
>>> [   84.383027]        lock_acquire+0xca/0x2e0
>>> [   84.387759]        __mutex_lock+0x9a/0xf30
>>> [   84.392491] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>> [   84.400345] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>> [   84.407410]        unmap_vmas+0x162/0x170
>>> [   84.412126]        unmap_region+0xa8/0x110
>>> [   84.416905]        __do_munmap+0x209/0x4f0
>>> [   84.421680]        __vm_munmap+0x78/0x120
>>> [   84.426365]        __x64_sys_munmap+0x17/0x20
>>> [   84.431392]        do_syscall_64+0x35/0x80
>>> [   84.436164]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [   84.442405]
>>>                other info that might help us debug this:
>>>
>>> [   84.452431] Chain exists of:
>>>                  &prange->lock --> fs_reclaim --> 
>>> mmu_notifier_invalidate_range_start
>>>
>>> [   84.466395]  Possible unsafe locking scenario:
>>>
>>> [   84.473720]        CPU0                    CPU1
>>> [   84.479020]        ----                    ----
>>> [   84.484296]   lock(mmu_notifier_invalidate_range_start);
>>> [   84.490333] lock(fs_reclaim);
>>> [   84.496705] lock(mmu_notifier_invalidate_range_start);
>>> [   84.505246]   lock(&prange->lock);
>>> [   84.509361]
>>>                 *** DEADLOCK ***
>>>
>>> [   84.517360] 2 locks held by kfdtest/3453:
>>> [   84.522060]  #0: ffff9a99821ec4a8 (&mm->mmap_lock#2){++++}-{3:3}, 
>>> at: __do_munmap+0x417/0x4f0
>>> [   84.531287]  #1: ffffffffbcd929c0 
>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>> unmap_vmas+0x5/0x170
>>> [   84.541896]
>>>                stack backtrace:
>>> [   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 
>>> 5.19.0-kfd-fkuehlin #75
>>> [   84.555537] Hardware name: To Be Filled By O.E.M. To Be Filled By 
>>> O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
>>> [   84.565788] Call Trace:
>>> [   84.568925]  <TASK>
>>> [   84.571702]  dump_stack_lvl+0x45/0x59
>>> [   84.576034]  check_noncircular+0xfe/0x110
>>> [   84.580715]  ? kernel_text_address+0x6d/0xe0
>>> [   84.585652]  __lock_acquire+0x12ed/0x27e0
>>> [   84.590340]  lock_acquire+0xca/0x2e0
>>> [   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>> [amdgpu]
>>> [   84.602338]  __mutex_lock+0x9a/0xf30
>>> [   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>> [amdgpu]
>>> [   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>> [amdgpu]
>>> [   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>> [amdgpu]
>>> [   84.629353]  svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>> [   84.636742]  ? lock_release+0x139/0x2b0
>>> [   84.641374] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>> [   84.647976]  unmap_vmas+0x162/0x170
>>> [   84.652203]  unmap_region+0xa8/0x110
>>> [   84.656503]  __do_munmap+0x209/0x4f0
>>> [   84.660792]  __vm_munmap+0x78/0x120
>>> [   84.664977]  __x64_sys_munmap+0x17/0x20
>>> [   84.669499]  do_syscall_64+0x35/0x80
>>> [   84.673755]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [   84.679485] RIP: 0033:0x7f32872eb97b
>>> [   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff 
>>> ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00 
>>> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 0d 00 f7 d8 64 
>>> 89 01 48
>>> [   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 ORIG_RAX: 
>>> 000000000000000b
>>> [   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
>>> 00007f32872eb97b
>>> [   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 
>>> 00007f32831ae000
>>> [   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 
>>> 000055e7570ad230
>>> [   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 
>>> 000055e75453cefa
>>> [   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 
>>> 0000000000000000
>>> [   84.751584]  </TASK>
>>>
>>>
>>

