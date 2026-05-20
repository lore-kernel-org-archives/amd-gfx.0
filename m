Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD48CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 01:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8686F10E1B4;
	Wed, 20 May 2026 01:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tLYqeqCu";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFA010E129
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 01:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0dzx0bbyS/mNanY8vbmeAezalMpHLfe15GsEJZwxHMHDqB+G+bjcmQAOEyrqQCudPwaqn11SB7up/TsuBOlGT1DG5zJ6MFvNeY9gAA1xhH9C66eCkR8w7ER16uZvWpD+22XT60BjWARGwhWktzTIdxFq9RG2XOsUX/v+xoG/wgOTpNJjEDwxmwp3Y/wc23bEVJcmjHjumSDomSU7P8Dy/m4pTOjgxuMvv/6JtSmHpuwxCIaqPQwZrpgdIcvdI4t9wofupVBpUCQ/bAuqUKOf2xHwYVcw2WbGF7OM1ydi2Mn6ZozKhNOHnQ8DzRR7qdNb8aWH9xsJQQxXKi3sssq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA9E50T3FYglHQnbfJ27kJCSYaJjf0pd4UjVmXJFY6I=;
 b=GuMLRE6r/A0FRZ2EfQOj+YK7zUdU+5Zfts/mnEommyUKbMjqRY4KrLgm5BjHyaQkqEPyMD2GAn2iD93OS14C11u+t6sHH0ui+gHNc1mNARk3ZCuf7DXtU6NkBg6GkAcXnEPkVHambu/gzrr+hsS+K3IYdB6M6kxGxuAWCykCoUuHi3sYOFnAhr8J+CCiE6KTVxvqaJInQkoFN/sec+RXjWMEbZ9Kznfbhrh4b5eTrkf9jk9/8EHf6nzrY6vX8bH8fgzrtfedSBR+gu0MfJ1Mveq04yZ22Kc5NzgYPEmamrX3BTDqS2VW+ZoqKM0+MHG14qmLrJ1pAAuMNYDZ7EYH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA9E50T3FYglHQnbfJ27kJCSYaJjf0pd4UjVmXJFY6I=;
 b=tLYqeqCuEmiZ55sVKgSfLrw7sg77Xh2SbNHC2XBI9imnCGKcsdBmSDxt0mb/kClHsqUc2yoQuKdPwa7fGB/kpyeX2mrLzfO8I5AqrQMLMTXQUoXUCG/q0Uhfvp6sjbY8eu7g70p8RaKuCyUWKSMMusW9zvEuyVTc5o6E4ryHqAQ=
Received: from PH7P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::24)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 01:56:16 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::c3) by PH7P221CA0027.outlook.office365.com
 (2603:10b6:510:32a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 01:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 01:56:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 20:56:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 20:56:11 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 20:56:10 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add lockdep annotations for lock ordering
Date: Tue, 19 May 2026 21:55:10 -0400
Message-ID: <20260520015609.127747-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: a95f9a33-6f44-484d-5d5c-08deb612fa03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qyGIa0hpwYHiZgfRFCnLH4Yr2fA8OQbRY6rsuxT+cQD8/LgcBKu7eW+MK5ORoEggLIQux406M8WBDf3kCUP3QJUzcvHeZPOlN3TC9BsBkk6sDcoSbdl/8gpUvpxJkqSNPovo/s8cLm0DOq7Wb6+8jURKtmL5DFY0JxIQ/TUY/FkI1Ge8I5Hq4yBZkjvm6pGRlvOqYWx2Sb8w0Cxio+l48FQM8F6WEbyN3GDfFmOzvmH/wqWOGpdZLpOO0+ejlldErgl5QiiUM9Ko/gknuWh/YrkWB4HqD6aoJAUlLA87ijISy1WUrAcXIuy9ZJYfhaZPYthQ1TKUD5uB7p2Spkb6zfEi4mnDD8Hde4snuazpguwxV48Tnvpwjwb6teu/DE2rg+COp7fN5dYC9D2UnJVtiolFS7ARy014Clt/uTGJ//hj1Yi1GVBaZddmdVrrPL07+zSHaN0uk4Zixx24xQ/m9CC3xJmV9HsscEKzCENsNGfe56Skd0eKpJP+dN103fWtGYvjvIkbrgYj9PX0pVl6ZDOzS8XELlH5qjljFTPZ8xpXx4tynqeyb+P83vBsHcrR7yhqwDh0tDbK5VKjtye9OWLk9ks8rjEDqhSzRB2kUWWXwhrtFo1mQmHTCQRTixPJIwE4nSu2YtHM1Z4B0SLQtX7Cpg8T0pE8Dw0/n3JopkRh2qUzrHaSUOsbfXfC8Ejsp5X6jNVeyFC/0clp3r26VDOYVG5tqRWsnc2yoAyStLc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XaZv5VtbbmjQdOQdNhfT5HxfocySH5WVkV4P0/d+7Ua7jp/O9bk089hmGe7Q1btKI+wpFpCl9FWqFpmRLLf5QWoHA2dTeIKEgXZ+c1TSoBC+KL/PjUWjl9rH8iXT7rZpyl0KAV5hBihX7oWNI0TZIM+fy8objhYF06npX291VqrrNJTMDd2r6YVJB62sqDfw+ZWdMrXLq79mNRHludc28SKbEgD/eWLipHiKnuUvXRUmeRTO3tecbaYnI/X5ueZUdA9A5gxdX+7EVDXQRBJpWB1xYMc/WEyKTreujw4jrODLOBz/f0XFpvxygX+pngDdrdY30z+JXDXXaFPdNf4Hpa38JFWOLRSEf0yjs6oEaFGWvkx5+CSZjBdZu+kfifxvCXiKbq5QR/e5NyuC/jIMLRrSJ9Kmvf7HA0cTCVfNYedITnCrFgk9qJWLe9k7OXF+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 01:56:15.2767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95f9a33-6f44-484d-5d5c-08deb612fa03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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

Add lockdep annotations to teach lockdep the correct lock hierarchy
and catch ordering violations during development. This follows the
pattern established by dma-resv in drivers/dma-buf/dma-resv.c.

Lock ordering hierarchy (outermost to innermost):
1. reset_domain->sem - GPU reset synchronization
2. reset_lock - Reset control mutex
3. notifier_lock - MMU notifier synchronization
4. vram_mgr->lock - VRAM memory allocator
5. srbm_mutex - SRBM register access
6. grbm_idx_mutex - GRBM index register access
7. mmio_idx_lock - MMIO index access (spinlock)

The implementation provides:
- Lock ordering training at module init (amdgpu_lockdep_init)
- Lock class association for real driver locks (amdgpu_lockdep_set_class)

Requires CONFIG_PROVE_LOCKING=y to activate.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: I1ff16ea256214d5599888e87d2320f24948d4f31
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 175 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h |  39 +++++
 6 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee3574797bc2..ba80542ead9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -69,7 +69,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
-	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
+	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0408476f1070..e276508ec704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -105,6 +105,7 @@
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_lockdep.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ccbe6c885cf..159882f5fdab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3739,6 +3739,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
 	mutex_init(&adev->gfx.reset_sem_mutex);
+
+	/* Associate locks with lockdep classes for ordering validation */
+	amdgpu_lockdep_set_class(adev);
 	/* Initialize the mutex for cleaner shader isolation between GFX and compute processes */
 	mutex_init(&adev->enforce_isolation_mutex);
 	for (i = 0; i < MAX_XCP; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4d4d21babc61..0df6b2a3afdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3159,6 +3159,9 @@ static int __init amdgpu_init(void)
 {
 	int r;
 
+	/* Train lockdep on correct lock ordering */
+	amdgpu_lockdep_init();
+
 	r = amdgpu_sync_init();
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
new file mode 100644
index 000000000000..55e99ed1e677
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Lockdep annotation for AMDGPU lock ordering
+ *
+ * This module teaches lockdep the correct lock ordering to catch
+ * potential deadlocks at development time rather than runtime.
+ *
+ * Based on dma-resv lockdep approach from:
+ * drivers/dma-buf/dma-resv.c:dma_resv_lockdep()
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
+
+#ifdef CONFIG_LOCKDEP
+
+/* Lock class keys for associating with real driver locks */
+static struct lock_class_key amdgpu_userq_sch_mutex_key;
+static struct lock_class_key amdgpu_userq_mutex_key;
+static struct lock_class_key amdgpu_reset_sem_key;
+static struct lock_class_key amdgpu_notifier_lock_key;
+static struct lock_class_key amdgpu_srbm_lock_key;
+static struct lock_class_key amdgpu_grbm_lock_key;
+static struct lock_class_key amdgpu_mmio_lock_key;
+
+/**
+ * amdgpu_lockdep_set_class - Associate lock class keys with real locks
+ * @adev: AMDGPU device
+ *
+ * Call during device init to associate lock classes with actual locks
+ * so lockdep can track them properly.
+ */
+void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
+{
+	lockdep_set_class(&adev->gfx.userq_sch_mutex,
+			  &amdgpu_userq_sch_mutex_key);
+	lockdep_set_class(&adev->srbm_mutex, &amdgpu_srbm_lock_key);
+	lockdep_set_class(&adev->grbm_idx_mutex, &amdgpu_grbm_lock_key);
+	lockdep_set_class(&adev->mmio_idx_lock, &amdgpu_mmio_lock_key);
+	lockdep_set_class(&adev->notifier_lock, &amdgpu_notifier_lock_key);
+
+	if (adev->reset_domain)
+		lockdep_set_class(&adev->reset_domain->sem,
+				  &amdgpu_reset_sem_key);
+}
+
+/**
+ * amdgpu_lockdep_init - Teach lockdep the correct lock ordering
+ *
+ * Instantiates dummy objects and takes locks in the correct order to
+ * train lockdep. This helps catch lock ordering violations during
+ * development.
+ *
+ * Lock ordering hierarchy (outermost to innermost):
+ *
+ * 1. userq_sch_mutex     - Global userq scheduler (enforce_isolation)
+ * 2. userq_mutex         - Per-context userq (held across queue create/destroy)
+ * 3. reset_domain->sem   - GPU reset synchronization
+ * 4. reset_lock          - Reset control lock
+ * 5. notifier_lock       - MMU notifier lock
+ * 6. vram_lock           - VRAM allocator lock
+ * 7. srbm_mutex          - SRBM register access
+ * 8. grbm_idx_mutex      - GRBM index access
+ * 9. mmio_idx_lock       - MMIO index access (spinlock)
+ *
+ * Evidence:
+ * - userq_sch_mutex -> userq_mutex: amdgpu_gfx_kfd_sch_ctrl() calls
+ *   amdgpu_userq_stop_sched_for_enforce_isolation() which takes userq_mutex
+ * - userq_mutex -> reset_domain->sem: amdgpu_userq_create() holds
+ *   userq_mutex (via ensure_ev_fence) then takes reset_domain->sem
+ * - reset_domain->sem -> notifier_lock: reset path can trigger HMM
+ *   invalidation
+ *
+ * Note: mmap_lock ordering relative to GPU locks is already taught
+ * by dma-resv (drivers/dma-buf/dma-resv.c).
+ */
+int amdgpu_lockdep_init(void)
+{
+	struct amdgpu_reset_domain *reset_domain = NULL;
+	struct amdgpu_reset_control reset_ctl;
+	struct mutex userq_sch_mutex;
+	struct mutex userq_mutex;
+	struct mutex notifier_lock;
+	struct mutex vram_lock;
+	struct mutex srbm_mutex;
+	struct mutex grbm_idx_mutex;
+	spinlock_t mmio_idx_lock;
+	unsigned long flags;
+
+	/*
+	 * Initialize dummy reset domain
+	 */
+	reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE,
+							"lockdep_test");
+	if (!reset_domain)
+		return -ENOMEM;
+
+	/* Initialize dummy locks */
+	mutex_init(&userq_sch_mutex);
+	mutex_init(&userq_mutex);
+	mutex_init(&reset_ctl.reset_lock);
+	mutex_init(&notifier_lock);
+	mutex_init(&vram_lock);
+	mutex_init(&srbm_mutex);
+	mutex_init(&grbm_idx_mutex);
+	spin_lock_init(&mmio_idx_lock);
+
+	/*
+	 * Take locks in the correct order to train lockdep.
+	 * This establishes the dependency chain.
+	 */
+
+	/* Level 1: Global userq scheduler mutex (outermost) */
+	mutex_lock(&userq_sch_mutex);
+
+	/* Level 2: Per-context userq mutex */
+	mutex_lock(&userq_mutex);
+
+	/* Level 3: Reset domain semaphore */
+	down_read(&reset_domain->sem);
+
+	/* Level 4: Reset control lock */
+	mutex_lock(&reset_ctl.reset_lock);
+
+	/*
+	 * Mark potential memory reclaim boundary.
+	 * GPU operations might trigger memory allocation/reclaim.
+	 */
+	fs_reclaim_acquire(GFP_KERNEL);
+
+	/* Level 5: Notifier lock */
+	mutex_lock(&notifier_lock);
+
+	/* Level 6: VRAM allocator lock */
+	mutex_lock(&vram_lock);
+
+	/* Level 7: SRBM register access */
+	mutex_lock(&srbm_mutex);
+
+	/* Level 8: GRBM index access */
+	mutex_lock(&grbm_idx_mutex);
+
+	/* Level 9: MMIO index access (innermost lock, spinlock) */
+	spin_lock_irqsave(&mmio_idx_lock, flags);
+
+	/*
+	 * All locks acquired in order.
+	 * Lockdep has now learned the valid dependency chain.
+	 */
+
+	/* Release in reverse order */
+	spin_unlock_irqrestore(&mmio_idx_lock, flags);
+	mutex_unlock(&grbm_idx_mutex);
+	mutex_unlock(&srbm_mutex);
+	mutex_unlock(&vram_lock);
+	mutex_unlock(&notifier_lock);
+
+	fs_reclaim_release(GFP_KERNEL);
+
+	mutex_unlock(&reset_ctl.reset_lock);
+	up_read(&reset_domain->sem);
+	mutex_unlock(&userq_mutex);
+	mutex_unlock(&userq_sch_mutex);
+
+	/* Cleanup */
+	amdgpu_reset_put_reset_domain(reset_domain);
+
+	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
+
+	return 0;
+}
+
+#endif /* CONFIG_LOCKDEP */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
new file mode 100644
index 000000000000..04adb58665bf
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Lockdep annotation interface for AMDGPU
+ */
+
+#ifndef __AMDGPU_LOCKDEP_H__
+#define __AMDGPU_LOCKDEP_H__
+
+#include <linux/lockdep.h>
+
+struct amdgpu_device;
+
+#ifdef CONFIG_LOCKDEP
+
+/**
+ * amdgpu_lockdep_init - Train lockdep on correct lock ordering
+ *
+ * Call once during module init to establish the lock dependency chain.
+ */
+int amdgpu_lockdep_init(void);
+
+/**
+ * amdgpu_lockdep_set_class - Associate lock class keys with real locks
+ * @adev: AMDGPU device
+ *
+ * Call during device init to associate lock classes with actual locks.
+ */
+void amdgpu_lockdep_set_class(struct amdgpu_device *adev);
+
+#else /* !CONFIG_LOCKDEP */
+
+static inline int amdgpu_lockdep_init(void) { return 0; }
+static inline void amdgpu_lockdep_set_class(struct amdgpu_device *adev) {}
+
+#endif /* CONFIG_LOCKDEP */
+
+#endif /* __AMDGPU_LOCKDEP_H__ */
-- 
2.54.0

