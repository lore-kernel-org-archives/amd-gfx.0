Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D7606A322
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DQghwr5d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B06112634;
	Fri, 30 Oct 2026 03:28:33 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55B4112634
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 03:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0LX1OkS5CUj8jnEJVPn1Yk3HqZCXGMndjlpyQf6hedOO9hA/dTOlKlJFYIkoav/P56YYIn+RFyS9NWNjKyMNNuG8PQCdSJitmlbcsAfp9pAInWTCzXy4Vujph5si0oO/Y6sseOxAtAeHMMOcnpYjDIHIkxSADpo0Uia4Qv+HGcc4AKADu6QP97Ii+AlVy+ZAqkH+QIbVsxDHBuuFlMUqOju1M/RWkcpU9gT2cWRX+EA3GAnwTl+UuKaR97mB9eSpb5eXuKuF/BjIrdQ7SXoETWBqTUQWp9tQecuo0Gd5ZsLhyDDMh7z33BlTbpv26Bd5YCK16/JpASCz+1BSnm8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M8dClF3XhDMsITmLxW/hjh146rBFfMqdbZydbVBvIk=;
 b=OADKBym1PLj1gXhBKQbqzDwkyDpJOh5dN9Vbx5wLA75AufYZ2DDmCQHOEA3vdMEHNj4vGIZMlQSOiNMwexN7tCfqiRpE/bM8hTPzVpXGz+JZJtPVfgN0lkXrVWIxrzpaIUp8k8XcJp7x3Fnn4ZVrjJ1LcJV5CVlkQF/FB+dbTIaWkzdQ6cut3GPZiJ1+RV9T4gyPYYNu6TMve7HJlGcjJT2RyooIYchccduziDtbH8UCE0qVjkzBHM7cvAmTrY3sFBGy4gTa8arSAaIOtnvBY4P6alr9YDk3kT/a//HtDbSlqsVhQRTtY8qvn7e9SkTVnYeASiXvPt6tk+meIGG2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M8dClF3XhDMsITmLxW/hjh146rBFfMqdbZydbVBvIk=;
 b=DQghwr5dVPjRDjW6v2RazqHEm5ozNckvKys8P+8KUoH5Hhr4IjHwWcj6EAc+FPaCugHKDGxKoThoHQa3gNegeqlMz8PDWUbxctT5jAp4eqW7IWtqdjLNu+cXxBuhZ7HuO5Vk/CwLocge9zD2RwSProyX1yLSoszW9/9dsgAzY1E=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 03:28:22 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7d) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Fri,
 30 Oct 2026 03:28:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 03:28:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 22:28:20 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 22:28:20 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: avoid blocking reset lock during eviction
Date: Thu, 29 Oct 2026 23:27:37 -0400
Message-ID: <20261030032818.136872-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 988d80ee-6f53-4d62-6961-08df3635d948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|18002099003|56012099006|11063799006|261022075727099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261009221227099003|261009223027099003|261026121527099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: N7DYKAiSVXObWN2gU50JXClPiFqqa29iMp6aBrokIpEoQghUVVzub5oPyOIzgI0DqB981z3yrvCmMeqw1KzdI2DwstZQR4PSycpANwCcdfTZ2mzgR8pzT7E4Z4Sy/FShp6PgtDxjCILmSSJ946FZ56S2bsVov+9N3MCbNZMIVJPa9I/HiPsWuvvHB5uov4syv0QfES1aeNKfzKfh/nX5gd7q0S4KGEGOBk+dEChP0e2izUziVKem7PZ+PQm8FljcEH01aoorb2nBSF5q+IPCJ+d5c6GTM2lMSYnngUAnVnQWm/nXVpF4j8ChRwILF0UDW/VxXAsKsQQLxP5jsjH3SPo9dFkC28pWaFjHI8MVXa4M8PfSpFzlC0I74FgPrfC2rL1J8WurcSPtdfyY9njSFdPnfpu0mVfDGEUEqCMy1SLrbqb0O5HWATMt+Tv26a1rJ6Xy1d+QwvXYPTWJt+Qwe/Z9W3TXrkdfX8R2p97Odlgz8Fx3gJ7UW+U6QQSQbPC0+VsbKCjHVXOEaP+2QtsJRMnGt7zoMPdqcwnHC29+I3pTMhAU49BjobQRFSk057cggHELTHlFFnYaN2R7G0SBg2p79lPIrrvbkSSmOVcRS1YJYuTUtvQmx7ktg3XnFLBg0z3vrhyu0J6rN4eKzLXTypUd5OrjkKG6NNPdqy9WDYlXdRCi6VrxaW9Ai1gPd462Ovpq1GVakRbSSBsnn9mhZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261026121527099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RHyBgdUm9oy1Ded6Hz+O52G61V0EtCSjyF+uk50q7cJS1eO085kbI2qDX99scOOqla++ZxLNJVREkpNiZxnD0kRcwO6UlGXTkMkPJCHG4+moaxUP5jK8Ctj0Smo+dYLeDXTPox39JDn0bbT+Ny/PhwDywo7g5IQStpdeeJpg/6rjeS2o2E1Brv+FGXFxK5blcHxvxpTbdUra+H4fe0fbviyVq9arVTI9hlUc/c+SIsAAWg5ldBv6CWWUnOzyxUZ/T7zpTq8rhMwqJ80fm/nO3JfDIWHrNpe0SLQJ3E367ouH8BFp0vOki5Jm+SmmbA2eN+fyX9DbXWs+tyY0oMLOj0in3WwGrkrZS2+W6M47yn6MIaid6c2+XD2GCpssdQen2AjEhfRAus1igZsFQWD7SbojM9YtFi4THapkt4hIFQYBr/+3HrtfB77M33KLJmGl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 03:28:21.5198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988d80ee-6f53-4d62-6961-08df3635d948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The eviction-fence worker runs inside a DMA-fence signalling section.
Userq eviction can block on reset_domain->sem while GPU recovery holds
that semaphore and invalidates mappings. Lockdep reports the resulting
dependency cycle through dma_fence_map.

[  +0.000295] amdgpu 0000:03:00.0: GPU reset begin!. Source:  5

[  +0.000233] ======================================================
[  +0.000001] WARNING: possible circular locking dependency detected
[  +0.000000] 7.2.0+ #97 Tainted: G        W
[  +0.000001] ------------------------------------------------------
[  +0.000001] kworker/u128:1/238 is trying to acquire lock:
[  +0.000001] ffff897b4fcc2eb8 (&mapping->i_mmap_rwsem){++++}-{4:4}, at: unmap_mapping_pages+0x6a/0xd0
[  +0.000005]
              but task is already holding lock:
[  +0.000001] ffff897b0fd60ec0 (&reset_domain->sem){++++}-{4:4}, at: amdgpu_device_lock_reset_domain+0x1c/0x30 [amdgpu]
[  +0.000294]
              which lock already depends on the new lock.

[  +0.000000]
              the existing dependency chain (in reverse order) is:
[  +0.000001]
              -> #3 (&reset_domain->sem){++++}-{4:4}:
[  +0.000002]        down_read+0x30/0x180
[  +0.000004]        amdgpu_userq_unmap_helper+0x46/0x290 [amdgpu]
[  +0.000212]        amdgpu_userq_evict+0x4e/0xf0 [amdgpu]
[  +0.000198]        amdgpu_eviction_fence_suspend_worker+0x51/0xf0 [amdgpu]
[  +0.000176]        process_one_work+0x22e/0x760
[  +0.000003]        worker_thread+0x1db/0x3d0
[  +0.000001]        kthread+0xfe/0x140
[  +0.000001]        ret_from_fork+0x3bd/0x470
[  +0.000002]        ret_from_fork_asm+0x1a/0x30
[  +0.000002]
              -> #2 (dma_fence_map){++++}-{0:0}:
[  +0.000003]        __dma_fence_might_wait+0x42/0xf0
[  +0.000002]        dma_resv_lockdep+0x26d/0x3b0
[  +0.000002]        do_one_initcall+0x74/0x3e0
[  +0.000002]        kernel_init_freeable+0x3f8/0x6d0
[  +0.000002]        kernel_init+0x1b/0x200
[  +0.000002]        ret_from_fork+0x3bd/0x470
[  +0.000001]        ret_from_fork_asm+0x1a/0x30
[  +0.000002]
              -> #1 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
[  +0.000002]        __split_huge_pmd+0x86/0x190
[  +0.000002]        vma_adjust_trans_huge+0x12b/0x1c0
[  +0.000002]        __split_vma+0x236/0x370
[  +0.000002]        vms_gather_munmap_vmas+0xe8/0x360
[  +0.000001]        __mmap_region+0x2ab/0x1060
[  +0.000001]        mmap_region+0xc4/0x180
[  +0.000001]        do_mmap+0x48b/0x660
[  +0.000002]        vm_mmap_pgoff+0x129/0x230
[  +0.000002]        ksys_mmap_pgoff+0x1a2/0x270
[  +0.000001]        __x64_sys_mmap+0x33/0x70
[  +0.000002]        x64_sys_call+0x2194/0x26e0
[  +0.000001]        do_syscall_64+0x103/0x6d0
[  +0.000001]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000002]
              -> #0 (&mapping->i_mmap_rwsem){++++}-{4:4}:
[  +0.000002]        __lock_acquire+0x15aa/0x2740
[  +0.000001]        lock_acquire+0xc4/0x2f0
[  +0.000002]        down_read+0x30/0x180
[  +0.000001]        unmap_mapping_pages+0x6a/0xd0
[  +0.000001]        unmap_mapping_range+0x25/0x40
[  +0.000002]        amdgpu_device_gpu_recover+0x17a/0x400 [amdgpu]
[  +0.000168]        amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
[  +0.000167]        process_one_work+0x22e/0x760
[  +0.000002]        worker_thread+0x1db/0x3d0
[  +0.000001]        kthread+0xfe/0x140
[  +0.000001]        ret_from_fork+0x3bd/0x470
[  +0.000001]        ret_from_fork_asm+0x1a/0x30
[  +0.000002]
              other info that might help us debug this:

[  +0.000000] Chain exists of:
                &mapping->i_mmap_rwsem --> dma_fence_map --> &reset_domain->sem

[  +0.000003]  Possible unsafe locking scenario:

[  +0.000000]        CPU0                    CPU1
[  +0.000001]        ----                    ----
[  +0.000001]   lock(&reset_domain->sem);
[  +0.000001]                                lock(dma_fence_map);
[  +0.000001]                                lock(&reset_domain->sem);
[  +0.000001]   rlock(&mapping->i_mmap_rwsem);
[  +0.000001]
               *** DEADLOCK ***

[  +0.000000] 3 locks held by kworker/u128:1/238:
[  +0.000001]  #0: ffff897b50d5f940 ((wq_completion)amdgpu-reset-dev){+.+.}-{0:0}, at: process_one_work+0x4a8/0x760
[  +0.000003]  #1: ffffce9fc0a13e30 ((work_completion)(&adev->reset_work)){+.+.}-{0:0}, at: process_one_work+0x1ee/0x760
[  +0.000003]  #2: ffff897b0fd60ec0 (&reset_domain->sem){++++}-{4:4}, at: amdgpu_device_lock_reset_domain+0x1c/0x30 [amdgpu]
[  +0.000201]
              stack backtrace:
[  +0.000001] CPU: 8 UID: 0 PID: 238 Comm: kworker/u128:1 Tainted: G        W           7.2.0+ #97 PREEMPT(full)
[  +0.000002] Tainted: [W]=WARN
[  +0.000000] Hardware name: ASUS System Product Name/ROG MAXIMUS Z790 HERO, BIOS 2703 10/17/2024
[  +0.000001] Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
[  +0.000165] Call Trace:
[  +0.000000]  <TASK>
[  +0.000001]  dump_stack_lvl+0xa5/0x110
[  +0.000002]  dump_stack+0x10/0x20
[  +0.000001]  print_circular_bug+0x285/0x360
[  +0.000001]  check_noncircular+0x14c/0x170
[  +0.000002]  __lock_acquire+0x15aa/0x2740
[  +0.000001]  ? add_lock_to_list+0x35/0x130
[  +0.000002]  lock_acquire+0xc4/0x2f0
[  +0.000001]  ? unmap_mapping_pages+0x6a/0xd0
[  +0.000002]  ? lock_acquire+0xc4/0x2f0
[  +0.000001]  ? amdgpu_device_lock_reset_domain+0x1c/0x30 [amdgpu]
[  +0.000196]  down_read+0x30/0x180
[  +0.000001]  ? unmap_mapping_pages+0x6a/0xd0
[  +0.000002]  unmap_mapping_pages+0x6a/0xd0
[  +0.000002]  unmap_mapping_range+0x25/0x40
[  +0.000001]  amdgpu_device_gpu_recover+0x17a/0x400 [amdgpu]
[  +0.000163]  amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
[  +0.000169]  process_one_work+0x22e/0x760
[  +0.000003]  worker_thread+0x1db/0x3d0
[  +0.000000]  ? __pfx_worker_thread+0x10/0x10
[  +0.000001]  kthread+0xfe/0x140
[  +0.000001]  ? __pfx_kthread+0x10/0x10
[  +0.000001]  ret_from_fork+0x3bd/0x470
[  +0.000001]  ? __pfx_kthread+0x10/0x10
[  +0.000001]  ret_from_fork_asm+0x1a/0x30
[  +0.000002]  </TASK>

Use a try-read-lock for eviction unmaps. If reset owns the semaphore,
leave the eviction fence unsignaled and retry the worker after a short
delay. Keep blocking read-locking for other userq unmap paths, which
must remain serialized with reset.

Convert suspend_work to delayed work so retries can be scheduled and
flushed during teardown.

Fixes: aebf196c550e ("drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues")

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 22 ++++++++++----
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 30 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
 4 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index a0802012de49..fe45fa164e79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -44,7 +44,7 @@ static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
 {
 	struct amdgpu_eviction_fence *ev_fence = to_ev_fence(f);
 
-	schedule_work(&ev_fence->evf_mgr->suspend_work);
+	schedule_delayed_work(&ev_fence->evf_mgr->suspend_work, 0);
 	return true;
 }
 
@@ -58,13 +58,15 @@ static void
 amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 {
 	struct amdgpu_eviction_fence_mgr *evf_mgr =
-		container_of(work, struct amdgpu_eviction_fence_mgr,
+		container_of(to_delayed_work(work),
+			     struct amdgpu_eviction_fence_mgr,
 			     suspend_work);
 	struct amdgpu_fpriv *fpriv =
 		container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct dma_fence *ev_fence;
 	bool cookie;
+	int ret;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
@@ -79,7 +81,14 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	cookie = dma_fence_begin_signalling();
 
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
-	amdgpu_userq_evict(uq_mgr);
+	ret = amdgpu_userq_evict(uq_mgr);
+	if (ret == -EAGAIN) {
+		dma_fence_end_signalling(cookie);
+		dma_fence_put(ev_fence);
+		schedule_delayed_work(&evf_mgr->suspend_work, 1);
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return;
+	}
 
 	/*
 	 * Signaling the eviction fence must be done while holding the
@@ -167,14 +176,15 @@ void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
 	evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
 	evf_mgr->ev_fence = dma_fence_get_stub();
 
-	INIT_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
+	INIT_DELAYED_WORK(&evf_mgr->suspend_work,
+		  amdgpu_eviction_fence_suspend_worker);
 }
 
 void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	evf_mgr->shutdown = true;
 	/* Make sure that the shutdown is visible to the suspend work */
-	flush_work(&evf_mgr->suspend_work);
+	flush_delayed_work(&evf_mgr->suspend_work);
 }
 
 void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr)
@@ -182,7 +192,7 @@ void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr)
 	dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
 		       false);
 	/* Make sure that we are done with the last suspend work */
-	flush_work(&evf_mgr->suspend_work);
+	flush_delayed_work(&evf_mgr->suspend_work);
 }
 
 void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index 2a750add4e7b..d3c3d0769864 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -43,7 +43,7 @@ struct amdgpu_eviction_fence_mgr {
 	 * Only signaled while holding the userq mutex.
 	 */
 	struct dma_fence __rcu	*ev_fence;
-	struct work_struct	suspend_work;
+	struct delayed_work	suspend_work;
 	bool			shutdown;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ccf0ff490ac2..d652a3a7a2da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -351,16 +351,22 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 	return r;
 }
 
-static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
+static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue,
+				     bool trylock)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
-	int r;
+	int r = 0;
 
 	/* The reset changes the queue state and the MES is unusable meanwhile */
-	guard(rwsem_read)(&adev->reset_domain->sem);
+	if (trylock) {
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			return -EAGAIN;
+	} else {
+		down_read(&adev->reset_domain->sem);
+	}
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		trace_amdgpu_userq_state_start(queue);
@@ -369,14 +375,16 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		if (r) {
 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-			return r;
+			goto unlock;
 		} else {
 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
 		}
 	}
 
-	return 0;
+unlock:
+	up_read(&adev->reset_domain->sem);
+	return r;
 }
 
 static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
@@ -563,7 +571,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
-	r = amdgpu_userq_unmap_helper(queue);
+	r = amdgpu_userq_unmap_helper(queue, false);
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
@@ -1296,7 +1304,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-		r = amdgpu_userq_unmap_helper(queue);
+		r = amdgpu_userq_unmap_helper(queue, true);
+		if (r == -EAGAIN)
+			return r;
 		if (r)
 			ret = r;
 	}
@@ -1327,10 +1337,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 	}
 }
 
-void
+int
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 {
-	amdgpu_userq_evict_all(uq_mgr);
+	return amdgpu_userq_evict_all(uq_mgr);
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
@@ -1422,7 +1432,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 		if (adev->in_s0ix)
 			r = amdgpu_userq_preempt_helper(queue);
 		else
-			r = amdgpu_userq_unmap_helper(queue);
+			r = amdgpu_userq_unmap_helper(queue, false);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..4dcf6151de6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -163,7 +163,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
 void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
-void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
+int amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
-- 
2.55.0

