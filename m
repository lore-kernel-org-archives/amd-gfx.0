Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76B1C44520
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 00:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8A410E225;
	Tue, 21 Jul 2026 00:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="49tFYfwS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A072110E225
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 00:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bChC0QJdc3H6tSw6cyH2OQkax7FKd/TCBImyCUD6r5K8Gs4ejK8IKNTJLdXDH6JXPm4BKfhVJGiES4tWYmEVxS2qnexUi4JoosilGYiAm3IT6mr2FiZcSymTvu/JH6RRGQTjafTtLm0ce6ypSZSTmFdKHGcFgg1bMtIIhUh4k8RXPLJomuYWHmCMvuNzNtDClyb3MNeWDmrmsLJMmn5KAk9e81oDPkMcZaZ+muRnoyCqV0mDK0UX3nRJDcL3K/0sUTh9ttbIsQlcbiJa5klTQ+sowRmNvMUEoF7VGck+5gbbN+LQ57BSSJ3qj7q5UrUK/44HwH+aQnQ4OTNNjjUHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNuAQFcoKRoFDk1EZUg888ihjK6F+AMF49adB+bef2M=;
 b=Wz+I3503Q8I2FFinW4eu69hUQQHi9Hlzrw/wbjrdbTbmYUVtK9uPgR+ZmyHVKSdYutRWm096NtULFsLTY/z0yoXvkKYATmameWM8GKDqrMzsj4jRVkS2sm6HmgYlx8tVldHLhrjW/m1VEYhKjxQwdqSj9sJzLh5xFqBoi1ux+hhF0AOCARZLARnjH6dYMSPRBAnqnU71qZmxQ4swenQvl3MsMncw8TFSjrnKZOZjnvw2XxwS68sNColGLVeOcVB4kdCW2dNdRXJ4Khvywbt6Dgoxxyas6Nymx93dZ7z3jlB5YBk16UzN0BYwaePsd1Go+zoSaFT92cT5I/+xgrDnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNuAQFcoKRoFDk1EZUg888ihjK6F+AMF49adB+bef2M=;
 b=49tFYfwSTaioY7MY0oLqrwVH++xbfg/CYeLh8ho6iFLCRqaBL99+iLqNfAvFLGRkljC+B1E6xpdG2aUpqzsnn7H6806942J9m/xbr8aM4MNO8b/MjqnAFWHJ+PBT9wFxv8VNSxvtWaxCRDI0KB6v+G6cH0G6HfPEduyrWvuNE6M=
Received: from BN9PR03CA0459.namprd03.prod.outlook.com (2603:10b6:408:139::14)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 00:18:56 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::63) by BN9PR03CA0459.outlook.office365.com
 (2603:10b6:408:139::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Tue,
 21 Jul 2026 00:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 00:18:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 19:18:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 17:18:55 -0700
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 20 Jul 2026 19:18:54 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add filelist_mutex to lockdep lock ordering
 annotations
Date: Mon, 20 Jul 2026 20:18:03 -0400
Message-ID: <20260721001851.113927-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbda9d4-6dce-4e9c-00b3-08dee6bda6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 8EhQW7nYXVU8HMVSjy0zU9oAbO7x41Iwd4tPX9Vn11Ng1QKjKmx1Z/5wfUmU03kElUamuYKyREREb8OljzFszxEaNhuAPcrAhX5PLWDDjM0DDH8DQXo9QppbgLjCSKPpsgf02RbZKMqsHXKlj8fwqzWcVczDYTFcad8WF6lTRKl8oa5X2EAtUNb00A8ivleQw8FU6Lp+a/mYZagfMHQEEYgOTtNvWxR4O24cdvSy7XxkLOxhor5wZ9rvgAzLNPMovu1bp9fv4pi2LE1gmBgB8CBDnaZUn6YFhcKhjfXc/iGQkwaba3Ywxn2mcasIHEeR6vFE5qMAZ/wO3g6nIYFD+YEWkgKei3Gn8zsWl89eI0+EDt9QFAogwPMnA7f8onhVIzV286Y7xP8vPhSDSWOl69QOGaDASvp4i2nJeaaXs4BPtVtEEV3zgsIgL06UDBxpvKfHA8Lo1T4HbQ7QE3AlTJEfYNekdBZOUJ4B/JqPhk5aCMNN5B2l2yHfnOi//yqbFULYZg/9+0mmt66CcpvMTy1X2AjLvmdJQ1YcRsE2MModJl6/cHIgZpOQtMQluXvHbXx0OfzwGwWkiM8XmLiCF1AloJcpt00P6ddgtXpDQ5JsDT9Hyt9VvyxdkgDzGarW4LmAat1xIoQYgWC0sWoBVMZEI7syi/Xfh27nTzkRWSjrJLb8vPZt8FbW5KzVK2CTziD27HQYN8vvxQJz1sQpKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T/XIBVwn78ogpH5fVPWQfxrCyjKP99S8JxLvRkEr3qAR/xoalVCp4z1Zj9QGgmDOOWCyEsCNCk3GCH7ex6/G+9GCBQlbvUQYWb1bq+tf6+/hy6eJiQZoDGl8h7J9tfqrylmPVcrlbaxTl7+GjtlXbwSN8rqUgsVY4njZKXm9OJ8a0nfagZYeUazWDnTSIWhbn+9PiZ79t6jJqNn+c2TiZ/pbjl7oKdnxsRqkVyMX2XQMbcp/oWDfBomCCt3pHOeHQsYuOefnKrT6cWM3cP3B6mo8q+a5X/n1qDVmidTcIYN4x7TMjwKm2UeIbeirSQRv3dSb+5HBGaZ0RtUJjISZWHYMfXjnnp4PslaqboRqtLLWpPEMQ+ZAjPS7UcSlFNgpE0lr8Pqro1Re69CV53JI/HKib52gimpoU4JwrDTaP5z7nMH3TMPRdDNHyEjWhjWV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 00:18:55.6850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbda9d4-6dce-4e9c-00b3-08dee6bda6f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
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

