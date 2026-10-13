Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C950CC6B12
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 19:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9823410E893;
	Tue, 13 Oct 2026 19:41:42 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C8A10E893
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 19:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl3Dcbu/gAfKoKGiHooMVA1OJ+CrZvOE0WLpmF4KlrkCERvjFIsOzkgXR7St715YKJUaz8g09M2W2J4ew6aJ11wA7MABcNgSXIiqYQThcrMM1Xg4Tays8H6bkkGhiOhaPUP48ZhT9tPlKpZ+MbeHZl1v+37esg2WScwDCfJxEcD9uZipcVDlm3aMaq8L7Z/7LP1uu1W86R0u44CDO5CXb8P+77Hh9PI+2klpSvZyS6/AY6SRCSf4GCiTITEViCdfobYAUKS/PGtLwOs0av2yhlRu4YW4ex66IB+zEApB9BlFL3G0CjZ7Mtp1akoIBbQ0aPIzfvl1C+Rq8Yr5wNdu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9nZavjACTMV+quPOfEsU57wzE7seAT/xo0ogFJr+oY=;
 b=Mp4eOwymegw8kPCu51cBstyNyFQiJTtQLYHg2fLfowSgbf8YOwaQoBDa3UKmRehbLTILg1HGggf0sozbFfWW7nvaw/ENmbx0hgOkJnU8F/v6apjobHkVKdkiaI6WHS+UF4a6MDbX20vyIxxBHiM46lD7wd+UhAleBaxPLAoc/MK04I3h3ZkB8CAPrswblcqQGmS6s64R1zVv41/9cJ4Kyj1c+gi/FAysdTHOubSS+BPocRchm8QIipTjhmBlSAvgnnBBJfVsaNZ0/0Uvr0y7L9XTf1GmHJCRp6IuVziOOZ4FyTe+oMskgQRtBim/sK8wdLJALyvMTs4RWxn8G6X0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9nZavjACTMV+quPOfEsU57wzE7seAT/xo0ogFJr+oY=;
 b=sXl1V5hr2cKsDwqkH+z1rJlKgKAPTBwfUf9IhfPNjwrBEnSFDAiaap0ggdfsNEcZQMA22Q4MmNfCfqMKAattLGTkluOpJzzTxO88PCJ19lHY2kHVFNvVTzpGUxyWryQV22EjFKdNdGOQ4Jb0egwDrb774wOyrW1zsmEPbNFblck=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH1PR12MB9597.namprd12.prod.outlook.com
 (2603:10b6:610:2ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 19:41:16 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 19:41:16 +0000
Message-ID: <2d2f9591-808c-4a63-8f64-63971fad6a91@amd.com>
Date: Tue, 13 Oct 2026 15:41:15 -0400
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_drm/amdkfd=3A_SVM_restore_worker_livelock?=
 =?UTF-8?Q?s_under_memory_reclaim_=E2=80=94_KFD_process_restart_wedges_until?=
 =?UTF-8?Q?_memory_pressure_subsides_=28gfx906=29?=
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20261013185356.34009-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261013185356.34009-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::24) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deadd4a-06b1-4d71-fd3a-08df2961f250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4fYPWCPjOFVHXnAyG/qSaViMNt/9GUHRDcpyagUERD5ECx0uOr/gvQlGS7cukrPTgJWfCj0ZMncCVfjuOBC0mC1B/VnmTJX7n4Z1NJ53ypy1hrAAI1ekLTlsAQrSbLnttouVyZ3A6Z4pqemd02cUUq8u2kJg4Bn4ZqQcpsNdHi6qlNen6CUDxZCCBhDwiOLi3k+SRoVwJgs15zroSqLI4bTTBsQgBSEf31Er8zOF5k3NVpuEnhW/KCaaEg8K3YDBQib0uHaYe5Nr+g+uy61f6kDHNcmqnv4lj71C2eNM+B5/c9Ubv1Lzfkf7eDAeYvkP4V904SlajQIvQYxDfbM5AOlGslZO6nNA9HyzOutCPFgvSLr/Alpymu26nB/FlL5h1cWbuJRs4fsMsczL7ACLfnc2Kd1yfJasok5YK8Hh2Qxgf2i8j5Z4/3xhXd/3t55TWw0uBKoZVFKhSijfkpoznMNToS8985x7P2cuo6SmMR8eMBxY5Tkt/Q1hsxMeaJC40uefP1OosBFo5/zqYNHydtrsbG1C2jZwD09n7s8I55c9CL90fCNtGiNTbshfxiSHwSMzkJfDOXjttUGNmuAOsCSjwIl4y9W2VWrIfbXmYZiSXM46pjCkv33w2dJljrG1ltfBUGaTqP4PMqsLh4F1sn2O63QKSjgstTj/B5K5UWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVprVFl3cC9ncXVjSmg5d2hDMzBuaGJEVjMwVFBXdmNlcVV4TFZVUGVVNVQ5?=
 =?utf-8?B?SFRrcklkMmFiTGNCYkhrTDhQckNtL1BTZDA1NEdBSWRlUFNLNUh3OTA4Qnho?=
 =?utf-8?B?dG5nZTlLdlFLMGQ1S0FaeWd0WXBzZTNtVUk1ZmdiYjMwREY3QXd4d01nU3Bi?=
 =?utf-8?B?WmJIYnlrNjhkZ24yYnZhNHphWTZrUnd6SEtZNS94bm02T2FvV0xKVXUrdlJP?=
 =?utf-8?B?aEJBa0xIdy8vOGNYMnFQNndyYk0xbmllTUZqeSs1V3JYT3NhTkpMWUh3dmRF?=
 =?utf-8?B?dUtZdjlhUklEd0R4clQyN25HMFJhNnpQMkw5dCsxdUQ0bWVNZUIxd042dG5x?=
 =?utf-8?B?eFcvZWRSTUpML0lIeGpVNmh6NGR5cHBmK1o5ZUU5dXZuVkF0RmgzaDJHOTdz?=
 =?utf-8?B?QmdmcnlyYTZUNVU5QjI5bTVVVXFmbVhkdHM0VFRPNlgvdXFST2xkRDl0Wklp?=
 =?utf-8?B?cWdBUGduSHQ4ZjNxRnFIVGFRNG81REhyeGNkVWNpOFBuYU83Y2RFbStxNENx?=
 =?utf-8?B?aVA4cXZaanhRN2d0TUw2Z0RDRW5CbmRWb0dnVU5tNXdNc3pqZ2NxUG0wOVJt?=
 =?utf-8?B?ZWMyNVIvYVNGZ1hnYkgwOWM4LzZhNk5ub1VVdnhnZ2VYaDMzK1gydW5mSDVV?=
 =?utf-8?B?VlZERDV6VHRvdmtmOUNrRlRJQUtzdmkrSy9rOUQ1eXNWQWE3QWtaM2lKRkV5?=
 =?utf-8?B?SlpvaCtpZktqcVNPN2RnaDE2SjhGcUhnV1N2ZGlOdmZrN3JtaEJmWjNkRkJC?=
 =?utf-8?B?anppaUdTYnNibW1tRzh2OTJvbmphODZoRG9KNzdNWm8wSWtmOWdQUWY2Zm1X?=
 =?utf-8?B?eDhYdnZLRWU0Tk9IZXo1R3NRV0M0ZURuNnhRY3FLSVdJLzJLZVVWQW5wL1lY?=
 =?utf-8?B?cHJRUlRqeXhKNHZCeng1eENUMjRnQ2JUY0wrRzZhTW1RSHBpYjFzU2dNUFYv?=
 =?utf-8?B?dXNMcnZ4Q1NXUEpjTTFVU3VhZGtRUWN0Q3o5dGQwYTB6U0xYVW94VWN3MUZZ?=
 =?utf-8?B?VWpSS1djczBxUWRlb1A2UU5IS1dCWXNKYmFVUWRuKzM3bG5SRC9Rd1d1dWJa?=
 =?utf-8?B?OHgxSTN4NnQ4ajlBRnRNUituT0NISlh4bDNUN2lnUmwxc29heU1HMGpqMUtz?=
 =?utf-8?B?NXoxUzNqNnpwSUdaQlJCTk55OFRkK3V6YTlvRnVUZVV3RFpMQXIvc0FkTG9q?=
 =?utf-8?B?MktmQlBNV2JsUm5ETkJVRndxQlVWNnZneUVuOXhTdktpVS80cDhaYlRkTzRN?=
 =?utf-8?B?NXc0cUVvME56Q2JZQXU0Y0VEVWU5K0Y4ZVR5cEtrUk85eU5qL2h0ZklUaVdq?=
 =?utf-8?B?VXB1M01IVk1vd0lWMEV4eWU5b3ROMEQwUUl3VkkvUUJJMXNWTVVCTk5SN2xY?=
 =?utf-8?B?S1U3dXZKTVdwcTBTVWpYNEpoMVE5Ym53eDQ5QmJ4YmYyZ2dBZ3hXSUpPWmdJ?=
 =?utf-8?B?ZFFUdE80c3FHZ2MzeU0vNy9XQVVFK29Gb3o2R3VvSXpQVVJEWVJ0Y1lTeXVa?=
 =?utf-8?B?OEprV1ZPRG9LVGpVYktqREJxcGlTUHdVUDZkdVpZYUF5MEM2T0E5SEtXclZQ?=
 =?utf-8?B?NzZsV2wya2VocGlSMlZZRlpNQkV6a3REOGk3Mmg2NDhkUEFJelN5d29NY0xv?=
 =?utf-8?B?ZE9rTm5vSlVvRkpzZVYrTzZ3T0xYU0pFNFUyZllNSGh5MHIwQzIrUkJMcEdB?=
 =?utf-8?B?alJyaTNmRTN1UnBhb0hBNDdxK3czTzc3Vm9DVXhMblhUbldOT3EyQjRMZUZh?=
 =?utf-8?B?eGI4ZlZ1eGtkRzIzaXB4OWRqbTQ5UTFrSmhXZG9MbDlyNVdZZmVFWlZDcnRm?=
 =?utf-8?B?R3JNRlQxcXNGbDcraU5MbE9zL0RZVWlCdk13WUlZVVRHbTFCU3l4ZXJ4S3Nu?=
 =?utf-8?B?bzVhaUVnZ0MzQzR4UTI2cGJRdnRuUFBuaFZ3cExBNjI0TmozRnNzWGUyRWZ0?=
 =?utf-8?B?aUxuaURJSC9yWkZZMFhDY080d1ZaSmU0alpNZk1QU3MrRytnS214UXM0c2R2?=
 =?utf-8?B?THJnWWg2Z1E4MlJyZEgxOS85RmZVK1FHZU5YRlFBaFJ0UDFOMXg2M1RjVHdx?=
 =?utf-8?B?ZytFMGFkOERYYVJXYmpVd2Fsb0NEOHBURUo2WWk2UjArS3hmNkhwVlQwRS90?=
 =?utf-8?B?Qzg0cHNVNkdLbnlYZUI2R1lHY3hwTWtwZml5Lzd5VmZBaXQxREU1cFRlV293?=
 =?utf-8?B?OFpRUW9YTDBLU0txdlNXRUtxVzV4cmVjTnRXUTlaVEFRRCtYcTlrWmtWSXRh?=
 =?utf-8?B?cFBMSXZZYVFJUXdqaWx1UFlkQUxUUlZma09xV3laY0RKTjl0UC9pejVNTTZw?=
 =?utf-8?B?RWpqMWpXTFUvSlRTNTQ0RXRlSGdIcXdIR3V6UWliektPYi95RnNPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deadd4a-06b1-4d71-fd3a-08df2961f250
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:41:16.5416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 360yBoNk2rmg+w708fsGYD2Dc42rhZptubcju11sDQspmmn1ZsEjifPZ/7YLmQC8gqGyg/c5SR7Pqb5o4T+UZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597
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

On 2026-10-13 14:53, Olivier Kaloudoff wrote:
> Hi Felix,
>
> Retest done on the same machine (MI50 gfx906 over TB3, Strix Halo host,
> 28GB RAM).
>
> Test kernel: 7.3.0-rc5 plus
>    - 25f0b322ffb5 (evict SVM BOs synchronously from TTM eviction)
>    - ec4d432b     (vm range hole fix)
>    - 46109de0     (skip migration when fault window already in VRAM)
>    - our local series from the original report (restore convergence,
>      non-xnack lock-bounded prefault, unplug/teardown guards), plus two
>      migration-error propagation changes still being baked.
>
> Reproducer: llama-server -ngl 99 with ~19GB mmap'd model
> (SVM-registered), health-polled while a second allocator saturated the
> remaining VRAM, then a managed-memory bounce workload
> (hipMallocManaged, 2GB, 20 CPU<->GPU rounds) on ranges that dmesg
> reports "over locked budget ... left evictable" — i.e. genuinely
> reclaimable and migrated under pressure.
>
> Results, 40 min sustained:
>
>    - ftrace count of svm_range_cpu_invalidate_pagetables: 0 for the
>      entire run, including a window where MemAvailable bottomed at
>      ~470MB and direct reclaim was hammering the host.
>    - llama-server health=200 on every poll; real inference verified.
>    - Managed bounce completed all 20 rounds, no migration errors.
>
> Baseline for comparison: on this same hardware at 7.3-rc5 + our series
> without 46109de0 + copy-done propagation, the bounce workload under
> VRAM eviction panic'd on Oct 3 — BUG_ON(start + size > res->size) at
> amdgpu_res_cursor.h:65 inside svm_migrate_copy_to_vram, called from
> svm_migrate_ram_to_vram via kfd_ioctl_svm prefetch. (EFI pstore
> capture; happy to send the trace.)
>
> So on this stack the storm is gone and the migrate path survives
> forced eviction.
>
> One honest caveat: our non-xnack locking makes registered ranges
> unevictable up to a lock budget, so "inv=0" is partly by construction —
> the over-budget bounce run is the part that exercises the evictable
> path, and that's where the Oct-3 BUG_ON used to live.
>
> So I ran the clean A/B: vanilla 7.3.0-rc5 with only your three commits
> (25f0b322ffb5, ec4d432b, 46109de0), none of our local SVM changes,
> same reclaim-storm reproducer:
>
>    - 94.3M svm_range_cpu_invalidate_pagetables hits in 30 min
>      (~4M/min, same rate as baseline)
>    - llama-server never converged (health 503, RSS churning, threads
>      parked in kfd_wait_on_events)
>    - an earlier run went fully dark ~13 min in — no console, no ICMP,
>      journal just ends (this run did not reproduce that)
>
> So on vanilla the three commits do not resolve the livelock. 46109de0
> only skips migration for windows that are already VRAM-resident; under
> reclaim the faulted ranges are genuinely RAM-side, so the residency
> check never engages and the evict -> restore -> re-invalidate loop is
> unchanged. The failure is restore-worker convergence itself — the
> invalid cmpxchg aborts that leave evicted_ranges never draining —
> which none of the three commits touch.

I think you're expecting your workload to run successfully while memory 
is overcommitted. In theory the driver tries to prevent memory 
overcommitment so that the entire workload can fit into memory at the 
same time. This is a prerequisite for the HIP programming model where 
all GPU-mapped virtual memory is resident and GPU accessible all the 
time. (We can handle memory overcommitment with recoverable page faults, 
but that's only supported on some GFX9 GPUs at the moment.)

Strix Halo is an APU with all memory shared between CPU and GPU. 
Allocations that would go to a dedicated VRAM heap on a discrete GPU are 
allocated from system memory. That creates an accounting problem where 
your application sees two memory heaps (VRAM and system memory) that 
alias the same physical memory space. If you try to allocate too much 
memory from both heaps, you are overcommitting your memory and that can 
cause the type of problem you're seeing.

Ideally, our memory accounting would be a bit more conservative and 
prevent you from allocating too much memory for the GPU. But the result 
would be that your application would fail with a memory allocation error 
instead of stalling. The trouble is, that it also depends on what else 
is running on the system.

There is an experimental patch in the user mode stack to use a different 
allocation method that allows users or administrators to impose memory 
limits through cgroups that apply to all types of memory allocations. 
That could potentially help in your situation (by failing memory 
allocations instead of stalling). You can experiment by setting 
HSA_USE_UDMABUF=1 in your environment. It won't do anything useful 
unless you limit your application's memory allowance with cgroup.

Regards,
   Felix


> The only thing that suppresses the storm here is our restore-worker
> locking, which is a workaround with its own tradeoffs, not an
> upstreamable fix — but it confirms where the loop lives.
>
> Regards,
>    Olivier
