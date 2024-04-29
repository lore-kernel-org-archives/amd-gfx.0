Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D598BC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294BE10E276;
	Mon, 29 Apr 2024 14:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jQ4idQhA";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FD510E3D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxzMTZfbt/iq+lGXEoecEkh/Xsz7M7Ps7p/jIWhXsjNHx+Zl4zA2zdszSFsWqBeagXGcDOxKoIgG4OTxRMajSX9RCI+83eDP8EgYHe2OVL9x++YpYpibCiY9Bws+1lHQaehlOn2U2msZqQ/Hb2w7TBLq/JbVvqztcNxR3qUvFQmNpX4/SABX/yyXN2Exh/WpG+6ZYkvC3VNsE2dH8CUHp2y2g+1U4hSHrCvXtsxcxolETT4lVmPVm2V/NQPwd5+5YmJ6tH47n07eIlGxEg6oX6UiKt4Jd+bEzfrwl5iqqa5TYvb6WwRad1pADYJ8Sg6v4yb5z+deM3RsTqvHVkV1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52bK9i41BLQ/RyuahSZKu7s2csmw/n79vN0FDDaioQU=;
 b=P7e5QergAMH6bu7pTGMB4sI9hHclh7IlcWQPxfCTmUOvLqrXQl7wvYm+Keqmuf1MEoBSON8CpViKDE2vWo9BexA3LBJuiI6LsfVvTlhGdbl0s8k47EuA/CiWecqdJ6DgNAIJ/nqHLyckomaq4xp2YjAMofQjQ50QiI28SeCcYbgHX+hiQKBjucEh8JQPaTYaOm2Pwwn7q2XqyaPWoCQPO+aHsqgT5kvcsgCD3znDuXAHUpPJQ2/z4dfmyh3RY8x5krNR+Fi0SXxmQWywvIlpci6hrBwDlKu+N6M1a5jSZWTAFiV/+iF0nR59PCaIGUIIeIGFoEYOdheekHbQNcgnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52bK9i41BLQ/RyuahSZKu7s2csmw/n79vN0FDDaioQU=;
 b=jQ4idQhAk2WgYEXY/wsO0m4Oed+bQcVsYI+lc8GYpKNQ49+oDthQwqGNuKpQT4SRfh9PS7g2S58qpDZSy4pNilxsNHT7P07e/rLoOz+NTlnweZpRes6cYTIeRb8y69kWYmzc5chtncrPMnGpMiYI7/2vluDrwluv8beX2hFCnD4=
Received: from BY5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:180::14)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:57:47 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::32) by BY5PR13CA0001.outlook.office365.com
 (2603:10b6:a03:180::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/14] drm/amdkfd: Added gfx_v12_kfd2kgd interface for GFX12.
Date: Mon, 29 Apr 2024 10:57:14 -0400
Message-ID: <20240429145726.3459450-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc5ea7d-dedf-493b-8956-08dc685cbb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q/WT+gzO9VCAua/wBERr30LYxLCOX2WG6wr2l8/z8w2X/iW1y3gPyx61WoqV?=
 =?us-ascii?Q?NNQbh3All+sEXqu8U32uYuYMDxPFg1D6SO3QnhEdzhfY/vzt70pTjL0z7Gl3?=
 =?us-ascii?Q?rx3vKAEsRlIlGDkjVNyItXSFlrehFNAhazU5iIcZWFwN5EEPXt9wfVNclm8T?=
 =?us-ascii?Q?mUUgJx8dE0zpx4a3i7G2aXTYuEnBVpq7IwddGvVzk62XYangH7JLAhjP/DFi?=
 =?us-ascii?Q?OL25bEwiXqFoagfL+xj/rOAGjWWg+cg0aSziqAFlT24T0Kv72gG2ze4oUzOX?=
 =?us-ascii?Q?JCqbPU2d6ver/7iUEXLoCaIAi1tZ8bX81ant2diVNW4lszR9uu5VM6pjHFEn?=
 =?us-ascii?Q?t8GDLFg3TNm1Zm8BOvIxSEpESoza5c/ooKqk1ekSCKRi1iQ/XuRnpeREaskz?=
 =?us-ascii?Q?WRBgJ67LOAOC01sTUCXJ1bUuzuzcpwUSbQOwI/oV3IzOvrRwb7LIFxeEtqDe?=
 =?us-ascii?Q?0+JqFsSKul94U55j5dNJKdmvIwTjAb6i/guvEe3J22vAMKarwyWXgOmACJT3?=
 =?us-ascii?Q?o452WRY9mknoFyzxdjzGyUJydDaXI1yC3GjzzTZ7q4lm6mTu6UgP/+1pUtqG?=
 =?us-ascii?Q?8M0cDzygZzvDVz8w6MGp/eBnrgmireCmkWnSdRDB3t/qNcmNVTE9l0qKHreO?=
 =?us-ascii?Q?I5d1UJPyhC5rwPWRBR4naOZD/lqUAeKMsqrXw1s2rAuj5NGbgJU6znZi/GyU?=
 =?us-ascii?Q?DxsnjsVCNMHg5iXc07Aqlltk08ZgNJTiJ+BaldJF64f4JvEwrHagF90RGi+o?=
 =?us-ascii?Q?OwySeny1419n5Pbu0vvKFGa9VxRIObtTFs8VGYCCSIhaRp8Hv9jDW9Shrg7S?=
 =?us-ascii?Q?soVHIAHdclX4obTCL07vy9PTCwV+gu7rp/BJixs3k+LnGxzrfmDBeB43/pMo?=
 =?us-ascii?Q?INLXDv9Zdrvvv2Trg185ZFdHRjywC/VnsNCzNFjS7ekSd8OHIMgrNJHQ7igh?=
 =?us-ascii?Q?uPpzTQzRaCHVG4TRNqj3h4Ky6BAxVVAF1Wutj7lvI3tkFv2RjVhBdiAvJ4CO?=
 =?us-ascii?Q?FVeCNcskHfw5y+65AbKQBYk2F/6IDUiWBydAZZpBLVbktXPpn+iqlle1Z+E2?=
 =?us-ascii?Q?Wal99h3UkW84PSGLMpW6VIw+37scCG59TIa7vgthnprKkjvMf09qAiX+UfMU?=
 =?us-ascii?Q?BsRJJxaggBEnJcc5x7bxpQaYB6U5RdqJbZq4uen5UsajaiuddmdUX/7hJIK3?=
 =?us-ascii?Q?d+u/rANAEvVkgA7bwQNL/cc+tLp1G/D83rjozviuTxlXpRknsT8iivaSRq5d?=
 =?us-ascii?Q?QJvxLjiXkGRF+WDF4/qWp9Sz1dnC90UFeEm9Vx64ZxJfL0FGqg4PiA5v/fSB?=
 =?us-ascii?Q?XptgHIHb3rcYVhrOymoYABz+qOmVUaWcUrpGsdY7O4FvYFH4svesidDszCsL?=
 =?us-ascii?Q?3XbSugHOYp/oNy/5vEGuLhrvA1wB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:46.7455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc5ea7d-dedf-493b-8956-08dc685cbb53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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

From: David Belanger <david.belanger@amd.com>

Initial implementation, based on GFX11.

v2: Removed functions not needed by cp scheduler.
v3: Fixed typos.
v4: squash in warning fix (Alex)

Signed-off-by: David Belanger <david.belanger@amd.com>
Acked-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c    | 339 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   5 +-
 3 files changed, 344 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 099a47b3e0496..de7b76327f5ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -281,7 +281,8 @@ amdgpu-y += \
 	amdgpu_amdkfd_gc_9_4_3.o \
 	amdgpu_amdkfd_gfx_v10.o \
 	amdgpu_amdkfd_gfx_v10_3.o \
-	amdgpu_amdkfd_gfx_v11.o
+	amdgpu_amdkfd_gfx_v11.o \
+	amdgpu_amdkfd_gfx_v12.o
 
 ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
 amdgpu-y += amdgpu_amdkfd_gfx_v7.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
new file mode 100644
index 0000000000000..5aa2fd147d99d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -0,0 +1,339 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+#include "gc/gc_12_0_0_offset.h"
+#include "gc/gc_12_0_0_sh_mask.h"
+#include "soc24.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
+			uint32_t queue, uint32_t vmid)
+{
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, mec, pipe, queue, vmid);
+}
+
+static void unlock_srbm(struct amdgpu_device *adev)
+{
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t queue_id)
+{
+	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	lock_srbm(adev, mec, pipe, queue_id, 0);
+}
+
+static void release_queue(struct amdgpu_device *adev)
+{
+	unlock_srbm(adev);
+}
+
+static int init_interrupts_v12(struct amdgpu_device *adev, uint32_t pipe_id, uint32_t inst)
+{
+	uint32_t mec;
+	uint32_t pipe;
+
+	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	lock_srbm(adev, mec, pipe, 0, 0);
+
+	WREG32_SOC15(GC, 0, regCPC_INT_CNTL,
+		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
+		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
+
+	unlock_srbm(adev);
+
+	return 0;
+}
+
+static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
+				unsigned int engine_id,
+				unsigned int queue_id)
+{
+	uint32_t sdma_engine_reg_base = 0;
+	uint32_t sdma_rlc_reg_offset;
+
+	switch (engine_id) {
+	case 0:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				regSDMA0_QUEUE0_RB_CNTL) - regSDMA0_QUEUE0_RB_CNTL;
+		break;
+	case 1:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
+				regSDMA1_QUEUE0_RB_CNTL) - regSDMA0_QUEUE0_RB_CNTL;
+		break;
+	default:
+		BUG();
+	}
+
+	sdma_rlc_reg_offset = sdma_engine_reg_base
+		+ queue_id * (regSDMA0_QUEUE1_RB_CNTL - regSDMA0_QUEUE0_RB_CNTL);
+
+	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
+			queue_id, sdma_rlc_reg_offset);
+
+	return sdma_rlc_reg_offset;
+}
+
+static int hqd_dump_v12(struct amdgpu_device *adev,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
+{
+	uint32_t i = 0, reg;
+#define HQD_N_REGS 56
+#define DUMP_REG(addr) do {				\
+		if (WARN_ON_ONCE(i >= HQD_N_REGS))	\
+			break;				\
+		(*dump)[i][0] = (addr) << 2;		\
+		(*dump)[i++][1] = RREG32(addr);		\
+	} while (0)
+
+	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	if (*dump == NULL)
+		return -ENOMEM;
+
+	acquire_queue(adev, pipe_id, queue_id);
+
+	for (reg = SOC15_REG_OFFSET(GC, 0, regCP_MQD_BASE_ADDR);
+	     reg <= SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_WPTR_HI); reg++)
+		DUMP_REG(reg);
+
+	release_queue(adev);
+
+	WARN_ON_ONCE(i != HQD_N_REGS);
+	*n_regs = i;
+
+	return 0;
+}
+
+static int hqd_sdma_dump_v12(struct amdgpu_device *adev,
+			     uint32_t engine_id, uint32_t queue_id,
+			     uint32_t (**dump)[2], uint32_t *n_regs)
+{
+	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
+			engine_id, queue_id);
+	uint32_t i = 0, reg;
+
+	const uint32_t first_reg = regSDMA0_QUEUE0_RB_CNTL;
+	const uint32_t last_reg = regSDMA0_QUEUE0_CONTEXT_STATUS;
+#undef HQD_N_REGS
+#define HQD_N_REGS (last_reg - first_reg + 1)
+
+	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	if (*dump == NULL)
+		return -ENOMEM;
+
+	for (reg = first_reg;
+	     reg <= last_reg; reg++)
+		DUMP_REG(sdma_rlc_reg_offset + reg);
+
+	WARN_ON_ONCE(i != HQD_N_REGS);
+	*n_regs = i;
+
+	return 0;
+}
+
+static int wave_control_execute_v12(struct amdgpu_device *adev,
+					uint32_t gfx_index_val,
+					uint32_t sq_cmd, uint32_t inst)
+{
+	uint32_t data = 0;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX), gfx_index_val);
+	WREG32(SOC15_REG_OFFSET(GC, 0, regSQ_CMD), sq_cmd);
+
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		INSTANCE_BROADCAST_WRITES, 1);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		SA_BROADCAST_WRITES, 1);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		SE_BROADCAST_WRITES, 1);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX), data);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v12_enable_debug_trap(struct amdgpu_device *adev,
+					    bool restore_dbg_registers,
+					    uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v12_disable_debug_trap(struct amdgpu_device *adev,
+						bool keep_trap_enabled,
+						uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, keep_trap_enabled);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+static int kgd_gfx_v12_validate_trap_override_request(struct amdgpu_device *adev,
+							uint32_t trap_override,
+							uint32_t *trap_mask_supported)
+{
+	*trap_mask_supported &= KFD_DBG_TRAP_MASK_FP_INVALID |
+				KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+				KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+				KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+				KFD_DBG_TRAP_MASK_FP_INEXACT |
+				KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION;
+
+	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
+			trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
+		return -EPERM;
+
+	return 0;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v12_set_wave_launch_trap_override(struct amdgpu_device *adev,
+					uint32_t vmid,
+					uint32_t trap_override,
+					uint32_t trap_mask_bits,
+					uint32_t trap_mask_request,
+					uint32_t *trap_mask_prev,
+					uint32_t kfd_dbg_trap_cntl_prev)
+
+{
+	uint32_t data = 0;
+
+	*trap_mask_prev = REG_GET_FIELD(kfd_dbg_trap_cntl_prev, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
+	trap_mask_bits = (trap_mask_bits & trap_mask_request) |
+		(*trap_mask_prev & ~trap_mask_request);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, trap_mask_bits);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, trap_override);
+
+	return data;
+}
+
+/* returns STALL_VMID or LAUNCH_MODE. */
+static uint32_t kgd_gfx_v12_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid)
+{
+	uint32_t data = 0;
+	bool is_stall_mode = wave_launch_mode == 4;
+
+	if (is_stall_mode)
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, STALL_VMID,
+									1);
+	else
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, LAUNCH_MODE,
+							wave_launch_mode);
+
+	return data;
+}
+
+#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H - regTCP_WATCH0_ADDR_H)
+static uint32_t kgd_gfx_v12_set_address_watch(struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode,
+					uint32_t debug_vmid,
+					uint32_t inst)
+{
+	uint32_t watch_address_high;
+	uint32_t watch_address_low;
+	uint32_t watch_address_cntl;
+
+	watch_address_cntl = 0;
+	watch_address_low = lower_32_bits(watch_address);
+	watch_address_high = upper_32_bits(watch_address) & 0xffff;
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 7);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			1);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_high);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_L) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_low);
+
+	return watch_address_cntl;
+}
+
+static uint32_t kgd_gfx_v12_clear_address_watch(struct amdgpu_device *adev,
+					uint32_t watch_id)
+{
+	return 0;
+}
+
+const struct kfd2kgd_calls gfx_v12_kfd2kgd = {
+	.init_interrupts = init_interrupts_v12,
+	.hqd_dump = hqd_dump_v12,
+	.hqd_sdma_dump = hqd_sdma_dump_v12,
+	.wave_control_execute = wave_control_execute_v12,
+	.get_atc_vmid_pasid_mapping_info = NULL,
+	.enable_debug_trap = kgd_gfx_v12_enable_debug_trap,
+	.disable_debug_trap = kgd_gfx_v12_disable_debug_trap,
+	.validate_trap_override_request = kgd_gfx_v12_validate_trap_override_request,
+	.set_wave_launch_trap_override = kgd_gfx_v12_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_gfx_v12_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v12_set_address_watch,
+	.clear_address_watch = kgd_gfx_v12_clear_address_watch,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bce190896a156..1e21908e972fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -56,6 +56,7 @@ extern const struct kfd2kgd_calls gc_9_4_3_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v11_kfd2kgd;
+extern const struct kfd2kgd_calls gfx_v12_kfd2kgd;
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
@@ -438,11 +439,11 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			break;
 		case IP_VERSION(12, 0, 0):
 			gfx_target_version = 120000;
-			f2g = &gfx_v11_kfd2kgd; /* GFX12_TODO: Change to v12 when available. */
+			f2g = &gfx_v12_kfd2kgd;
 			break;
 		case IP_VERSION(12, 0, 1):
 			gfx_target_version = 120001;
-			f2g = &gfx_v11_kfd2kgd; /* GFX12_TODO: Change to v12 when available. */
+			f2g = &gfx_v12_kfd2kgd;
 			break;
 		default:
 			break;
-- 
2.44.0

