Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C429AC88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 05:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598DF10E277;
	Wed, 16 Sep 2026 05:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WymCCz7n";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D3710E277
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 05:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5R10buQpb/GQ0SvFv6PeSfqF1iXQLCeoDmR8agAw3pdR9rGO7RdnCTqnsEH5TafLuTKSmfGhwcevYxfFTNqgL43gnJY/JoGYGc5I0Cn4XxUcXaCq/rwTIWDGI0jzH8E/NWzliGEdpzBmhXML3mNWdUCpWnZibOdQ7ktI0TAW7v1f0zF83MxAjxaeF+ONHOCpvGS369VEt++56LQAg92KIT3Re6onV/O4iACfiVWxP3KIBvn1PDBsWbjLlc/u/nJfMg2FsMmkpB28L5ur6Ow6jp+IfME9Iwe5QNWDr8Ho1wAeJTAjJtpb6hPX+z06dVksuihLkDdBtl/3W+GfQCvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf/Tj5woyRHFe+/ibJI1P2pdfUDs6qRJWKnnDPgIqQA=;
 b=Sbx7d0AEsO0YhgAGZEXZYUUgn5eL+D2Az6n7jX8bmJX0fvQjjHXdYWcJdJxisdedy4bmPtmI74F7uof6eKdCpcSIo0p7dSF/Fm+4LvbTX6EWWTeYig9Nf8S+mNc0XsW7RJBTxwtDNzVeXA2LUACttzpB1TVn906wVRNuQutsLa+jpZ7h/7I6j8lwbq9ET+FxRQ6tDKIGM4lKUVg1Sic2IaHucvK/aZHYS9Fs22jrXektZLPEE6QVyb7UnqzcR8jWEHGmStHYkxPKWdMMLcjHsV1iBXtcy9ZXVkaOq36V2xNIACSVg5jPEcGawzC0T2wJGrCMcjGqkT59rBF0zHw0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf/Tj5woyRHFe+/ibJI1P2pdfUDs6qRJWKnnDPgIqQA=;
 b=WymCCz7nqkZn4hh4Nez3VhBUNiET99Gxgqmo0xdDwJqhXAfbnYxO8TXnaN1beAeHeUKYLKWT3Jcs4dHXPN4ZswcNd3ggO9OUGUO1wSpV3e4Yr2s0XWECvvOOCDj1A9sDZ78PqskwXGEy7nrr6C+Z5o8UlA0QrlRt5pWjJNUXaig=
Received: from PH7P220CA0051.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::13)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 05:37:47 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:510:32b:cafe::6e) by PH7P220CA0051.outlook.office365.com
 (2603:10b6:510:32b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 05:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:37:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 00:37:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 "Lijo Lazar" <lijo.lazar@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
Date: Wed, 16 Sep 2026 11:07:21 +0530
Message-ID: <20260916053722.601067-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: ee044ca4-e6f2-4680-dbb4-08df13b4a34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: Lneji2gJG0dxeXbfEVWSVRQFusS500J7diRad2bc2ga0TbWi1UzT5tijnwqvkGSqSgcEipNcbotIspQyKgqsMajhLd7k8q8VR7Sh9GyLMpp4WZSlprRImZ7viuQEIJQ0yr5ghp19L4fB654+nBITz0VDPa8reSbv3d9BkRBQO4Z8GMsIEvJfsnXkpsxOCyO+IiwmDOhmClX9TtpXm6sW7BtCR8aq95hpOkHITqqnf0TIDFO9OzSUu421OtGsu1Zc/MlNXzykVcuhIORkHEmsjrQ8uAbVfmYUIndTRl2cETiMqmV8x4G4iH6sHlkkTn4LjHFJia0X6KbXy12JSK5qFxjnpO3ygqC/SSFxRl7mGyX64Gar7s/cMwuyFnp2WLx2Wbjd3RIzGxlX8FCaVLqxFHJ+EFLSfHUBMkl7hM2eutirYTU/8xiCQx9b0GrT1HzF5TC8WDqmZwIgNwpDruYzy03gxMnR41sDEmDYt7VZS55nbwW8FhAnY/dUBhcbdtE5O8QvUnxfzOvKA69+YiNo0FuXkW6cGf/mQRKJTH1es9UxcpHlh7mgmuib9lQ+PXk6xdvuOfbf1RZKlV3gtU+T/ew58JbaryL69x6Puz8dn25am8PqM1vIHFOSWpld8vP3k5SJFwsWkWF/+uMMu3xuIGyRjuKfL4Ka7/z1+h9ZDtBticHl6ZvhFh0o0ZP7+YR+mPqyNzP1wTBbD4NHqnuysQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FgHCdhIzbztss+eD1t4DTNpcfnmhuEYxrqPpkU0f8pADIYc4gnpD3NQ0Py7RHVzwylnGahimmK1T042GdyszeIIp1hPqx/6HAROloyTDgqBB3L9VYB6sFFautEiHcNNhUX18q78z9LobtDkV6iZ41lK1DRIAtr+Riyo2X71vq3DDhPUpoBxdmWRZ+252xGkT5a9gJwE/UhBNF+xpTC9s3/Pm/PwfLgIvcqQLq8XDgIZNKI9Whnl9fEkltUaifkjNUhsf94AnA6n0yZBTX0FxVPLWKfH844My2lfNub7Lnw8296cBBdaD1ovMbdTfM/KAAm8WmPD56rddhOmFlV6A55KHm4QHzCKAWPsSoPmLb4IoXB4UCzxUjl+aXKFi7nxqn5Nc89zIaSgac1jKtwGfh8wZl6wfsGs+3TTTPI2rUgR75SEnKCapyDyB0mJkAemg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:37:46.4219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee044ca4-e6f2-4680-dbb4-08df13b4a34f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

User-queue VMIDs receive their trap register state from MES/KIQ at queue
creation. Kernel-managed VMIDs do not; program them here.

Add program_kernel_trap_tba_tma() to each gfxhub generation and call it
from setup_vmid_config(). No vmhub callback is introduced: the operation
is generation-specific and belongs in each gfxhub's own setup path.

Both TBA and TMA addresses are GPU virtual addresses taken from the
common trap mapping established at vm_init. TRAP_EN is safe to set at
this point: any GPUVM assigned to a kernel-managed VMID already has a
valid trap mapping before it can execute work.

TBA is the shared device-level ISA BO mapped into each VM at
AMDGPU_VA_RESERVED_TRAP_START. TMA starts at offset 0x1800 from the same
base, matching KFD_CWSR_TMA_OFFSET so both KFD and render-node VMs use
the same per-VM buffer layout.

The helper is named program_kernel_trap_tba_tma() because it selects
each kernel-managed VMID and writes its TBA/TMA registers; it does not
configure the VMIDs themselves.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  9 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 35 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 35 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 39 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 35 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 35 ++++++++++++++++++
 7 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 3313bc099cf4..d17f54ccadb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -38,10 +38,6 @@
 
 extern int cwsr_enable;
 
-#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
-#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
-#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
-
 #define SGPR_SIZE_PER_CU 0x4000
 #define LDS_SIZE_PER_CU 0x10000
 #define HWREG_SIZE_PER_CU 0x1000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 2d855433308a..5769c5acb5c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -26,6 +26,15 @@
 #include <linux/types.h>
 #include <linux/iosys-map.h>
 
+/*
+ * TBA occupies one page plus 2 KiB (0x1800). TMA starts at that offset.
+ * Matches KFD_CWSR_TMA_OFFSET so both KFD and render-node paths share
+ * the same per-VM buffer layout.
+ */
+#define AMDGPU_TRAP_TBA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE + 2048)  /* 0x1800 */
+#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_TRAP_TMA_OFFSET   (AMDGPU_TRAP_TBA_MAX_SIZE)     /* 0x1800 */
+
 struct amdgpu_bo;
 struct amdgpu_bo_va;
 struct amdgpu_device;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 652eea6eae4a..687268e23344 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v11_5_0.h"
 
 #include "gc/gc_11_5_0_offset.h"
@@ -290,6 +291,37 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
+	int vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8));
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -337,6 +369,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 6cbf837d50dd..b521a6c6eaf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v12_0.h"
 
 #include "gc/gc_12_0_0_offset.h"
@@ -295,6 +296,37 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
+	int vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8));
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -342,6 +374,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c2fd1e6616e..ac52ccda713d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v12_1.h"
 
@@ -406,6 +407,41 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
 	}
 }
 
+static void
+gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
+	int xcc, vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for_each_inst(xcc, adev->gfx.xcc_mask) {
+		for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, xcc);
+			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_LO,
+				     lower_32_bits(tba_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_HI,
+				     upper_32_bits(tba_addr >> 8) |
+				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_LO,
+				     lower_32_bits(tma_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_HI,
+				     upper_32_bits(tma_addr >> 8));
+		}
+	}
+	/* Reset the VMID selector on every XCC instance. */
+	for_each_inst(xcc, adev->gfx.xcc_mask)
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					       uint32_t xcc_mask)
 {
@@ -468,6 +504,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 
 		hub->vm_cntx_cntl = tmp;
 	}
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_1_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9ea593e2c719..ba2d5d719474 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_0.h"
 
 #include "gc/gc_10_1_0_offset.h"
@@ -280,6 +281,37 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
+	int vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8));
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -327,6 +359,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 9e6a6e13dec0..204a8817df30 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v3_0.h"
 
 #include "gc/gc_11_0_0_offset.h"
@@ -287,6 +288,37 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 0x1800 */
+	int vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8));
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -334,6 +366,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
-- 
2.34.1

