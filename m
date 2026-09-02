Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4F7C624D7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 15:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2950410F267;
	Wed,  2 Sep 2026 15:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FYA27rvq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FC410F265
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 15:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFOEAxUTvrSTy1yvHh1PPuayLSk81+eyGXHoo2DUToaVpz4zf6a0pEZ3d44sx8G4eQ0QBBk7zuMWqptB4Tyoh5va5AYZ0gXbg7APwOGnov5ytDXZ5McmNpnnY3aAlfEnG9Ls8du+w6MYxb5hQt+Ll10Y2/K4QGyrZJ5efSThomM+haz+Mnrxipfy0/5KZa2Et15LQtCz4dDgPd3QbJF3BdX1KGX/A34wNcMKihQ01v0xpQQVgLNekpRZBOIk08QEt7Ggr1Dq4uWm/T0Al4wLsybTQkNCI8YUe03aDMvXxhbQnLrxUCc/4DbU50PaQfKFC9/Y9KOTaXvPuAMsuNteKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNpJF9A6qoUfmAI+tCbmGCJty2u3Ry1q0a1NlBKU4y8=;
 b=cQtnCPsbXbp4PewPco4E1C7kR0qFq8ul+ssZ8FfzQ6g8kCw+/kTyGq+nHkTXPU746poibJ9jvxbZfKXrDz8OmntK3fXGtVL2oIne5jRFn6GgHvXP4M1AZLEdXtmksqTI0YplWHnXUW+YoCN83+y/+m2k6cve7oZdp9glHuPb1GrUqaBgpjo7dPofgz4cwO2PXxOqDbFwFDxKfhU6Yz2dJ8LQNx9zEl3tWagJAp9NNfcWudcqKnlU6Qx6oMpYx82cQ+oCnntZ/OTUdl5UvKBl/3kxRsozJO1reEuU7wMTPCA3D7tseraQHQIgXxGYiZxZEJwiah1+Wbf34en36XLDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNpJF9A6qoUfmAI+tCbmGCJty2u3Ry1q0a1NlBKU4y8=;
 b=FYA27rvqov16xsm93Y/YXk+XaalZsJjYGybrlW8mbkdNZaQTte6DcUR9ytrTo35+XZFXiR7FLMRwJoMpeuDrQ2GGe8NUR1nJ2KWjs2lT/Kt6u1ZJJoazUxftM7U+JvwwUrYQHgFNaAH3Io1Es6Xtw9ijLv59q1V+8ix7qeEY/Fo=
Received: from SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::18)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:07:11 +0000
Received: from SJ1PEPF000037BB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::5f) by SJ0P220CA0027.outlook.office365.com
 (2603:10b6:a03:41b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 15:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BB.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 15:07:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 10:07:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Timur Kristof <timur.kristof@valve.com>
Subject: [RFC PATCH 2/2] drm/amdgpu: Implement kernel VMID trap handler for
 GFX10/11/12
Date: Wed, 2 Sep 2026 20:36:56 +0530
Message-ID: <20260902150656.183333-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
References: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BB:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cc4e3f-af91-4ee1-cbb4-08df0903dd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|10067099003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 3K0s1u8NQRU1BH6Lry1eQwji3nHReQeaay/PBfswdRuBdQpgzHXBVgKu/OONeQP6zTNsYeDrFRBzHJtxK4OoCQX9Wj99CXYWHUD6d2CUzI9ZUFkg1IeA0vRsjkiJ8yy1Qv3xeZDO/hfZu2zHncZvLBV9qr2RfyujuTIgyoQGuyPsaE3YSoj8ZcCP4k2v5MMRE+kkDaOjeogLXgG6pYQluTRdAf1mGjA41SsBnte9p2qy4oQcdWczxDX5fCJPD1s8lOQReSKhVhZTSWvET68h+AEkocliTrDkc15wKVXSbuq6m0BLz8xECcdrr4f4gyBSiX4UPZikjUNDFv8hioc3zCjTTF32uBobWOPoKaf7tOQlO0m3RbwsyROwUOT/K8DvI0oxp/oGUUSAspejYHUuFanmbxqatZq/FGe8Pyueb+Fd9oS2r+DhyMpFF8pnSZS6pt9BTnkyt0iry0IpT33GR6coRpZ74QGLDi+eA7etVOuMhvzS2Ug9vTNONN5WSn85iKmDHrYsHTgwp5vzAfz/mpekTuPrFDzV3N5p05FgSCi0zUNPGSgmetG9eLAM3BotJ7/clVKHX/3VkrrnpTY9fReh3ANnuhhnbXAicBLkFdu0H1g6+dx+mJHcdApPVuts34pFAWYsgh3A4XFciyNTsUzMpTwyuAN1Qnn0jb6uGvZc2WL+wop8r0FVQfL2UxjQLwRxJor1g7LsS6H6NyIr3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eP9TgjmvWA48qiqqRJnmxNlrh2HDz9gk7IxcQGFUEVaI2Mfdg/W4Ypd1N+q7JD0FdPxh3YXYuMeqwoFhmLROniNAUkL27XgG9j1ubK9uP8RHqnOEivUfYRjthaPzUAfyT2rHPu2mo6d6EflyDo1eBd0NuEtOy4wrZ2fpHsQbwa1Erdf7Ce+oRVCrvKHl/Boeo+zGw9w/Fz+CCzaKniPnmPU3wFhtOkm3A3KJ0K1qpv0+/SxfmX/VjV7VbMY+t169oMK3onhfGjPb1b4tKqni+J/3qpyfGjFh3dncO70xUwB92sIJNm4tWhPbJE5Lb/GiC2dXsrp92xDha3JyR/ec27/AHsszkWmuM+YeIkp9p+kKZEHOlmfZHg9FYWNpOW/bvY8ioeaf2oSgC+2o17UpGEdEEg3lIin5b37crPuayZRDTbZvkTSH9Nuik8IUW/ba
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:07:11.6437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cc4e3f-af91-4ee1-cbb4-08df0903dd9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
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

Implement program_kernel_trap_vmids() in each gfxhub version to write
SQ_SHADER_TBA_LO/HI and SQ_SHADER_TMA_LO/HI registers for kernel queue
VMIDs (1..first_kfd_vmid-1) using SRBM select.

Only kernel queue VMIDs are programmed here. User queue VMIDs
(first_kfd_vmid..15) are handled by MES via the ADD_QUEUE packet's
trap_handler_addr field and must not be touched by the driver.

The TBA address points to the device-level CWSR ISA BO (isa_bo).
The TMA address points to the device-level scratch BO (kq_tma_bo).
Both are pinned GTT BOs and cannot be evicted. Addresses are stored
as addr >> 8 to match the hardware register format (256-byte aligned).
TRAP_EN is set in TBA_HI to enable trap handling for each VMID.

WARN_ON is used to catch alignment regressions at development time.
The null check on gfx.funcs->select_me_pipe_q guards against calls
before GFX IP is fully initialized.

GFX10 (gfxhub_v2_0): uses mm-prefixed registers.
GFX11 (gfxhub_v3_0, gfxhub_v11_5_0): uses reg-prefixed registers.
GFX12 (gfxhub_v12_0): uses reg-prefixed registers.
GFX12.1 (gfxhub_v12_1): multi-XCC, iterates over all XCC instances.

The function is called at two points:
  1. amdgpu_trap_init() — first boot, after ISA and TMA BOs are ready
  2. setup_vmid_config() — GPU resume, after GART registers are restored

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alexander Deucher <alexander.deucher@amd.com>
Cc: Timur Kristof <timur.kristof@valve.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 43 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 34 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 37 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 34 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 34 ++++++++++++++++
 5 files changed, 182 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 652eea6eae4a..32d651be9ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "gfxhub_v11_5_0.h"
+#include "amdgpu_trap.h"
 
 #include "gc/gc_11_5_0_offset.h"
 #include "gc/gc_11_5_0_sh_mask.h"
@@ -290,6 +291,44 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+/*
+ * MES owns kernel VMIDs but does not program trap handler registers.
+ * Program SQ_SHADER_TBA/TMA directly via SRBM select so the first-level
+ * CWSR handler is active for kernel queue VMIDs. Required for RADV
+ * debugging (Valve/Steam Deck) and future Navi ray tracing on kernel queues.
+ */
+static void gfxhub_v11_5_0_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = amdgpu_bo_gpu_offset(adev->trap_info->kq_tma_bo);
+	int i;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	/* Program VMIDs 1..first_kfd_vmid-1 (kernel queue range only).
+	 * User queue VMIDs (first_kfd_vmid..15) are programmed by MES.
+	 */
+	for (i = 1; i < adev->vm_manager.first_kfd_vmid; i++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, 0);
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
@@ -337,6 +376,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v11_5_0_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
@@ -459,6 +501,7 @@ static void gfxhub_v11_5_0_set_fault_enable_default(struct amdgpu_device *adev,
 static const struct amdgpu_vmhub_funcs gfxhub_v11_5_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v11_5_0_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v11_5_0_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v11_5_0_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v11_5_0_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 6cbf837d50dd..ffab4a25ec6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -28,6 +28,7 @@
 #include "gc/gc_12_0_0_sh_mask.h"
 #include "soc24_enum.h"
 #include "soc15_common.h"
+#include "amdgpu_trap.h"
 
 #define regGCVM_L2_CNTL3_DEFAULT	0x80120007
 #define regGCVM_L2_CNTL4_DEFAULT	0x000000c1
@@ -295,6 +296,35 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void gfxhub_v12_0_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = amdgpu_bo_gpu_offset(adev->trap_info->kq_tma_bo);
+	int i;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 1; i < adev->vm_manager.first_kfd_vmid; i++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, 0);
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
@@ -342,6 +372,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_0_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
@@ -464,6 +497,7 @@ static void gfxhub_v12_0_set_fault_enable_default(struct amdgpu_device *adev,
 static const struct amdgpu_vmhub_funcs gfxhub_v12_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v12_0_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v12_0_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v12_0_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v12_0_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c2fd1e6616e..de162c5066ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v12_1.h"
 
@@ -406,6 +407,38 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
 	}
 }
 
+static void gfxhub_v12_1_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = amdgpu_bo_gpu_offset(adev->trap_info->kq_tma_bo);
+	u32 xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	int i, j;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	for_each_inst(j, xcc_mask) {
+		mutex_lock(&adev->srbm_mutex);
+		for (i = 1; i < adev->vm_manager.first_kfd_vmid; i++) {
+			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, j);
+			WREG32_SOC15(GC, GET_INST(GC, j), regSQ_SHADER_TBA_LO,
+				     lower_32_bits(tba_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, j), regSQ_SHADER_TBA_HI,
+				     upper_32_bits(tba_addr >> 8) |
+				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+			WREG32_SOC15(GC, GET_INST(GC, j), regSQ_SHADER_TMA_LO,
+				     lower_32_bits(tma_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, j), regSQ_SHADER_TMA_HI,
+				     upper_32_bits(tma_addr >> 8));
+		}
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, j);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+}
+
 static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					       uint32_t xcc_mask)
 {
@@ -468,6 +501,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 
 		hub->vm_cntx_cntl = tmp;
 	}
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_1_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
@@ -751,6 +787,7 @@ static void gfxhub_v12_1_print_l2_protection_fault_status(struct amdgpu_device *
 static const struct amdgpu_vmhub_funcs gfxhub_v12_1_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v12_1_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v12_1_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v12_1_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9ea593e2c719..52a6ee09b036 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_0.h"
 
 #include "gc/gc_10_1_0_offset.h"
@@ -280,6 +281,35 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void gfxhub_v2_0_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = amdgpu_bo_gpu_offset(adev->trap_info->kq_tma_bo);
+	int i;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 1; i < adev->vm_manager.first_kfd_vmid; i++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, 0);
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
@@ -327,6 +357,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v2_0_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
@@ -428,6 +461,7 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v2_0_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v2_0_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v2_0_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v2_0_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 9e6a6e13dec0..287e7ea43287 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v3_0.h"
 
 #include "gc/gc_11_0_0_offset.h"
@@ -287,6 +288,35 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void gfxhub_v3_0_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = amdgpu_bo_gpu_offset(adev->trap_info->kq_tma_bo);
+	int i;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 1; i < adev->vm_manager.first_kfd_vmid; i++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, 0);
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
@@ -334,6 +364,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v3_0_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
@@ -456,6 +489,7 @@ static void gfxhub_v3_0_set_fault_enable_default(struct amdgpu_device *adev,
 static const struct amdgpu_vmhub_funcs gfxhub_v3_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v3_0_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v3_0_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v3_0_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v3_0_init(struct amdgpu_device *adev)
-- 
2.34.1

