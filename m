Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522FBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FFE10F57F;
	Wed, 27 Apr 2022 15:20:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E16010F57E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ7VKkBKl5K81avdZSEiD/U2WCrLtHK0Skq4LmJSQbHD277fTzfeA8snkg9gCW2Zu7t0iXnLmaDOhVtcWD4mALWAKMBby5hVMzGLqF35M6yNQa6XR93Yvg2wGqJVq6vJK+QMzjVzPN2NwFaatgdbQKfNvmYWoRMfvb2ZpIr2tFHnfJC9BIGdYCp4zPEthwTPeB3c5lASCBtH8uQuKQFed2mLDPWksjhDt0p2q5OMoURhMd/QMbrEWjlrYBMchdMVPRjjTf3/xIM3HD8Li+OmkqJbzufrZykvmTM8Balz4+0/IUK8emIvGDq0DqN5wUuxuIRwlX8H0b1+L2KLGyMs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLWxkGTHXHdfICVu+THnLbvclTqa816dWA6pIkpmdII=;
 b=EayeRE1FMD8v8k/Wvxs6KS3f4fkZ08JEGkkBa/iED3GCEburbrZFFzBfZATRTHbI+vmSFzNA0t0XIO7tDzGDVf5AOUBu3dIXFzgjsrfrVeCLjA3IdHgJhIysjMbeg3oSweKMxh/xWAk41QXEsVjT4TJN5Nof2J8eIvRMoVb4Q8uL3OtE9Nz/1x6V5nvdkp05w05G1I2I6Zxn2TgHBIPTqcL0NSylGhAJ67GV/aKq9rZI5BovQP3rixlFYoC4mf4z1imkRrmxvj6L4m04aM+9r/DsAjIEnwFnu9uW63k85gvv9KcxxdmXFT4HMPaXKpxJBbsNjp52GQMuFrcql4OEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLWxkGTHXHdfICVu+THnLbvclTqa816dWA6pIkpmdII=;
 b=SkzFRJpacLWgSIhLvBLUFTiVgV1oyKmFMCtO9/6f/RHdfBCV3A5NrZnEiluz0ObavjrINe1Lqi2g0B1g9i4eaKIYiXqL2SA6LK91QLvJTFjSL8Mx3MCQS0/eQBl772LUl2Tq5+aLNmig4j9mPGOqhXubLGGjTzh+r8bTZ7SutBo=
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 27 Apr
 2022 15:20:46 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::8) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 15:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:20:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:20:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: add ih v6_0 ip block v2
Date: Wed, 27 Apr 2022 11:20:28 -0400
Message-ID: <20220427152029.3105101-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427152029.3105101-1-alexander.deucher@amd.com>
References: <20220427152029.3105101-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45714c3b-c291-4764-97eb-08da286180b6
X-MS-TrafficTypeDiagnostic: MN0PR12MB6128:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6128A21AB353BFE67F756686F7FA9@MN0PR12MB6128.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpmcwtRIvRdGnln7su8YJrOX4c1MpuQ1c79vc8x+qt6Rbsl+/u96G+YIGSQsC4H/yQgBjp68354fHGPR8pAH/OzQzRd6gOrVF+eesDtKFFvjK6s5mS6bQgCyfs5wHyiMyItrv7fBHkeME1wzxLVTGftjj4epPgohXksbaYUr85wEKX6GN87vHM3K5Ey//D/NKMyvYxlFRI+pwVPr4vMZ+yp8R0/FRlnX0FCn7/gpS4igvqh+OJTxlun9umczIKSxR0B0JM3oyoWXTRJclgmYTEdrKdJyLw2Cwl1ySN4JVQ4OZ9w4THXcZOqOrRVCH0hpSZKAWHAbiAzIzSxWpWQnUWF4uHK0k6JrIxziGSZFOB183Ri3Pzr3vIwjbQdPX3dgS3awQe/8BQzwQG5HsgR31oCdcurkMxOMnLcnLraoO9wXhcYgUHlW/LVWGVTYxV25OwBRE3sCdmQ3AjAvLpUTu1RNNhWW4sLxulW5i2u5iHnzGgsebD/BArpqNj+RsFwVFyl9Rf6V4wWZ244D+orToTFyvVZCfiOThN7jxkwoWBLy+vc8i45tFeI300ndB1DNuXkm+9/ZwCnHbDaOqm9pOfKKO9xFXRTAEd/ooHx4mqZZqT6zBiIe1I7QUxiRpNnOHL1QsKIgJw97lXG/qyiYqd4HI3GpfXORRTIYkAWk5g/GQIUwGy4ipBjqwbamsdgRTu/4yoGKiQX5kE7qMO0zVXhqF1PFtnZ2nRSOw/EsfQopJerrMhg9BUaD5i7Xf3LU1hzNljyx9Pj+Knf8Hm2lfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(186003)(16526019)(426003)(336012)(47076005)(4326008)(8676002)(2616005)(1076003)(81166007)(316002)(86362001)(8936002)(36860700001)(70586007)(5660300002)(40460700003)(82310400005)(26005)(30864003)(70206006)(54906003)(6916009)(508600001)(83380400001)(7696005)(6666004)(2906002)(356005)(21314003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:20:46.1641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45714c3b-c291-4764-97eb-08da286180b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Stanley . Yang" <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

This adds ih v6_0 ip block support.  IH is the
interrupt handler.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c     | 745 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.h     |  28 +
 drivers/gpu/drm/amd/include/amd_shared.h |   1 +
 4 files changed, 776 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v6_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 313af306687b..244f53cc7c46 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -103,7 +103,8 @@ amdgpu-y += \
 	cz_ih.o \
 	vega10_ih.o \
 	vega20_ih.o \
-	navi10_ih.o
+	navi10_ih.o \
+	ih_v6_0.o
 
 # add PSP block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
new file mode 100644
index 000000000000..92dc60a9d209
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -0,0 +1,745 @@
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
+#include <linux/pci.h>
+
+#include "amdgpu.h"
+#include "amdgpu_ih.h"
+
+#include "oss/osssys_6_0_0_offset.h"
+#include "oss/osssys_6_0_0_sh_mask.h"
+
+#include "soc15_common.h"
+#include "ih_v6_0.h"
+
+#define MAX_REARM_RETRY 10
+
+static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev);
+
+/**
+ * ih_v6_0_init_register_offset - Initialize register offset for ih rings
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Initialize register offset ih rings (IH_V6_0).
+ */
+static void ih_v6_0_init_register_offset(struct amdgpu_device *adev)
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
+	WREG32_SOC15(OSSSYS, 0, regIH_RB_CNTL_RING1, ih_rb_cntl);
+	WREG32_SOC15(OSSSYS, 0, regIH_CNTL2, ih_cntl);
+}
+
+/**
+ * ih_v6_0_toggle_ring_interrupts - toggle the interrupt ring buffer
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointet
+ * @enable: true - enable the interrupts, false - disable the interrupts
+ *
+ * Toggle the interrupt ring buffer (IH_V6_0)
+ */
+static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
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
+	WREG32(ih_regs->ih_rb_cntl, tmp);
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
+ * ih_v6_0_toggle_interrupts - Toggle all the available interrupt ring buffers
+ *
+ * @adev: amdgpu_device pointer
+ * @enable: enable or disable interrupt ring buffers
+ *
+ * Toggle all the available interrupt ring buffers (IH_V6_0).
+ */
+static int ih_v6_0_toggle_interrupts(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1};
+	int i;
+	int r;
+
+	for (i = 0; i < ARRAY_SIZE(ih); i++) {
+		if (ih[i]->ring_size) {
+			r = ih_v6_0_toggle_ring_interrupts(adev, ih[i], enable);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
+static uint32_t ih_v6_0_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl)
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
+static uint32_t ih_v6_0_doorbell_rptr(struct amdgpu_ih_ring *ih)
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
+ * ih_v6_0_enable_ring - enable an ih ring buffer
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: amdgpu_ih_ring pointer
+ *
+ * Enable an ih ring buffer (IH_V6_0)
+ */
+static int ih_v6_0_enable_ring(struct amdgpu_device *adev,
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
+	tmp = ih_v6_0_rb_cntl(ih, tmp);
+	if (ih == &adev->irq.ih)
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
+	if (ih == &adev->irq.ih1) {
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
+	}
+	WREG32(ih_regs->ih_rb_cntl, tmp);
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
+	WREG32(ih_regs->ih_doorbell_rptr, ih_v6_0_doorbell_rptr(ih));
+
+	return 0;
+}
+
+/**
+ * ih_v6_0_irq_init - init and enable the interrupt ring
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Allocate a ring buffer for the interrupt controller,
+ * enable the RLC, disable interrupts, enable the IH
+ * ring buffer and enable it.
+ * Called at device load and reume.
+ * Returns 0 for success, errors for failure.
+ */
+static int ih_v6_0_irq_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1};
+	u32 ih_chicken;
+	u32 tmp;
+	int ret;
+	int i;
+
+	/* disable irqs */
+	ret = ih_v6_0_toggle_interrupts(adev, false);
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
+			ret = ih_v6_0_enable_ring(adev, ih[i]);
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
+	ret = ih_v6_0_toggle_interrupts(adev, true);
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
+ * ih_v6_0_irq_disable - disable interrupts
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Disable interrupts on the hw.
+ */
+static void ih_v6_0_irq_disable(struct amdgpu_device *adev)
+{
+	force_update_wptr_for_self_int(adev, 0, 8, false);
+	ih_v6_0_toggle_interrupts(adev, false);
+
+	/* Wait and acknowledge irq */
+	mdelay(1);
+}
+
+/**
+ * ih_v6_0_get_wptr - get the IH ring buffer wptr
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Get the IH ring buffer wptr from either the register
+ * or the writeback memory buffer.  Also check for
+ * ring buffer overflow and deal with it.
+ * Returns the value of the wptr.
+ */
+static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
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
+ * ih_v6_0_irq_rearm - rearm IRQ if lost
+ *
+ * @adev: amdgpu_device pointer
+ *
+ */
+static void ih_v6_0_irq_rearm(struct amdgpu_device *adev,
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
+ * ih_v6_0_set_rptr - set the IH ring buffer rptr
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set the IH ring buffer rptr.
+ */
+static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
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
+			ih_v6_0_irq_rearm(adev, ih);
+	} else {
+		ih_regs = &ih->ih_regs;
+		WREG32(ih_regs->ih_rb_rptr, ih->rptr);
+	}
+}
+
+/**
+ * ih_v6_0_self_irq - dispatch work for ring 1
+ *
+ * @adev: amdgpu_device pointer
+ * @source: irq source
+ * @entry: IV with WPTR update
+ *
+ * Update the WPTR from the IV and schedule work to handle the entries.
+ */
+static int ih_v6_0_self_irq(struct amdgpu_device *adev,
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
+static const struct amdgpu_irq_src_funcs ih_v6_0_self_irq_funcs = {
+	.process = ih_v6_0_self_irq,
+};
+
+static void ih_v6_0_set_self_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.self_irq.num_types = 0;
+	adev->irq.self_irq.funcs = &ih_v6_0_self_irq_funcs;
+}
+
+static int ih_v6_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	ih_v6_0_set_interrupt_funcs(adev);
+	ih_v6_0_set_self_irq_funcs(adev);
+	return 0;
+}
+
+static int ih_v6_0_sw_init(void *handle)
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
+	ih_v6_0_init_register_offset(adev);
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
+static int ih_v6_0_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	amdgpu_irq_fini_sw(adev);
+
+	return 0;
+}
+
+static int ih_v6_0_hw_init(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = ih_v6_0_irq_init(adev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int ih_v6_0_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	ih_v6_0_irq_disable(adev);
+
+	return 0;
+}
+
+static int ih_v6_0_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return ih_v6_0_hw_fini(adev);
+}
+
+static int ih_v6_0_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return ih_v6_0_hw_init(adev);
+}
+
+static bool ih_v6_0_is_idle(void *handle)
+{
+	/* todo */
+	return true;
+}
+
+static int ih_v6_0_wait_for_idle(void *handle)
+{
+	/* todo */
+	return -ETIMEDOUT;
+}
+
+static int ih_v6_0_soft_reset(void *handle)
+{
+	/* todo */
+	return 0;
+}
+
+static void ih_v6_0_update_clockgating_state(struct amdgpu_device *adev,
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
+static int ih_v6_0_set_clockgating_state(void *handle,
+					   enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	ih_v6_0_update_clockgating_state(adev,
+				state == AMD_CG_STATE_GATE);
+	return 0;
+}
+
+static void ih_v6_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
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
+static int ih_v6_0_set_powergating_state(void *handle,
+					 enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_PG_STATE_GATE);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
+		ih_v6_0_update_ih_mem_power_gating(adev, enable);
+
+	return 0;
+}
+
+static void ih_v6_0_get_clockgating_state(void *handle, u64 *flags)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!RREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL))
+		*flags |= AMD_CG_SUPPORT_IH_CG;
+
+	return;
+}
+
+static const struct amd_ip_funcs ih_v6_0_ip_funcs = {
+	.name = "ih_v6_0",
+	.early_init = ih_v6_0_early_init,
+	.late_init = NULL,
+	.sw_init = ih_v6_0_sw_init,
+	.sw_fini = ih_v6_0_sw_fini,
+	.hw_init = ih_v6_0_hw_init,
+	.hw_fini = ih_v6_0_hw_fini,
+	.suspend = ih_v6_0_suspend,
+	.resume = ih_v6_0_resume,
+	.is_idle = ih_v6_0_is_idle,
+	.wait_for_idle = ih_v6_0_wait_for_idle,
+	.soft_reset = ih_v6_0_soft_reset,
+	.set_clockgating_state = ih_v6_0_set_clockgating_state,
+	.set_powergating_state = ih_v6_0_set_powergating_state,
+	.get_clockgating_state = ih_v6_0_get_clockgating_state,
+};
+
+static const struct amdgpu_ih_funcs ih_v6_0_funcs = {
+	.get_wptr = ih_v6_0_get_wptr,
+	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.set_rptr = ih_v6_0_set_rptr
+};
+
+static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.ih_funcs = &ih_v6_0_funcs;
+}
+
+const struct amdgpu_ip_block_version ih_v6_0_ip_block =
+{
+	.type = AMD_IP_BLOCK_TYPE_IH,
+	.major = 6,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &ih_v6_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.h b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.h
new file mode 100644
index 000000000000..f27b55580716
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.h
@@ -0,0 +1,28 @@
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
+#ifndef __IH_V6_0_IH_H__
+#define __IH_V6_0_IH_H__
+
+extern const struct amdgpu_ip_block_version ih_v6_0_ip_block;
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 06f21e9008c6..9086df53660c 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -167,6 +167,7 @@ enum amd_powergating_state {
 #define AMD_PG_SUPPORT_VCN_DPG			(1 << 15)
 #define AMD_PG_SUPPORT_ATHUB			(1 << 16)
 #define AMD_PG_SUPPORT_JPEG			(1 << 17)
+#define AMD_PG_SUPPORT_IH_SRAM_PG		(1 << 18)
 
 /**
  * enum PP_FEATURE_MASK - Used to mask power play features.
-- 
2.35.1

