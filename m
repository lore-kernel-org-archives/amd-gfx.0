Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43BEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461D310EA2F;
	Thu, 28 Apr 2022 18:54:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3569810EA2F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I96RadrpNUXwSSEQwLGKsmF7rZhVVqlR975fukruGwvTPh93kT7HyZR5v2Lw6BeXLn/oytAE9vwhmQckme2CybMoiIgDyaCiqRMOW5KHRdaTUaAWbFltGX2L2pmI4a63C5QL2S0F4vKei8MI/PUOZE7tUFp9vJXr4T7RQnLHGb/nNopedxpS8Sn46bR7c22eSMSroFxt+qUpm2yPdoiY3kfQ10ntvN8mCUbDAwKNEG+rfLqp3lklPUeKzKR8l6VpQGg7gRprmupHrz4ItLaRl1rVoq6FGqGOK+C8PAO5pyaLNr/xJ/4z/RC6yOetrMufKd75FbN08lvSClBsOHRfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8Yx8XLJ86nCJ4J5xSIK3ME594bLN/INFNLOhqxSgHg=;
 b=g5VFf3BNnuN5HLopt2lEhjVmD1R0s8cVwIpAWeupCd81Ohyg/8FnkGtVUkbAlOX1rD03E3jEYTzrf61tT4C1l8pxMPL3AIpUt25e6bGQpNlhLgDBPmyuwUauRpTEMP6u5aSbK7WTdP3Ih0ekuBNMlpa9MyV6LZOnSyhcnLlZh8m+W3YN0kVM0wWz0lX3oRPjKtYYIMz5hlCC6XTzBUSfXgaILMiN4rCAxqMvUYdmqX3IQHVWnF5cU7XhcUqw5Qr63tX/mPiJ1SErv3nKS/blvpgaoihTyO1qhq5rBV3Vv+hKmmJ7PeakAbCGwFH0Jg8J96StIlMX9t/JWmiRarengQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8Yx8XLJ86nCJ4J5xSIK3ME594bLN/INFNLOhqxSgHg=;
 b=OppIlAQ4qbBEHascS/zf0jjRhTOCJI+Sqgu5Mjh/wmgRyRIfizEDq5LbCUVf6Wikn3b75RkTcOsLHqSAyy8bd9yxDX8CZRV59gFpSk21fz17pyH142yMgOmloTg+HapIuA2uPyz+tVWCeyaHeg2T5ZJgoX87r7B9MSPS3+2fTiI=
Received: from MW4PR03CA0117.namprd03.prod.outlook.com (2603:10b6:303:b7::32)
 by MWHPR1201MB2493.namprd12.prod.outlook.com (2603:10b6:300:ec::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 18:54:02 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::e4) by MW4PR03CA0117.outlook.office365.com
 (2603:10b6:303:b7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Thu, 28 Apr 2022 18:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:54:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:54:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add gmc v11_0 ip block (v3)
Date: Thu, 28 Apr 2022 14:53:48 -0400
Message-ID: <20220428185349.672503-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428185349.672503-1-alexander.deucher@amd.com>
References: <20220428185349.672503-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ca338e-e462-4cd0-a3d3-08da2948760b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2493:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB24933D3A5830491488018EF3F7FD9@MWHPR1201MB2493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAdQGgISkpOTDpofE0FSKvsdrisCvnlmalkFSo0ktFgSmBzZoGoRiLyWYsKbG4lg9Lu6YV8iLS1UEnHRT6K+NjSYcpoulUq/6r+TMFVGdVDM+Fww8WkhZ9adNy0UVTz9pRVJDvfbSLrqTODvkZ+WqmumME9Rs6qfkN7nZXQ/wPoXb0pMLQWRPxi2UJ6i5wgpTLmUepiWt3sYsMVqDWFtzgXzgEVF1/9E34DtZpmv94o3TN865CpkD/cPcjjMpXLFtjuP1qnvucRA8T3ek/zGwIWn0i5Xyh4usamYtAfapIAmCTF6XyT/JtttAemNmbSKkw0aD3A7pQANdoFS43RHk2LS3DwkhLToclq88eiUwwCXiQELPXDTytTBHCOhlaAr6hTA7EsvITngDLvkRZipbMcZXvhG9GMniITWy1MFjV8OwJF3oN6Cf+lOcRytGVgbLm1W0G8ZVTVSYmhGeDZIrvvMCCciFA0cFStiNklpHSc5q9tDfUjWNBbzR0ji6NBMHNgBq21Fn9nZlLZJH3UUwO2EmUaaguvGegDqumJ2QZz2yPh5idDKrt45CgvRQsfQmDDGl6DyYd0UOiRostecFjP4zjRhzN/KBik7zkWBwCkcHwjOrdP6sPyFCbvPNAGYfs2A2TY4sSYho3ZYdewzGIPI+HqvnYn2h8enhkYg+KYulwcSO0V22akZ4B0gpv2aLqHSHDW31QacBDEA7eMjXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(26005)(83380400001)(316002)(5660300002)(36860700001)(54906003)(8936002)(47076005)(426003)(336012)(6666004)(186003)(16526019)(36756003)(2616005)(7696005)(1076003)(508600001)(82310400005)(2906002)(30864003)(6916009)(356005)(40460700003)(4326008)(8676002)(70206006)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:54:01.9330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ca338e-e462-4cd0-a3d3-08da2948760b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2493
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Tianci.Yin" <tianci.yin@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

Add support for GPU memory controller v11.

v1: Add support for gmc v11.0
    Add gmc 11 block (Tianci)
v2: drop unused amdgpu_bo_late_init (Hawking)
v3: squash in various fix

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 966 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.h  |  30 +
 4 files changed, 1001 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 156de606f275..7a1b13fabebb 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -88,7 +88,7 @@ amdgpu-y += \
 	gmc_v8_0.o \
 	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o mmhub_v9_4.o \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
-	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o
+	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o gmc_v11_0.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ad8e7d486a7d..8e18d3fc4fab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -335,8 +335,10 @@ struct amdgpu_gfx {
 	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
 	/*ras */
-	struct ras_common_if			*ras_if;
-	struct amdgpu_gfx_ras	*ras;
+	struct ras_common_if		*ras_if;
+	struct amdgpu_gfx_ras		*ras;
+
+	bool				is_poweron;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
new file mode 100644
index 000000000000..4a5fdcbc1a83
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -0,0 +1,966 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+ *
+ */
+#include <linux/firmware.h>
+#include <linux/pci.h>
+#include "amdgpu.h"
+#include "amdgpu_atomfirmware.h"
+#include "gmc_v11_0.h"
+#include "umc_v8_7.h"
+#include "athub/athub_3_0_0_sh_mask.h"
+#include "athub/athub_3_0_0_offset.h"
+#include "oss/osssys_6_0_0_offset.h"
+#include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
+#include "navi10_enum.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "soc15_common.h"
+#include "nbio_v4_3.h"
+#include "gfxhub_v3_0.h"
+#include "mmhub_v3_0.h"
+#include "athub_v3_0.h"
+
+
+static int gmc_v11_0_ecc_interrupt_state(struct amdgpu_device *adev,
+					 struct amdgpu_irq_src *src,
+					 unsigned type,
+					 enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static int
+gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *src, unsigned type,
+				   enum amdgpu_interrupt_state state)
+{
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		/* MM HUB */
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, false);
+		/* GFX HUB */
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		/* MM HUB */
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, true);
+		/* GFX HUB */
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
+				       struct amdgpu_irq_src *source,
+				       struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
+	uint32_t status = 0;
+	u64 addr;
+
+	addr = (u64)entry->src_data[0] << 12;
+	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		/*
+		 * Issue a dummy read to wait for the status register to
+		 * be updated to avoid reading an incorrect value due to
+		 * the new fast GRBM interface.
+		 */
+		if (entry->vmid_src == AMDGPU_GFXHUB_0)
+			RREG32(hub->vm_l2_pro_fault_status);
+
+		status = RREG32(hub->vm_l2_pro_fault_status);
+		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+	}
+
+	if (printk_ratelimit()) {
+		struct amdgpu_task_info task_info;
+
+		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
+		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+
+		dev_err(adev->dev,
+			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, "
+			"for process %s pid %d thread %s pid %d)\n",
+			entry->vmid_src ? "mmhub" : "gfxhub",
+			entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid, task_info.process_name, task_info.tgid,
+			task_info.task_name, task_info.pid);
+		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
+			addr, entry->client_id);
+		if (!amdgpu_sriov_vf(adev))
+			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
+	}
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs gmc_v11_0_irq_funcs = {
+	.set = gmc_v11_0_vm_fault_interrupt_state,
+	.process = gmc_v11_0_process_interrupt,
+};
+
+static const struct amdgpu_irq_src_funcs gmc_v11_0_ecc_funcs = {
+	.set = gmc_v11_0_ecc_interrupt_state,
+	.process = amdgpu_umc_process_ecc_irq,
+};
+
+static void gmc_v11_0_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->gmc.vm_fault.num_types = 1;
+	adev->gmc.vm_fault.funcs = &gmc_v11_0_irq_funcs;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->gmc.ecc_irq.num_types = 1;
+		adev->gmc.ecc_irq.funcs = &gmc_v11_0_ecc_funcs;
+	}
+}
+
+/**
+ * gmc_v11_0_use_invalidate_semaphore - judge whether to use semaphore
+ *
+ * @adev: amdgpu_device pointer
+ * @vmhub: vmhub type
+ *
+ */
+static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
+				       uint32_t vmhub)
+{
+	return ((vmhub == AMDGPU_MMHUB_0) &&
+		(!amdgpu_sriov_vf(adev)));
+}
+
+static bool gmc_v11_0_get_atc_vmid_pasid_mapping_info(
+					struct amdgpu_device *adev,
+					uint8_t vmid, uint16_t *p_pasid)
+{
+#if 0 // TODO:
+	uint32_t value;
+
+	value = RREG32(SOC15_REG_OFFSET(ATHUB, 0, mmATC_VMID0_PASID_MAPPING)
+		     + vmid);
+	*p_pasid = value & ATC_VMID0_PASID_MAPPING__PASID_MASK;
+
+	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
+#else
+	return 0;
+#endif
+}
+
+/*
+ * GART
+ * VMID 0 is the physical GPU addresses as used by the kernel.
+ * VMIDs 1-15 are used for userspace clients and are handled
+ * by the amdgpu vm/hsa code.
+ */
+
+static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
+				   unsigned int vmhub, uint32_t flush_type)
+{
+	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(adev, vmhub);
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 tmp;
+	/* Use register 17 for GART */
+	const unsigned eng = 17;
+	unsigned int i;
+
+	spin_lock(&adev->gmc.invalidate_lock);
+	/*
+	 * It may lose gpuvm invalidate acknowldege state across power-gating
+	 * off cycle, add semaphore acquire before invalidation and semaphore
+	 * release after invalidation to avoid entering power gated state
+	 * to WA the Issue
+	 */
+
+	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
+	if (use_semaphore) {
+		for (i = 0; i < adev->usec_timeout; i++) {
+			/* a read return value of 1 means semaphore acuqire */
+			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
+					    hub->eng_distance * eng);
+			if (tmp & 0x1)
+				break;
+			udelay(1);
+		}
+
+		if (i >= adev->usec_timeout)
+			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
+	}
+
+	WREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+
+	/* Wait for ACK with a delay.*/
+	for (i = 0; i < adev->usec_timeout; i++) {
+		tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
+				    hub->eng_distance * eng);
+		tmp &= 1 << vmid;
+		if (tmp)
+			break;
+
+		udelay(1);
+	}
+
+	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
+	if (use_semaphore)
+		/*
+		 * add semaphore release after invalidation,
+		 * write with 0 means semaphore release
+		 */
+		WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
+			      hub->eng_distance * eng, 0);
+
+	/* Issue additional private vm invalidation to MMHUB */
+	if ((vmhub != AMDGPU_GFXHUB_0) &&
+	    (hub->vm_l2_bank_select_reserved_cid2)) {
+		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
+		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
+		inv_req |= (1 << 25);
+		/* Issue private invalidation */
+		WREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2, inv_req);
+		/* Read back to ensure invalidation is done*/
+		RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
+	}
+
+	spin_unlock(&adev->gmc.invalidate_lock);
+
+	if (i < adev->usec_timeout)
+		return;
+
+	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
+}
+
+/**
+ * gmc_v11_0_flush_gpu_tlb - gart tlb flush callback
+ *
+ * @adev: amdgpu_device pointer
+ * @vmid: vm instance to flush
+ *
+ * Flush the TLB for the requested page table.
+ */
+static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
+					uint32_t vmhub, uint32_t flush_type)
+{
+	if ((vmhub == AMDGPU_GFXHUB_0) && !adev->gfx.is_poweron)
+		return;
+
+	/* flush hdp cache */
+	adev->hdp.funcs->flush_hdp(adev, NULL);
+
+	/* For SRIOV run time, driver shouldn't access the register through MMIO
+	 * Directly use kiq to do the vm invalidation instead
+	 */
+	if (adev->gfx.kiq.ring.sched.ready &&
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+		const unsigned eng = 17;
+		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
+				1 << vmid);
+		return;
+	}
+
+	mutex_lock(&adev->mman.gtt_window_lock);
+	gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
+	mutex_unlock(&adev->mman.gtt_window_lock);
+	return;
+}
+
+/**
+ * gmc_v11_0_flush_gpu_tlb_pasid - tlb flush via pasid
+ *
+ * @adev: amdgpu_device pointer
+ * @pasid: pasid to be flush
+ *
+ * Flush the TLB for the requested pasid.
+ */
+static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					uint16_t pasid, uint32_t flush_type,
+					bool all_hub)
+{
+	int vmid, i;
+	signed long r;
+	uint32_t seq;
+	uint16_t queried_pasid;
+	bool ret;
+	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+
+	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
+		spin_lock(&adev->gfx.kiq.ring_lock);
+		/* 2 dwords flush + 8 dwords fence */
+		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
+		kiq->pmf->kiq_invalidate_tlbs(ring,
+					pasid, flush_type, all_hub);
+		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+		if (r) {
+			amdgpu_ring_undo(ring);
+			spin_unlock(&adev->gfx.kiq.ring_lock);
+			return -ETIME;
+		}
+
+		amdgpu_ring_commit(ring);
+		spin_unlock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (r < 1) {
+			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
+			return -ETIME;
+		}
+
+		return 0;
+	}
+
+	for (vmid = 1; vmid < 16; vmid++) {
+
+		ret = gmc_v11_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
+				&queried_pasid);
+		if (ret	&& queried_pasid == pasid) {
+			if (all_hub) {
+				for (i = 0; i < adev->num_vmhubs; i++)
+					gmc_v11_0_flush_gpu_tlb(adev, vmid,
+							i, flush_type);
+			} else {
+				gmc_v11_0_flush_gpu_tlb(adev, vmid,
+						AMDGPU_GFXHUB_0, flush_type);
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static uint64_t gmc_v11_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
+					     unsigned vmid, uint64_t pd_addr)
+{
+	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+	unsigned eng = ring->vm_inv_eng;
+
+	/*
+	 * It may lose gpuvm invalidate acknowldege state across power-gating
+	 * off cycle, add semaphore acquire before invalidation and semaphore
+	 * release after invalidation to avoid entering power gated state
+	 * to WA the Issue
+	 */
+
+	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
+	if (use_semaphore)
+		/* a read return value of 1 means semaphore acuqire */
+		amdgpu_ring_emit_reg_wait(ring,
+					  hub->vm_inv_eng0_sem +
+					  hub->eng_distance * eng, 0x1, 0x1);
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
+					    hub->eng_distance * eng,
+					    hub->vm_inv_eng0_ack +
+					    hub->eng_distance * eng,
+					    req, 1 << vmid);
+
+	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
+	if (use_semaphore)
+		/*
+		 * add semaphore release after invalidation,
+		 * write with 0 means semaphore release
+		 */
+		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
+				      hub->eng_distance * eng, 0);
+
+	return pd_addr;
+}
+
+static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
+					 unsigned pasid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reg;
+
+	if (ring->funcs->vmhub == AMDGPU_GFXHUB_0)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid;
+	else
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM) + vmid;
+
+	amdgpu_ring_emit_wreg(ring, reg, pasid);
+}
+
+/*
+ * PTE format:
+ * 63:59 reserved
+ * 58:57 reserved
+ * 56 F
+ * 55 L
+ * 54 reserved
+ * 53:52 SW
+ * 51 T
+ * 50:48 mtype
+ * 47:12 4k physical page base address
+ * 11:7 fragment
+ * 6 write
+ * 5 read
+ * 4 exe
+ * 3 Z
+ * 2 snooped
+ * 1 system
+ * 0 valid
+ *
+ * PDE format:
+ * 63:59 block fragment size
+ * 58:55 reserved
+ * 54 P
+ * 53:48 reserved
+ * 47:6 physical base address of PD or PTE
+ * 5:3 reserved
+ * 2 C
+ * 1 system
+ * 0 valid
+ */
+
+static uint64_t gmc_v11_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
+{
+	switch (flags) {
+	case AMDGPU_VM_MTYPE_DEFAULT:
+		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+	case AMDGPU_VM_MTYPE_NC:
+		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+	case AMDGPU_VM_MTYPE_WC:
+		return AMDGPU_PTE_MTYPE_NV10(MTYPE_WC);
+	case AMDGPU_VM_MTYPE_CC:
+		return AMDGPU_PTE_MTYPE_NV10(MTYPE_CC);
+	case AMDGPU_VM_MTYPE_UC:
+		return AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
+	default:
+		return AMDGPU_PTE_MTYPE_NV10(MTYPE_NC);
+	}
+}
+
+static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
+				 uint64_t *addr, uint64_t *flags)
+{
+	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
+		*addr = adev->vm_manager.vram_base_offset + *addr -
+			adev->gmc.vram_start;
+	BUG_ON(*addr & 0xFFFF00000000003FULL);
+
+	if (!adev->gmc.translate_further)
+		return;
+
+	if (level == AMDGPU_VM_PDB1) {
+		/* Set the block fragment size */
+		if (!(*flags & AMDGPU_PDE_PTE))
+			*flags |= AMDGPU_PDE_BFS(0x9);
+
+	} else if (level == AMDGPU_VM_PDB0) {
+		if (*flags & AMDGPU_PDE_PTE)
+			*flags &= ~AMDGPU_PDE_PTE;
+		else
+			*flags |= AMDGPU_PTE_TF;
+	}
+}
+
+static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
+				 struct amdgpu_bo_va_mapping *mapping,
+				 uint64_t *flags)
+{
+	*flags &= ~AMDGPU_PTE_EXECUTABLE;
+	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
+
+	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
+	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
+
+	if (mapping->flags & AMDGPU_PTE_PRT) {
+		*flags |= AMDGPU_PTE_PRT;
+		*flags |= AMDGPU_PTE_SNOOPED;
+		*flags |= AMDGPU_PTE_LOG;
+		*flags |= AMDGPU_PTE_SYSTEM;
+		*flags &= ~AMDGPU_PTE_VALID;
+	}
+}
+
+static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
+{
+	return 0;
+}
+
+static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
+	.flush_gpu_tlb = gmc_v11_0_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
+	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
+	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
+	.map_mtype = gmc_v11_0_map_mtype,
+	.get_vm_pde = gmc_v11_0_get_vm_pde,
+	.get_vm_pte = gmc_v11_0_get_vm_pte,
+	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
+};
+
+static void gmc_v11_0_set_gmc_funcs(struct amdgpu_device *adev)
+{
+	adev->gmc.gmc_funcs = &gmc_v11_0_gmc_funcs;
+}
+
+static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(8, 10, 0):
+		break;
+	default:
+		break;
+	}
+}
+
+
+static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
+{
+	adev->mmhub.funcs = &mmhub_v3_0_funcs;
+}
+
+static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
+{
+	adev->gfxhub.funcs = &gfxhub_v3_0_funcs;
+}
+
+static int gmc_v11_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	gmc_v11_0_set_gfxhub_funcs(adev);
+	gmc_v11_0_set_mmhub_funcs(adev);
+	gmc_v11_0_set_gmc_funcs(adev);
+	gmc_v11_0_set_irq_funcs(adev);
+	gmc_v11_0_set_umc_funcs(adev);
+
+	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
+	adev->gmc.shared_aperture_end =
+		adev->gmc.shared_aperture_start + (4ULL << 30) - 1;
+	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
+	adev->gmc.private_aperture_end =
+		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
+
+	return 0;
+}
+
+static int gmc_v11_0_late_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_gmc_ras_late_init(adev);
+	if (r)
+		return r;
+
+	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
+}
+
+static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
+					struct amdgpu_gmc *mc)
+{
+	u64 base = 0;
+
+	base = adev->mmhub.funcs->get_fb_location(adev);
+
+	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
+	amdgpu_gmc_gart_location(adev, mc);
+
+	/* base offset of vram pages */
+	adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
+}
+
+/**
+ * gmc_v11_0_mc_init - initialize the memory controller driver params
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Look up the amount of vram, vram width, and decide how to place
+ * vram and gart within the GPU's physical address space.
+ * Returns 0 for success.
+ */
+static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	/* size in MB on si */
+	adev->gmc.mc_vram_size =
+		adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
+	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
+
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_device_resize_fb_bar(adev);
+		if (r)
+			return r;
+	}
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+
+	/* In case the PCI BAR is larger than the actual amount of vram */
+	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
+		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
+
+	/* set the gart size */
+	if (amdgpu_gart_size == -1) {
+		adev->gmc.gart_size = 512ULL << 20;
+	} else
+		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+
+	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
+
+	return 0;
+}
+
+static int gmc_v11_0_gart_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (adev->gart.bo) {
+		WARN(1, "PCIE GART already initialized\n");
+		return 0;
+	}
+
+	/* Initialize common gart structure */
+	r = amdgpu_gart_init(adev);
+	if (r)
+		return r;
+
+	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
+	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_NV10(MTYPE_UC) |
+				 AMDGPU_PTE_EXECUTABLE;
+
+	return amdgpu_gart_table_vram_alloc(adev);
+}
+
+static int gmc_v11_0_sw_init(void *handle)
+{
+	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	adev->mmhub.funcs->init(adev);
+
+	spin_lock_init(&adev->gmc.invalidate_lock);
+
+	r = amdgpu_atomfirmware_get_vram_info(adev,
+					      &vram_width, &vram_type, &vram_vendor);
+	adev->gmc.vram_width = vram_width;
+
+	adev->gmc.vram_type = vram_type;
+	adev->gmc.vram_vendor = vram_vendor;
+
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
+		adev->num_vmhubs = 2;
+		/*
+		 * To fulfill 4-level page support,
+		 * vm size is 256TB (48bit), maximum size,
+		 * block size 512 (9bit)
+		 */
+		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		break;
+	default:
+		break;
+	}
+
+	/* This interrupt is VMC page fault.*/
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_VMC,
+			      VMC_1_0__SRCID__VM_FAULT,
+			      &adev->gmc.vm_fault);
+
+	if (r)
+		return r;
+
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
+			      UTCL2_1_0__SRCID__FAULT,
+			      &adev->gmc.vm_fault);
+	if (r)
+		return r;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		/* interrupt sent to DF. */
+		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_DF, 0,
+				      &adev->gmc.ecc_irq);
+		if (r)
+			return r;
+	}
+
+	/*
+	 * Set the internal MC address mask This is the max address of the GPU's
+	 * internal address space.
+	 */
+	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
+
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+	if (r) {
+		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
+		return r;
+	}
+
+	r = gmc_v11_0_mc_init(adev);
+	if (r)
+		return r;
+
+	amdgpu_gmc_get_vbios_allocations(adev);
+
+	/* Memory manager */
+	r = amdgpu_bo_init(adev);
+	if (r)
+		return r;
+
+	r = gmc_v11_0_gart_init(adev);
+	if (r)
+		return r;
+
+	/*
+	 * number of VMs
+	 * VMID 0 is reserved for System
+	 * amdgpu graphics/compute will use VMIDs 1-7
+	 * amdkfd will use VMIDs 8-15
+	 */
+	adev->vm_manager.first_kfd_vmid = 8;
+
+	amdgpu_vm_manager_init(adev);
+
+	return 0;
+}
+
+/**
+ * gmc_v11_0_gart_fini - vm fini callback
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Tears down the driver GART/VM setup (CIK).
+ */
+static void gmc_v11_0_gart_fini(struct amdgpu_device *adev)
+{
+	amdgpu_gart_table_vram_free(adev);
+}
+
+static int gmc_v11_0_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	amdgpu_vm_manager_fini(adev);
+	gmc_v11_0_gart_fini(adev);
+	amdgpu_gem_force_release(adev);
+	amdgpu_bo_fini(adev);
+
+	return 0;
+}
+
+static void gmc_v11_0_init_golden_registers(struct amdgpu_device *adev)
+{
+}
+
+/**
+ * gmc_v11_0_gart_enable - gart enable
+ *
+ * @adev: amdgpu_device pointer
+ */
+static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
+{
+	int r;
+	bool value;
+
+	if (adev->gart.bo == NULL) {
+		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
+		return -EINVAL;
+	}
+
+	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
+	r = adev->mmhub.funcs->gart_enable(adev);
+	if (r)
+		return r;
+
+	/* Flush HDP after it is initialized */
+	adev->hdp.funcs->flush_hdp(adev, NULL);
+
+	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
+		false : true;
+
+	adev->mmhub.funcs->set_fault_enable_default(adev, value);
+	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0, 0);
+
+	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+		 (unsigned)(adev->gmc.gart_size >> 20),
+		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
+
+	return 0;
+}
+
+static int gmc_v11_0_hw_init(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	/* The sequence of these two function calls matters.*/
+	gmc_v11_0_init_golden_registers(adev);
+
+	r = gmc_v11_0_gart_enable(adev);
+	if (r)
+		return r;
+
+	if (adev->umc.funcs && adev->umc.funcs->init_registers)
+		adev->umc.funcs->init_registers(adev);
+
+	return 0;
+}
+
+/**
+ * gmc_v11_0_gart_disable - gart disable
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This disables all VM page table.
+ */
+static void gmc_v11_0_gart_disable(struct amdgpu_device *adev)
+{
+	adev->mmhub.funcs->gart_disable(adev);
+}
+
+static int gmc_v11_0_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* full access mode, so don't touch any GMC register */
+		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
+		return 0;
+	}
+
+	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+	gmc_v11_0_gart_disable(adev);
+
+	return 0;
+}
+
+static int gmc_v11_0_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	gmc_v11_0_hw_fini(adev);
+
+	return 0;
+}
+
+static int gmc_v11_0_resume(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = gmc_v11_0_hw_init(adev);
+	if (r)
+		return r;
+
+	amdgpu_vmid_reset_all(adev);
+
+	return 0;
+}
+
+static bool gmc_v11_0_is_idle(void *handle)
+{
+	/* MC is always ready in GMC v11.*/
+	return true;
+}
+
+static int gmc_v11_0_wait_for_idle(void *handle)
+{
+	/* There is no need to wait for MC idle in GMC v11.*/
+	return 0;
+}
+
+static int gmc_v11_0_soft_reset(void *handle)
+{
+	return 0;
+}
+
+static int gmc_v11_0_set_clockgating_state(void *handle,
+					   enum amd_clockgating_state state)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = adev->mmhub.funcs->set_clockgating(adev, state);
+	if (r)
+		return r;
+
+	return athub_v3_0_set_clockgating(adev, state);
+}
+
+static void gmc_v11_0_get_clockgating_state(void *handle, u64 *flags)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	adev->mmhub.funcs->get_clockgating(adev, flags);
+
+	athub_v3_0_get_clockgating(adev, flags);
+}
+
+static int gmc_v11_0_set_powergating_state(void *handle,
+					   enum amd_powergating_state state)
+{
+	return 0;
+}
+
+const struct amd_ip_funcs gmc_v11_0_ip_funcs = {
+	.name = "gmc_v11_0",
+	.early_init = gmc_v11_0_early_init,
+	.sw_init = gmc_v11_0_sw_init,
+	.hw_init = gmc_v11_0_hw_init,
+	.late_init = gmc_v11_0_late_init,
+	.sw_fini = gmc_v11_0_sw_fini,
+	.hw_fini = gmc_v11_0_hw_fini,
+	.suspend = gmc_v11_0_suspend,
+	.resume = gmc_v11_0_resume,
+	.is_idle = gmc_v11_0_is_idle,
+	.wait_for_idle = gmc_v11_0_wait_for_idle,
+	.soft_reset = gmc_v11_0_soft_reset,
+	.set_clockgating_state = gmc_v11_0_set_clockgating_state,
+	.set_powergating_state = gmc_v11_0_set_powergating_state,
+	.get_clockgating_state = gmc_v11_0_get_clockgating_state,
+};
+
+const struct amdgpu_ip_block_version gmc_v11_0_ip_block =
+{
+	.type = AMD_IP_BLOCK_TYPE_GMC,
+	.major = 11,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &gmc_v11_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.h b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.h
new file mode 100644
index 000000000000..def4d5516f82
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#ifndef __GMC_V11_0_H__
+#define __GMC_V11_0_H__
+
+extern const struct amd_ip_funcs gmc_v11_0_ip_funcs;
+extern const struct amdgpu_ip_block_version gmc_v11_0_ip_block;
+
+#endif
-- 
2.35.1

