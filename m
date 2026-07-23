Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08589C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 22:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9295810F23C;
	Thu, 23 Jul 2026 22:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oBd6IDIk";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECC010F23C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 22:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/C+tgyJS/TMbf8mJMFJowuDT7ji8rggbq1+vgsQsdoR/unLfcuu50x4iwdax/IsSBYjTtWa2ETOANkrSw0cUqCII9wrVkzcxjHlM8JgmsH+SMPtqZ5fOJW0X5+fp+YsaFV52ROqDm15CXOkNYyAwHcA8OuPcnofS8Mg5QzVNjQJE65pkN0zMR4ycYzhCOE7O22lU0Ipw7SG8TQ/oWs1CfCW4/0DAMeO9Pg+6sV9lsleGgKD6mIIWq+N4Le3SLra85SPsRv/4NfddWC4JjbxaMScRhomxikl1xvmBreNqsZVWiN+eJRrhrVCBrRGxOdxbDrh5Yr49NhGReRT2k4Z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1c6z9f6sLL+TvcHl9Z7IvSuUR4rjr7UaJayrwU73hw=;
 b=K404yj6ZmSiWAQpRgB8NLZpJH1zA2kdKF1sgghJtZXDtMejFy51UT/3tbLgtDWot6Jx3Uffqr0lJFUMC9ODSixjByzmYBxw2vzYh7z1ivGSkaHKMTI52zN51jn6RhvqkSj4P+RdXabtUOzGYnlccYBxDIKg9awvdOe0gEejDIzu5ueI7noyNHOSM0sg1JQ7n90U/DdYzcoOcpzFwFnLQDR+5ZfkYgdw4t8j3vSTnDdurv1numLrG0SaNeu+nOq12DV9cWpo0wDeoZ8RYXpfJkrvrSAMg9CkkQX/AyWbsi/HwHJAoDi/s5rPPLk3CbRoaHkm8K8r5y23XjNkT4dnkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1c6z9f6sLL+TvcHl9Z7IvSuUR4rjr7UaJayrwU73hw=;
 b=oBd6IDIkxGnohhGfHgSusEqsL+7DwAnPp9JoJKYkfdEOfFwiUuVtqZJ4lzKkqDUKmvpajz28JbG1r3Xw/CA5Q7CmNibN8vzwh/ds9tOv03NPlgJBuzxPaQ/mJ3CnXUp5d+VDHRKa/O2ynSipeXfuNkJX3MkpSVUaSu6O65/gpZI=
Received: from SA1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:806:2cf::24)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 22:19:15 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::43) by SA1PR02CA0024.outlook.office365.com
 (2603:10b6:806:2cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 22:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 22:19:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 17:19:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:13 -0700
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 17:19:13 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, "Arunpravin
 PaneerSelvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: add filelist_mutex to lockdep lock
 ordering annotations
Date: Thu, 23 Jul 2026 18:18:42 -0400
Message-ID: <20260723221910.85822-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723221910.85822-1-vitaly.prosyak@amd.com>
References: <20260723221910.85822-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: c53ff054-8ac0-4690-2b69-08dee9086e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: kqITlb29KhXmK701xVbCrM3NqBbOkbTR0YA+P9BHFm6YVygNgtXG1G/ZuB2cTm+uudgO/HTw7lso/Wr1VRPRzpB7I2m+U2seZTWygBe3ihwPM1tuh1XQASR57HKvygPuRk5olRk9EJAzr/xB/Gky0SEzXNim6Ig4XcfwjxBbvf0fvJKG82yt3B/LjatQ1LmXth40lZqEn3pgWBjyNDNqtYChBNN81hdxM6cZjNVe5sPDLFq0jDrxgBCD9KBlyD72fb1b3RNR5qogSLUBKg4/SycBsLiqIneqKbayhI+Kbwhz25k+LsjPg4IknLkabCywOZdXpJSBs35TgHGRFmE8cN3oDsKC/vhSitTD0cuWeNdISeCIXxMYttKWLGDJO8tyG7izd78hdMz27WiVtZi6KNbNCtbHH7EvSfYQ7t8ky3YF44rxBakHqhvVApDZccLLq3IFIp0aIxipzKIyWaJRnCMDNQbp2nTHGyPkf7ExCRf9KynNCfHNuCO9aw4Iy4TMExxgc9dWGhDY6h6M7fpKA4FNCa8+NDY0KzsqJOWt9nMfETX0x2JPwEWBzSvgVK8VBbeCNvD7h6FPg6i7ycnhagHmFA70ylwoVfCGS7u4FEQXF4R9VG/lBUQFSp0FPeKO/xUWOtf8u5kW5YFE6yBKaqUqyQDVRUdDI92HFep9GpeEpv8ba5jioPwAK5Hgd+lxHLhJERXUM8jTPfeipJpsEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BgadMUN1IIi77YOSi5it9QX8C84RAE4eJUcyRSjIBhQJMpZ5m9aVsQ5fHwPpKWhHWi0AbeIJwGEnZ9+r52XBScggmXIr0LiJ9gLi27xPFAO/okTz14fVWk9/QXwZfIVHXEtUxYHyEzKxjj8IFgAoIi8fFCDlljQ68eGK+KxBLvXCknyfA93Te+MsaLIDOyXaATrK+5TrDpzSjK/gWGfKXqX9vHgDM7QXR0lttk58Pbn4FSfY77VtVpCl7h5/pSR3Kdj4q/6FW48H66qY2JvETRQTvBI00zmucamjwC6Ke+DLLFLjHCR2gSwcyhw5TvsQzMiKY8UMb+sEyar+IhDLCl9r0XKvcsfoVy9zqnXrG+rADML3Lv4kxefIXlCgM+gQDO2oJNzl+SyUDHogREcFq+HHCBdRFvYJS0JBpBhBPdrXtQ+Ehe5A5mOHwIpylsEz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 22:19:14.9881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53ff054-8ac0-4690-2b69-08dee9086e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
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
Cc: Jesse Zhang <jesse.zhang@amd.com>
Cc: Arunpravin PaneerSelvam <Arunpravin.PaneerSelvam@amd.com>
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
2.54.0

