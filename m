Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9ACCD6E79
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4588110F964;
	Mon,  8 Jun 2026 19:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BBA0VCm9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9037310F950
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lS8Zmhx9tDWdJAwarnee6dRv+sd8ev1YBElebeQzleMZWecb4/YwW6JQrqYh/hbIRLPO0BX4dQd+V6VXJQcFONEhP3CEhTor8GgCgUCvTuSlW7FNpBhfgNbDVaP1K0pfCpK6I1CFTki3hXCZnCEJdWZ5oo9mgBqSLZdxtEtgsXOCeclDxkBaoZt120BSL0NLaSsWJ0UCKQGVQRzY1R9FzZOjS77FraJThXFC1X3NKPMe13GMmhNM5Lt0TjNgPSWNJmFzR1P/00fIh1kC/OGHeRKbNh0zXD0OizGjAOwdV/lmMeFnyVh9yEj35FmYtgzoJKS3UyUhxFWk2yONB+kMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaCx+EmuIoXuDwy+p11ERGGvt72WhUL3aIoilTJ/mqk=;
 b=BLlks/kHOkoVBCjKuOZbd6jMdIRJDLJvTID5I1pocg/4QeNTw1FziKAm41HmOpznH2gxUGJNXuRCmxH4KqpO0/BUEJiKWpJGqr0Q21nm9mQSpV4fUVwSiY+q+X9wH2f74rvYJRcYd+hr9PnTxB+jIox7sgfpMdnvoD0hufut/4GMfjFfvBCU5hHRUXY8krYQ+bsCuGbxm90Dnff7VDmpoeM0l10SyLlBbTZ7ViGWh/RU2PONJjAvwtPnc6GgLYjGy+0J0H0MGTUOaoRD2hKvgVQYoK6IotmKBzy35t+Toa3R4xXJMrzbrIUFnnQhju+NsNqMQqE6zdPYKY7wq1PduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaCx+EmuIoXuDwy+p11ERGGvt72WhUL3aIoilTJ/mqk=;
 b=BBA0VCm9csd9tmvHrTKnY7BEQDKTD0/Zslu+KNMfIVWQysCVklM6xa+GJbecKraXAtIwMM0EI8/YCk4rbVX4nDA6iduko8ti4UZcCFhj7xW0j2jTPM28AK54ktA9KO3SLLHRyOQ38IpgbELji4N291s7KpFyOVh534bSFnPe7WI=
Received: from PH8PR05CA0015.namprd05.prod.outlook.com (2603:10b6:510:2cc::16)
 by CH8PR12MB9815.namprd12.prod.outlook.com (2603:10b6:610:277::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 19:48:02 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::64) by PH8PR05CA0015.outlook.office365.com
 (2603:10b6:510:2cc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.8 via Frontend Transport; Mon, 8
 Jun 2026 19:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:02 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:00 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 02/11] drm/amdgpu: move struct amdgpu_wb and helpers into
 separate files
Date: Mon, 8 Jun 2026 15:47:32 -0400
Message-ID: <20260608194741.1590055-3-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194741.1590055-1-shahyan.soltani@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CH8PR12MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cfe497-1483-4c5a-e2b5-08dec596da02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|3023799007|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CpybgTHZ5o/5AzSmvNHgOD9bFl1T/8G4hTX00PfMYUEPkqZ0W47Bo4p3MCAWlED2wyksint3lr5wpEhQ91A0Pj/Z2T1FerjBY2Y2iSsdOL5DuAiaUwr6mLqHEMRX8g2yfyvZ4AqOJfV0BycMScPqG5vX+lgNx/wG8ODqTOkH6CBLxTS2vaThNhGUsrerONo1bhnKEBgugnE0xroSEpYigNex5zFZmBqzi73+fb/Ho5eFAT3MhKJCkddwIxl20KSC/6swjfiKZmk+4PxqKStxE1Tip/5bxtJGNJF+bQM+N13aM9TU/JlW8sTKfBxvn85IrzpxVagOFlDOvGplzdbNgzFL/SUuakEFjIyr4IHRRlC3TJbB0f0Q3GUzi+VstcFoYaJikKhvGy2wvnJlD7DOpQXWSNH+z/mRRQDP4ZKTZEmbUki6JpPFmca7oh7pxkVX5NwTaU1fRQCfy3fvRYLEfQL5/l5BOrlC1JjIoYGWb3WaUzn+JOmGTS3RRJmj4cbc4j/b6M9jOxbCpAfLOVgExqk4PErB+sGC6Uv+lo3obcUY8vZczOZg/oCV4Xiok4VW2s1qS1Hz5N5HPVMXo/GAyGATank4MKJaxnqY4BNzuPAb9bswh6XpBom4Z3vgk3uPKLLuhVBuo4Z18QgrUVYeM+9XnckuCaWeqvOOGPH9ioiJiKSi6Sbi6ARv2MaPEjGvOgUWMMI8q3Q5GLfgotvTQvOuN5SoGRbBMGZx7LsidXQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(3023799007)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: McohNMQfo9pCk6A3q1LsXMtc6qqtax0FbFdKXbO9sw95mFNM73d8Z9u/V6IuJiqYrlHID/vuD/ULU53yDZ7gii/QnfKPFrcravv0dsHlNoc2M3YeB4FO3ERIF64tAF471jNaphlwqyL0mCfFU0ipZ1STZKX+w20kxzQ68zLR6ochpCcKmcHsyp3iwOK8lP0YR86Q3moCJNzGheVoElNo1rCQgqofXeS4IRkoJvMeHf9HpmkKuQGakU7E4inU8dFKSo4+WtyDSIJre4VfLsGJqMAEJ/Av8m8805Hpit5tUFNvJLoqoQ/gwd2gDpsDQ2lXv8LDXjfJDzNBFCLxbKdCAhnF3/dOMOLuU1UQVsKbWfFBuLocveH7qmEIUWrkvQuxD+PRlf4Msq95gg9wGgAzNodQyD+Odbdg817OQDz1HaI6G/eHtKzCI1YdVui5u3FY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:02.5911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cfe497-1483-4c5a-e2b5-08dec596da02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9815
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

Move struct amdgpu_wb and helpers out of the monolithic header amdgpu.h
into its own dedicated header amdgpu_wb.h.

Move functions amdgpu_device_wb_get() and amdgpu_device_wb_free out of
amdgpu_device.c into new dedicated amdgpu_wb.c file.

Update amdgpu/Makefile to build amdgpu_wb.o.

This is part of the ongoing effort to reduce the size of amdgpu.h into
their own respective separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  68 +-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  45 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c     |  69 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h     | 100 +++++++++++++++++++++
 5 files changed, 172 insertions(+), 113 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee3574797bc2..e6deb24f73bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
+	amdgpu_wb.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d7d8664854fd..9a714b4b59bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,6 +112,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_eviction_fence.h"
 #include "amdgpu_sa.h"
+#include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
@@ -429,73 +430,6 @@ struct amdgpu_fpriv {
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
-/*
- * Writeback
- */
-#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
-
-/**
- * struct amdgpu_wb - This struct is used for small GPU memory allocation.
- *
- * This struct is used to allocate a small amount of GPU memory that can be
- * used to shadow certain states into the memory. This is especially useful for
- * providing easy CPU access to some states without requiring register access
- * (e.g., if some block is power gated, reading register may be problematic).
- *
- * Note: the term writeback was initially used because many of the amdgpu
- * components had some level of writeback memory, and this struct initially
- * described those components.
- */
-struct amdgpu_wb {
-
-	/**
-	 * @wb_obj:
-	 *
-	 * Buffer Object used for the writeback memory.
-	 */
-	struct amdgpu_bo	*wb_obj;
-
-	/**
-	 * @wb:
-	 *
-	 * Pointer to the first writeback slot. In terms of CPU address
-	 * this value can be accessed directly by using the offset as an index.
-	 * For the GPU address, it is necessary to use gpu_addr and the offset.
-	 */
-	uint32_t		*wb;
-
-	/**
-	 * @gpu_addr:
-	 *
-	 * Writeback base address in the GPU.
-	 */
-	uint64_t		gpu_addr;
-
-	/**
-	 * @num_wb:
-	 *
-	 * Number of writeback slots reserved for amdgpu.
-	 */
-	u32			num_wb;
-
-	/**
-	 * @used:
-	 *
-	 * Track the writeback slot already used.
-	 */
-	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
-
-	/**
-	 * @lock:
-	 *
-	 * Protects read and write of the used field array.
-	 */
-	spinlock_t		lock;
-};
-
-int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
-void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
-
 /*
  * Benchmarking
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ff224163bab..15a6a9010fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1058,51 +1058,6 @@ static int amdgpu_device_wb_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * amdgpu_device_wb_get - Allocate a wb entry
- *
- * @adev: amdgpu_device pointer
- * @wb: wb index
- *
- * Allocate a wb slot for use by the driver (all asics).
- * Returns 0 on success or -EINVAL on failure.
- */
-int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
-{
-	unsigned long flags, offset;
-
-	spin_lock_irqsave(&adev->wb.lock, flags);
-	offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
-	if (offset < adev->wb.num_wb) {
-		__set_bit(offset, adev->wb.used);
-		spin_unlock_irqrestore(&adev->wb.lock, flags);
-		*wb = offset << 3; /* convert to dw offset */
-		return 0;
-	} else {
-		spin_unlock_irqrestore(&adev->wb.lock, flags);
-		return -EINVAL;
-	}
-}
-
-/**
- * amdgpu_device_wb_free - Free a wb entry
- *
- * @adev: amdgpu_device pointer
- * @wb: wb index
- *
- * Free a wb slot allocated for use by the driver (all asics)
- */
-void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
-{
-	unsigned long flags;
-
-	wb >>= 3;
-	spin_lock_irqsave(&adev->wb.lock, flags);
-	if (wb < adev->wb.num_wb)
-		__clear_bit(wb, adev->wb.used);
-	spin_unlock_irqrestore(&adev->wb.lock, flags);
-}
-
 /**
  * amdgpu_device_resize_fb_bar - try to resize FB BAR
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
new file mode 100644
index 000000000000..8e5f572077f3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include "amdgpu.h"
+#include "amdgpu_wb.h"
+#include <linux/spinlock.h>
+/**
+ * amdgpu_device_wb_get - Allocate a wb entry
+ *
+ * @adev: amdgpu_device pointer
+ * @wb: wb index
+ *
+ * Allocate a wb slot for use by the driver (all asics).
+ * Returns 0 on success or -EINVAL on failure.
+ */
+int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
+{
+	unsigned long flags, offset;
+
+	spin_lock_irqsave(&adev->wb.lock, flags);
+	offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
+	if (offset < adev->wb.num_wb) {
+		__set_bit(offset, adev->wb.used);
+		spin_unlock_irqrestore(&adev->wb.lock, flags);
+		*wb = offset << 3; /* convert to dw offset */
+		return 0;
+	} else {
+		spin_unlock_irqrestore(&adev->wb.lock, flags);
+		return -EINVAL;
+	}
+}
+
+/**
+ * amdgpu_device_wb_free - Free a wb entry
+ *
+ * @adev: amdgpu_device pointer
+ * @wb: wb index
+ *
+ * Free a wb slot allocated for use by the driver (all asics)
+ */
+void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
+{
+	unsigned long flags;
+
+	wb >>= 3;
+	spin_lock_irqsave(&adev->wb.lock, flags);
+	if (wb < adev->wb.num_wb)
+		__clear_bit(wb, adev->wb.used);
+	spin_unlock_irqrestore(&adev->wb.lock, flags);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
new file mode 100644
index 000000000000..dac9fc3f0004
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef __AMDGPU_WB_H__
+#define __AMDGPU_WB_H__
+
+#include <linux/types.h>
+#include <linux/spinlock_types.h>
+#include <linux/math.h>
+
+/*
+ * Writeback
+ */
+#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
+
+/**
+ * struct amdgpu_wb - This struct is used for small GPU memory allocation.
+ *
+ * This struct is used to allocate a small amount of GPU memory that can be
+ * used to shadow certain states into the memory. This is especially useful for
+ * providing easy CPU access to some states without requiring register access
+ * (e.g., if some block is power gated, reading register may be problematic).
+ *
+ * Note: the term writeback was initially used because many of the amdgpu
+ * components had some level of writeback memory, and this struct initially
+ * described those components.
+ */
+
+struct amdgpu_bo;
+struct amdgpu_device;
+
+struct amdgpu_wb {
+
+	/**
+	 * @wb_obj:
+	 *
+	 * Buffer Object used for the writeback memory.
+	 */
+	struct amdgpu_bo	*wb_obj;
+
+	/**
+	 * @wb:
+	 *
+	 * Pointer to the first writeback slot. In terms of CPU address
+	 * this value can be accessed directly by using the offset as an index.
+	 * For the GPU address, it is necessary to use gpu_addr and the offset.
+	 */
+	uint32_t		*wb;
+
+	/**
+	 * @gpu_addr:
+	 *
+	 * Writeback base address in the GPU.
+	 */
+	uint64_t		gpu_addr;
+
+	/**
+	 * @num_wb:
+	 *
+	 * Number of writeback slots reserved for amdgpu.
+	 */
+	u32			num_wb;
+
+	/**
+	 * @used:
+	 *
+	 * Track the writeback slot already used.
+	 */
+	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
+
+	/**
+	 * @lock:
+	 *
+	 * Protects read and write of the used field array.
+	 */
+	spinlock_t		lock;
+};
+
+int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
+void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
+#endif
-- 
2.54.0

