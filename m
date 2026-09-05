Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC7FC624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 08:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E0510E5C6;
	Sat,  5 Sep 2026 08:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KdSC5aDF";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8DC510E5C6
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 08:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ios/5hHfbT1diDk2wfn/rp3JZ533Fzq1kDUq7tELSMXLU9VISiLoZLjOqnKhtq+Q0kjLkuMe//A9ge93TZnXIJG8cNYM7uyjXKc4jFaPWENaVevrbefJHDo+mCWznhSfP2+qc7CfCuenMBS5BEhL6p1ZysE7yXR3/8YGSG7mibMW0+RmUgU0kLQsXBFfezbEwWVbfSKApFMLSnAOIhHj71cD/Fxz2tZmbYIX+/+MSl7TjQPVb4D4PlEShIiqQLEXDzgCHi1OfIW9wfvJpl8bl5C0062h2rcprlrYd62mNjSXIk6aD847b+y+o5sVb//evuRBZOe/BFN7koztxRKThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjt0+Lc2G9geuhBn+iKW1OtFW1aZYYHd2z2VwZPZsFw=;
 b=LOspI2hqavpTs9lQu2kIhekCJv78uCBEhl04BbbEZAfTZ94bex0w1HySrZ4vx88XferA4lnR2WIKe+Tr/qg10Vw1kVwTuZxHHXGwUmqLPU7QynqvecMcPZ0z0wy9x0aOhfwhihPA+H737ZWMcYBRwmduWyB+q+1ZIXUdJGpIXnqBwUm9leFiZ1k9Xy6xvxeLf0m9ofPqrElrmwjNLf641FYNLKkGVNxrPGU3nvLuke4eBZLcHWMkWXWFohfrJ0pbBhWR4bKDjCHMfknvOsvp4+mzQyNrR+PtFCSK8JKihDHL/xD2nmWvxsCDXjZfmVg0Nn1vnmT2GCwNU7GXQSu0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjt0+Lc2G9geuhBn+iKW1OtFW1aZYYHd2z2VwZPZsFw=;
 b=KdSC5aDFqS/dmb74gWUvjOOsV/xnKdd+E8rE04oNl/ancxGRNaz3UhkKLJSWzRc2DvIY35fi3P0BzLl+2Acy5RPhGJJ3W3kzx/klUscc3tqUz8/zY4/48Nv3fdb+BdD1rQQGIQgZJLvlpSIexP38lP040uRTFBjDtfHI8nF7u/M=
Received: from SJ0PR05CA0125.namprd05.prod.outlook.com (2603:10b6:a03:33d::10)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sat, 5 Sep
 2026 08:20:08 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::51) by SJ0PR05CA0125.outlook.office365.com
 (2603:10b6:a03:33d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Sat, 5
 Sep 2026 08:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 08:20:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 03:19:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>, Samuel Pitoiset
 <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH 2/3] drm/amdgpu: Implement kernel VMID SQ_SHADER_TBA/TMA
 programming for GFX10/11/12
Date: Sat, 5 Sep 2026 13:49:34 +0530
Message-ID: <20260905081935.338775-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2e42cc-17ba-4009-43e0-08df0b267da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HuwxBAlkuHtqA/aLpXM4j5JZWZ2ENinUE2N6DvRIZov9N+j0a7xsziKeIsrotOf/78aOnYzEz0qpELAvYXX0iKcwxhtVRYTpZw+yrU9O2bV7ASm82jDun0Su2CTZcyDDkCiLeweLNQqlHCVI29W8SBWaOfRJ2fj8kEFVsks42QKNX0nwC/NjrFsL5raoTolQix0m2K/OR9oBCidy+NbeGPM2y1wVY3QQ2H87DxX5j3vTO5RQAR8udYvbZQEc6ngAMjM1A+wxiTobg+0Q7uL0UdAy5v7lhJ29NxziT1J1FFpBeol7kYX1RheeOqmQ/IOAiOOEQMgWRe2KNlfWvdJFakJWfpOjyKQqG6JCGILIsaZPxdc+9mNwei34ZbdG2P+OBq7M7VG+esQsGVKpf8e5T7te90WUxFIAtjTJ+cKzzc2FRdJh3jmDKqrD8Z5ftaiG+BgMEnggpnJBoRguESWWfVM4+E1HqAaEcT6fzbfqdSJJtbBYgSB9RXymDr5nMdly6AOzWVD91iZ9OnCtqerr8+ZGDF3vBis/95/ankd9bXdgY0+gJvjYRXpvsYOE6fH3M1yqBP1xUpoXCqKsDiwgPQan0jwEOkSNBj6wxuAomuAevsSILxne6GA9I1zpTyQ8/22e15WlnFd4kRnyF2p6X2yPNBk+d+I2yCy7Xc23elEYMQLp32ygXND5qkouls8BxgSPuOk6BPPauQhAy2sI+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SkXoAKxi+XWHQ5ENRy0W7g5mgz8ZY99kw7j/Vhp4v3Jt23omK8BXACwFk848sSwUdMgIRBYNq8sV9S/y4cATEi03m0GkqQ3MDBgnTrytQ39+8UrWZXXwFmNV0nEK4Sco9VV+VRGfOaGBE8hMlCGQnuEsAOw93yQoeXE4BfD2ctjBMN0PmslwuNAgw9MQOiIrkl7DLBbC+m1bbBlB/bGTndQzA1QCU+V7EujySF2Neg6qf2xMfBr+CW8lKii2+rUulPk37Pl5eQgcf5zHOqppwEUw0+wDdr04+4ChpW5SEl7FNDfzXI0C70JiS3iScgf8HGShxdJolShjPbBl7VzPIsm8NMfaSg9xVdj047MvgpGBy6/XNhbVORjU7lKeRWfVptpl5gMXuYqa8+PELrPFvCWUOa2uFSGMrKYo/a9XxxO4baL1jbmRfNbpQy+d+Gii
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 08:20:05.3128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2e42cc-17ba-4009-43e0-08df0b267da0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
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

Implement the program_kernel_trap_vmids() vmhub callback for all
supported hardware generations. Each implementation programs
SQ_SHADER_TBA/TMA for kernel queue VMIDs (1..first_kfd_vmid-1)
via SRBM select.

TBA points to the device-level CWSR ISA BO — same binary for all VMIDs.
TMA is set to AMDGPU_VA_RESERVED_TRAP_START, the fixed virtual address
where each VM's kq_tma_bo is mapped. The hardware resolves this VA
through the active VMID's page tables, giving each process its own
physical TMA buffer without requiring per-submission register updates.

User queue VMIDs (first_kfd_vmid..15) must not be touched here — they
are programmed by MES via the ADD_QUEUE packet's trap_handler_addr field.

The function is called at two points:
  1. amdgpu_trap_init()     — first boot, after ISA BO is ready
  2. setup_vmid_config()    — GPU resume, after GART is restored

GFX versions covered:
  GFX10   (gfxhub_v2_0):    mm-prefixed registers, single XCC
  GFX11   (gfxhub_v3_0):    reg-prefixed registers, single XCC
  GFX11.5 (gfxhub_v11_5_0): reg-prefixed registers, single XCC
  GFX12   (gfxhub_v12_0):   reg-prefixed registers, single XCC
  GFX12.1 (gfxhub_v12_1):   reg-prefixed registers, multi-XCC

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I2fa05a8ac96e5fe4b6e5f79dbdf62f32b8dbf96f
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 38 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 38 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 36 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 38 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 33 ++++++++++++++++++
 5 files changed, 183 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 652eea6eae4a..b6f43c8274d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v11_5_0.h"
 
 #include "gc/gc_11_5_0_offset.h"
@@ -290,6 +291,39 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+/*
+ * MES owns kernel VMIDs but does not program trap handler registers.
+ * Program SQ_SHADER_TBA/TMA directly via SRBM select so the first-level
+ * CWSR handler is active for kernel queue VMIDs.
+ */
+static void gfxhub_v11_5_0_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	int i;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
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
 static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -337,6 +371,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v11_5_0_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
@@ -459,6 +496,7 @@ static void gfxhub_v11_5_0_set_fault_enable_default(struct amdgpu_device *adev,
 static const struct amdgpu_vmhub_funcs gfxhub_v11_5_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v11_5_0_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v11_5_0_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v11_5_0_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v11_5_0_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 6cbf837d50dd..5b2f0f59b895 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v12_0.h"
 
 #include "gc/gc_12_0_0_offset.h"
@@ -295,6 +296,39 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+/*
+ * MES owns kernel VMIDs but does not program trap handler registers.
+ * Program SQ_SHADER_TBA/TMA directly via SRBM select so the first-level
+ * CWSR handler is active for kernel queue VMIDs.
+ */
+static void gfxhub_v12_0_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	int i;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
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
@@ -342,6 +376,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_0_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
@@ -464,6 +501,7 @@ static void gfxhub_v12_0_set_fault_enable_default(struct amdgpu_device *adev,
 static const struct amdgpu_vmhub_funcs gfxhub_v12_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v12_0_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v12_0_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v12_0_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v12_0_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c2fd1e6616e..528917913950 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v12_1.h"
 
@@ -406,6 +407,37 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
 	}
 }
 
+static void gfxhub_v12_1_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	u32 xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	int i, j;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
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
@@ -468,6 +500,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 
 		hub->vm_cntx_cntl = tmp;
 	}
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_1_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
@@ -751,6 +786,7 @@ static void gfxhub_v12_1_print_l2_protection_fault_status(struct amdgpu_device *
 static const struct amdgpu_vmhub_funcs gfxhub_v12_1_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v12_1_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v12_1_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v12_1_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9ea593e2c719..47a25df2a0c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_0.h"
 
 #include "gc/gc_10_1_0_offset.h"
@@ -280,6 +281,39 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+/*
+ * MES owns kernel VMIDs but does not program trap handler registers.
+ * Program SQ_SHADER_TBA/TMA directly via SRBM select so the first-level
+ * CWSR handler is active for kernel queue VMIDs.
+ */
+static void gfxhub_v2_0_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	int i;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
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
@@ -327,6 +361,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v2_0_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
@@ -428,6 +465,7 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v2_0_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v2_0_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v2_0_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v2_0_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 9e6a6e13dec0..2f59de6e9407 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v3_0.h"
 
 #include "gc/gc_11_0_0_offset.h"
@@ -287,6 +288,34 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void gfxhub_v3_0_program_kernel_trap_vmids(struct amdgpu_device *adev)
+{
+	u64 tba_addr = amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
+	u64 tma_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+	int i;
+
+	if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
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
@@ -334,6 +363,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v3_0_program_kernel_trap_vmids(adev);
 }
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
@@ -456,6 +488,7 @@ static void gfxhub_v3_0_set_fault_enable_default(struct amdgpu_device *adev,
 static const struct amdgpu_vmhub_funcs gfxhub_v3_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v3_0_print_l2_protection_fault_status,
 	.get_invalidate_req = gfxhub_v3_0_get_invalidate_req,
+	.program_kernel_trap_vmids = gfxhub_v3_0_program_kernel_trap_vmids,
 };
 
 static void gfxhub_v3_0_init(struct amdgpu_device *adev)
-- 
2.34.1

