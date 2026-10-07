Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E39CA5FF1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19F610EE6B;
	Wed,  7 Oct 2026 11:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tzp0evGd";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF66810E572
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHqsLHUMohYjnLrV48xg0mToRaYSdrSbPPz3Lmx+pBqNDbRVbj6PJJ9pSy40bsZFP8CvlGrxdKXUGJ8pFgbeTvUtm0NMPUWg+Rk7sCEF9FH9/xnGQh0HNqPKcK/0+QAJ3nlsQLg/PNfkVKlA2S35JSHyJeAdlcNZtbA6A9shjL+cOOA5drMzJIdqG0L2FoNhcWl63ZFS5hS8QejflkTSaDUzMCF2u9JlxT8QZBMreYJjmThTy26ae7uDdGYUJ3rFP0igkSaYWF7dFWHtW+nVhkxy0DSjw77Hnj1Nh046I9OcribrHzz/MV8HBxYPXHteb952XlUQDre8sg8Pvg6iBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy5qKGaTeitI7xYP5OfLCKfKXLa0LIsG7FT/GXBtui0=;
 b=tJs/Mmc4ZwLxgEA140O839/RAi+7yThzFNW53ANAY4QxHebclXxXypeLiMg6jpeRkuftxL64NzYVuHTLW/OUnsomRWkRahCYnF85uBtVgx6xI2U4Jqg3OdX/JXDK/znlP9HzPaUfU5tVQNbxwdogsGbv+KQFJOUbuL8awfhQ+SOGXWEnFFr9PBU0Bc+C8hK5bkmbR/sdl4nIrBb/DzFvmQWD1tOYj045MMglQXpueEOyYqZn6hIQWa1tjvf1X6wUX/Kxo6Sq7v1qFlXhmnkgh9iCUlphFrLQEP1A8sL8gMLh0Ai49eZzJXHjY3ApjUGoEQIY+JI9JvQOuGyDSbB/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy5qKGaTeitI7xYP5OfLCKfKXLa0LIsG7FT/GXBtui0=;
 b=Tzp0evGdI689qCXWzbDzmYCu565Nfj+00g9cj6Z8IuKwWsT5a7Z9kgM9bAFWZABYnkL+sKP+JEUWnrX/ouxTidGsRNe+NhBz0A/aDOMthAtErCtB/Dy6g+wxJlPMLNvo7XFUfLeo9wkqZr7R5NkSgBLSt290ITj4Y18ItIvXcG4=
Received: from SJ0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:2c0::23)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:05:27 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6b) by SJ0PR13CA0018.outlook.office365.com
 (2603:10b6:a03:2c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 11:05:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: Add CWSR functions and save area handling
Date: Wed, 7 Oct 2026 16:34:59 +0530
Message-ID: <20261007110506.1065076-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
References: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 71261c23-0cfb-4952-3c8b-08df2462e48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|3023799007|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: JMhiLesXG7FCm3JS5T3BV0qsCuK3ADb7GeKW1e+JaPGUx8B4wTO49cZIByO9mvYfZ+ckhrPOSkgq364O2FRMNMXM+Kd20vgj/eZLQI1OcWtjDe/BW/ReGjQERZ8zdWOjHrQIxXeHJP3gbw4xEkHpzmKRTbGZdZeGUePkJRs0A9hV7X7gNoF7ubaZ0UN4jhCFTJ98QfuQF55di1p+P5S/6X7QijfTYPoSruzTVPJP91TSPKlSDyBtFZfc/rI/QjuUrF/mWpoWxYsO/n3xQQd4ChBBUS3hvGKA+VIO70ZCIDlIsBKesOUd6fYpAOZIE0RufEEnsk56UaUS7KPgHqhEQM97IfwH2Km5r+CuooopzS6l68pRE93IYVQ1z7SVK+Y/8O4PnnDGYceUV+cwSTKJR2ndLqW0+6avfNXQ8qskzjNiqmY3mAbISNYCzFldEbUalnHqgnw9Pn66FhIyKRdQUq8aJIstQ9BIsymtU5HKocozI/hhkQhGumi7mc5OyK/xgGSaPgVQQkQaxJIJUjvTIYhgS/IwIOFlxxsQPCzpb3Mulio+ALpnLo3XNenLkXMDBudbh5JV/+hJP4lB2CJP5FLI8P/NKhJC1ngEoKY4nfTj7LlY4NxbYyi+uOORKuqdDz83lInX5cX4NAnurvtEwFBMHAuIXmt7kf4VkQhS133OlO4bCkf5zdBGdZtTX7I8VUucNcWeX4368itPrhdtsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9kgmOaQZRMzxF/KNTImIUSLZRHrcTiBEm9svVVuMn33OySZSTZxNE5IY7VYSWW8PPAaUlRbLnHhbBYVM3MG/CeuTfgYGY2bXT1jk34ggudlLl+7tDgiHRJgm7eaotVWgmKg+RcSNtuqDzPWyqlSgjyizH4RQ1j3QgM1CDkwMG9w6mY+opCS2lwU8/v8WJWEdshvBYaiyxr7tuBtbq/nxcN03HCi7jnB0cfpLdfInHzMKouWeSI8brOxqMM825EeOfzXmwlEGeXeH/Vg1hVajNZC58PWqH3O70F+uIRtSu3DOg05Fm1Qm2QPq0kPtp6VuPm+qR8+xHSLCKZ1HdWzuDJW50CFYFm9KxV+E2gQO7yDNjLNDU6GzIWh7GLN76ixDih71AVMgBHKOl3hMfXq0iy2uJ0qcgP5gPQbv/mkNf6AZj0hCkut6DliqIwECe0Y3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:26.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71261c23-0cfb-4952-3c8b-08df2462e48f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add the core CWSR handling infrastructure for user queues, including
the first-level trap handler objects and save area sizing.

Calculate the control stack, wave context and debugger memory sizes
required for CWSR, and provide validation for userspace supplied save
area parameters. Address validation is handled separately by the
caller.

Create the per-VM TMA BO using the VM root BO reservation object. This
avoids recursively acquiring reservation_ww_class_mutex while the VM
reservation is already held through drm_exec. The TMA BO is not pinned
and is covered by the VM reservation while being added to the VM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Co-developed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I47b1c8efaedd1577be95903487088a667d48f6f2
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 534 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  81 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  13 +-
 6 files changed, 638 insertions(+), 14 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 55b5d11f1938..5086a482daf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o
+	amdgpu_wb.o amdgpu_cwsr.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ce671731b700..26561a4f4db8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -332,6 +332,7 @@ struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
+struct amdgpu_cwsr_isa;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -974,6 +975,8 @@ struct amdgpu_device {
 	 * Must be last --ends in a flexible-array member.
 	 */
 	struct amdgpu_kfd_dev		kfd;
+
+	struct amdgpu_cwsr_info *cwsr_info;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
new file mode 100644
index 000000000000..6b6c11bb5fd7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -0,0 +1,534 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+
+#include <drm/drm_exec.h>
+
+#include "amdgpu.h"
+#include "cwsr_trap_handler.h"
+#include "amdgpu_cwsr.h"
+
+extern int cwsr_enable;
+
+#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
+
+#define SGPR_SIZE_PER_CU 0x4000
+#define LDS_SIZE_PER_CU 0x10000
+#define HWREG_SIZE_PER_CU 0x1000
+#define DEBUGGER_BYTES_ALIGN 64
+#define DEBUGGER_BYTES_PER_WAVE 32
+#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
+
+enum amdgpu_cwsr_region {
+	AMDGPU_CWSR_TBA,
+	AMDGPU_CWSR_TMA,
+};
+
+static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
+{
+	uint64_t addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
+
+	addr = amdgpu_gmc_sign_extend(addr);
+
+	return addr;
+}
+
+static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (!cwsr_enable || adev->gfx.disable_uq ||
+	    gc_ver < IP_VERSION(9, 0, 1))
+		return false;
+
+	return true;
+}
+
+uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
+{
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return 0;
+
+	return num_xcc *
+	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
+}
+
+static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
+					 struct amdgpu_cwsr_info *cwsr_info)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (gc_ver < IP_VERSION(9, 0, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx8_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_arcturus_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_aldebaran_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
+		   gc_ver == IP_VERSION(9, 4, 4)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
+	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
+	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
+	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_nv1x_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
+	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx10_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
+	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
+		/* The gfx11 cwsr trap handler must fit inside a single
+			   page. */
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
+	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
+	} else {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
+	}
+}
+
+static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	uint32_t vgpr_size;
+
+	switch (gc_ver) {
+	case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
+	case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
+	case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 5, 0):
+		vgpr_size = 0x80000;
+		break;
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		vgpr_size = 0x60000;
+		break;
+	default:
+		vgpr_size = 0x40000;
+		break;
+	}
+
+	return vgpr_size;
+}
+
+static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
+{
+	uint32_t lds_sz_per_cu;
+
+	lds_sz_per_cu =
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
+			(adev->gfx.cu_info.lds_size << 10) :
+			LDS_SIZE_PER_CU;
+
+	return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
+	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
+}
+
+static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
+{
+	uint32_t sz;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 1, 0))
+		sz = 12;
+	else
+		sz = 8;
+	return sz;
+}
+
+static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
+					    struct amdgpu_cwsr_info *cwsr_info)
+{
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	uint32_t ctl_stack_size, wg_data_size, dbg_mem_size;
+	uint32_t array_count;
+	uint32_t wave_num;
+	uint32_t cu_num;
+
+	if (gc_ver < IP_VERSION(9, 0, 1))
+		return;
+
+	array_count = gfx_info->max_shader_engines * gfx_info->max_sh_per_se;
+
+	cu_num = adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask);
+	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAVI10 */
+			   min(cu_num * 40,
+			       array_count / gfx_info->max_sh_per_se * 512) :
+			   cu_num * 32;
+
+	wg_data_size = ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_cu(adev),
+			     PAGE_SIZE);
+	ctl_stack_size =
+		wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
+	ctl_stack_size =
+		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
+		      PAGE_SIZE);
+	dbg_mem_size =
+		ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
+	/*
+	* HW design limits control stack size to 0x7000.
+	* This is insufficient for theoretical PM4 cases
+	* but sufficient for AQL, limited by SPI events.
+	*/
+	if (IP_VERSION_MAJ(gc_ver) == 10)
+		ctl_stack_size = min(ctl_stack_size, 0x7000);
+
+	cwsr_info->xcc_ctl_stack_sz = ctl_stack_size;
+	cwsr_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
+	cwsr_info->xcc_dbg_mem_sz = dbg_mem_size;
+}
+
+int amdgpu_cwsr_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_cwsr_info *cwsr_info __free(kfree) =
+		kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
+	void *ptr;
+	int r;
+
+	if (!amdgpu_cwsr_is_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_info)
+		return -ENOMEM;
+	amdgpu_cwsr_init_isa_details(adev, cwsr_info);
+
+	if (!cwsr_info->isa_sz)
+		return -EOPNOTSUPP;
+
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->isa_bo,
+				    NULL, &ptr);
+	if (r)
+		return r;
+
+	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
+
+	amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
+	adev->cwsr_info = no_free_ptr(cwsr_info);
+
+	return 0;
+}
+
+void amdgpu_cwsr_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return;
+
+	amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
+	kfree(adev->cwsr_info);
+	adev->cwsr_info = NULL;
+}
+
+/*
+ * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
+ * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, and each
+ * compute queue can use this virtual address for wave save/restore
+ * operations to support compute preemption.
+ */
+static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm,
+				  struct amdgpu_cwsr_trap_obj *cwsr,
+				  enum amdgpu_cwsr_region region)
+{
+	uint64_t cwsr_addr, va_flags, va;
+	struct amdgpu_bo_va **bo_va;
+	struct amdgpu_bo *bo;
+	uint32_t size;
+	int r;
+
+	if (!cwsr || !vm)
+		return -EINVAL;
+
+	cwsr_addr = amdgpu_cwsr_tba_vaddr(adev);
+
+	if (region == AMDGPU_CWSR_TBA) {
+		size = AMDGPU_CWSR_TBA_MAX_SIZE;
+		bo_va = &cwsr->tba_va;
+		bo = adev->cwsr_info->isa_bo;
+		va = cwsr_addr;
+		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
+			    AMDGPU_VM_PAGE_EXECUTABLE);
+	} else {
+		size = AMDGPU_CWSR_TMA_MAX_SIZE;
+		bo_va = &cwsr->tma_va;
+		bo = cwsr->tma_bo;
+		va = cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
+		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
+	}
+
+	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
+	if (!*bo_va)
+		return -ENOMEM;
+
+	va &= AMDGPU_GMC_HOLE_MASK;
+	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
+	if (r) {
+		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
+			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
+		amdgpu_vm_bo_del(adev, *bo_va);
+		*bo_va = NULL;
+		return r;
+	}
+
+	r = amdgpu_vm_bo_update(adev, *bo_va, false);
+	if (r) {
+		dev_err(adev->dev,
+			"failed to do page table update of %s region, err=%d\n",
+			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
+		amdgpu_vm_bo_del(adev, *bo_va);
+		*bo_va = NULL;
+		return r;
+	}
+
+	if (region == AMDGPU_CWSR_TBA)
+		cwsr->tba_gpu_va_addr = va;
+	else
+		cwsr->tma_gpu_va_addr = va;
+
+	return 0;
+}
+
+static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
+				    struct amdgpu_cwsr_trap_obj *cwsr,
+				    enum amdgpu_cwsr_region region)
+{
+	struct amdgpu_bo_va **bo_va;
+	uint64_t va;
+	int r;
+
+	if (!cwsr)
+		return -EINVAL;
+
+	if (region == AMDGPU_CWSR_TBA) {
+		bo_va = &cwsr->tba_va;
+		va = cwsr->tba_gpu_va_addr;
+	} else {
+		bo_va = &cwsr->tma_va;
+		va = cwsr->tma_gpu_va_addr;
+	}
+
+	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
+	if (r) {
+		dev_err(adev->dev,
+			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
+			r);
+		return r;
+	}
+
+	amdgpu_vm_bo_del(adev, *bo_va);
+	*bo_va = NULL;
+
+	return r;
+}
+
+int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **trap_obj)
+{
+	struct amdgpu_bo_param bp;
+	struct amdgpu_cwsr_trap_obj *cwsr;
+	struct amdgpu_bo *bo;
+	struct drm_exec exec;
+	int r;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+	if (!vm || !trap_obj)
+		return -EINVAL;
+
+	cwsr = kzalloc(sizeof(*cwsr), GFP_KERNEL);
+	if (!cwsr)
+		return -ENOMEM;
+
+	bo = adev->cwsr_info->isa_bo;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r)) {
+			dev_err(adev->dev,
+				"failed to reserve for CWSR allocs: err=%d\n",
+				r);
+			goto err_exec;
+		}
+	}
+
+	/*
+	 * Create TMA BO using the VM's already-locked resv so no new
+	 * reservation_ww_class_mutex acquisition is needed, avoiding the
+	 * recursive ww_mutex deadlock. Unpinned; eviction is handled via
+	 * amdgpu_vm_bo_add() inside amdgpu_cwsr_map_region().
+	 */
+	memset(&bp, 0, sizeof(bp));
+	bp.size = AMDGPU_CWSR_TMA_MAX_SIZE;
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	bp.type = ttm_bo_type_kernel;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.resv = vm->root.bo->tbo.base.resv;
+
+	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
+	if (r)
+		goto err_exec;
+
+	/* VM resv already held, kmap directly, no separate reserve needed. */
+	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
+	if (r)
+		goto err_tma;
+
+	memset(cwsr->tma_cpu_addr, 0, AMDGPU_CWSR_TMA_MAX_SIZE);
+
+	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
+	if (r)
+		goto err_kmap;
+
+	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
+	if (r) {
+		amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
+		goto err_kmap;
+	}
+
+	drm_exec_fini(&exec);
+	*trap_obj = cwsr;
+	return 0;
+
+err_kmap:
+	amdgpu_bo_kunmap(cwsr->tma_bo);
+err_tma:
+	amdgpu_bo_unref(&cwsr->tma_bo);
+err_exec:
+	drm_exec_fini(&exec);
+	kfree(cwsr);
+	*trap_obj = NULL;
+	return r;
+}
+
+int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_cwsr_params *cwsr_params,
+				int num_xcc)
+{
+	uint32_t min_size, max_size;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_params)
+		return -EINVAL;
+
+	min_size = amdgpu_cwsr_size_needed(adev, num_xcc);
+	max_size = 2 * min_size;
+	/*
+	 * Only save area size details checked. Address validation needs to be
+	 * carried out separately. User is expected to pass a cwsr buffer area
+	 * with size >= ctl stack size + wg data size + debug memory size
+	 */
+	if (cwsr_params->cwsr_sz < min_size ||
+	    cwsr_params->cwsr_sz > max_size) {
+		dev_dbg(adev->dev,
+			"queue cwsr size 0x%x should be within min %u : max %u\n",
+			cwsr_params->cwsr_sz, min_size, max_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **trap_obj)
+{
+	struct amdgpu_bo *tba_bo;
+	struct amdgpu_bo *tma_bo;
+	struct drm_exec exec;
+	int r;
+
+	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
+		return;
+
+	tba_bo = adev->cwsr_info->isa_bo;
+	tma_bo = (*trap_obj)->tma_bo;
+
+	if (!tba_bo || !tma_bo)
+		return;
+
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r)) {
+			dev_err(adev->dev,
+				"failed to reserve CWSR BOs: err=%d\n", r);
+			goto err;
+		}
+	}
+
+	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
+	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
+
+err:
+	drm_exec_fini(&exec);
+
+	/* TMA BO not pinned, release CPU mapping and free. */
+	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
+	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
+	kfree(*trap_obj);
+	*trap_obj = NULL;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
new file mode 100644
index 000000000000..7f922559e297
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+
+#ifndef AMDGPU_CWSR_H
+#define AMDGPU_CWSR_H
+
+#include <linux/types.h>
+
+struct amdgpu_bo;
+struct amdgpu_bo_va;
+struct amdgpu_device;
+struct amdgpu_vm;
+
+/**
+ * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
+ * @bo: Buffer object for CWSR area
+ * @bo_va: Buffer object virtual address mapping
+ */
+struct amdgpu_cwsr_trap_obj {
+	uint64_t tma_gpu_va_addr;
+	uint64_t tba_gpu_va_addr;
+
+	struct amdgpu_bo *tma_bo;
+	struct amdgpu_bo_va *tba_va;
+	struct amdgpu_bo_va *tma_va;
+	void *tma_cpu_addr;
+};
+
+struct amdgpu_cwsr_info {
+	/* cwsr isa */
+	struct amdgpu_bo *isa_bo;
+	const void *isa_buf;
+	uint32_t isa_sz;
+	/* cwsr size info per XCC*/
+	uint32_t xcc_ctl_stack_sz;
+	uint32_t xcc_dbg_mem_sz;
+	uint32_t xcc_cwsr_sz;
+};
+
+struct amdgpu_cwsr_params {
+	uint64_t ctx_save_area_address;
+	/* cwsr size info */
+	uint32_t cwsr_sz;
+};
+
+int amdgpu_cwsr_init(struct amdgpu_device *adev);
+void amdgpu_cwsr_fini(struct amdgpu_device *adev);
+
+int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
+void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
+static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
+{
+	return adev->cwsr_info != NULL;
+}
+
+uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
+int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_cwsr_params *cwsr_params,
+				int num_xcc);
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ab6f9131ac11..b2a8a8b37006 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -764,6 +764,15 @@ MODULE_PARM_DESC(use_xgmi_p2p,
 	"Enable XGMI P2P interface (0 = disable; 1 = enable (default))");
 module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
 
+/**
+ * DOC: cwsr_enable (int)
+ * CWSR(compute wave store and resume) allows the GPU to preempt shader execution in
+ * the middle of a compute wave. Default is 1 to enable this feature. Setting 0
+ * disables it.
+ */
+int cwsr_enable = 1;
+module_param(cwsr_enable, int, 0444);
+MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off, 1 = On (Default))");
 
 #ifdef CONFIG_HSA_AMD
 /**
@@ -787,16 +796,6 @@ module_param(hws_max_conc_proc, int, 0444);
 MODULE_PARM_DESC(hws_max_conc_proc,
 	"Max # processes HWS can execute concurrently when sched_policy=0 (0 = no concurrency, #VMIDs for KFD = Maximum(default))");
 
-/**
- * DOC: cwsr_enable (int)
- * CWSR(compute wave store and resume) allows the GPU to preempt shader execution in
- * the middle of a compute wave. Default is 1 to enable this feature. Setting 0
- * disables it as only in non-HWS mode.
- */
-int cwsr_enable = 1;
-module_param(cwsr_enable, int, 0444);
-MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off (debugging only), 1 = On (Default))");
-
 /**
  * DOC: max_num_of_queues_per_device (int)
  * Maximum number of queues per device. Valid setting is between 1 and 4096. Default
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1a..226caa99f6ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -178,10 +178,17 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VA_RESERVED_TRAP_SIZE		(1ULL << 16)
 #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
+/* TBD: Ideally, existing TRAP VA should do. There is a conflict with KFD mapping that needs to be
+ * resolved. Revisit later.
+ */
+#define AMDGPU_VA_RESERVED_TRAP_UQ_SIZE (3ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_UQ_START(adev) \
+	(AMDGPU_VA_RESERVED_TRAP_START(adev) - AMDGPU_VA_RESERVED_TRAP_UQ_SIZE)
+
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
-						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
-						 AMDGPU_VA_RESERVED_CSA_SIZE)
+#define AMDGPU_VA_RESERVED_TOP                                            \
+	(AMDGPU_VA_RESERVED_TRAP_UQ_SIZE + AMDGPU_VA_RESERVED_TRAP_SIZE + \
+	 AMDGPU_VA_RESERVED_SEQ64_SIZE + AMDGPU_VA_RESERVED_CSA_SIZE)
 
 /* See vm_update_mode */
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
-- 
2.34.1

