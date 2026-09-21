Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4710C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B70210E453;
	Mon, 21 Sep 2026 20:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AtrVWe0G";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E613710E453
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbhRAuoJQF/vrFw2wkZDPkC/dWZMCsqXV8mQ4QOrJ7on8tYKVNN7Z5azHLKpT04ynvZUbST5nHGk/CQcmDY8ZGyfRwAlZRWdob+2PF+zbK4cBgNNXSlH/mc7h/BSnBX8aTloJY79RAEiynuHiZV9Uxnerse267RwrBHQ7gHhV2CXF+DfSoZvh2SN8EXY0/62retEq34ekYu+vo0bq5ikwK9gVtG+Bau1mXL9VWgMqbfD809e0pImsHxfxCniztwBMJuUMOPP9tRm+pYUnNe1nJCRLt3ZZeWVdjNGaFfaNsU+zg6nYr9BJI4NumSG89FmXiWyHyiv2IW6Ezeggj+N9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmzIWSIcDIhNfcMITUkHAD+i2Tx+J217anBmOlZXSbE=;
 b=XGvy3jUfQY6H2YfYvyMwqOKEwt4gI7+bQJpyPkfuD8TsLqRQkzzi4PP1hZk8fQ2Ht6pPfOMPt6naA2FRQLBU063UooaTtIOVG6pC0aOU3GTD0YGqSgbVCeoP64nsWXkqxxCTLvqdCzlSpc7b680uTvVOKZM3xkT8t1u1KRE3rFKCyKut4/dL5MUfeJ2BLE7tjWt6HwiEW3gJS05D/BAG7Ii02ZSYBiI3jazJo071xLontbij/kKa4BIE4+QXyEkxy84/4spSCzC60uXsuEwp7lN7VFepy2LFpY1EhIEKV3rm1VnzQm+Q4pfHLMhid+5mjullhOPN7PDIUgEIBKNPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmzIWSIcDIhNfcMITUkHAD+i2Tx+J217anBmOlZXSbE=;
 b=AtrVWe0GhcxBf5jyljAF4A8H/PVdH0+yZmG/LUHRKMa0z0O80jg5ZLkQC/aNARs0VqRl4RyIj3t2s6V2uggi2EtI23I1N3G8h/qbvx5zbWTxyNfx3qTXHEDOXUosJNt/pGCiZkJNimiNDjRGruhaVbrkUnTgVX8trsZEYNPdUiY=
Received: from MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) by
 DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Mon, 21 Sep 2026 20:26:37 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::f) by MN2PR01CA0065.outlook.office365.com
 (2603:10b6:208:23f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:26:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:26:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:26:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:26:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add ih v8_0 support
Date: Mon, 21 Sep 2026 16:26:26 -0400
Message-ID: <20260921202627.2038382-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921202627.2038382-1-alexander.deucher@amd.com>
References: <20260921202627.2038382-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0576ac83-72b5-493d-8c24-08df181ea2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|5023799004|56012099006|10067099003|11063799006|18002099003|22082099003|18092099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Az/GzRzIZb+WWhHwbmEOj8yfwwxluNbl2a9KphlZNFQRRzTIT0E2kSPk2RRUX3HYgWb6gEVfyVxBF5adnJb3WDdIjV2W831xV0knkQyJYO5KPtoKBP6/ED6MDchxktKVaw3SIE4hB7orilYDBBbn83Y2XPGetbCUB1dFfNAWX9YCerAqOq3IzE5dwPzqixVRd4ZrNz6Is5qbUkp3qqKeEa2vCvmxnBCjNFNl4QiO6pe5WjffNaOpt3BnIF3qmcBooShnLarYEKS/BP24qW9FmD8LHi+vaspMkYje3KK+rEtaDoaj0ca2RbkeXz1+QL+o1fbfEpeL9tj3UlJtwDvLzjP3KEZmAeLpYfdJ7Pxd2CwrjA46/vMd3GDVuUMlcNhKsihdWcvZzanz8mxo/a/tk4GuAze+ldJ/cD9yieRYAK00tB20BAjQkgiV2WmZXAVrLMJeUOPd66COv991jkqZN2a+y/LyXR+HxIs7E4KJqhYg122PQgYUDm2idR0ga7A+V6ET6iOaD9cRIiviXH9yW8M+WViQBl5cn8y6mnb6VoEGhM8kF9lVVCE7QlkcTAjlkmt2AlxqZWiDg1snIURHuMVMhMfFyb7RO0CSe8Zd7LGL+fMXHoveSBlVPj2TqdskBmi9Lh07T8oJvyjBv/qONp+3fo4fkH9vqsRueykATdOwFdWSI0FmaB/QwlZOHaD8Co3BSDPl0aX86gCkvckwng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(5023799004)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(18092099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nEuDpKiMVG4Cbo2dySPjWzP6heLGx355aa1zhbQtMV1JeLyihePa453OYXDAywsyQQhsViqQcv+uP/8/jxHsVJjVqwoANEf1CyRmBxddKSxaCY9jl48owS6VlyCNBXqUNbN+WuG2ICgpS20mpfqX1Fsu1Q+Ze50v25yVi2StWAOk7an77eCBcLMCTOIe/LsK4L9OVmctNSl93TFDtC0jyNd/yWj4AlvX8pSHlu9lemjW0jHj8ZGzJVOPOmIct4e9vKASjKuZRbGTsjj0N1RCAZLurd8/Q85H/adyPNhIn8YHblQfqexmCXoZWwZw/QmSpPkUCnI9cMeoE8SKVKDazAVPBmBq4BcjxHWKFe1pEuysOsENZWszXeu062+SO98gUxwh2P+sIjz7CbCs/IdeO687c1cmpRi0EyJZp27qlASj8jiBxDw5m1QP+ieZQxKi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:26:36.9712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0576ac83-72b5-493d-8c24-08df181ea2d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add initial implementation for the new generation of ih

v2: squash in flood control fix

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile  |   3 +-
 drivers/gpu/drm/amd/amdgpu/ih_v8_0.c | 781 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v8_0.h |  28 +
 3 files changed, 811 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v8_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7b08814a24da4..ce557cf36c9d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -128,7 +128,8 @@ amdgpu-y += \
 	navi10_ih.o \
 	ih_v6_0.o \
 	ih_v6_1.o \
-	ih_v7_0.o
+	ih_v7_0.o \
+	ih_v8_0.o
 
 # add PSP block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v8_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v8_0.c
new file mode 100644
index 0000000000000..0540f33206639
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v8_0.c
@@ -0,0 +1,781 @@
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
+ *
+ */
+
+#include <linux/pci.h>
+
+#include "amdgpu.h"
+#include "amdgpu_ih.h"
+
+#include "oss/osssys_8_0_1_offset.h"
+#include "oss/osssys_8_0_1_sh_mask.h"
+
+#include "soc15_common.h"
+#include "ih_v8_0.h"
+
+#define MAX_REARM_RETRY 10
+
+static void ih_v8_0_set_interrupt_funcs(struct amdgpu_device *adev);
+
+/**
+ * ih_v8_0_init_register_offset - Initialize register offset for ih rings
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Initialize register offset ih rings (IH_V7_0).
+ */
+static void ih_v8_0_init_register_offset(struct amdgpu_device *adev)
+{
+	struct amdgpu_ih_regs *ih_regs;
+
+	/* ih ring 2 is removed
+	 * ih ring and ih ring 1 are available */
+	if (adev->irq.ih.ring_size) {
+		ih_regs = &adev->irq.ih.ih_regs;
+		ih_regs->ih_rb_base = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_BASE);
+		ih_regs->ih_rb_base_hi = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_BASE_HI);
+		ih_regs->ih_rb_cntl = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_CNTL);
+		ih_regs->ih_rb_wptr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_WPTR);
+		ih_regs->ih_rb_rptr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_RPTR);
+		ih_regs->ih_doorbell_rptr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_DOORBELL_RPTR);
+		ih_regs->ih_rb_wptr_addr_lo = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_WPTR_ADDR_LO);
+		ih_regs->ih_rb_wptr_addr_hi = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_WPTR_ADDR_HI);
+		ih_regs->psp_reg_id = PSP_REG_IH_RB_CNTL;
+	}
+
+	if (adev->irq.ih1.ring_size) {
+		ih_regs = &adev->irq.ih1.ih_regs;
+		ih_regs->ih_rb_base = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_BASE_RING1);
+		ih_regs->ih_rb_base_hi = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_BASE_HI_RING1);
+		ih_regs->ih_rb_cntl = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_CNTL_RING1);
+		ih_regs->ih_rb_wptr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_WPTR_RING1);
+		ih_regs->ih_rb_rptr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RB_RPTR_RING1);
+		ih_regs->ih_doorbell_rptr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_DOORBELL_RPTR_RING1);
+		ih_regs->psp_reg_id = PSP_REG_IH_RB_CNTL_RING1;
+	}
+}
+
+/**
+ * force_update_wptr_for_self_int - Force update the wptr for self interrupt
+ *
+ * @adev: amdgpu_device pointer
+ * @threshold: threshold to trigger the wptr reporting
+ * @timeout: timeout to trigger the wptr reporting
+ * @enabled: Enable/disable timeout flush mechanism
+ *
+ * threshold input range: 0 ~ 15, default 0,
+ * real_threshold = 2^threshold
+ * timeout input range: 0 ~ 20, default 8,
+ * real_timeout = (2^timeout) * 1024 / (socclk_freq)
+ *
+ * Force update wptr for self interrupt ( >= SIENNA_CICHLID).
+ */
+static void force_update_wptr_for_self_int(struct amdgpu_device *adev,
+					   u32 threshold, u32 timeout,
+					   bool enabled)
+{
+	u32 ih_cntl, ih_rb_cntl;
+
+	ih_cntl = RREG32_SOC15(OSSSYS, 0, regIH_CNTL2);
+	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, regIH_RB_CNTL_RING1);
+
+	ih_cntl = REG_SET_FIELD(ih_cntl, IH_CNTL2,
+				SELF_IV_FORCE_WPTR_UPDATE_TIMEOUT, timeout);
+	ih_cntl = REG_SET_FIELD(ih_cntl, IH_CNTL2,
+				SELF_IV_FORCE_WPTR_UPDATE_ENABLE, enabled);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+				   RB_USED_INT_THRESHOLD, threshold);
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl))
+			return;
+	} else {
+		WREG32_SOC15(OSSSYS, 0, regIH_RB_CNTL_RING1, ih_rb_cntl);
+	}
+
+	WREG32_SOC15(OSSSYS, 0, regIH_CNTL2, ih_cntl);
+}
+
+/**
+ * ih_v8_0_toggle_ring_interrupts - toggle the interrupt ring buffer
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointet
+ * @enable: true - enable the interrupts, false - disable the interrupts
+ *
+ * Toggle the interrupt ring buffer (IH_V8_0)
+ */
+static int ih_v8_0_toggle_ring_interrupts(struct amdgpu_device *adev,
+					  struct amdgpu_ih_ring *ih,
+					  bool enable)
+{
+	struct amdgpu_ih_regs *ih_regs;
+	uint32_t tmp;
+
+	ih_regs = &ih->ih_regs;
+
+	tmp = RREG32(ih_regs->ih_rb_cntl);
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
+	/* enable_intr field is only valid in ring0 */
+	if (ih == &adev->irq.ih)
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+			return -ETIMEDOUT;
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
+
+	if (enable) {
+		ih->enabled = true;
+	} else {
+		/* set rptr, wptr to 0 */
+		WREG32(ih_regs->ih_rb_rptr, 0);
+		WREG32(ih_regs->ih_rb_wptr, 0);
+		ih->enabled = false;
+		ih->rptr = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * ih_v8_0_toggle_interrupts - Toggle all the available interrupt ring buffers
+ *
+ * @adev: amdgpu_device pointer
+ * @enable: enable or disable interrupt ring buffers
+ *
+ * Toggle all the available interrupt ring buffers (IH_V8_0).
+ */
+static int ih_v8_0_toggle_interrupts(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1};
+	int i;
+	int r;
+
+	for (i = 0; i < ARRAY_SIZE(ih); i++) {
+		if (ih[i]->ring_size) {
+			r = ih_v8_0_toggle_ring_interrupts(adev, ih[i], enable);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
+static uint32_t ih_v8_0_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl)
+{
+	int rb_bufsz = order_base_2(ih->ring_size / 4);
+
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   MC_SPACE, ih->use_bus_addr ? 2 : 4);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   WPTR_OVERFLOW_CLEAR, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   WPTR_OVERFLOW_ENABLE, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Ring Buffer write pointer writeback. If enabled, IH_RB_WPTR register
+	 * value is written to memory
+	 */
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   WPTR_WRITEBACK_ENABLE, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_SNOOP, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_RO, 0);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_VMID, 0);
+
+	return ih_rb_cntl;
+}
+
+static uint32_t ih_v8_0_doorbell_rptr(struct amdgpu_ih_ring *ih)
+{
+	u32 ih_doorbell_rtpr = 0;
+
+	if (ih->use_doorbell) {
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR, OFFSET,
+						 ih->doorbell_index);
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR,
+						 ENABLE, 1);
+	} else {
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR,
+						 ENABLE, 0);
+	}
+	return ih_doorbell_rtpr;
+}
+
+/**
+ * ih_v8_0_enable_ring - enable an ih ring buffer
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
+ *
+ * Enable an ih ring buffer (IH_V7_0)
+ */
+static int ih_v8_0_enable_ring(struct amdgpu_device *adev,
+			       struct amdgpu_ih_ring *ih)
+{
+	struct amdgpu_ih_regs *ih_regs;
+	uint32_t tmp;
+
+	ih_regs = &ih->ih_regs;
+
+	/* Ring Buffer base. [39:8] of 40-bit address of the beginning of the ring buffer*/
+	WREG32(ih_regs->ih_rb_base, ih->gpu_addr >> 8);
+	WREG32(ih_regs->ih_rb_base_hi, (ih->gpu_addr >> 40) & 0xff);
+
+	tmp = RREG32(ih_regs->ih_rb_cntl);
+	tmp = ih_v8_0_rb_cntl(ih, tmp);
+	if (ih == &adev->irq.ih)
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
+	if (ih == &adev->irq.ih1) {
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
+	}
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
+
+	if (ih == &adev->irq.ih) {
+		/* set the ih ring 0 writeback address whether it's enabled or not */
+		WREG32(ih_regs->ih_rb_wptr_addr_lo, lower_32_bits(ih->wptr_addr));
+		WREG32(ih_regs->ih_rb_wptr_addr_hi, upper_32_bits(ih->wptr_addr) & 0xFFFF);
+	}
+
+	/* set rptr, wptr to 0 */
+	WREG32(ih_regs->ih_rb_wptr, 0);
+	WREG32(ih_regs->ih_rb_rptr, 0);
+
+	WREG32(ih_regs->ih_doorbell_rptr, ih_v8_0_doorbell_rptr(ih));
+
+	return 0;
+}
+
+/**
+ * ih_v8_0_irq_init - init and enable the interrupt ring
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Allocate a ring buffer for the interrupt controller,
+ * enable the RLC, disable interrupts, enable the IH
+ * ring buffer and enable it.
+ * Called at device load and reume.
+ * Returns 0 for success, errors for failure.
+ */
+static int ih_v8_0_irq_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1};
+	u32 ih_chicken;
+	u32 tmp;
+	int ret;
+	int i;
+
+	/* disable irqs */
+	ret = ih_v8_0_toggle_interrupts(adev, false);
+	if (ret)
+		return ret;
+
+	adev->nbio.funcs->ih_control(adev);
+
+	if (unlikely((adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
+		     (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO))) {
+		if (ih[0]->use_bus_addr) {
+			ih_chicken = RREG32_SOC15(OSSSYS, 0, regIH_CHICKEN);
+			ih_chicken = REG_SET_FIELD(ih_chicken,
+					IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
+			WREG32_SOC15(OSSSYS, 0, regIH_CHICKEN, ih_chicken);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ih); i++) {
+		if (ih[i]->ring_size) {
+			ret = ih_v8_0_enable_ring(adev, ih[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* update doorbell range for ih ring 0 */
+	adev->nbio.funcs->ih_doorbell_range(adev, ih[0]->use_doorbell,
+					    ih[0]->doorbell_index);
+
+	tmp = RREG32_SOC15(OSSSYS, 0, regIH_STORM_CLIENT_LIST_CNTL);
+	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
+			    CLIENT18_IS_STORM_CLIENT, 1);
+	WREG32_SOC15(OSSSYS, 0, regIH_STORM_CLIENT_LIST_CNTL, tmp);
+
+	tmp = RREG32_SOC15(OSSSYS, 0, regIH_FUNC_CNTL);
+	tmp = REG_SET_FIELD(tmp, IH_FUNC_CNTL, FLOOD_CNTL_ENABLE, 1);
+	WREG32_SOC15(OSSSYS, 0, regIH_FUNC_CNTL, tmp);
+
+	/* GC/MMHUB UTCL2 page fault interrupts are configured as
+	 * MSI storm capable interrupts by deafult. The delay is
+	 * used to avoid ISR being called too frequently
+	 * when page fault happens on several continuous page
+	 * and thus avoid MSI storm */
+	tmp = RREG32_SOC15(OSSSYS, 0, regIH_MSI_STORM_CTRL);
+	tmp = REG_SET_FIELD(tmp, IH_MSI_STORM_CTRL,
+			    DELAY, 3);
+	WREG32_SOC15(OSSSYS, 0, regIH_MSI_STORM_CTRL, tmp);
+
+	/* Redirect the interrupts to IH RB1 for dGPU */
+	if (adev->irq.ih1.ring_size) {
+		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX);
+		tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_INDEX, INDEX, 0);
+		WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX, tmp);
+
+		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA);
+		tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, CLIENT_ID, 0xa);
+		tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, SOURCE_ID, 0x0);
+		tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA,
+				    SOURCE_ID_MATCH_ENABLE, 0x1);
+
+		WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA, tmp);
+	}
+
+	pci_set_master(adev->pdev);
+
+	/* enable interrupts */
+	ret = ih_v8_0_toggle_interrupts(adev, true);
+	if (ret)
+		return ret;
+	/* enable wptr force update for self int */
+	force_update_wptr_for_self_int(adev, 0, 8, true);
+
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
+	return 0;
+}
+
+/**
+ * ih_v8_0_irq_disable - disable interrupts
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Disable interrupts on the hw.
+ */
+static void ih_v8_0_irq_disable(struct amdgpu_device *adev)
+{
+	force_update_wptr_for_self_int(adev, 0, 8, false);
+	ih_v8_0_toggle_interrupts(adev, false);
+
+	/* Wait and acknowledge irq */
+	mdelay(1);
+}
+
+/**
+ * ih_v8_0_get_wptr() - get the IH ring buffer wptr
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to fetch wptr
+ *
+ * Get the IH ring buffer wptr from either the register
+ * or the writeback memory buffer.  Also check for
+ * ring buffer overflow and deal with it.
+ * Returns the value of the wptr.
+ */
+static u32 ih_v8_0_get_wptr(struct amdgpu_device *adev,
+			      struct amdgpu_ih_ring *ih)
+{
+	u32 wptr, tmp;
+	struct amdgpu_ih_regs *ih_regs;
+
+	wptr = le32_to_cpu(*ih->wptr_cpu);
+	ih_regs = &ih->ih_regs;
+
+	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+
+	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
+	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+
+	/* When a ring buffer overflow happen start parsing interrupt
+	 * from the last not overwritten vector (wptr + 32). Hopefully
+	 * this should allow us to catch up.
+	 */
+	tmp = (wptr + 32) & ih->ptr_mask;
+	dev_warn(adev->dev, "IH ring buffer overflow "
+		 "(0x%08X, 0x%08X, 0x%08X)\n",
+		 wptr, ih->rptr, tmp);
+	ih->rptr = tmp;
+
+	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+out:
+	return (wptr & ih->ptr_mask);
+}
+
+/**
+ * ih_v8_0_irq_rearm - rearm IRQ if lost
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: IH ring to match
+ *
+ */
+static void ih_v8_0_irq_rearm(struct amdgpu_device *adev,
+			      struct amdgpu_ih_ring *ih)
+{
+	uint32_t v = 0;
+	uint32_t i = 0;
+	struct amdgpu_ih_regs *ih_regs;
+
+	ih_regs = &ih->ih_regs;
+
+	/* Rearm IRQ / re-write doorbell if doorbell write is lost */
+	for (i = 0; i < MAX_REARM_RETRY; i++) {
+		v = RREG32_NO_KIQ(ih_regs->ih_rb_rptr);
+		if ((v < ih->ring_size) && (v != ih->rptr))
+			WDOORBELL32(ih->doorbell_index, ih->rptr);
+		else
+			break;
+	}
+}
+
+/**
+ * ih_v8_0_set_rptr - set the IH ring buffer rptr
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to set rptr
+ */
+static void ih_v8_0_set_rptr(struct amdgpu_device *adev,
+			     struct amdgpu_ih_ring *ih)
+{
+	struct amdgpu_ih_regs *ih_regs;
+
+	if (ih->use_doorbell) {
+		/* XXX check if swapping is necessary on BE */
+		*ih->rptr_cpu = ih->rptr;
+		WDOORBELL32(ih->doorbell_index, ih->rptr);
+
+		if (amdgpu_sriov_vf(adev))
+			ih_v8_0_irq_rearm(adev, ih);
+	} else {
+		ih_regs = &ih->ih_regs;
+		WREG32(ih_regs->ih_rb_rptr, ih->rptr);
+	}
+}
+
+/**
+ * ih_v8_0_self_irq - dispatch work for ring 1
+ *
+ * @adev: amdgpu_device pointer
+ * @source: irq source
+ * @entry: IV with WPTR update
+ *
+ * Update the WPTR from the IV and schedule work to handle the entries.
+ */
+static int ih_v8_0_self_irq(struct amdgpu_device *adev,
+			    struct amdgpu_irq_src *source,
+			    struct amdgpu_iv_entry *entry)
+{
+	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
+
+	switch (entry->ring_id) {
+	case 1:
+		*adev->irq.ih1.wptr_cpu = wptr;
+		schedule_work(&adev->irq.ih1_work);
+		break;
+	default: break;
+	}
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs ih_v8_0_self_irq_funcs = {
+	.process = ih_v8_0_self_irq,
+};
+
+static void ih_v8_0_set_self_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.self_irq.num_types = 0;
+	adev->irq.self_irq.funcs = &ih_v8_0_self_irq_funcs;
+}
+
+static int ih_v8_0_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	ih_v8_0_set_interrupt_funcs(adev);
+	ih_v8_0_set_self_irq_funcs(adev);
+	return 0;
+}
+
+static int ih_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+	struct amdgpu_device *adev = ip_block->adev;
+	bool use_bus_addr;
+
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
+			      &adev->irq.self_irq);
+
+	if (r)
+		return r;
+
+	/* use gpu virtual address for ih ring
+	 * until ih_checken is programmed to allow
+	 * use bus address for ih ring by psp bl */
+	use_bus_addr =
+		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	if (r)
+		return r;
+
+	adev->irq.ih.use_doorbell = true;
+	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
+
+	if (!(adev->flags & AMD_IS_APU)) {
+		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, IH_RING_SIZE,
+					use_bus_addr);
+		if (r)
+			return r;
+
+		adev->irq.ih1.use_doorbell = true;
+		adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
+	}
+
+	/* initialize ih control register offset */
+	ih_v8_0_init_register_offset(adev);
+
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_init(adev);
+
+	return r;
+}
+
+static int ih_v8_0_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	amdgpu_irq_fini_sw(adev);
+
+	return 0;
+}
+
+static int ih_v8_0_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+	struct amdgpu_device *adev = ip_block->adev;
+
+	r = ih_v8_0_irq_init(adev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int ih_v8_0_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	ih_v8_0_irq_disable(ip_block->adev);
+
+	return 0;
+}
+
+static int ih_v8_0_suspend(struct amdgpu_ip_block *ip_block)
+{
+	return ih_v8_0_hw_fini(ip_block);
+}
+
+static int ih_v8_0_resume(struct amdgpu_ip_block *ip_block)
+{
+	return ih_v8_0_hw_init(ip_block);
+}
+
+static int ih_v8_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
+{
+	/* todo */
+	return -ETIMEDOUT;
+}
+
+static int ih_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
+{
+	/* todo */
+	return 0;
+}
+
+static void ih_v8_0_update_clockgating_state(struct amdgpu_device *adev,
+					     bool enable)
+{
+	uint32_t data, def, field_val;
+
+	if (adev->cg_flags & AMD_CG_SUPPORT_IH_CG) {
+		def = data = RREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL);
+		field_val = enable ? 0 : 1;
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     DBUS_MUX_CLK_SOFT_OVERRIDE, field_val);
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     OSSSYS_SHARE_CLK_SOFT_OVERRIDE, field_val);
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     LIMIT_SMN_CLK_SOFT_OVERRIDE, field_val);
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     DYN_CLK_SOFT_OVERRIDE, field_val);
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     REG_CLK_SOFT_OVERRIDE, field_val);
+		if (def != data)
+			WREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL, data);
+	}
+
+	return;
+}
+
+static int ih_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					 enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	ih_v8_0_update_clockgating_state(adev,
+				state == AMD_CG_STATE_GATE);
+	return 0;
+}
+
+static void ih_v8_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
+					       bool enable)
+{
+	uint32_t ih_mem_pwr_cntl;
+
+	/* Disable ih sram power cntl before switch powergating mode */
+	ih_mem_pwr_cntl = RREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL);
+	ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+					IH_BUFFER_MEM_POWER_CTRL_EN, 0);
+	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
+
+	/* It is recommended to set mem powergating mode to DS mode */
+	if (enable) {
+		/* mem power mode */
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_BUFFER_MEM_POWER_LS_EN, 0);
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_BUFFER_MEM_POWER_DS_EN, 1);
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_BUFFER_MEM_POWER_SD_EN, 0);
+		/* cam mem power mode */
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_RETRY_INT_CAM_MEM_POWER_LS_EN, 0);
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_RETRY_INT_CAM_MEM_POWER_DS_EN, 1);
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_RETRY_INT_CAM_MEM_POWER_SD_EN, 0);
+		/* re-enable power cntl */
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_BUFFER_MEM_POWER_CTRL_EN, 1);
+	} else {
+		/* mem power mode */
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_BUFFER_MEM_POWER_LS_EN, 0);
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_BUFFER_MEM_POWER_DS_EN, 0);
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_BUFFER_MEM_POWER_SD_EN, 0);
+		/* cam mem power mode */
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_RETRY_INT_CAM_MEM_POWER_LS_EN, 0);
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_RETRY_INT_CAM_MEM_POWER_DS_EN, 0);
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_RETRY_INT_CAM_MEM_POWER_SD_EN, 0);
+		/* re-enable power cntl*/
+		ih_mem_pwr_cntl = REG_SET_FIELD(ih_mem_pwr_cntl, IH_MEM_POWER_CTRL,
+						IH_BUFFER_MEM_POWER_CTRL_EN, 1);
+	}
+
+	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
+}
+
+static int ih_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					 enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool enable = (state == AMD_PG_STATE_GATE);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
+		ih_v8_0_update_ih_mem_power_gating(adev, enable);
+
+	return 0;
+}
+
+static void ih_v8_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64 *flags)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (!RREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL))
+		*flags |= AMD_CG_SUPPORT_IH_CG;
+
+	return;
+}
+
+static const struct amd_ip_funcs ih_v8_0_ip_funcs = {
+	.name = "ih_v8_0",
+	.early_init = ih_v8_0_early_init,
+	.sw_init = ih_v8_0_sw_init,
+	.sw_fini = ih_v8_0_sw_fini,
+	.hw_init = ih_v8_0_hw_init,
+	.hw_fini = ih_v8_0_hw_fini,
+	.suspend = ih_v8_0_suspend,
+	.resume = ih_v8_0_resume,
+	.wait_for_idle = ih_v8_0_wait_for_idle,
+	.soft_reset = ih_v8_0_soft_reset,
+	.set_clockgating_state = ih_v8_0_set_clockgating_state,
+	.set_powergating_state = ih_v8_0_set_powergating_state,
+	.get_clockgating_state = ih_v8_0_get_clockgating_state,
+};
+
+static const struct amdgpu_ih_funcs ih_v8_0_funcs = {
+	.get_wptr = ih_v8_0_get_wptr,
+	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
+	.set_rptr = ih_v8_0_set_rptr
+};
+
+static void ih_v8_0_set_interrupt_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.ih_funcs = &ih_v8_0_funcs;
+}
+
+const struct amdgpu_ip_block_version ih_v8_0_ip_block =
+{
+	.type = AMD_IP_BLOCK_TYPE_IH,
+	.major = 8,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &ih_v8_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v8_0.h b/drivers/gpu/drm/amd/amdgpu/ih_v8_0.h
new file mode 100644
index 0000000000000..1cefd14b19efa
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v8_0.h
@@ -0,0 +1,28 @@
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
+ *
+ */
+#ifndef __IH_V8_0_IH_H__
+#define __IH_V8_0_IH_H__
+
+extern const struct amdgpu_ip_block_version ih_v8_0_ip_block;
+
+#endif
-- 
2.55.0

