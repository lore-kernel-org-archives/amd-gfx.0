Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97EFCD98D2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 01:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9BA10E8E1;
	Wed, 17 Jun 2026 01:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CDDSCKZe";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE74110E8E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 01:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkjaTsDIIvRkiXaqnVBYKLAxSXKKh/acuZix3SUVU71ePm0rXt6UFuXrEB7OKiiOKiDHzbMF4khe6EuDp7d81LW7wXyKqfjWYKLhXCwNJSgDTCpVfr6AcQLqp/d4F/otSYFB0vU3+1QjymPDQmgbw1NgNLuwq/rX6cwQ7HGGfdS1lv1YfbpMEwEy5AQAcooanJZcccLxJyCCSMOhM6iQhbBNoicjTLm+pHLx7T8zkXmwiy/HGBEAiwXBfQb1npWLrZvSvLwkBR/lGXNFgNxhl57CNnBUSSYzyy2lXRZXJn1YQyXsAomgKmp3tVw2eFG0MMGmOmfn2SrPal7N4e4V3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNNwA+98643QkLNQQD0bFtAxRv6InttgE4DlO5Yn5D4=;
 b=xLs54yQgMi0I6vJT8WH65NUBhzpaJyX9HbC7IABX+arHJ0ncblQ3qe6yULg2w+uIs+4rMNPiMkn2grxK7y1IvU3Izs1Wr2y+K1lAhDtJTzFTOD0AXRR3tEimX/vznfyOqjWydpGV8lNjpwOv3Wm9xN552MTlBKrrb/UiQrZlmiG3k4XOIX2ZQEVo7T7UNVRm+om6BokiU0SqiRGmmmPV02NIwkT1MM8s+L9WL6wFnkrwK+/ZJwGmlZn5A6nuLtKKMeivJEyCQVNtGsjVCVqcaFZzH+D3rMyjYyvMs1fBoXaAOgv94JrrUBFN7othOsC5Gxf6EJ8iBk64Dar+3F2kDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNNwA+98643QkLNQQD0bFtAxRv6InttgE4DlO5Yn5D4=;
 b=CDDSCKZeoWD6/pP9JAkXB3aiU/DVfGmT9wpa+RSGuS3+U1qeSintLnaCo3FmW/QKNfQGMJBxZOZahnhR0zyBnPy3m0UZkD4vpHct8/+znNMm76yvKrieXd1U4vvVErTC+4F2/tvnGFdV8rP9A7CFUPDYeCT5tV1rMC5qa+jc1/Y=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 01:18:08 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::f) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 01:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 01:18:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 20:18:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 20:18:07 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 20:18:07 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add filelist_mutex to lockdep lock ordering
 annotations
Date: Tue, 16 Jun 2026 21:15:20 -0400
Message-ID: <20260617011804.106764-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e55e4ec-3189-4783-7447-08decc0e4a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: lhHXEnsSf4IhXpHSKWrvuUnlnFjYJmmz87uIL2srohuA3E0UiHjoGMmhn/4p75XR8U/K+7TjZLIk3hSlhNspdcXHuZ+d+rwUn7L1nkWebcX4e8qG1H6pXLJEQFJEv2fU3r9kVeefT8Aqp4SioQeuwu5y7NiLhgV/xkRxWQQso22+XUSpn9b7wEvQhhpAJ/2vh+cz8cxxCtkSNLh5dLuoVeFCR5CgZLKeuqXuPRQnYppraTN1iO2IceOJlflc/5eY0VC/wuCvkl98D3AVAykAkh1pbecKNwwLhWfDyvT8NCb9DZDmNDMhk2n1QBNP0R+ujdYp/5qK/3ahGCKpCDAd+SeKcj+p3zcbWMimxblA1ONvZfjQOnXYaqRh7aFOVMGIUNBzegmZXkDWS0zYLyhODEi+Gw5Apk3KlpN8Oygtd+cXFCHRcTwcooSaxIdAfYRTWAbSoj/9NGymNfK3TocT/+XKfrnKdJtS1VU2Qwpxrue4Xi2RmpLzuoFZCuVQ/+lnu/25vEGjw7bQpkZ2/KV5jbmx8ixAtyIqMgrpk3sc1S8vRpsZk7ARGJYJHyJIS/Xj6fnCwOX0j0FGiAXguxJcwciU0xNUnQjjyY1c8ebFd23KmWjvdUHQ170EZR0EGlNcifNcntlM3Xpn7TZHG6UBcA53Db3voW+Woeau+7FbWsNO9DCxrMMIRf0wfxQnZv492myaOVpHcjfOA+Ytne38/zs0Uh3X34zBi3HJcWu4jwE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ic+bCk8+8/f0rtzQb1ulKoRESFYQ6pMQzGw1hYJ10NT9B8WIbtNCszC0y3DbWA+DSHWi9vkFyXyyRWlzrOKcrcI4jJPJDXOD0abDaSRHC3w+v9t3yWLpCHbfFmwPWvzvNCiK5VANL+0r09QnTxxOIiUUmsL8ngaiWTOoOgl7EIETPekS5JkJbDeQ6R8ztn0nIYZbQ5+k2tsfkO6/37wLE05hn3JkleisFYZuhn+gf/21zPaghgnqhhRL33FRh9GPNdKxSQZLUkhALx7eEgFM9kY+TXPOAGpDP/AJ+EaNoFoeZhZSWqEx1dn1UGmGg8fqQJZ8vIVmTq5nzV+Jx0RxD4/sxk2hOiurh3vOiboJlrw6r4g5RjD4RrEIXC2RmNSmWqkUzhqqy6Wi/sDkZbfTD4Smsf9lvrH9GPevxyqO9Omhei6vZyjMcUfGEjwW0Qm8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 01:18:08.1345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e55e4ec-3189-4783-7447-08decc0e4a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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

Add ddev->filelist_mutex as level 7 in the lockdep hierarchy, between
reset_lock (level 6) and srbm_mutex (now level 8). This teaches lockdep
the correct ordering for filelist_mutex relative to other amdgpu locks.

The ordering evidence comes from the GPU reset path: gpu_recover() holds
reset_domain->sem (write) and calls amdgpu_device_eventfd_signal_gpu_reset()
which acquires filelist_mutex to iterate the DRM file list and signal
eventfds. This places filelist_mutex inner to reset_domain->sem.

Existing filelist_mutex users (amdgpu_gem_force_release, debugfs vm_info)
do not hold any reset locks, so this ordering is consistent with all
current call paths.

Updated hierarchy (10 lock levels):
 1. userq_sch_mutex     - Global userq scheduler
 2. userq_mutex         - Per-context userq
 3. notifier_lock       - MMU notifier
 4. vram_lock           - VRAM allocator
 5. reset_domain->sem   - GPU reset synchronization
 6. reset_lock          - Reset control
 7. filelist_mutex      - DRM file list iteration (NEW)
 8. srbm_mutex          - SRBM register access
 9. grbm_idx_mutex      - GRBM index access
10. mmio_idx_lock       - MMIO index (spinlock, innermost)

Requested-by: Christian König <christian.koenig@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 29 ++++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
index 61450af539a6..b251350b1fb2 100644
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
@@ -154,18 +165,21 @@ int amdgpu_lockdep_init(void)
 
 	/* Level 6: Reset control lock */
 	mutex_lock(&locks->reset_lock);
+
+	/* Level 7: DRM file list mutex */
+	mutex_lock(&locks->filelist_mutex);
 	/*
 	 * Mark potential memory reclaim boundary.
 	 * GPU operations might trigger memory allocation/reclaim.
 	 */
 	fs_reclaim_acquire(GFP_KERNEL);
 
-	/* Level 7: SRBM register access */
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
@@ -178,6 +192,7 @@ int amdgpu_lockdep_init(void)
 	mutex_unlock(&locks->srbm_mutex);
 	fs_reclaim_release(GFP_KERNEL);
 
+	mutex_unlock(&locks->filelist_mutex);
 	mutex_unlock(&locks->reset_lock);
 	up_read(&reset_domain->sem);
 
@@ -190,7 +205,7 @@ int amdgpu_lockdep_init(void)
 	amdgpu_reset_put_reset_domain(reset_domain);
 
 	kfree(locks);
-	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
+	pr_info("AMDGPU: Lockdep annotations initialized (10 lock levels)\n");
 
 	return 0;
 }
-- 
2.43.0

