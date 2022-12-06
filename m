Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE0FC4708E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Dec 2022 00:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5DF10E0DD;
	Tue,  6 Dec 2022 00:04:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D5710E2BB
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Dec 2022 00:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr+tRrL2tkgPtVuz/9G380ntR7/OMzrmTm7Brd+jrLLgBJdgkSfJtimIrmf/en20u95cuGNWJugcjP+NUs7U2GRuy5ytNIcPfB1iod2fsEovQ3mGBLrfXWKmojFpt13fNhWLMVXIBGE1WhVLE/CxQxPpCMdjgfnOfMgVBQPQ47M9BrSlGplwW+PFg3l+F63ofAV1jZeq4uL3YAZUQmnVl08vbFaJhYVXsL43xUP28w22BtH1VTsd2EA5OtTMtfkT25rF0sN315hrnC8Bo9tfK67vqHOeN1AHyGZGvYt3HRvmgOnxntNgI6Sb/g4VB6DmLmEuEi81Kml5nPypIhKqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVlIa4z3QAgdZmGUEuNWX9hf61CLZGajo8weqlVtJJE=;
 b=jX2Q8HtyusiyxHfRuzEROfrbl7jqMIbCER7D87HhfyJ6iWua9WRQeN1WlbgTlbM6oo9boNFKwR8kxBZ5Gf6IeDxb+/aaECmPAnAwL5y1qBPawpDTER558KeVou0QSzcKOyR+mB/g6ao87zinAIR+eUMFrMiokFB2oK/x5mUbIhSRa5yBSZ4vqTkEpY9ZRop//FFI10hEB+H0+jLA5n41S/1bd+8+Oq5rbCQVtcMUG1G5YMkke3lrkY8Cr/cKnK+LHciGZk5kwc7ZwZJ1LMhyTLBs+zcyBkU32VJYaF6Nu0ml0w6KeS4fBBfJVFmsbOD3pI54is7PHlYIUobk8qfSxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVlIa4z3QAgdZmGUEuNWX9hf61CLZGajo8weqlVtJJE=;
 b=OQTvTQFgmtan3c60K9HVCGJbUBAtzGLuqpdm9R4wlVbQbNQOQ7S7joRBOAUdsYLGN/6ZBnxpZiIuq2PVeqUrtIOqKIwM7TSO8qzZ7pUUD1RIR4UaLZy+VfMlHuumcI6CpoptD5ZqpTRR/z7sek47C50gG5PyHm87qZ6ZWeTK8Dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 00:04:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 00:04:32 +0000
Message-ID: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
Date: Mon, 5 Dec 2022 19:04:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Another circular lock dependency involving fs-reclaim and drm_buddy
To: Philip Yang <Philip.Yang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Language: en-US
Organization: AMD Inc.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:36e::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5298:EE_
X-MS-Office365-Filtering-Correlation-Id: ed73494e-ff19-4bd7-6cc4-08dad71d73d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxQAKpJP1n3J9Z9l6x1JSSnhAltUau9qpH8xwe/18g8PFKcFm/rNKWbFKlGGzlWK34snbJrQ8UZbb3YUgwiYt0RpfWyUnfF4uHEdvGqpYelBwBL1KFvBwRqBwg1N6DuRIo8R/REMA7ASbWMcSFKNf118z1SsncOYYrs19yfVpoXHTxggDBSZ89bju4wurj4+54OLtZYNzLALw3sFkjy2NvZQ7qCAfcxjeykdKdbX17A39ifBXgVbKyfDJC2rScm0rp3JRgnbxs23/NT+YA6AsNo7UdZDMjwJ7XsUwzEgLUsW6l+NhKxGoks8PkWeHWw/Nvgy+JVrgmqaUKFnW2WcIPEYdMAjqzcd1KF5lx6AN+KuBlv/SD2wtuSxQDBPdc7Qdt18A83Y68OHLfEbGYuzqbtmFLAjaVlGrFgjmMRMy6fdz6+UDqnarXytu5ZJ/hUfqSE4zZqbYVZEZnQlbwbDq4aKoAwNAgK7XXU9SPi8nuxkZn0IvEmW/pSR4CkcR3sMkh7jrl7wXgWcR8d9BKywFx1p6vyPm9+Dz8ShtRDuKfPibvaXSKtBb3iB4TSaz7nGxIgvOGZFke5P+6I3jTdxZaocUFK/Ve/Murf6HbWMmesYKa4IW+UZYbJdL/f8/0YoV6pb9GJeH5qBBSaB8viLVFjR4GP3xvFGem1x6Qbjez50eDOsIz5Ne6/VhrR0lVlT0HrO5SYRIRTNzoBXE5BiWd8lTmbduudUIeex9exw87eVdQZ9ncAjP7GfHgs9YFiF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(84970400001)(36756003)(40140700001)(31686004)(31696002)(86362001)(66946007)(66476007)(8676002)(8936002)(41300700001)(66556008)(2906002)(44832011)(83380400001)(38100700002)(2616005)(316002)(110136005)(5660300002)(36916002)(6486002)(186003)(26005)(6506007)(6512007)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFZd1FiNWJ3ejQ0YVl5SDRKZGV6NjgwZ0RRVjZ2WFVzcFNGcmFtWTNBYUYy?=
 =?utf-8?B?K0Z2c3J6UjBBVzU1cTZGeW5hdE9ZK0FVQWdKMW80UENVaUdsOXZxNW1JUmVh?=
 =?utf-8?B?VW1BRFZmZkN6Qkt3YnpTa25YWjV1Tk9NQjMxaHhTTUt4TFduV3BLWWU4ZUhK?=
 =?utf-8?B?MWZNbmhOZUR5N3BEc3ptZG1YRWV3aDZ6SVFIOFBlb3ZVQ3ViaXV4aDc5OE1u?=
 =?utf-8?B?eGt2TkptbDZaMG5SYmE2NmJWbXRVV3dDQmRRenpzUUZiSS9EbU5hLzhwVnVl?=
 =?utf-8?B?TVhBTmpsd3dJS2JpQTdSa2ZHbHNjemlkVEkrRGxiUVp1dUxZc1ZLOThmRGk3?=
 =?utf-8?B?ZTk2clBDZytEOG9GQzE0SnlpWk9aS2U0NEdsQWpqNGJFeWlHcUVyN2pBeG13?=
 =?utf-8?B?VTlrSEZSMWp1Y3h0R0ZWVUg1NFE0YkU5a0xNa0E3dnZUVEc4UXZNN3RHdm9o?=
 =?utf-8?B?R0p2NHdrZElOeiszb2R4dk5GNTNtMVZjU3ZJeDAvSUY0UTZwM2dhYzBZWXBU?=
 =?utf-8?B?MjNwRjNqSE9uLy9ORjRMRWFQM2dEbWdlVS9udVhsYXgxMklpeklIWlcwVm1w?=
 =?utf-8?B?YkdRVnFCQ3JlNk0yZENmZjBaN0pUbWw4YTZ1RGZOcEc5RkMvUXlnOXphOE9P?=
 =?utf-8?B?RUlOcG5ZR29mbGZrVmZDRmptanBoRzlsdC9yd2thRmd0TU5qSExNSjhTV2pS?=
 =?utf-8?B?dDFDakNOaEc0UHlzQ2hpTnBLMlRYM092L3JGbktVWE5xQXBtZ21iOGtyaEJG?=
 =?utf-8?B?TEphcCtaMEI1S1VKQ2ZsOFBTM1haNngrSWh6bGJUN3Vsdm8xS0JwY2NWbjcx?=
 =?utf-8?B?RitMMHFzVnAwTytaUFVBbVgzTXFHR1JoWWRGMnNpODhZWnBxZVNuZEczdHVQ?=
 =?utf-8?B?Y0xxdEl3R3RtM2VVMDNxZ045NUlHT3VYR0NVUlNyYnIxSXhmUHFYQUc3ZHBJ?=
 =?utf-8?B?S2xNcXczTFQ3OURBQkpYTmszaytsZFArTFhONFl1NnA4em9QWnhtUDkxUHN6?=
 =?utf-8?B?VTY2d0JjZjdkMEZYT3hDYXg5RUYvRUVoVVdEeU5HMXlESWowU0FRMWxoaHdk?=
 =?utf-8?B?Wll0TWtCclhiOWVQQnBMTENJcWxkOTQ2SkhNQS9lZXZHNFRibWQ5S29PbmhR?=
 =?utf-8?B?L1Z6bWFvNW1jeCtNTkVsSmI5V0NQdnBXQ1NrMDczTG5JbE4wKzg4aUh4UVZ6?=
 =?utf-8?B?ZTZGYmhHYzFvdFZ2aU9xaTFUWElacWJmb3pWa05rZGYzNTRUUzV1L3VhNWVD?=
 =?utf-8?B?ODFkcmtvY0ZUb1ZmaVdnVXQ5ZGlpdFhrbUZvMzlteGFUQ3Vtc1g3Zlp6QnpW?=
 =?utf-8?B?VmZWdUdtRTJLNWtYeHVsZXBLSUlIbUFpTXo1c2MydWtEWnA4KzAwb1o4V0E0?=
 =?utf-8?B?VGl1K0FFUktmTG1LdExaRVBtUXMwbGtlSWxsNVUvaDlDZk1maDZzQUU3SVNh?=
 =?utf-8?B?Vm9hb25GS1Zlb0pBb3RCZllwanFEUXNmdHRhVHg1TktaVUNQRmFPcDQxTFBD?=
 =?utf-8?B?RExoZmVkdko1YXp3eTQyWXVIbk14K3E0WlgzZC9XSGg4SW9wUHArSmpIZzFl?=
 =?utf-8?B?Uy9tK25xTVZzejF6RFlhNFU3K3B3eGMzK1czZDBSblhhd0hxbmxhbmVvVmxQ?=
 =?utf-8?B?NENmbnlaQTJDcmNpMENGdjF3YkRpT1NyS3htaFFMNHlreVJTd243NWZxcmVJ?=
 =?utf-8?B?RWNudUdLZlR0RUprQ0RlNDBBRUpPRThVT00xWEYvdHFHK0ZKUEJNa0tyNG5B?=
 =?utf-8?B?dUxxSHg1S2Y5YTR2M2hnaWVmZkswVXk5V0hKUWltYUNDckkvbi9veEJCZktn?=
 =?utf-8?B?YmZ6cFBzQ2JRT3NuWTVPaDNCN3NWRS9zNnNVRzRqMCtmZmxqajJNS213eFBJ?=
 =?utf-8?B?bW8ycXZpdTl5SzZmQmFsSzlqL21PMkppTlhnM0ZFSEtXaHlEai9rdi8wOFJv?=
 =?utf-8?B?alBMS1dXbzFlaERJZHhCSS9RZVhIR2NnZ2dhWlJ6aWI5N2Q1MzB5VERnQzJG?=
 =?utf-8?B?NzFlUjVBTUYvdXlIL0lFZHVLTnBSTTRlM0h5a29IeThJRmlvN2JNRzBKM25Z?=
 =?utf-8?B?d3pLQURvbWU5b1V4Qjh5MmtxUjZGUXBBTHNaL1lRblhrajljZVpNNFlmeUsw?=
 =?utf-8?Q?+BCkfPIlzufEh/gPrJ9DSo9p6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed73494e-ff19-4bd7-6cc4-08dad71d73d6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 00:04:32.5364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JKOTMzvEbEhdGOfn0J0vRNJx/rYzdkkShXWBLERBq/YX50TnUmsjVaw8lWdSgPehP0cXMtiNQAgC9dVbd9Zsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
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

We fixed a similar issue with Philip's patch "drm/amdgpu: Drop eviction 
lock when allocating PT BO", but there was another one hiding underneath 
that (see the log below). The problem is, that we're still allocating 
page tables while holding the prange->lock in the kfd_svm code, which is 
also held in MMU notifiers. This creates a lock dependency between the 
vram_mgr->lock and fs-reclaim.

There are three ways around this:

  * Do the page table mapping outside prange->lock (creates a race,
    contradicts advice in Documentation/vm/hmm.rst)
  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
    allocate page tables ahead of time somehow)
  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore (may cause
    memory allocations to fail in drm_buddy under memory pressure)

I only mention the first one for completeness. It's not a valid 
solution. Neither of the remaining two options are particularly 
appealing either.

Regards,
   Felix


[   83.979486] ======================================================
[   83.986583] WARNING: possible circular locking dependency detected
[   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
[   83.999044] ------------------------------------------------------
[   84.006088] kfdtest/3453 is trying to acquire lock:
[   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.023911]
                but task is already holding lock:
[   84.031608] ffffffffbcd929c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: unmap_vmas+0x5/0x170
[   84.041992]
                which lock already depends on the new lock.

[   84.052785]
                the existing dependency chain (in reverse order) is:
[   84.061993]
                -> #3 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
[   84.071548]        fs_reclaim_acquire+0x6d/0xd0
[   84.076941]        kmem_cache_alloc_trace+0x34/0x760
[   84.082766]        alloc_workqueue_attrs+0x1b/0x50
[   84.088411]        workqueue_init+0x88/0x318
[   84.093533]        kernel_init_freeable+0x134/0x28f
[   84.099258]        kernel_init+0x16/0x130
[   84.104107]        ret_from_fork+0x1f/0x30
[   84.109038]
                -> #2 (fs_reclaim){+.+.}-{0:0}:
[   84.116348]        fs_reclaim_acquire+0xa1/0xd0
[   84.121697]        kmem_cache_alloc+0x2c/0x760
[   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
[   84.133679]        split_block+0x4d/0x140 [drm_buddy]
[   84.139539]        drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
[   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
[   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
[   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
[   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
[   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
[   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
[   84.183600]        amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
[   84.190803]        amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
[   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
[   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
[   84.210813]        amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
[   84.218077]        amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
[   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
[   84.231313]        local_pci_probe+0x40/0x80
[   84.236437]        work_for_cpu_fn+0x10/0x20
[   84.241500]        process_one_work+0x270/0x5a0
[   84.246805]        worker_thread+0x203/0x3c0
[   84.251828]        kthread+0xea/0x110
[   84.256229]        ret_from_fork+0x1f/0x30
[   84.261061]
                -> #1 (&mgr->lock){+.+.}-{3:3}:
[   84.268156]        __mutex_lock+0x9a/0xf30
[   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
[   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
[   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
[   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
[   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
[   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
[   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
[   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
[   84.322090]        amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
[   84.328793]        amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
[   84.335537]        svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
[   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
[   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
[   84.354808]        __x64_sys_ioctl+0x80/0xb0
[   84.359738]        do_syscall_64+0x35/0x80
[   84.364481]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   84.370687]
                -> #0 (&prange->lock){+.+.}-{3:3}:
[   84.377864]        __lock_acquire+0x12ed/0x27e0
[   84.383027]        lock_acquire+0xca/0x2e0
[   84.387759]        __mutex_lock+0x9a/0xf30
[   84.392491]        svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.400345]        __mmu_notifier_invalidate_range_start+0x1d3/0x230
[   84.407410]        unmap_vmas+0x162/0x170
[   84.412126]        unmap_region+0xa8/0x110
[   84.416905]        __do_munmap+0x209/0x4f0
[   84.421680]        __vm_munmap+0x78/0x120
[   84.426365]        __x64_sys_munmap+0x17/0x20
[   84.431392]        do_syscall_64+0x35/0x80
[   84.436164]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   84.442405]
                other info that might help us debug this:

[   84.452431] Chain exists of:
                  &prange->lock --> fs_reclaim --> mmu_notifier_invalidate_range_start

[   84.466395]  Possible unsafe locking scenario:

[   84.473720]        CPU0                    CPU1
[   84.479020]        ----                    ----
[   84.484296]   lock(mmu_notifier_invalidate_range_start);
[   84.490333]                                lock(fs_reclaim);
[   84.496705]                                lock(mmu_notifier_invalidate_range_start);
[   84.505246]   lock(&prange->lock);
[   84.509361]
                 *** DEADLOCK ***

[   84.517360] 2 locks held by kfdtest/3453:
[   84.522060]  #0: ffff9a99821ec4a8 (&mm->mmap_lock#2){++++}-{3:3}, at: __do_munmap+0x417/0x4f0
[   84.531287]  #1: ffffffffbcd929c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: unmap_vmas+0x5/0x170
[   84.541896]
                stack backtrace:
[   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 5.19.0-kfd-fkuehlin #75
[   84.555537] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
[   84.565788] Call Trace:
[   84.568925]  <TASK>
[   84.571702]  dump_stack_lvl+0x45/0x59
[   84.576034]  check_noncircular+0xfe/0x110
[   84.580715]  ? kernel_text_address+0x6d/0xe0
[   84.585652]  __lock_acquire+0x12ed/0x27e0
[   84.590340]  lock_acquire+0xca/0x2e0
[   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.602338]  __mutex_lock+0x9a/0xf30
[   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.629353]  svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.636742]  ? lock_release+0x139/0x2b0
[   84.641374]  __mmu_notifier_invalidate_range_start+0x1d3/0x230
[   84.647976]  unmap_vmas+0x162/0x170
[   84.652203]  unmap_region+0xa8/0x110
[   84.656503]  __do_munmap+0x209/0x4f0
[   84.660792]  __vm_munmap+0x78/0x120
[   84.664977]  __x64_sys_munmap+0x17/0x20
[   84.669499]  do_syscall_64+0x35/0x80
[   84.673755]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   84.679485] RIP: 0033:0x7f32872eb97b
[   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 0d 00 f7 d8 64 89 01 48
[   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
[   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f32872eb97b
[   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 00007f32831ae000
[   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 000055e7570ad230
[   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 000055e75453cefa
[   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000000
[   84.751584]  </TASK>


-- 
F e l i x   K u e h l i n g
PMTS Software Development Engineer | Linux Compute Kernel
1 Commerce Valley Dr. East, Markham, ON L3T 7X6 Canada
(O) +1(289)695-1597
     _     _   _   _____   _____
    / \   | \ / | |  _  \  \ _  |
   / A \  | \M/ | | |D) )  /|_| |
  /_/ \_\ |_| |_| |_____/ |__/ \|   facebook.com/AMD | amd.com

