Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D723DC48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D0A112DE8;
	Tue,  6 Feb 2024 20:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gmKBLwMX";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F12112DE8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmNJF1pytEbAFXjenWAiwA2YSF9nsOc2sXhGqfAulmFRszY42iiz98HDYuoh7FoRdd4b58d+JquIGQKQ38GZ8EdYch4FhfthDq9eP0h+23xPreqcoqrgZXzQkUT+L0tjEJE3jR2/IiCANKoWzI09whK3XeKxcrV/GoRfeylb9Lr8N5lp7lMRTexNK9+sZSiYW1217sKRzUJ0Ux/C7d5rUqQkahapkKHU++eP1HOiR2Z71ZwzUwhii9U9hY06x7yftqtz0ULT59QSrQzOzGcPLRvWC42D64FTij7I6JlyS9BfHF6aGGfp/uU4IcFjq01wdui4/9irW+TcnHj9fAo4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACkoFkYkHbU5yb++LHqTC9+H5thQAWjUOPlX6aXgaQc=;
 b=AtTe0NhAE++C1tOWpSXr1RB3Fq2SiF+w4IT+uX+VHzB0x6njyVQ4mWIK5rZL2jmbp0Ru5GVbhE4i4dBqTGTzu6lQcaMbWe7K5bC175Y10t//mYX/Fx2kfhKVZM8OVvbzU6knuXSJ0nqbKF05DgaXdnGe6QWJCeiNZKd6weE1KGfusTNa+Zk+S2whwwHdmyYHr3FU56Yzi3twYq10zRbCePwmPZ5cagUTXnPbAMOcISnB621JaAyUPEaDxKkU8xxqtD90W9Zsc2QfQKzKCa0oNiYisx8IUvJxsa+sx1TIiIx6rTJ69AvcoJAqKJWGUvaaiynNqbb6KbvNsDs5EHjsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACkoFkYkHbU5yb++LHqTC9+H5thQAWjUOPlX6aXgaQc=;
 b=gmKBLwMXw3VSONUjzcs4Wc4mAQGud2bXSDLsAUa0uiRJwb9wgICEmNi8oi6JZPQ63cZiZsGhLdpHnOngyMLF620M3qnU+vUupWRiivxYM77Xjt4b2GYSTiY7Q40nz3HSkoc1sQ5ZEMhvVJZ+e1cIDY6HxWIUmT+Dh2/CL9J0W9k=
Received: from BL0PR0102CA0050.prod.exchangelabs.com (2603:10b6:208:25::27) by
 DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.13; Tue, 6 Feb 2024 20:22:45 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::32) by BL0PR0102CA0050.outlook.office365.com
 (2603:10b6:208:25::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Tue, 6 Feb 2024 20:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:22:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:22:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add ih v7_0 ip block support
Date: Tue, 6 Feb 2024 15:22:26 -0500
Message-ID: <20240206202227.1671475-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206202227.1671475-1-alexander.deucher@amd.com>
References: <20240206202227.1671475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: a504a2ff-c733-46a0-d8ea-08dc275160ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozicM29GRO2bJCBkycBnp6VhhKFS53NGSh8hIoeDZ4Td0zmVOu/6IGX3GKN4W+YMwZoVoGT0xumTdoFDu8XvcTLZPdFw2jYC3Nxv1J6Q3Y/SS5AVnTFkU8uRKQZVQO/4HnWpZfpzYgj33LB85lzrIjvkMAw7skjDUp6B+m/tvMMsXG1bBtsNxYRkmOzEhAM1IGNZ9zJe3d4S9law7DoWCwsDfZ2mQ0S5M3IzUBuiMkZBbmMzFdhiFIMpq0+9zpMk/1NkR1dhGVcfGEI9JOznrCGiKdIbVoN0qvX5FM3Ae8dCneRUy9yZxyInXDm5J/EiWyWttkDVjrklstzDaosewa8DYptO0svLGXy35RxQFX8YxcZK3hvubsTjmPlvsiugKxxz/SSrRLMbbkumRbaKC8LtzzMwM5BsWPgD23f8HEI9uf2EeCcB0ItMkje4cDQSI6FseQ65BacxlXzIKvbUWeC8gT3t9E++Zs1rat27D6zCx28fUy6d1flEG7sA5Ws4I0ngehwH+/s6ZMyH/nG3vmqKpMBdgyaulDDzd0Uwpr921ax78FHKCKK+yINlIKkhaLd3J4oWKB0i7AEs2f7kkP93Kqdp2ghEM9WWxQri0Yvr6P27wQo7y/yHCHTpokiZG2d3UQsMCw2ARJclDU7c8GRPcNygtWymunIxLQ5IPNeoc3wnFs395x5WrrY7CEhe3yyMlBm3zmmk8zNvXzb+fM379pcwHUcpBDBpoZqpEFM7pb7KFcMVxh1dpYICo2gmPOO9nP34ZUenFq/y3eEzbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(40480700001)(66899024)(478600001)(5660300002)(30864003)(7696005)(356005)(83380400001)(47076005)(70586007)(4326008)(6916009)(8936002)(36756003)(6666004)(70206006)(316002)(86362001)(426003)(2616005)(41300700001)(16526019)(1076003)(26005)(336012)(82740400003)(8676002)(81166007)(54906003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:22:45.1268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a504a2ff-c733-46a0-d8ea-08dc275160ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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

From: Likun Gao <Likun.Gao@amd.com>

Add ih v7_0 ip block support.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile  |   3 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 766 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.h |  28 +
 3 files changed, 796 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v7_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3f7de16e0dc4..9bc5f3dde442 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -132,7 +132,8 @@ amdgpu-y += \
 	vega20_ih.o \
 	navi10_ih.o \
 	ih_v6_0.o \
-	ih_v6_1.o
+	ih_v6_1.o \
+	ih_v7_0.o
 
 # add PSP block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
new file mode 100644
index 000000000000..236806797b23
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -0,0 +1,766 @@
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
+ *
+ */
+
+#include <linux/pci.h>
+
+#include "amdgpu.h"
+#include "amdgpu_ih.h"
+
+#include "oss/osssys_7_0_0_offset.h"
+#include "oss/osssys_7_0_0_sh_mask.h"
+
+#include "soc15_common.h"
+#include "ih_v7_0.h"
+
+#define MAX_REARM_RETRY 10
+
+static void ih_v7_0_set_interrupt_funcs(struct amdgpu_device *adev);
+
+/**
+ * ih_v7_0_init_register_offset - Initialize register offset for ih rings
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Initialize register offset ih rings (IH_V7_0).
+ */
+static void ih_v7_0_init_register_offset(struct amdgpu_device *adev)
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
+static void
+force_update_wptr_for_self_int(struct amdgpu_device *adev,
+			       u32 threshold, u32 timeout, bool enabled)
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
+ * ih_v7_0_toggle_ring_interrupts - toggle the interrupt ring buffer
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointet
+ * @enable: true - enable the interrupts, false - disable the interrupts
+ *
+ * Toggle the interrupt ring buffer (IH_V7_0)
+ */
+static int ih_v7_0_toggle_ring_interrupts(struct amdgpu_device *adev,
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
+ * ih_v7_0_toggle_interrupts - Toggle all the available interrupt ring buffers
+ *
+ * @adev: amdgpu_device pointer
+ * @enable: enable or disable interrupt ring buffers
+ *
+ * Toggle all the available interrupt ring buffers (IH_V7_0).
+ */
+static int ih_v7_0_toggle_interrupts(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1};
+	int i;
+	int r;
+
+	for (i = 0; i < ARRAY_SIZE(ih); i++) {
+		if (ih[i]->ring_size) {
+			r = ih_v7_0_toggle_ring_interrupts(adev, ih[i], enable);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
+static uint32_t ih_v7_0_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl)
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
+static uint32_t ih_v7_0_doorbell_rptr(struct amdgpu_ih_ring *ih)
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
+ * ih_v7_0_enable_ring - enable an ih ring buffer
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
+ *
+ * Enable an ih ring buffer (IH_V7_0)
+ */
+static int ih_v7_0_enable_ring(struct amdgpu_device *adev,
+				      struct amdgpu_ih_ring *ih)
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
+	tmp = ih_v7_0_rb_cntl(ih, tmp);
+	if (ih == &adev->irq.ih)
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
+	if (ih == &adev->irq.ih1) {
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
+	}
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
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
+	WREG32(ih_regs->ih_doorbell_rptr, ih_v7_0_doorbell_rptr(ih));
+
+	return 0;
+}
+
+/**
+ * ih_v7_0_irq_init - init and enable the interrupt ring
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Allocate a ring buffer for the interrupt controller,
+ * enable the RLC, disable interrupts, enable the IH
+ * ring buffer and enable it.
+ * Called at device load and reume.
+ * Returns 0 for success, errors for failure.
+ */
+static int ih_v7_0_irq_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1};
+	u32 ih_chicken;
+	u32 tmp;
+	int ret;
+	int i;
+
+	/* disable irqs */
+	ret = ih_v7_0_toggle_interrupts(adev, false);
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
+			ret = ih_v7_0_enable_ring(adev, ih[i]);
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
+	tmp = RREG32_SOC15(OSSSYS, 0, regIH_INT_FLOOD_CNTL);
+	tmp = REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1);
+	WREG32_SOC15(OSSSYS, 0, regIH_INT_FLOOD_CNTL, tmp);
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
+	pci_set_master(adev->pdev);
+
+	/* enable interrupts */
+	ret = ih_v7_0_toggle_interrupts(adev, true);
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
+ * ih_v7_0_irq_disable - disable interrupts
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Disable interrupts on the hw.
+ */
+static void ih_v7_0_irq_disable(struct amdgpu_device *adev)
+{
+	force_update_wptr_for_self_int(adev, 0, 8, false);
+	ih_v7_0_toggle_interrupts(adev, false);
+
+	/* Wait and acknowledge irq */
+	mdelay(1);
+}
+
+/**
+ * ih_v7_0_get_wptr - get the IH ring buffer wptr
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Get the IH ring buffer wptr from either the register
+ * or the writeback memory buffer.  Also check for
+ * ring buffer overflow and deal with it.
+ * Returns the value of the wptr.
+ */
+static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
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
+out:
+	return (wptr & ih->ptr_mask);
+}
+
+/**
+ * ih_v7_0_irq_rearm - rearm IRQ if lost
+ *
+ * @adev: amdgpu_device pointer
+ *
+ */
+static void ih_v7_0_irq_rearm(struct amdgpu_device *adev,
+			       struct amdgpu_ih_ring *ih)
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
+ * ih_v7_0_set_rptr - set the IH ring buffer rptr
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set the IH ring buffer rptr.
+ */
+static void ih_v7_0_set_rptr(struct amdgpu_device *adev,
+			       struct amdgpu_ih_ring *ih)
+{
+	struct amdgpu_ih_regs *ih_regs;
+
+	if (ih->use_doorbell) {
+		/* XXX check if swapping is necessary on BE */
+		*ih->rptr_cpu = ih->rptr;
+		WDOORBELL32(ih->doorbell_index, ih->rptr);
+
+		if (amdgpu_sriov_vf(adev))
+			ih_v7_0_irq_rearm(adev, ih);
+	} else {
+		ih_regs = &ih->ih_regs;
+		WREG32(ih_regs->ih_rb_rptr, ih->rptr);
+	}
+}
+
+/**
+ * ih_v7_0_self_irq - dispatch work for ring 1
+ *
+ * @adev: amdgpu_device pointer
+ * @source: irq source
+ * @entry: IV with WPTR update
+ *
+ * Update the WPTR from the IV and schedule work to handle the entries.
+ */
+static int ih_v7_0_self_irq(struct amdgpu_device *adev,
+			      struct amdgpu_irq_src *source,
+			      struct amdgpu_iv_entry *entry)
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
+static const struct amdgpu_irq_src_funcs ih_v7_0_self_irq_funcs = {
+	.process = ih_v7_0_self_irq,
+};
+
+static void ih_v7_0_set_self_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.self_irq.num_types = 0;
+	adev->irq.self_irq.funcs = &ih_v7_0_self_irq_funcs;
+}
+
+static int ih_v7_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	ih_v7_0_set_interrupt_funcs(adev);
+	ih_v7_0_set_self_irq_funcs(adev);
+	return 0;
+}
+
+static int ih_v7_0_sw_init(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
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
+	adev->irq.ih1.ring_size = 0;
+	adev->irq.ih2.ring_size = 0;
+
+	/* initialize ih control register offset */
+	ih_v7_0_init_register_offset(adev);
+
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_init(adev);
+
+	return r;
+}
+
+static int ih_v7_0_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	amdgpu_irq_fini_sw(adev);
+
+	return 0;
+}
+
+static int ih_v7_0_hw_init(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = ih_v7_0_irq_init(adev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int ih_v7_0_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	ih_v7_0_irq_disable(adev);
+
+	return 0;
+}
+
+static int ih_v7_0_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return ih_v7_0_hw_fini(adev);
+}
+
+static int ih_v7_0_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return ih_v7_0_hw_init(adev);
+}
+
+static bool ih_v7_0_is_idle(void *handle)
+{
+	/* todo */
+	return true;
+}
+
+static int ih_v7_0_wait_for_idle(void *handle)
+{
+	/* todo */
+	return -ETIMEDOUT;
+}
+
+static int ih_v7_0_soft_reset(void *handle)
+{
+	/* todo */
+	return 0;
+}
+
+static void ih_v7_0_update_clockgating_state(struct amdgpu_device *adev,
+					       bool enable)
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
+static int ih_v7_0_set_clockgating_state(void *handle,
+					   enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	ih_v7_0_update_clockgating_state(adev,
+				state == AMD_CG_STATE_GATE);
+	return 0;
+}
+
+static void ih_v7_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
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
+static int ih_v7_0_set_powergating_state(void *handle,
+					 enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_PG_STATE_GATE);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
+		ih_v7_0_update_ih_mem_power_gating(adev, enable);
+
+	return 0;
+}
+
+static void ih_v7_0_get_clockgating_state(void *handle, u64 *flags)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!RREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL))
+		*flags |= AMD_CG_SUPPORT_IH_CG;
+
+	return;
+}
+
+static const struct amd_ip_funcs ih_v7_0_ip_funcs = {
+	.name = "ih_v7_0",
+	.early_init = ih_v7_0_early_init,
+	.late_init = NULL,
+	.sw_init = ih_v7_0_sw_init,
+	.sw_fini = ih_v7_0_sw_fini,
+	.hw_init = ih_v7_0_hw_init,
+	.hw_fini = ih_v7_0_hw_fini,
+	.suspend = ih_v7_0_suspend,
+	.resume = ih_v7_0_resume,
+	.is_idle = ih_v7_0_is_idle,
+	.wait_for_idle = ih_v7_0_wait_for_idle,
+	.soft_reset = ih_v7_0_soft_reset,
+	.set_clockgating_state = ih_v7_0_set_clockgating_state,
+	.set_powergating_state = ih_v7_0_set_powergating_state,
+	.get_clockgating_state = ih_v7_0_get_clockgating_state,
+};
+
+static const struct amdgpu_ih_funcs ih_v7_0_funcs = {
+	.get_wptr = ih_v7_0_get_wptr,
+	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
+	.set_rptr = ih_v7_0_set_rptr
+};
+
+static void ih_v7_0_set_interrupt_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.ih_funcs = &ih_v7_0_funcs;
+}
+
+const struct amdgpu_ip_block_version ih_v7_0_ip_block =
+{
+	.type = AMD_IP_BLOCK_TYPE_IH,
+	.major = 7,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &ih_v7_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.h b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.h
new file mode 100644
index 000000000000..af9dcbc451fd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.h
@@ -0,0 +1,28 @@
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
+ *
+ */
+#ifndef __IH_V7_0_IH_H__
+#define __IH_V7_0_IH_H__
+
+extern const struct amdgpu_ip_block_version ih_v7_0_ip_block;
+
+#endif
-- 
2.42.0

