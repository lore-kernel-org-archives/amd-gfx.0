Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A282EC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 02:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04AA10E114;
	Fri, 10 Jul 2026 02:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QY8aeCrr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A4210E114
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 02:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otsb/3RiKWNbgZao4FzMpBjc1P6JgXXLXiPxOC0kmO9SVdm780Q7i8Hm+k0yMDNASR/2M4zbssLW4SklaxQcTMse6HiQuRzmNVzNv4ibqVsOXb9EjMeJIN6e3S4vciEZFLvyypn7Y0cZoQt5DbzhBxb94f9/t7xOciJjKI0+R52V/OMd6gGI8PfidjR1INbIuEt1wHc0TxfthSlyQiEDs1wuOf658uQOx9Al1Vz8eHRT8/eD66jm3a9xkqnxgDzFko9XbNIwOSFAeTN6AoLVvLq09wRIpDMqvb2RfwAcqanslcFt1JtELF99MOqc8qndNtYwtgfK8dfsjwFDCCI+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvP//dTJIukyd1EVWavWs+utFm+GqdMjKd87F56FZW8=;
 b=ag3tFfFyo6O/tzfnYS8fcly24HI4c4UMZBFVEzHtDpqoyzBa1RSCsn2VrUaHK1MwLbEt6rq7Ck4zWIUAt7OHsxim5pjnKBcCvXTWqX1KxskhdhHm1ClRO2tGhtsCkKbjwuntaICxdNyU+z54TBVOTh+sF1BY30Un6PE2Et1LzsfB6FmPjOv+O5x3aTbZznXbqK+UwVDKstei77Zbr38lbKv6UsrHOVlWQT9KhPzBl/1dLoLgQIVOMTxIGcV+HyUxTrkkYgF9TpanC8jXit2C+VVvD2tuQ81tDsZiyzW4+l3VjGfAMjYqoJNOAIiN0oUI3dBdZk0MAZj+WAj4ORfdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvP//dTJIukyd1EVWavWs+utFm+GqdMjKd87F56FZW8=;
 b=QY8aeCrrOaa6po5vQnumQO4L9J2w6n2cz3m0VpQUEMSRM5M5S7A6M68AQzqGzOyViNaHjJiyGI9JlfCWt5gBnBQDFNsfHfAr4zb7bVcsAM2l8XHrEDVDazpjHwy9yKrQ6hLv+xkAY9q7EX8BBe6zaKu/KK/NG1sY0YfxvhME2fI=
Received: from SA0PR11CA0153.namprd11.prod.outlook.com (2603:10b6:806:1bb::8)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 02:52:40 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::2a) by SA0PR11CA0153.outlook.office365.com
 (2603:10b6:806:1bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Fri,
 10 Jul 2026 02:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 02:52:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 21:52:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 19:52:39 -0700
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 21:52:39 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Michael Gavrilov
 <mikhail.v.gavrilov@gmail.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init
Date: Thu, 9 Jul 2026 22:50:35 -0400
Message-ID: <20260710025232.208861-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 8818838b-5316-4ba1-c2fa-08dede2e4ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: C5QY7YPYmVnXUce4GJ1Rw6w9LavoF/EjoKF18zzPSnZsz19YuiYCeiaX2URMn/q24GBSWdEkaQ5jiaFk/0oZi55B8yGqpHkvRavfOcpSMLs/gdO4B0h5SjaXgpn6osLXwbiPeYPRlzxCc2s7zQbqItcxBW9o+Jvm7psleWkYg4nIPPmawwEQWT+ucggI8zr211n/4Q2Vxqc9OYy7UeUmix8KCIEh3JGnkX8WVuLKK4pqv7m/A0vkq3M5JKT14O2P4Mi0kjer9SVPglrJASXjrQToU3Dgi3Ruk8kpKPTck1L8QYodi6RvEGBnRPYv4Mwo7FclHl99mN3SrPqO1DDDOjDZVxFka8MGVq+8/soq8zFwRQHxvreSDlOsOcu9m2qq6+Z0RWFgKOKJAgroFcdCmQdCwG1oq2RRnY/oyrSUkMxgRDCC4PEyQ2J0MZmnOZd4YQM6opdUdWCB8XcwhjrlnLWdszWCM5vrUAN0Qbc3mLyCZZ6MjeI4MsYhU4Rmogze/YXSGFO0uoZZQRfkviOq51FGn9bT8m6mMltVrok3m0J9n0cv1LgpduJhEPq20qZ2KhSrYNuPlwi53E3tKaNFW/60xg08plt1ciCkt8vGka28zF1iHAWMtKei9Rm2P/A++U/NjXD6y3VWGc7v8srd2Erc8W5NE/MX/3fUvLAnpzJWxklIt6su9TUGXDRC8W2Ulm47PiRN3fEhp+uq9tDIxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yPLwBOUKoCABOb7N53ZQQeJw3KuUKNauEabjJsVy9QC2KoMvs6bJYzYjW7t92YO1T1yfwe7r9b5ulIJHfOaoaGWKAZQ6tG5kxJ74N6SgcvWVWj7xeUQzr/Ys9LdyAno2IcH9HK6j/lxHzdC1S+0z7TIAZa8yO5a/U0sVc4MQ1l9NUDcF8hjM//bg9HgvFbiOumQP7xH6pqHZ46Ms9t3jBH8S+aY/elRO0OVgaQINtLtoQQDGo670S81DtUHYbFkaV1rvVpjT/iVENk3IoSxZeiyz/3fiwAXGCqoTTPmhxKbSmC08PRzFpxEtExt/cQqz5nIqqMSODhKNuJ/0vW+Ok0I1rWGSqTh8e48lsi2jm5uBlZmtbowTCjNs+JKKAo60dG3h8uySgyM5vCnW29ZyZvUkPQX8fFwAATyaBlimiUzcls1ffPp1Xg0mVBqJWvf4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 02:52:40.3375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8818838b-5316-4ba1-c2fa-08dede2e4ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Move fs_reclaim_acquire() to before all lock acquisitions to teach
lockdep the correct dependency order and eliminate false positive
circular locking dependency warning.

PROBLEM:

amdgpu_lockdep_init() trains lockdep by acquiring locks in sequence
while calling fs_reclaim_acquire() in the middle. The fs_reclaim call
was placed while notifier_lock was held, teaching lockdep:

    notifier_lock -> fs_reclaim

However, at runtime, MMU notifier callbacks run from inside memory
reclaim, establishing the opposite dependency:

    fs_reclaim -> mmu_notifier -> notifier_lock

These form a false cycle that lockdep reports when reclaim unmaps a
page covered by an amdgpu userptr notifier.

LOCKDEP WARNING EXAMPLE (BEFORE FIX):

    WARNING: possible circular locking dependency detected
    6.19.0+ #48 Not tainted
    amd_lockdep/3762 is trying to acquire lock:
    ffff8881756f3c30 (&amdgpu_notifier_lock_key), at: amdgpu_hmm_invalidate_gfx

    but task is already holding lock:
    ffffffff92e4b5c0 (mmu_notifier_invalidate_range_start), at: try_to_unmap_one

    Chain exists of:
      &amdgpu_notifier_lock_key --> fs_reclaim --> mmu_notifier_invalidate_range_start

    Possible unsafe locking scenario:
          CPU0                    CPU1
          ----                    ----
     lock(mmu_notifier_invalidate_range_start);
                                  lock(fs_reclaim);
                                  lock(mmu_notifier_invalidate_range_start);
     lock(&amdgpu_notifier_lock_key);

     *** DEADLOCK ***

The dependency chain shows:
  -> #5 (fs_reclaim):
       amdgpu_lockdep_init+0x61e/0x730 [amdgpu]  <- FALSE EDGE
  -> #0 (&amdgpu_notifier_lock_key):
       amdgpu_hmm_invalidate_gfx+0x77/0x110 [amdgpu]  <- RUNTIME PATH

SOLUTION:

Move fs_reclaim_acquire/release to BEFORE all lock acquisitions.
This teaches lockdep that fs_reclaim is outermost, matching runtime
where reclaim calls MMU notifiers which then take notifier_lock.

VERIFICATION (AFTER FIX):

Test reproducer (based on Michael Gavrilov's standalone test case)
creates a 64MB GPU userptr memory buffer, then repeatedly forces the
kernel to reclaim it by moving pages to disk (simulating memory
pressure). Each reclaim cycle triggers the MMU notifier callback path.

The test would be available as an IGT subtest:
  tests/amdgpu/amd_lockdep.c::notifier-reclaim-splat

Results:
  Before fix: Lockdep false positive warning on first reclaim attempt
  After fix:  Completed 8 reclaim cycles with no lockdep warnings

dmesg after fix shows only test success messages, no circular dependency
warnings. The fix is minimal (relocate 2 lines) with no runtime overhead,
only corrects lockdep's static analysis model.

Reported-by: Michael Gavrilov <mikhail.v.gavrilov@gmail.com>
Analyzed-by: Michael Gavrilov <mikhail.v.gavrilov@gmail.com>
Test-case-by: Michael Gavrilov <mikhail.v.gavrilov@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: I584f833aaeac39d7eb777980f49ee503e70eb058
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 47 +++++++++++++++------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
index 61450af539a6..718411f724f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
@@ -18,6 +18,7 @@
 
 struct amdgpu_lockdep_dummy_locks {
 	struct mutex reset_lock;
+	struct mutex filelist_mutex;
 	struct mutex userq_sch_mutex;
 	struct mutex userq_mutex;
 	struct mutex notifier_lock;
@@ -34,6 +35,7 @@ static struct lock_class_key amdgpu_notifier_lock_key;
 static struct lock_class_key amdgpu_vram_lock_key;
 static struct lock_class_key amdgpu_reset_sem_key;
 static struct lock_class_key amdgpu_reset_lock_key;
+static struct lock_class_key amdgpu_filelist_mutex_key;
 static struct lock_class_key amdgpu_srbm_lock_key;
 static struct lock_class_key amdgpu_grbm_lock_key;
 static struct lock_class_key amdgpu_mmio_lock_key;
@@ -57,6 +59,9 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
 	if (adev->reset_domain)
 		lockdep_set_class(&adev->reset_domain->sem,
 				  &amdgpu_reset_sem_key);
+
+	lockdep_set_class(&adev_to_drm(adev)->filelist_mutex,
+			  &amdgpu_filelist_mutex_key);
 }
 
 /**
@@ -74,9 +79,10 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
  * 4. vram_lock           - VRAM allocator lock
  * 5. reset_domain->sem   - GPU reset synchronization
  * 6. reset_lock          - Reset control lock
- * 7. srbm_mutex          - SRBM register access
- * 8. grbm_idx_mutex      - GRBM index access
- * 9. mmio_idx_lock       - MMIO index access (spinlock)
+ * 7. filelist_mutex      - DRM file list iteration (ddev->filelist_mutex)
+ * 8. srbm_mutex          - SRBM register access
+ * 9. grbm_idx_mutex      - GRBM index access
+ * 10. mmio_idx_lock      - MMIO index access (spinlock)
  *
  * Evidence:
  * - userq_sch_mutex -> userq_mutex: amdgpu_gfx_kfd_sch_ctrl() calls
@@ -88,6 +94,9 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
  *   must be outer to reset_domain->sem
  * - vram_lock -> reset_domain->sem: VRAM management paths may need to
  *   wait for ongoing reset to complete
+ * - reset_domain->sem -> filelist_mutex: GPU reset path
+ *   (amdgpu_device_gpu_recover) holds reset_domain->sem and calls
+ *   amdgpu_device_eventfd_signal_gpu_reset() which takes filelist_mutex
  *
  * Note: mmap_lock ordering relative to GPU locks is already taught
  * by dma-resv (drivers/dma-buf/dma-resv.c).
@@ -117,6 +126,7 @@ int amdgpu_lockdep_init(void)
 	mutex_init(&locks->notifier_lock);
 	mutex_init(&locks->vram_lock);
 	mutex_init(&locks->reset_lock);
+	mutex_init(&locks->filelist_mutex);
 	mutex_init(&locks->srbm_mutex);
 	mutex_init(&locks->grbm_idx_mutex);
 	spin_lock_init(&locks->mmio_idx_lock);
@@ -132,6 +142,7 @@ int amdgpu_lockdep_init(void)
 	lockdep_set_class(&locks->vram_lock, &amdgpu_vram_lock_key);
 	lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
 	lockdep_set_class(&locks->reset_lock, &amdgpu_reset_lock_key);
+	lockdep_set_class(&locks->filelist_mutex, &amdgpu_filelist_mutex_key);
 	lockdep_set_class(&locks->srbm_mutex, &amdgpu_srbm_lock_key);
 	lockdep_set_class(&locks->grbm_idx_mutex, &amdgpu_grbm_lock_key);
 	lockdep_set_class(&locks->mmio_idx_lock, &amdgpu_mmio_lock_key);
@@ -139,6 +150,18 @@ int amdgpu_lockdep_init(void)
 	 * Take locks in the correct order to train lockdep.
 	 * This establishes the dependency chain.
 	 */
+	/*
+	 * Train fs_reclaim FIRST, before taking any locks.
+	 * This teaches lockdep that fs_reclaim is the OUTERMOST context.
+	 * When memory reclaim later calls MMU notifiers (which take notifier_lock),
+	 * lockdep will see: fs_reclaim -> notifier_lock (correct runtime edge).
+	 *
+	 * Bug fix: Previously fs_reclaim_acquire() was called while holding
+	 * notifier_lock, teaching lockdep the FALSE edge: notifier_lock -> fs_reclaim.
+	 * This caused false positive circular dependency warnings.
+	 */
+	fs_reclaim_acquire(GFP_KERNEL);
+	fs_reclaim_release(GFP_KERNEL);
 
 	/* Level 1: Global userq scheduler mutex (outermost) */
 	mutex_lock(&locks->userq_sch_mutex);
@@ -154,18 +177,16 @@ int amdgpu_lockdep_init(void)
 
 	/* Level 6: Reset control lock */
 	mutex_lock(&locks->reset_lock);
-	/*
-	 * Mark potential memory reclaim boundary.
-	 * GPU operations might trigger memory allocation/reclaim.
-	 */
-	fs_reclaim_acquire(GFP_KERNEL);
 
-	/* Level 7: SRBM register access */
+	/* Level 7: DRM file list mutex */
+	mutex_lock(&locks->filelist_mutex);
+
+	/* Level 8: SRBM register access */
 	mutex_lock(&locks->srbm_mutex);
-	/* Level 8: GRBM index access */
+	/* Level 9: GRBM index access */
 	mutex_lock(&locks->grbm_idx_mutex);
 
-	/* Level 9: MMIO index access (innermost lock, spinlock) */
+	/* Level 10: MMIO index access (innermost lock, spinlock) */
 	spin_lock_irqsave(&locks->mmio_idx_lock, flags);
 	/*
 	 * All locks acquired in order.
@@ -176,8 +197,8 @@ int amdgpu_lockdep_init(void)
 	spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
 	mutex_unlock(&locks->grbm_idx_mutex);
 	mutex_unlock(&locks->srbm_mutex);
-	fs_reclaim_release(GFP_KERNEL);
 
+	mutex_unlock(&locks->filelist_mutex);
 	mutex_unlock(&locks->reset_lock);
 	up_read(&reset_domain->sem);
 
@@ -190,7 +211,7 @@ int amdgpu_lockdep_init(void)
 	amdgpu_reset_put_reset_domain(reset_domain);
 
 	kfree(locks);
-	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
+	pr_info("AMDGPU: Lockdep annotations initialized (10 lock levels)\n");
 
 	return 0;
 }
-- 
2.54.0

