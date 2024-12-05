Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C11E7717A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3346E10E0EF;
	Thu,  5 Dec 2024 17:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vrgkI3tz";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8170A10E5DE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPxoXsj2DL0aV/vOLqLBbXPdYSzNUc2V5DDjDPQaSCwjxFf9kKDJp5u9zMPdY3qWibo2iC/0QGhOE7K0ngFD7zaYd0AKTgglqWWK5B9xGnyPrbY++2yC0TFW3sOuRLUBilS19vBb42C4jP8vEOAzpSd8oSg6s+ZaQdL75EX1wv3Yf/hKSCQSEfFJ7dZBWx0fKlci8LjC4j1Nth9gmGROA1xvo7gPIRg0C1ghnuyAaATotZH+Zui/GCreyO6zMDIxPFBlaZJKUuqBLEwnxD+UrcDuQk1l+hOOuYKZ4fXq0TbAHiNpoxeGG/NrcGCMTyaqvTlkOUrvt7pDBRzidysx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG6Qw0GPEM4MPV4Iq50u/QraLldll1t69LohsKMZ60U=;
 b=EnSeBzTAwJN0F17hIDbYM6AHbVMR/kjtuayJPMQQnjwnI4dDwq/xTil88mzR04Z7nle5eGZfabv9VWgSK1M3ZR2R1NSkGY1IpK0i562dMBTUleM3I6/j/2dwpyCp1HnkJ0+XmL887IqgW6WR1fM6w0E4rCcUsdVeS9gsghXPLr0xv9AHWvMG0nPfjV9ddlW4QLwvwEnxEOJBr2J4sAk9EVFq0Mttf2HfXh/Pdwjj/btoIvYC/QdHlDsgiRiXOrn8a7ER8TAg/YIYhkdzx6XJbehIWzHPbxRNjvGPHwtw19zOWtjqw2gAxHtPLxqtc2x3xYZTCbPUNuotgA9ZHeJmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG6Qw0GPEM4MPV4Iq50u/QraLldll1t69LohsKMZ60U=;
 b=vrgkI3tzp8FeFC8GIrISJINQtyDu/pIZBvL9Y7K1Nx+VVLeOK7YLV0Eyuv2dTr/749inD+FeGAhj0t0gn1kvUFXSRoA7diu57AA+emdc/Wou9kCPLrVE8PpwNX6NyX3K9Lm/lmkID7UnMa/wbWB+eaWN0DdfVsmi1nRjEbX3GeQ=
Received: from BN9PR03CA0469.namprd03.prod.outlook.com (2603:10b6:408:139::24)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 17:36:29 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::4f) by BN9PR03CA0469.outlook.office365.com
 (2603:10b6:408:139::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Thu,
 5 Dec 2024 17:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:36:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:36:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: Add JPEG5_0_1 support
Date: Thu, 5 Dec 2024 12:36:07 -0500
Message-ID: <20241205173610.334358-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205173610.334358-1-alexander.deucher@amd.com>
References: <20241205173610.334358-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: af9738dd-679f-439d-65b7-08dd155359e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ev078RzskVQ59NFU293jkgeNtT0ZWoYl9ZDWAeKpDJbBT4IHX8BgYWZNQCL6?=
 =?us-ascii?Q?5czz8A1H51xTReqtixvcGN9AeSJvBm6kTEhB5GUu2yS1VVwFTl1pSpoXkxIK?=
 =?us-ascii?Q?7YoBnIoVx0rmrhPMhaPidsMdD+01IbKJovfQDG/E0AQOToPfey/IiwYe0NtS?=
 =?us-ascii?Q?nvUkg81m2wzMVQIO7YnMMF7ERlKBWkvYTdQ1fm1I9+La0mzISb4C7Wjbncu1?=
 =?us-ascii?Q?EVDlPYeuw0SA8jJJNpPeKr9+HnwOM2DdkoJ/zfEuavCf2fYoCAyke2vc0l6V?=
 =?us-ascii?Q?WKigxaWV5xbJOilFi5Ml2ngmk/JPxBzpiRq/A+2/aMBMvDxd5V+GTkL/7k19?=
 =?us-ascii?Q?TiCjiGTZZ2YTFMf60ItigGy3DjnOVZI46SgGID/hUyF46nieq7V4mGpBKLfi?=
 =?us-ascii?Q?xbjXKfXJcMQazCbNw66owgl+s/AfYvRWC8t65vj8r10EKs7cPcU+oracLeVn?=
 =?us-ascii?Q?bTYMZnH/tUKmnocOuZIJ39nc8/0/Y5mJL54fmhqIWnlC3aZV1mxFwvcoArLp?=
 =?us-ascii?Q?n5qtF2yLKIjqeYP85shlG8iE6hno2zwGGTjcex0AfZAj6TrEYvZGtVdWr/af?=
 =?us-ascii?Q?cOJynCThcQBgVgQ/YJLga+1NlqDu4HfqCOGsQH12w0ZPmPhuLpIU/CfU/sER?=
 =?us-ascii?Q?NdsqKmruaNoTe9qSZRoi/xMAb9j8/d/6je/h88/N++J9Bmw2zpN/gdhPjkby?=
 =?us-ascii?Q?ue+xE/1Crn35b06JFxlVPgsb7laQGaD9WslQtD8Hkc4d53ZmQLJQfZhcWzwj?=
 =?us-ascii?Q?k/UkXI+YTd6NLuaV9Od9+OoASiOH+q9+L6shPC81aKj4MiHnjcChUxmzvMZe?=
 =?us-ascii?Q?p/hsEsAPhBeZkEiJq5PBtjMakeOjcQO4lQrEepemtsZUK314r2bKjuFPNrXs?=
 =?us-ascii?Q?XR+DwFI6bSWpnKl2rWVEeh1uV3Tfq64ysOgaC1Rps+ZAAby3ZuRoKenbLWOW?=
 =?us-ascii?Q?OHBDURxwC28qrqVnCNV3I92Qoqw66xFRUOex3GF7hLocCU0F3SmKvcltU2DX?=
 =?us-ascii?Q?YMbK/UOqfjwSMZI2hkKIPgij4d6WOXsCJCVCxeEi0jFdoAHFrksuHS93GMxD?=
 =?us-ascii?Q?iakjX/NTYyWmaEg/7ZV77Jsl9pRTWYbHdNLW9cqvT3DDjdEvVkaEwGLgNEzx?=
 =?us-ascii?Q?BL+dvgI99j9Y2PCN38eKsiCFneEvxOHaY1MAYjn9hvyZ2ack5lcbYithdhzk?=
 =?us-ascii?Q?z0gIy6eKcECjh+XgyAIOdWKTAUapCg0IeOo0+usHAFHp51RwLD8ZKyIpyJOX?=
 =?us-ascii?Q?y3s9Wi/KAtFB20S2r4k8ZCtFIiWon0jdkyDtSRHMMiQtESmByJHwWCbIZX63?=
 =?us-ascii?Q?M8yT4yFIEAhT3qnzvrfStffYMfeuV94yB2wWxs9W8lnlqOtEz1x1D8rIGZLH?=
 =?us-ascii?Q?PYVcE98mSCJeXrJVcYDTIMP7YxiOT4nuvEap1FWPiOXFDZKaawEC+r5N2lhQ?=
 =?us-ascii?Q?ap1DFHf15KZiSJV8AbgCcEvL7zSFs2hd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:36:29.0241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9738dd-679f-439d-65b7-08dd155359e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

add support for JPEG5_0_1

v2: squash in updates, rebase on IP instance changes

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 708 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h |  29 +
 3 files changed, 739 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 502adcda7b65c..1b03ea3ef925f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -212,7 +212,8 @@ amdgpu-y += \
 	jpeg_v4_0.o \
 	jpeg_v4_0_3.o \
 	jpeg_v4_0_5.o \
-	jpeg_v5_0_0.o
+	jpeg_v5_0_0.o \
+	jpeg_v5_0_1.o
 
 # add VPE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
new file mode 100644
index 0000000000000..8bfa400e7a874
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -0,0 +1,708 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2014-2024 Advanced Micro Devices, Inc. All rights reserved.
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
+#include "amdgpu_jpeg.h"
+#include "amdgpu_pm.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "jpeg_v4_0_3.h"
+#include "jpeg_v5_0_1.h"
+
+#include "vcn/vcn_5_0_0_offset.h"
+#include "vcn/vcn_5_0_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+
+static void jpeg_v5_0_1_set_dec_ring_funcs(struct amdgpu_device *adev);
+static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
+static int jpeg_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					     enum amd_powergating_state state);
+static void jpeg_v5_0_1_dec_ring_set_wptr(struct amdgpu_ring *ring);
+
+static int amdgpu_ih_srcid_jpeg[] = {
+	VCN_5_0__SRCID__JPEG_DECODE,
+	VCN_5_0__SRCID__JPEG1_DECODE,
+	VCN_5_0__SRCID__JPEG2_DECODE,
+	VCN_5_0__SRCID__JPEG3_DECODE,
+	VCN_5_0__SRCID__JPEG4_DECODE,
+	VCN_5_0__SRCID__JPEG5_DECODE,
+	VCN_5_0__SRCID__JPEG6_DECODE,
+	VCN_5_0__SRCID__JPEG7_DECODE,
+	VCN_5_0__SRCID__JPEG8_DECODE,
+	VCN_5_0__SRCID__JPEG9_DECODE,
+};
+
+static int jpeg_v5_0_1_core_reg_offset(u32 pipe)
+{
+	if (pipe <= AMDGPU_MAX_JPEG_RINGS_4_0_3)
+		return ((0x40 * pipe) - 0xc80);
+	else
+		return ((0x40 * pipe) - 0x440);
+}
+
+/**
+ * jpeg_v5_0_1_early_init - set function pointers
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Set ring and irq function pointers
+ */
+static int jpeg_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (!adev->jpeg.num_jpeg_inst || adev->jpeg.num_jpeg_inst > AMDGPU_MAX_JPEG_INSTANCES)
+		return -ENOENT;
+
+	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
+	jpeg_v5_0_1_set_dec_ring_funcs(adev);
+	jpeg_v5_0_1_set_irq_funcs(adev);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_1_sw_init - sw init for JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Load firmware and sw initialization
+ */
+static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int i, j, r, jpeg_inst;
+
+	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+		/* JPEG TRAP */
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+				      amdgpu_ih_srcid_jpeg[j], &adev->jpeg.inst->irq);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_jpeg_sw_init(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		jpeg_inst = GET_INST(JPEG, i);
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			ring->use_doorbell = false;
+			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
+			if (!amdgpu_sriov_vf(adev)) {
+				ring->doorbell_index =
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					1 + j + 11 * jpeg_inst;
+			} else {
+				if (j < 4)
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						4 + j + 32 * jpeg_inst;
+				else
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						8 + j + 32 * jpeg_inst;
+			}
+			sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.inst[i].aid_id, j);
+			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
+					     AMDGPU_RING_PRIO_DEFAULT, NULL);
+			if (r)
+				return r;
+
+			adev->jpeg.internal.jpeg_pitch[j] =
+				regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET;
+			adev->jpeg.inst[i].external.jpeg_pitch[j] =
+				SOC15_REG_OFFSET1(JPEG, jpeg_inst, regUVD_JRBC_SCRATCH0,
+						  (j ? jpeg_v5_0_1_core_reg_offset(j) : 0));
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_1_sw_fini - sw fini for JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * JPEG suspend and free up sw allocation
+ */
+static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_jpeg_suspend(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_sw_fini(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_0_1_hw_init - start and test JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ */
+static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int i, j, r, jpeg_inst;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* jpeg_v5_0_1_start_sriov(adev); */
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+				ring = &adev->jpeg.inst[i].ring_dec[j];
+				ring->wptr = 0;
+				ring->wptr_old = 0;
+				jpeg_v5_0_1_dec_ring_set_wptr(ring);
+				ring->sched.ready = true;
+			}
+		}
+		return 0;
+	}
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		jpeg_inst = GET_INST(JPEG, i);
+		ring = adev->jpeg.inst[i].ring_dec;
+		if (ring->use_doorbell)
+			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				 (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * jpeg_inst,
+				 adev->jpeg.inst[i].aid_id);
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			if (ring->use_doorbell)
+				WREG32_SOC15_OFFSET(VCN, GET_INST(VCN, i), regVCN_JPEG_DB_CTRL,
+						    (ring->pipe ? (ring->pipe - 0x15) : 0),
+						    ring->doorbell_index <<
+						    VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+						    VCN_JPEG_DB_CTRL__EN_MASK);
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_1_hw_fini - stop the hardware block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Stop the JPEG block, mark ring as not ready any more
+ */
+static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+
+	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
+		ret = jpeg_v5_0_1_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+
+	return ret;
+}
+
+/**
+ * jpeg_v5_0_1_suspend - suspend JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * HW fini and suspend JPEG block
+ */
+static int jpeg_v5_0_1_suspend(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = jpeg_v5_0_1_hw_fini(ip_block);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_suspend(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_0_1_resume - resume JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Resume firmware and hw init JPEG block
+ */
+static int jpeg_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	r = jpeg_v5_0_1_hw_init(ip_block);
+
+	return r;
+}
+
+static int jpeg_v5_0_1_disable_antihang(struct amdgpu_device *adev, int inst_idx)
+{
+	int jpeg_inst;
+
+	jpeg_inst = GET_INST(JPEG, inst_idx);
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS), 0,
+		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* keep the JPEG in static PG mode */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS), 0,
+		 ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
+
+	return 0;
+}
+
+static int jpeg_v5_0_1_enable_antihang(struct amdgpu_device *adev, int inst_idx)
+{
+	int jpeg_inst;
+
+	jpeg_inst = GET_INST(JPEG, inst_idx);
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
+		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_1_start - start JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the JPEG block
+ */
+static int jpeg_v5_0_1_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	int i, j, jpeg_inst, r;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		jpeg_inst = GET_INST(JPEG, i);
+
+		/* disable antihang */
+		r = jpeg_v5_0_1_disable_antihang(adev, i);
+		if (r)
+			return r;
+
+		/* MJPEG global tiling registers */
+		WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
+			     adev->gfx.config.gb_addr_config);
+
+		/* enable JMI channel */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
+			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			int reg_offset = (j ? jpeg_v5_0_1_core_reg_offset(j) : 0);
+			u32 reg, data, mask;
+
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+
+			/* enable System Interrupt for JRBC */
+			reg = SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN);
+			if (j < AMDGPU_MAX_JPEG_RINGS_4_0_3) {
+				data = JPEG_SYS_INT_EN__DJRBC0_MASK << j;
+				mask = ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j);
+				WREG32_P(reg, data, mask);
+			} else {
+				data = JPEG_SYS_INT_EN__DJRBC0_MASK << (j+12);
+				mask = ~(JPEG_SYS_INT_EN__DJRBC0_MASK << (j+12));
+				WREG32_P(reg, data, mask);
+			}
+
+			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+					    regUVD_LMI_JRBC_RB_VMID,
+					    reg_offset, 0);
+			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+					    regUVD_JRBC_RB_CNTL,
+					    reg_offset,
+					    (0x00000001L | 0x00000002L));
+			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+					    regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+					    reg_offset, lower_32_bits(ring->gpu_addr));
+			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+					    regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+					    reg_offset, upper_32_bits(ring->gpu_addr));
+			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+					    regUVD_JRBC_RB_RPTR,
+					    reg_offset, 0);
+			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+					    regUVD_JRBC_RB_WPTR,
+					    reg_offset, 0);
+			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+					    regUVD_JRBC_RB_CNTL,
+					    reg_offset, 0x00000002L);
+			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+					    regUVD_JRBC_RB_SIZE,
+					    reg_offset, ring->ring_size / 4);
+			ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC_RB_WPTR,
+							 reg_offset);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_1_stop - stop JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * stop the JPEG block
+ */
+static int jpeg_v5_0_1_stop(struct amdgpu_device *adev)
+{
+	int i, jpeg_inst, r;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		jpeg_inst = GET_INST(JPEG, i);
+		/* reset JMI */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
+			 UVD_JMI_CNTL__SOFT_RESET_MASK,
+			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+		/* enable antihang */
+		r = jpeg_v5_0_1_enable_antihang(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_1_dec_ring_get_rptr - get read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware read pointer
+ */
+static uint64_t jpeg_v5_0_1_dec_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC_RB_RPTR,
+				   ring->pipe ? jpeg_v5_0_1_core_reg_offset(ring->pipe) : 0);
+}
+
+/**
+ * jpeg_v5_0_1_dec_ring_get_wptr - get write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware write pointer
+ */
+static uint64_t jpeg_v5_0_1_dec_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell)
+		return adev->wb.wb[ring->wptr_offs];
+
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC_RB_WPTR,
+				   ring->pipe ? jpeg_v5_0_1_core_reg_offset(ring->pipe) : 0);
+}
+
+/**
+ * jpeg_v5_0_1_dec_ring_set_wptr - set write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the write pointer to the hardware
+ */
+static void jpeg_v5_0_1_dec_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me),
+				    regUVD_JRBC_RB_WPTR,
+				    (ring->pipe ? jpeg_v5_0_1_core_reg_offset(ring->pipe) : 0),
+				    lower_32_bits(ring->wptr));
+	}
+}
+
+static bool jpeg_v5_0_1_is_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool ret = false;
+	int i, j;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			int reg_offset = (j ? jpeg_v5_0_1_core_reg_offset(j) : 0);
+
+			ret &= ((RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, i),
+				regUVD_JRBC_STATUS, reg_offset) &
+				UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+				UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+		}
+	}
+
+	return ret;
+}
+
+static int jpeg_v5_0_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+	int i, j;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			int reg_offset = (j ? jpeg_v5_0_1_core_reg_offset(j) : 0);
+
+			ret &= SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, i),
+							 regUVD_JRBC_STATUS, reg_offset,
+							 UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+							 UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+		}
+	}
+	return ret;
+}
+
+static int jpeg_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					     enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+
+	int i;
+
+	if (!enable)
+		return 0;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (!jpeg_v5_0_1_is_idle(adev))
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int jpeg_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					     enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret;
+
+	if (state == adev->jpeg.cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = jpeg_v5_0_1_stop(adev);
+	else
+		ret = jpeg_v5_0_1_start(adev);
+
+	if (!ret)
+		adev->jpeg.cur_state = state;
+
+	return ret;
+}
+
+static int jpeg_v5_0_1_set_interrupt_state(struct amdgpu_device *adev,
+					   struct amdgpu_irq_src *source,
+					   unsigned int type,
+					   enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
+					 struct amdgpu_irq_src *source,
+					 struct amdgpu_iv_entry *entry)
+{
+	u32 i, inst;
+
+	i = node_id_to_phys_map[entry->node_id];
+	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
+
+	for (inst = 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
+		if (adev->jpeg.inst[inst].aid_id == i)
+			break;
+
+	if (inst >= adev->jpeg.num_jpeg_inst) {
+		dev_WARN_ONCE(adev->dev, 1,
+			      "Interrupt received for unknown JPEG instance %d",
+			      entry->node_id);
+		return 0;
+	}
+
+	switch (entry->src_id) {
+	case VCN_5_0__SRCID__JPEG_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
+		break;
+	case VCN_5_0__SRCID__JPEG1_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
+		break;
+	case VCN_5_0__SRCID__JPEG2_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
+		break;
+	case VCN_5_0__SRCID__JPEG3_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
+		break;
+	case VCN_5_0__SRCID__JPEG4_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
+		break;
+	case VCN_5_0__SRCID__JPEG5_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
+		break;
+	case VCN_5_0__SRCID__JPEG6_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
+		break;
+	case VCN_5_0__SRCID__JPEG7_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
+		break;
+	case VCN_5_0__SRCID__JPEG8_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
+		break;
+	case VCN_5_0__SRCID__JPEG9_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
+		break;
+	default:
+		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
+			      entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
+	.name = "jpeg_v5_0_1",
+	.early_init = jpeg_v5_0_1_early_init,
+	.late_init = NULL,
+	.sw_init = jpeg_v5_0_1_sw_init,
+	.sw_fini = jpeg_v5_0_1_sw_fini,
+	.hw_init = jpeg_v5_0_1_hw_init,
+	.hw_fini = jpeg_v5_0_1_hw_fini,
+	.suspend = jpeg_v5_0_1_suspend,
+	.resume = jpeg_v5_0_1_resume,
+	.is_idle = jpeg_v5_0_1_is_idle,
+	.wait_for_idle = jpeg_v5_0_1_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = jpeg_v5_0_1_set_clockgating_state,
+	.set_powergating_state = jpeg_v5_0_1_set_powergating_state,
+	.dump_ip_state = NULL,
+	.print_ip_state = NULL,
+};
+
+static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_JPEG,
+	.align_mask = 0xf,
+	.get_rptr = jpeg_v5_0_1_dec_ring_get_rptr,
+	.get_wptr = jpeg_v5_0_1_dec_ring_get_wptr,
+	.set_wptr = jpeg_v5_0_1_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* jpeg_v5_0_1_dec_ring_emit_vm_flush */
+		22 + 22 + /* jpeg_v5_0_1_dec_ring_emit_fence x2 vm fence */
+		8 + 16,
+	.emit_ib_size = 22, /* jpeg_v5_0_1_dec_ring_emit_ib */
+	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
+	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
+	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
+	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
+	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
+	.insert_nop = jpeg_v4_0_3_dec_ring_nop,
+	.insert_start = jpeg_v4_0_3_dec_ring_insert_start,
+	.insert_end = jpeg_v4_0_3_dec_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_jpeg_ring_begin_use,
+	.end_use = amdgpu_jpeg_ring_end_use,
+	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
+	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
+static void jpeg_v5_0_1_set_dec_ring_funcs(struct amdgpu_device *adev)
+{
+	int i, j, jpeg_inst;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			adev->jpeg.inst[i].ring_dec[j].funcs = &jpeg_v5_0_1_dec_ring_vm_funcs;
+			adev->jpeg.inst[i].ring_dec[j].me = i;
+			adev->jpeg.inst[i].ring_dec[j].pipe = j;
+		}
+		jpeg_inst = GET_INST(JPEG, i);
+		adev->jpeg.inst[i].aid_id =
+			jpeg_inst / adev->jpeg.num_inst_per_aid;
+	}
+}
+
+static const struct amdgpu_irq_src_funcs jpeg_v5_0_1_irq_funcs = {
+	.set = jpeg_v5_0_1_set_interrupt_state,
+	.process = jpeg_v5_0_1_process_interrupt,
+};
+
+static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
+		adev->jpeg.inst->irq.num_types += adev->jpeg.num_jpeg_rings;
+
+	adev->jpeg.inst->irq.funcs = &jpeg_v5_0_1_irq_funcs;
+}
+
+const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_JPEG,
+	.major = 5,
+	.minor = 0,
+	.rev = 1,
+	.funcs = &jpeg_v5_0_1_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
new file mode 100644
index 0000000000000..8ce146c00bb69
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#ifndef __JPEG_V5_0_1_H__
+#define __JPEG_V5_0_1_H__
+
+extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
+
+#endif /* __JPEG_V5_0_0_H__ */
-- 
2.47.0

