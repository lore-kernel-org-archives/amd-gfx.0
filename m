Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FDAC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 11:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0059710E267;
	Mon, 24 Feb 2025 11:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKgBlmCq";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E45F10E267
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 11:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSPEx/n93RsdnrC56O+OE80OL612eHB8A16rqf0ozJ/IVBdxzJPUkFxRZexVvRHB6mg4VmKmjVOKuDJOJ6vl8WNYxqZihrZF/aklwx4Qdac328gnQdSCQtGJKapejhqD4IW5CIGVXfrMkEhrnVI0mfd0ETs/ZypvAcvHvcSD3HQVMWremXjhQHeknK4UnE7i70KCD/iuneUnoHIIanY1v4MOdilM+2PQNPt6gqpy6LwVBx69HLsbZQk/U8pR9MM3IoArEJud4UxdeMr9HviAtqnnmwwEeS5YvWPGwRZ+b0kxcH+Z3G0LQ/hDZJkLNuMC0TyYZZ5omHDro3ohWtG5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDDDBUNJ9EEZs/Lbpd1VmKbmJ2TpBZCG9chM0fwTYxo=;
 b=lCBbrqE+tEI3hPdca0djNmNl7j72r7VktomtPWRN/s4GxsYF5OuQZf7R6hvtrhchcv1fqUZNh0hNwFPgnzFg1H78a/U0sv7wHDa1Dh6q0m+9XWIUVTQkgJL/1qvZvdWFvMSzoYG319KLxB8Z3KbkvBrs6AnyO5+14BBgNSCasAZxgXjdfq3Cmjcn6zZDuiIA9z7fYUH7HCwh6xqinU6p+CJedKuDq+nb7sUNc1Pc7+RThAZ0cBxywL/+51jYi4dirVAORidhtA6TAzUT6v1r0oMcwOmT32OZqgh31x9UdpucSkqdz51rwd7051UwZFTdJnOsTwl3k4MTShx/HbM5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDDDBUNJ9EEZs/Lbpd1VmKbmJ2TpBZCG9chM0fwTYxo=;
 b=tKgBlmCqbKTntq8QuZvdlzvzG9iZfK8zo/q8Ec2kEaWVCVNrx+mQK1nYEChIZvNfZ5EBW1VOCY6ZppTe7LKEw5HR3hWVyyMcZPJPTeDyCg8O8PewuxoQy0Yp9z3+VReqak7pMBpfazbRYgmU7VLmGkWOyu9iQmy/cHFCDX/gkhg=
Received: from BY3PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:39a::32)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 11:31:12 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::9b) by BY3PR03CA0027.outlook.office365.com
 (2603:10b6:a03:39a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 11:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 11:31:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Feb 2025 05:31:05 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, "Yunxiang
 Li" <Yunxiang.Li@amd.com>, Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix Circular Locking Dependency in
 'svm_range_cpu_invalidate_pagetables'
Date: Mon, 24 Feb 2025 17:00:20 +0530
Message-ID: <20250224113020.2273984-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218160130.810595-1-srinivasan.shanmugam@amd.com>
References: <20250218160130.810595-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 95193b8a-6f35-4cea-db73-08dd54c6bdaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkxNeVNJbTlWTUREN3VhaVJpMVFaWUIzblVVcXZzdkFrVkhlZ3NHYk4zR3Qy?=
 =?utf-8?B?NVhITERJOXhGN3MvbDRQM1JrT2N3YWNTNE1VVzljdkZOOW1tbVhvZWVkMENF?=
 =?utf-8?B?NzNpZ0l0OFlzckY4MlVKdkwvTFJ5a2lVL2o5TDNkbStnWnA3OTN4Rk50SFZy?=
 =?utf-8?B?YzZKQ0hDdzF6R2YxMjlhdk1NOFZVR0NKMUhsZUZZKzFseEJ2amFiNG14WEhs?=
 =?utf-8?B?NTN6UkpSZnlPMjdBVWhPcXBlY3U1aDVZRk52UGxOaFFCZHVGV25BWWxXbUxx?=
 =?utf-8?B?WHMrUWpQa1g2S0ZYUG1YZ1ozR29Rbzl5cmtwcFNRZ0p2bk45bmpzMXdKMmRY?=
 =?utf-8?B?dXphOVF4c01DRk1wQnorVHc0L0wwVm5DYzVBL1JFZXM0UXFZaFVyYy9icmNJ?=
 =?utf-8?B?dHhucWN3NSs1aGtGZXZMOE13alFXZHBOaG05Slhjbzg3VHlXK1dWclRldCtj?=
 =?utf-8?B?VUdjSlA0eDY2OTZacXdtelF2aytab2l6QVpDQTRTbldEeHRDRzYxNTNyZjg4?=
 =?utf-8?B?dHRKVnpzcEJIR0RRVkZLY3I5TmNTOTgwbHRUQ3VDaDYxdnREVHpSYVFBcy80?=
 =?utf-8?B?aU5CVnU5S1N3amdDRzlYMFVxYmE3MUJPaUpQcCt3WHBybTBJU2dSMUNRK29V?=
 =?utf-8?B?Sk5NWHkvSlRUOUYyOXB4VG5aS0kwN3NtbkhWTmh2RDgzd3RNbzBzZ0FpSGhj?=
 =?utf-8?B?UjU3ekZXWHAwSDl5Y3hrbFArLzZCT2dhdDJiZmhXM2hMNHZ0bGdZd1pCU0lx?=
 =?utf-8?B?WHpVcGZITXZCSG0yd2dHR0dvczJ5V0dJR2tLR0JBRFNDOGk3Tk9IUnFGODlo?=
 =?utf-8?B?ODNzWVhLd1lJQmZDTE5LNHZudlBOUWtmUkVKMGxwa25wMUx2K1Q4bjV1ZDdx?=
 =?utf-8?B?RHczczFFUFIwZlo0MnphWHJQbS93MGR5ZGxQM0puNmVxQVdCT04zUjE0T29o?=
 =?utf-8?B?cjFER3MrYVRuSVo0S2ZkZHFiblJGQ3NVT0RWWGM0b2VFZDQzQ2ptclhGMDZm?=
 =?utf-8?B?dzZ5eVpKOFlrdlgyTWp6TEJTS0l0Mkd5V294YVpnNHdxYm41VTlHZVJWUjY2?=
 =?utf-8?B?ZXlYdTgvWUx0alhPSDF0am5UdzBYazRuSmZPZGZFM1pWTXpkNlBZem00UFJE?=
 =?utf-8?B?ejNZejNwSHJGNzRNdHozeVg4Z1V3NVpqRVVsTGRyTHF0T3ZBNDlRSzJRTXpi?=
 =?utf-8?B?bWhLMk8vS2FxVzhhRTR2RW1uaXI4UmptenJnU2xtaWEvUGtmZWF5NlA2eDZP?=
 =?utf-8?B?RE1Scyt5SnZib1BrUWFZK3VWd2ZkQUhsck9jOUpkdDBySE42eUF5Nlc5ZFdR?=
 =?utf-8?B?dEIydmRTZ0NSQWlsUjlTNVp2bmx2aTRPQWloVkM3L1dPNWJUS24zbmRIZS9Z?=
 =?utf-8?B?UU5hQVd6MytJY2JZWWpncWhXaGQwOFRQa2VkVGwzWHZzaUFzNjloY21abE56?=
 =?utf-8?B?WFVxMEJUczZLbzRpR2k5OXgvamkzcUJudzFrTGdqQWgyM1JmeCtPWkJLbmh4?=
 =?utf-8?B?UXdESnd2MFFPVGJWazBRR0REVFBIbE1NcTJCaHRJUFE2Snp2cmxwZ0d0Tzd3?=
 =?utf-8?B?UXZOUUZ4MDBtWTltY0tUN28xTXJuOTNrQTNxTGEvb3NBdTcvTWI5SmRPYWlw?=
 =?utf-8?B?Q2FQMXdLOU1FREIrTm11L1JKYmxiVTU2aWs3WkFBWlNRMFhpYVJtdGhFSmxT?=
 =?utf-8?B?UFFjeWdQU2l4RThLMGNLcXBubnZNYTF5cStFRUpTU0F5bjhtY29rWllwZWor?=
 =?utf-8?B?c0NLS01BL3ROaWxxbFJCT29vSFN4VnNNdkdnaStZcERBQ0NSNE9VenlkcDFR?=
 =?utf-8?B?bnFRQ2FBNXUxMHp1WWVMK0xJdk82dlphaHZpUjQ3Tk03U0ZyK0dYQmVjZFZ0?=
 =?utf-8?B?bm9qOUNqbU9NWDFyQUNYYU9WRWxBWTVnT29XSVI1QXRhQ2ZJcU5sUkd5VCts?=
 =?utf-8?B?Q0FTTys3ckd1TllOV0dFck5oOFhGZERGN3RHVHFPeGorZDNRWXJtRXkzZmVs?=
 =?utf-8?Q?pMqLc2tby/S+D9w6XQKqKnSRq9uTcI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:31:11.7264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95193b8a-6f35-4cea-db73-08dd54c6bdaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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

This commit addresses a circular locking dependency in the
svm_range_cpu_invalidate_pagetables function. The function previously
held a lock while determining whether to perform an unmap or eviction
operation, which could lead to deadlocks.

v2: To resolve this issue, the allocation of the process context buffer
(`proc_ctx_bo`) has been moved from the `add_queue_mes` function to
the `pqm_create_queue` function. This change ensures that the buffer
is allocated only when the first queue for a process is created and
only if the Memory Execution Scheduler (MES) is enabled. (Felix)

Fixes the below:

[  223.418794] ======================================================
[  223.418820] WARNING: possible circular locking dependency detected
[  223.418845] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
[  223.418869] ------------------------------------------------------
[  223.418889] kfdtest/3939 is trying to acquire lock:
[  223.418906] ffff8957552eae38 (&dqm->lock_hidden){+.+.}-{3:3}, at: evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.419302]
               but task is already holding lock:
[  223.419303] ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
[  223.419447] Console: switching to colour dummy device 80x25
[  223.419477] [IGT] amd_basic: executing
[  223.419599]
               which lock already depends on the new lock.

[  223.419611]
               the existing dependency chain (in reverse order) is:
[  223.419621]
               -> #2 (&prange->lock){+.+.}-{3:3}:
[  223.419636]        __mutex_lock+0x85/0xe20
[  223.419647]        mutex_lock_nested+0x1b/0x30
[  223.419656]        svm_range_validate_and_map+0x2f1/0x15b0 [amdgpu]
[  223.419954]        svm_range_set_attr+0xe8c/0x1710 [amdgpu]
[  223.420236]        svm_ioctl+0x46/0x50 [amdgpu]
[  223.420503]        kfd_ioctl_svm+0x50/0x90 [amdgpu]
[  223.420763]        kfd_ioctl+0x409/0x6d0 [amdgpu]
[  223.421024]        __x64_sys_ioctl+0x95/0xd0
[  223.421036]        x64_sys_call+0x1205/0x20d0
[  223.421047]        do_syscall_64+0x87/0x140
[  223.421056]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  223.421068]
               -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
[  223.421084]        __ww_mutex_lock.constprop.0+0xab/0x1560
[  223.421095]        ww_mutex_lock+0x2b/0x90
[  223.421103]        amdgpu_amdkfd_alloc_gtt_mem+0xcc/0x2b0 [amdgpu]
[  223.421361]        add_queue_mes+0x3bc/0x440 [amdgpu]
[  223.421623]        unhalt_cpsch+0x1ae/0x240 [amdgpu]
[  223.421888]        kgd2kfd_start_sched+0x5e/0xd0 [amdgpu]
[  223.422148]        amdgpu_amdkfd_start_sched+0x3d/0x50 [amdgpu]
[  223.422414]        amdgpu_gfx_enforce_isolation_handler+0x132/0x270 [amdgpu]
[  223.422662]        process_one_work+0x21e/0x680
[  223.422673]        worker_thread+0x190/0x330
[  223.422682]        kthread+0xe7/0x120
[  223.422690]        ret_from_fork+0x3c/0x60
[  223.422699]        ret_from_fork_asm+0x1a/0x30
[  223.422708]
               -> #0 (&dqm->lock_hidden){+.+.}-{3:3}:
[  223.422723]        __lock_acquire+0x16f4/0x2810
[  223.422734]        lock_acquire+0xd1/0x300
[  223.422742]        __mutex_lock+0x85/0xe20
[  223.422751]        mutex_lock_nested+0x1b/0x30
[  223.422760]        evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.423025]        kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
[  223.423285]        kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
[  223.423540]        svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
[  223.423807]        __mmu_notifier_invalidate_range_start+0x1f5/0x250
[  223.423819]        copy_page_range+0x1e94/0x1ea0
[  223.423829]        copy_process+0x172f/0x2ad0
[  223.423839]        kernel_clone+0x9c/0x3f0
[  223.423847]        __do_sys_clone+0x66/0x90
[  223.423856]        __x64_sys_clone+0x25/0x30
[  223.423864]        x64_sys_call+0x1d7c/0x20d0
[  223.423872]        do_syscall_64+0x87/0x140
[  223.423880]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  223.423891]
               other info that might help us debug this:

[  223.423903] Chain exists of:
                 &dqm->lock_hidden --> reservation_ww_class_mutex --> &prange->lock

[  223.423926]  Possible unsafe locking scenario:

[  223.423935]        CPU0                    CPU1
[  223.423942]        ----                    ----
[  223.423949]   lock(&prange->lock);
[  223.423958]                                lock(reservation_ww_class_mutex);
[  223.423970]                                lock(&prange->lock);
[  223.423981]   lock(&dqm->lock_hidden);
[  223.423990]
                *** DEADLOCK ***

[  223.423999] 5 locks held by kfdtest/3939:
[  223.424006]  #0: ffffffffb82b4fc0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x1387/0x2ad0
[  223.424026]  #1: ffff89575eda81b0 (&mm->mmap_lock){++++}-{3:3}, at: copy_process+0x13a8/0x2ad0
[  223.424046]  #2: ffff89575edaf3b0 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_process+0x13e4/0x2ad0
[  223.424066]  #3: ffffffffb82e76e0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: copy_page_range+0x1cea/0x1ea0
[  223.424088]  #4: ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
[  223.424365]
               stack backtrace:
[  223.424374] CPU: 0 UID: 0 PID: 3939 Comm: kfdtest Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
[  223.424392] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  223.424401] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS PRO WIFI/X570 AORUS PRO WIFI, BIOS F36a 02/16/2022
[  223.424416] Call Trace:
[  223.424423]  <TASK>
[  223.424430]  dump_stack_lvl+0x9b/0xf0
[  223.424441]  dump_stack+0x10/0x20
[  223.424449]  print_circular_bug+0x275/0x350
[  223.424460]  check_noncircular+0x157/0x170
[  223.424469]  ? __bfs+0xfd/0x2c0
[  223.424481]  __lock_acquire+0x16f4/0x2810
[  223.424490]  ? srso_return_thunk+0x5/0x5f
[  223.424505]  lock_acquire+0xd1/0x300
[  223.424514]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.424783]  __mutex_lock+0x85/0xe20
[  223.424792]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.425058]  ? srso_return_thunk+0x5/0x5f
[  223.425067]  ? mark_held_locks+0x54/0x90
[  223.425076]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.425339]  ? srso_return_thunk+0x5/0x5f
[  223.425350]  mutex_lock_nested+0x1b/0x30
[  223.425358]  ? mutex_lock_nested+0x1b/0x30
[  223.425367]  evict_process_queues_cpsch+0x43/0x210 [amdgpu]
[  223.425631]  kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
[  223.425893]  kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
[  223.426156]  svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
[  223.426423]  ? srso_return_thunk+0x5/0x5f
[  223.426436]  __mmu_notifier_invalidate_range_start+0x1f5/0x250
[  223.426450]  copy_page_range+0x1e94/0x1ea0
[  223.426461]  ? srso_return_thunk+0x5/0x5f
[  223.426474]  ? srso_return_thunk+0x5/0x5f
[  223.426484]  ? lock_acquire+0xd1/0x300
[  223.426494]  ? copy_process+0x1718/0x2ad0
[  223.426502]  ? srso_return_thunk+0x5/0x5f
[  223.426510]  ? sched_clock_noinstr+0x9/0x10
[  223.426519]  ? local_clock_noinstr+0xe/0xc0
[  223.426528]  ? copy_process+0x1718/0x2ad0
[  223.426537]  ? srso_return_thunk+0x5/0x5f
[  223.426550]  copy_process+0x172f/0x2ad0
[  223.426569]  kernel_clone+0x9c/0x3f0
[  223.426577]  ? __schedule+0x4c9/0x1b00
[  223.426586]  ? srso_return_thunk+0x5/0x5f
[  223.426594]  ? sched_clock_noinstr+0x9/0x10
[  223.426602]  ? srso_return_thunk+0x5/0x5f
[  223.426610]  ? local_clock_noinstr+0xe/0xc0
[  223.426619]  ? schedule+0x107/0x1a0
[  223.426629]  __do_sys_clone+0x66/0x90
[  223.426643]  __x64_sys_clone+0x25/0x30
[  223.426652]  x64_sys_call+0x1d7c/0x20d0
[  223.426661]  do_syscall_64+0x87/0x140
[  223.426671]  ? srso_return_thunk+0x5/0x5f
[  223.426679]  ? common_nsleep+0x44/0x50
[  223.426690]  ? srso_return_thunk+0x5/0x5f
[  223.426698]  ? trace_hardirqs_off+0x52/0xd0
[  223.426709]  ? srso_return_thunk+0x5/0x5f
[  223.426717]  ? syscall_exit_to_user_mode+0xcc/0x200
[  223.426727]  ? srso_return_thunk+0x5/0x5f
[  223.426736]  ? do_syscall_64+0x93/0x140
[  223.426748]  ? srso_return_thunk+0x5/0x5f
[  223.426756]  ? up_write+0x1c/0x1e0
[  223.426765]  ? srso_return_thunk+0x5/0x5f
[  223.426775]  ? srso_return_thunk+0x5/0x5f
[  223.426783]  ? trace_hardirqs_off+0x52/0xd0
[  223.426792]  ? srso_return_thunk+0x5/0x5f
[  223.426800]  ? syscall_exit_to_user_mode+0xcc/0x200
[  223.426810]  ? srso_return_thunk+0x5/0x5f
[  223.426818]  ? do_syscall_64+0x93/0x140
[  223.426826]  ? syscall_exit_to_user_mode+0xcc/0x200
[  223.426836]  ? srso_return_thunk+0x5/0x5f
[  223.426844]  ? do_syscall_64+0x93/0x140
[  223.426853]  ? srso_return_thunk+0x5/0x5f
[  223.426861]  ? irqentry_exit+0x6b/0x90
[  223.426869]  ? srso_return_thunk+0x5/0x5f
[  223.426877]  ? exc_page_fault+0xa7/0x2c0
[  223.426888]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  223.426898] RIP: 0033:0x7f46758eab57
[  223.426906] Code: ba 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
[  223.426930] RSP: 002b:00007fff5c3e5188 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  223.426943] RAX: ffffffffffffffda RBX: 00007f4675f8c040 RCX: 00007f46758eab57
[  223.426954] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  223.426965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  223.426975] R10: 00007f4675e81a50 R11: 0000000000000246 R12: 0000000000000001
[  223.426986] R13: 00007fff5c3e5470 R14: 00007fff5c3e53e0 R15: 00007fff5c3e5410
[  223.427004]  </TASK>

Fixes: 3e5199134e47 ("drm/amdkfd: pause autosuspend when creating pdd")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Alex Sierra <alex.sierra@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 15 ---------------
 .../drm/amd/amdkfd/kfd_process_queue_manager.c    | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 195085079eb2..94b1ac8a4735 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -207,21 +207,6 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	if (!pdd->proc_ctx_cpu_ptr) {
-		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
-				AMDGPU_MES_PROC_CTX_SIZE,
-				&pdd->proc_ctx_bo,
-				&pdd->proc_ctx_gpu_addr,
-				&pdd->proc_ctx_cpu_ptr,
-				false);
-		if (r) {
-			dev_err(adev->dev,
-				"failed to allocate process context bo\n");
-			return r;
-		}
-		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-	}
-
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 	queue_input.process_id = pdd->pasid;
 	queue_input.page_table_base_addr =  qpd->page_table_base;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index d7947311cbbd..07bdb0102ad4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -367,6 +367,21 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	    list_empty(&pdd->qpd.priv_queue_list))
 		dev->dqm->ops.register_process(dev->dqm, &pdd->qpd);
 
+	/* Allocate proc_ctx_bo only if MES is enabled and this is the first queue */
+	if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
+		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+						     AMDGPU_MES_PROC_CTX_SIZE,
+						     &pdd->proc_ctx_bo,
+						     &pdd->proc_ctx_gpu_addr,
+						     &pdd->proc_ctx_cpu_ptr,
+						     false);
+		if (retval) {
+			dev_err(dev->adev->dev, "failed to allocate process context bo\n");
+			return retval;
+		}
+		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+	}
+
 	pqn = kzalloc(sizeof(*pqn), GFP_KERNEL);
 	if (!pqn) {
 		retval = -ENOMEM;
-- 
2.34.1

