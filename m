Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87564CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 01:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C88810E088;
	Thu, 21 May 2026 01:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rDqHYbhc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1759E10E088
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 01:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNm+rpr6VDBa0kUAg4gDWkyOfQKreWP9HtlRZcNIH2oqDzbIMkn4mcMO9UV9OUYH7p8HCKBRw26GUpk+YoQD39K7mVfyT5LQeOwPyn1EnyCh9TzHpvfB/ktsLoWeLT0dMdLwex0HghPAYKEVp8yiT9h+8cNKIUzRXP3oH3kIagvG9y8YlfimXt49CVP6GSWTajY49mUyvq60bCd8iFOczmHLIt2jp9Pky8ZyW2JA2ouPfhvq6iQumG+q19A+7fwCwP+2lXWaxrOdBEYPx9jYF9zQwgLPHtA0uk4h6w2Mcnc3fB/uHpeBcIO3I4vhN/Koor+BmVFZtNK7ERSGhywgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAPReCzjaHZk3TnhnAtEb3xY82DUMv14xPwBSY1Aa9o=;
 b=ft2Ylr7LxBKd505XYhe3oZUKzY9+UFzVPSUNvOJLluTG9gt8sukKL98/A0KKPzW8xcssaGtxk9K9SJ+amTrhXUeILd65TyLprIu5KNvwDQa3h64iBUyMiqbbOrrdvYqefeq/v1nwreDFVXp501OSIFFwxfa/krGzTjvsavc8mTvsr9HemHU9AvpHCO/0yfdAE0AUYwc8mVY1pM+TYLVJxEijHGNJpJFOLdVWGA5JJebtzXn0g9C5w+OMNcmyW4RRtSVWYxVwElHg/t0zV9jT1+7YzKA6UOJNAyLZUWJWIdy+wL3W2xEu85xZQTBrmOhPpXindv/qsz0rbRODQC3oig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAPReCzjaHZk3TnhnAtEb3xY82DUMv14xPwBSY1Aa9o=;
 b=rDqHYbhcfspXDXYk/MgI+BpPmXtvodq8ebJ544S54fIPuPmqvJx13q46kYnoQ/0f2bxUe4lS+bpLJ5QSRniDzueYDrj/c5kG7SR312rAeuQv8WixEn86GEv20bJQNAwDOGAln4Z99CAF1ysyufKe+YNIWxb+BZVIQ+JoSGcSuuU=
Received: from BLAPR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:335::6)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 01:51:23 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::2) by BLAPR05CA0025.outlook.office365.com
 (2603:10b6:208:335::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via Frontend Transport; Thu, 21
 May 2026 01:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 01:51:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 20:51:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 20:51:22 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 20:51:21 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Christian Konig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add lockdep annotations for lock ordering
 validation
Date: Wed, 20 May 2026 21:50:45 -0400
Message-ID: <20260521015119.149698-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b50906-6ddc-4c95-e72e-08deb6db7606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|18002099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info: ThwYheKrpgcdw+cTNLywz9ArKn5j9vnVFehmCRVSj6A+tQcIbYVmjkreiumtLr+9U8VJSsYNkEuQpJeHPNUMjS4hM1WccTNm5T/O0/9NhUlMFmV+/iKyoE3ORI1BUhKQ1+s4GkXfxubfMA4tVkFvtWG2ytB6ctzGrBDNr8DKZvac2D+hxT3qgVcJ+hZUkhu1yk2Td5nb5zkWUcg/8YgCLsN58Jz4dcwM6eHqr9MwV5aUFaPNMmF9CrAWpqN3qo0P7o5m08vQ3HlPWwr151dhaI0NnvI2PRFzRo6+QKefswUT4iI6Y9Ln26iKEqdhNQ0j7lvSoDuteo0MXI9pVS7/RXdeT01Zdfq9X1nfYvFpD+QPlFkf2YiXhehBJxPICMMq6r/Bg98lDL1eYHL+eCyGRbwjeydxGU0YZxJDT42xKdbZw5kgfUAbufJMtGPaQImqbYI5w7SEfjIOjMEZysTY0fSFWd7Yj9roWFHjKpmRXMgsJGgPfEob7dS9RQVW3SYQ+ops1LO6oRxmdRgVf6Pef2s6MZuG0mRupY0KUR1eY6k2ZXNo/cQyLjmK9rhcr2x9JZsAzIuCHVkwfStxxJRNmTTnNXnYFPvfLvh4SY0OXVyV3q3Cg7D3sYAsoCNZtOdwB4Z5Sz8TcC8GTwohixul+WJw0VNGpUmhQeX/nhjk1iyX4LWA5z9xevcZSbvwYJUVW1+EEZMBOWQxSqL6NM5/oc/TCxXhrzN0r87K/ymVCbw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(18002099003)(56012099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5xGE/dBHLSSsndPKTEHvQL4Jyg+5WNHvCfW8qrFkkiBOea0tsztnIgU2jmUONRdQ3eZJG2DUfBOzK2WNJZobhatBXEyhhzQ6LnpF5Xsh/7gmk8SD+jB+Sgp2hh0SrzFNIqDvDlV8wMGDcdHUmI2UzmkC5tXBFR4XeJmZwhoPWbwICe9g5fLivEqjwrP0N8q7Gl5lkAS056Gy+J706PNqZi1GZuXPWQTZrsgMi7+JDzngjWXOHtGZMRM++h6tPjUDw/3Orse4xQlu0FRunMiEJobxv30/lSnlmhhKSPXhITt7nHU9luYQx0/ALebIBg+N/tqsr4Tk7N8mHc6Af6db8p30DKYeBVZ3R2/rcNAs98OTxD8KZPDMBxT59BnAhY+fKwwe7Iw2YMNs8xqIvmvozPWKIgNZ7Qhs93Tud06Px3a0q31LRR0xcQfcYkoigmKZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 01:51:22.7023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b50906-6ddc-4c95-e72e-08deb6db7606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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

1. userq_sch_mutex   - Global userq scheduler (enforce_isolation)
2. userq_mutex       - Per-context userq (held across queue create/destroy)
3. notifier_lock     - MMU notifier synchronization
4. vram_lock         - VRAM memory allocator
5. reset_domain->sem - GPU reset synchronization
6. reset_lock        - Reset control mutex
7. srbm_mutex        - SRBM register access
8. grbm_idx_mutex    - GRBM index register access
9. mmio_idx_lock     - MMIO index access (spinlock)

The implementation provides:
- Lock ordering training at module init (amdgpu_lockdep_init)
- Lock class association for real driver locks (amdgpu_lockdep_set_class)

Dummy locks are associated with the same class keys as real driver locks
via lockdep_set_class(), ensuring lockdep connects the training ordering
with actual runtime locks.

Testing:
  Build the kernel with CONFIG_PROVE_LOCKING=y (enables CONFIG_LOCKDEP):
    scripts/config --enable PROVE_LOCKING
    scripts/config --enable DEBUG_LOCKDEP
    make -j$(nproc)

  On boot, dmesg should show:
    AMDGPU: Lockdep annotations initialized (9 lock levels)

  The companion IGT test (tests/amdgpu/amd_lockdep) exercises lock-heavy
  GPU code paths concurrently to trigger lockdep warnings on violations:
    sudo ./build/tests/amdgpu/amd_lockdep
    sudo dmesg | grep -A 50 "circular locking dependency"

  IGT subtests:
    concurrent-reset-and-submit  - reset_sem vs submission locks
    concurrent-mmap-and-evict    - mmap_lock vs vram_lock
    concurrent-userptr-and-reset - notifier_lock vs reset_sem
    stress-all-paths             - all of the above simultaneously

  A clean dmesg (no "circular locking dependency" or "possible recursive
  locking detected" messages) confirms no lock ordering violations.

  For CI integration, the test should be run on kernels compiled with
  CONFIG_LOCKDEP=y; dmesg is scanned post-run for lockdep splats.

v2: (Christian)
- Move notifier_lock and vram_lock before reset locks in hierarchy.
  HMM invalidation holds notifier_lock and can wait for GPU reset
  completion, so notifier_lock must be outer to reset_domain->sem.
- Associate dummy locks with lock class keys via lockdep_set_class()
  so lockdep connects training with real driver locks.
- Update commit message to list all 9 lock levels.

Requires CONFIG_PROVE_LOCKING=y to activate.

Cc: Christian Konig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 195 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h |  39 ++++
 6 files changed, 242 insertions(+), 1 deletion(-)
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
index 5d7bfa59424a..7b09410d6d8f 100644
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
index 1781c0c3d010..bf4260269681 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3158,6 +3158,9 @@ static int __init amdgpu_init(void)
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
index 000000000000..d5d71fd7c70d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
@@ -0,0 +1,195 @@
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
+static struct lock_class_key amdgpu_notifier_lock_key;
+static struct lock_class_key amdgpu_vram_lock_key;
+static struct lock_class_key amdgpu_reset_sem_key;
+static struct lock_class_key amdgpu_reset_lock_key;
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
+	lockdep_set_class(&adev->notifier_lock, &amdgpu_notifier_lock_key);
+	lockdep_set_class(&adev->srbm_mutex, &amdgpu_srbm_lock_key);
+	lockdep_set_class(&adev->grbm_idx_mutex, &amdgpu_grbm_lock_key);
+	lockdep_set_class(&adev->mmio_idx_lock, &amdgpu_mmio_lock_key);
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
+ * 3. notifier_lock       - MMU notifier lock
+ * 4. vram_lock           - VRAM allocator lock
+ * 5. reset_domain->sem   - GPU reset synchronization
+ * 6. reset_lock          - Reset control lock
+ * 7. srbm_mutex          - SRBM register access
+ * 8. grbm_idx_mutex      - GRBM index access
+ * 9. mmio_idx_lock       - MMIO index access (spinlock)
+ *
+ * Evidence:
+ * - userq_sch_mutex -> userq_mutex: amdgpu_gfx_kfd_sch_ctrl() calls
+ *   amdgpu_userq_stop_sched_for_enforce_isolation() which takes userq_mutex
+ * - userq_mutex -> notifier_lock: userq paths may trigger MMU notifier
+ *   invalidation which acquires notifier_lock
+ * - notifier_lock -> reset_domain->sem: HMM invalidation callback holds
+ *   notifier_lock and can wait for GPU reset completion, so notifier_lock
+ *   must be outer to reset_domain->sem
+ * - vram_lock -> reset_domain->sem: VRAM management paths may need to
+ *   wait for ongoing reset to complete
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
+	mutex_init(&notifier_lock);
+	mutex_init(&vram_lock);
+	mutex_init(&reset_ctl.reset_lock);
+	mutex_init(&srbm_mutex);
+	mutex_init(&grbm_idx_mutex);
+	spin_lock_init(&mmio_idx_lock);
+
+	/*
+	 * Associate dummy locks with the same class keys used for real
+	 * driver locks. This ensures lockdep connects the ordering learned
+	 * here with the actual locks used at runtime.
+	 */
+	lockdep_set_class(&userq_sch_mutex, &amdgpu_userq_sch_mutex_key);
+	lockdep_set_class(&userq_mutex, &amdgpu_userq_mutex_key);
+	lockdep_set_class(&notifier_lock, &amdgpu_notifier_lock_key);
+	lockdep_set_class(&vram_lock, &amdgpu_vram_lock_key);
+	lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
+	lockdep_set_class(&reset_ctl.reset_lock, &amdgpu_reset_lock_key);
+	lockdep_set_class(&srbm_mutex, &amdgpu_srbm_lock_key);
+	lockdep_set_class(&grbm_idx_mutex, &amdgpu_grbm_lock_key);
+	lockdep_set_class(&mmio_idx_lock, &amdgpu_mmio_lock_key);
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
+	/* Level 3: MMU notifier lock */
+	mutex_lock(&notifier_lock);
+
+	/* Level 4: VRAM allocator lock */
+	mutex_lock(&vram_lock);
+
+	/* Level 5: Reset domain semaphore */
+	down_read(&reset_domain->sem);
+
+	/* Level 6: Reset control lock */
+	mutex_lock(&reset_ctl.reset_lock);
+
+	/*
+	 * Mark potential memory reclaim boundary.
+	 * GPU operations might trigger memory allocation/reclaim.
+	 */
+	fs_reclaim_acquire(GFP_KERNEL);
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
+
+	fs_reclaim_release(GFP_KERNEL);
+
+	mutex_unlock(&reset_ctl.reset_lock);
+	up_read(&reset_domain->sem);
+	mutex_unlock(&vram_lock);
+	mutex_unlock(&notifier_lock);
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

