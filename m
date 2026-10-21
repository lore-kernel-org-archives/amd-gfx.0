Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935D606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ey5OSSMa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076C810E3F9;
	Wed, 21 Oct 2026 06:56:37 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF0610E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKWXrA1/Jl7w4fttowLYW+Lz+IY6QhosRrWtP/HIEUh6WsnjamakOchuIhKSWQ8FN/WDncJ5md0+7PfpRzWIYR5UdNggJafmLyMmbGm/HKjIWE7dWogc/50r4Jnxi8mR617Mo9rJ39LeqtGjnDJDAdD+6tfjyiVSFIXM6J4+3QXfTakWdshTWjQ5QKTrr90upfdQED44Z9U127ZPK0V7V2Hc8wuKiV2GbzhCXpzgNp5SnrRvaJRqbXEMgz0sm3hRFsXAvtemreGXEUDbY6CSIH4R7I0mrdkwVNnHY9Wr2tSYCKNEHfjQ06bxJ398/dk52OnguNkMDjs3ZWMQXKOdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uo8zM9psEDBkFRqEjXVwo1HG9tlB/CrqUeX0cSk3fk=;
 b=IEpMXJ9z6LEBRcPWCibRnEYBcQn5CxzO74ZJmNIgqaw9lp+ZCqJAjCjpzXrf+9xeTGPuM0bAhiFociGG8rWsHcaL5Tx6bL51pF5sV2gLhowzX6R5VAKJICVVSgCZsLNklE+wt+C6xC9tJHZjlEzJ9ZrmZScPSaQwtZ+gjDMZxLsiapbjstUPgDQ3ODTgNjOisiYKGPY33dxKgKoAYrqVJm57IAalIrDDAXtz3zHEyy5FWOrJAOgAUg68AsJWzQilKKHQqGR1ecOI0OH9Qq8vqBoMO5fp3SEdLeVrMI6xZQJGF7Pmzr0xqARp8Z/N60SItDyK8Oo3m+/OUskWl7E7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uo8zM9psEDBkFRqEjXVwo1HG9tlB/CrqUeX0cSk3fk=;
 b=ey5OSSMa5ewZZJm2GhQele/mmngVue5IWzPrr5NaSrDr2VicbSXPmBsQ19LEnTlkKj16TPdFJZTWNhXy2lyKJ5TY0IBEHnKYzKQuuern+KTsDz1JBhor4f17FxsV1cNPftBpq4Ml/Lr1+7O4y/LeHMHlYhHQ0Z4uR4j/wLv4bS8=
Received: from BY5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:1d0::27)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:56:24 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::9b) by BY5PR04CA0017.outlook.office365.com
 (2603:10b6:a03:1d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:56:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:56:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 01:56:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu: Add CWSR infrastructure for user queues
Date: Wed, 21 Oct 2026 12:25:57 +0530
Message-ID: <20261021065603.1329111-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ceeeeb-5d5c-4303-2fc5-08df2f406b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|18002099003|22082099003|3023799007|11063799006|10067099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: mancYbNkDmgjOGnROkLfpnMbQEE46UXKzg3XJT81kYv2Zl9P4TcP79iws7g2wvU1LmuQimWG8CujueyoA4KatHwSKCRHKkG8hCA3rVM8MyVoS6LYk0rVFpG7QuAWOl7Qwm+3jVSednndxNp3Wk7gkjtx1dpfGviK9SzWBN4GzA2jjThclqaqQf3lcfNhFOz6V8ICKo5NUtRLavTmUWzID/FHIz6+qCVsf1vlHuLoc1AsOF1NeAuizur7X0paEvpNOtVZR/s3hLR2RxZoXcWdYpkiXPbC6u36kDiI3MhxBWp9qoKO1e7kFFPv8DYC5bBEgivu6sCLTZGuAhIhuljo4hxEOGzNgHWcOBffJI51HRaByQE6djTeTHI5MI0amAGvmjkkRpqZnIFPMtYE+Fwhvkg4iojdaiSH0WuAwcZbPTd0+ybeFBfGN4Za3obyrpnSfdaAL4cNYp8zkMOvZdC/wnXwdsM6ipI6rrgD1gi+T61EJt2ErH18TEc7PFjmXuW7zqqymvQOxcR1Urbm3NHs5Od90Jt/+AktF165VZUDrIVxfJxD6AodKYLvJ9Cw+epR5RKaDbgSZPkzXH1RaodN64jR5xUwP/AXw/Da0wwQ70uuZNBbTN5kRlsphGzZNA68S3pRayk90oYUi4kMaR2PSXA2tj54JIQrv/nSBc2uS697NFfmQX2zPZzT43qNbhzvWiXcevOrnBZHnsjNm63SYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FwgPSN4niivmMoFjjvxIM8M7mBDQMk/pnkrwWxhIbHvMrIQ4dNBOkGJSzm3Ln7jBdmotHLbJk+67VPHQ9BsIQEEGpEFtAWw/IcvfJZh/i9/eTy5mqItI3oHk1YQSR8sd3szwQ94w7u0yBri8OuS0YQ/k/59Y0jlNhUOe/hI7Bl64Fu3BOXYl3usyaDUT+3ukta+5XZCHuSpv7RpaONfT9LPZbR0lkFQDVKMq5rBBiLPG618BWAS0/OcLiawzNJorRdN2zNjHvmwfpr/gzVEdNXsuQ24wBWU5u67D4pMExElOI6d9PhY7RXnqM31K1kkrYClzE9So33y7c5Mjp3UwyprFKDxnU+N/9ZJt590uckIPdnJdLfAhQ6Z3j0s+0EvlmwjC2vyzcaSH1eGQQuET3pPrrgDJM5+RnflCwmLDd2HhKHavHdyNA6riEJ8M1tg7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:56:23.3785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ceeeeb-5d5c-4303-2fc5-08df2f406b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lijo Lazar <lijo.lazar@amd.com>

Add a helper to get the number of XCCs for a partition, defaulting to
one when no partition manager is available.

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
Acked-by: Christian König <christian.koenig@amd.com>
Change-Id: I0fd5b2f8e75081db37615673a2dc5a0c7ead931f
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 535 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  82 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h  |  22 +
 7 files changed, 662 insertions(+), 14 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8687afc00c24..0f449b8a1b43 100644
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
index 5a32b54b1e9b..53aeaca52a6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -332,6 +332,7 @@ struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
+struct amdgpu_cwsr_isa;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -986,6 +987,8 @@ struct amdgpu_device {
 	 * Must be last --ends in a flexible-array member.
 	 */
 	struct amdgpu_kfd_dev		kfd;
+
+	struct amdgpu_cwsr_info *cwsr_info;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
new file mode 100644
index 000000000000..e9cd04364367
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -0,0 +1,535 @@
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
+		/*
+		 * The gfx11 CWSR trap handler must fit inside a single page.
+		 */
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
+	 * HW design limits control stack size to 0x7000.
+	 * This is insufficient for theoretical PM4 cases
+	 * but sufficient for AQL, limited by SPI events.
+	 */
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
index 000000000000..297a4ff04730
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: MIT */
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
index 3e5634de077f..436656734a1b 100644
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
index 2a2a2ccbaa2c..f55239b5bc06 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index e2fd32af9932..7cd0ad6c3164 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -227,4 +227,26 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
 	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
 	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
 
+static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
+					 int xcp_id)
+{
+	struct amdgpu_xcp *xcp;
+	uint32_t xcc_mask;
+	int i, r;
+
+	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return 1;
+	for_each_xcp(xcp_mgr, xcp, i) {
+		if (xcp->id == xcp_id) {
+			r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
+							&xcc_mask);
+			if (unlikely(r))
+				return 1;
+			else
+				return hweight32(xcc_mask);
+		}
+	}
+
+	return 1;
+}
 #endif
-- 
2.34.1

