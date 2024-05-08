Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC40C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 14:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF4D112F35;
	Wed,  8 May 2024 14:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lncS1Fa+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 978DB112F35
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 14:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbRQwVsRiesgOZtp9z1CssbJd1+Skml9ytWPlF3iqlKZKX+OQ+bq9dit/jYokabMY+ncSZvtUYOavzn4qdRnOi+qd/s3CZ1ta7MbFxUctLBB/Fw5GMNak/8OphxEn/72B2UYFzu5MCRNKE/XBCrGBHW2QFGZynTrwh2E700fGWsaD6SnHuqlSGC7TinCZrG57osADwA7ddL93ZrR7IRtqKEv3Gl4tF/v8Ke4+3EkOrHP/NwUr+pyNK996aKtu3k9ZtlBkRhK9G7uv3GYDCcoOgsI0ePZxHL2tU2aNyCHlEV/xNPxYiMh8BKM5QON4ljVv4EwiUk10PaQzZki9aCXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKH70e+wsw/XkUy0SCE0zumCE0ucrdZtJMNLAASfUlg=;
 b=dAh4LWRfBUHqL4wVTb11djwVpX4+ddFec09iYeoGha5Dns+JZYyQs5it0DbFmbl/wYT59obhGWfmneGO0F3HungWUv4HrDEAguWoDJWViTQvv/NMKfZvxtIA4vALkHJUlguoM+YBvQnAR+32Q8ovpDMshQ6RhXbbzBDRAcvV8NnKy8MAyNLw8sNdE1KxnGqiCISROFlnh2FwYUCuu/HeTbH32/V9fqm/Ca88aQ3SBEMuE6OPSbX08Fipqnh3iT59lJeOmYPuOx0KSWgyfXNsqRsME5Fw/UBECA+T5AMEBdo9xOxGJDYXtN0VjzcDwcofNY05MW6ccj2MNWmJ19ht3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKH70e+wsw/XkUy0SCE0zumCE0ucrdZtJMNLAASfUlg=;
 b=lncS1Fa+zSoikhq4QoHghtF6RKXQ5j6CLLlz3Cql7DwVtMCOdLrhufcB4v5WcNzgkN91j85eBQb4hfvvtVnJdoPFex/yHCLWxkAtDVVk0eU3uTS+2MvNnMnoo+NIOY/qoKgdUUKIKPaIz/ORoBly3RMbrqZmYOmeaT7rBlb1wuo=
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 14:51:15 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::f4) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Wed, 8 May 2024 14:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 14:51:14 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 09:51:13 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 2/3] drm/amd/amdgpu: Add ISP driver support
Date: Wed, 8 May 2024 10:50:58 -0400
Message-ID: <20240508145058.254306-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0ae50e-a0b1-4a9c-bb53-08dc6f6e4f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dAZ40kZa3CqKwNYsIRR/UJ0tLRfyVqqiZxIHLlbnrugpA00I/rLI2g4oVfak?=
 =?us-ascii?Q?qLWr5220+CRLNggwRzaFyvQmE33RAwLJJ7U2KkaAcGZUEZXENj/McW0U6gI+?=
 =?us-ascii?Q?bym3VS0IIomWD8c9YP5hhsVv+nWIHcL4KDK29aQjg7nzpvXg99IFNFWgmrF9?=
 =?us-ascii?Q?McBPJi9MbcjJ63XzwWWAg0Zkl7MO7ZIqrbfbH+TT2bEcVUIXyHoYaziMPFbx?=
 =?us-ascii?Q?mLq2T6A5uPAYerDvjnbAlf5bvF55xaSoNurbXCg/2kQN+u8kuaXHI1KqPgdc?=
 =?us-ascii?Q?Be13OWsGt4kSob6moD7EhrRbmLD97FFrGJsV7a0xnuOaSYIbJ3nl99SsjYrj?=
 =?us-ascii?Q?l4Ei+bCC10nTTuyfsVADh5RolZBL+nuOKlH94N4mlyX5wBNSygBuzuL59frB?=
 =?us-ascii?Q?E5ltbcVYUzJCl30Hqx0CN+Vk2kUxer6xunUnRotF5p9pGuthxDnYGHg1EU9H?=
 =?us-ascii?Q?id21x8MINh36FtRkPfBKf/dTMlqJjqTwSAoAh6xkGRa0e/vJKGAxt1ql7bi2?=
 =?us-ascii?Q?RTXB1RqGIDPloaLURenI3rggS/qxgs72rG3BJ1ShtN8QUz5fGLojf1J7HQ9c?=
 =?us-ascii?Q?9aMGikTRnTRi9mSWAvc8IlGSPXrH45/ySEh8DoGVIIU9DMGzDPsnLZUkraM2?=
 =?us-ascii?Q?2ygmF7FPr3yqOAy5H+AAsI9QKCwFM66b/fqFyKCse6FM/PvnBLAOusiFjH2v?=
 =?us-ascii?Q?w+G+as1z8gusMCV6nQIRgkGwI3ViF/Us8izo4FK+BD4PDvoK1UpE7UI1qIDE?=
 =?us-ascii?Q?+u8+jeDJMC3MnKnB4vbU4FQOY4tZBWflqs4LUO824o+hCSdMVVYgNA3YXvz9?=
 =?us-ascii?Q?8E8pFR5f3c0GMtlCvsU/57xRq+9cIhk5zFZA6edmSxZ8x25Nps5zZKmMof9F?=
 =?us-ascii?Q?fvleINXnDzQ+dUVIGeOR9jICZ4oJC/deRKzA/6Oll5RkXXgHPVby9KUEkqL/?=
 =?us-ascii?Q?LM0Zwkt/7RSKMlWDAcbBv6BqmnrnjKjwsIkmDZWvp+5wlk25gw6k07IsNBzs?=
 =?us-ascii?Q?ws5MXRh2eqI+BxyPhTg6p5tReIvjBcjVo9mdLl5zWQ9TEBoRdypEoz0fgUza?=
 =?us-ascii?Q?0IBlqy+peuwiHGQrMKpk21Oa7i/AQEd6SQuAW68fFcXaRr2bNMSgc94bMK0s?=
 =?us-ascii?Q?ZixriPAlV05bXIaoxET+dIivzlErhMEwsFv0KBMyeWgA/Noh8ci2eX7DyjFM?=
 =?us-ascii?Q?JJUtvBdumkdIbVmg2XkaOeVibppB+nBHuL89EAeB3pslmOD+r9I6Dnew2GoX?=
 =?us-ascii?Q?bQbBrcOVomE8SfGs/u2+nUF4aUuyMf31fthhWaLXk4O5o298p5foriYMZeZj?=
 =?us-ascii?Q?xKXlQH0Z5ZAXPszHClDhvvaQTIk91sEm/GFdnqDw4tCZupL5LCIf0YfUXJbT?=
 =?us-ascii?Q?/rlecXA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:51:14.6445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0ae50e-a0b1-4a9c-bb53-08dc6f6e4f44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

Add the isp driver in amdgpu to support ISP device on the APUs that
supports ISP IP block. ISP hw block is used for camera front-end, pre
and post processing operations.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c   | 298 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h   |  54 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   1 +
 7 files changed, 368 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index de7b76327f5b..12ba76025cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -324,4 +324,7 @@ amdgpu-y += $(AMD_DISPLAY_FILES)
 
 endif
 
+# add isp block
+amdgpu-y += amdgpu_isp.o
+
 obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index eb60d28a3a13..6d7f9ef53269 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,6 +112,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
+#include "amdgpu_isp.h"
 
 #define MAX_GPU_INSTANCE		64
 
@@ -1045,6 +1046,9 @@ struct amdgpu_device {
 	/* display related functionality */
 	struct amdgpu_display_manager dm;
 
+	/* isp */
+	struct amdgpu_isp		isp;
+
 	/* mes */
 	bool                            enable_mes;
 	bool                            enable_mes_kiq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
new file mode 100644
index 000000000000..dcc01a339a43
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#include <linux/irqdomain.h>
+#include <linux/pm_domain.h>
+#include <linux/platform_device.h>
+#include <sound/designware_i2s.h>
+#include <sound/pcm.h>
+#include <linux/acpi.h>
+#include <linux/firmware.h>
+
+#include "amdgpu_smu.h"
+#include "atom.h"
+#include "amdgpu_isp.h"
+#include "smu_internal.h"
+#include "smu_v11_5_ppsmc.h"
+#include "smu_v11_5_pmfw.h"
+
+#define mmDAGB0_WRCLI5_V4_1	0x6811C
+#define mmDAGB0_WRCLI9_V4_1	0x6812C
+#define mmDAGB0_WRCLI10_V4_1	0x68130
+#define mmDAGB0_WRCLI14_V4_1	0x68140
+#define mmDAGB0_WRCLI19_V4_1	0x68154
+#define mmDAGB0_WRCLI20_V4_1	0x68158
+
+static int isp_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	pr_info("%s called adev %p\n", __func__, adev);
+
+	adev->isp.parent = adev->dev;
+
+	adev->isp.cgs_device = amdgpu_cgs_create_device(adev);
+	if (!adev->isp.cgs_device)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int isp_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	pr_info("%s called adev %p\n", __func__, adev);
+
+	if (adev->isp.cgs_device)
+		amdgpu_cgs_destroy_device(adev->isp.cgs_device);
+
+	return 0;
+}
+
+/**
+ * isp_hw_init - start and test isp block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ */
+static int isp_hw_init(void *handle)
+{
+	int r;
+	u64 isp_base;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	const struct amdgpu_ip_block *ip_block =
+		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP);
+
+	if (!ip_block)
+		return -EINVAL;
+
+	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
+		return -EINVAL;
+
+	isp_base = adev->rmmio_base;
+
+	adev->isp.isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
+	if (!adev->isp.isp_cell) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
+		goto failure;
+	}
+
+	adev->isp.isp_res = kcalloc(2, sizeof(struct resource), GFP_KERNEL);
+	if (!adev->isp.isp_res) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		goto failure;
+	}
+
+	adev->isp.isp_pdata = kzalloc(sizeof(*adev->isp.isp_pdata), GFP_KERNEL);
+	if (!adev->isp.isp_pdata) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
+		goto failure;
+	}
+
+	// initialize isp platform data
+	adev->isp.isp_pdata->adev = (void *)adev;
+	adev->isp.isp_pdata->asic_type = adev->asic_type;
+	adev->isp.isp_pdata->base_rmmio_size = adev->rmmio_size;
+
+	adev->isp.isp_res[0].name = "isp41_reg";
+	adev->isp.isp_res[0].flags = IORESOURCE_MEM;
+	adev->isp.isp_res[0].start = isp_base;
+	adev->isp.isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
+
+	adev->isp.isp_res[1].name = "isp41_irq";
+	adev->isp.isp_res[1].flags = IORESOURCE_IRQ;
+	adev->isp.isp_res[1].start = amdgpu_irq_create_mapping(adev, 162);
+	adev->isp.isp_res[1].end = adev->isp.isp_res[1].start;
+
+	adev->isp.isp_cell[0].name = "amd_isp41_capture";
+	adev->isp.isp_cell[0].num_resources = 2;
+	adev->isp.isp_cell[0].resources = &adev->isp.isp_res[0];
+	adev->isp.isp_cell[0].platform_data = adev->isp.isp_pdata;
+	adev->isp.isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
+
+	r = mfd_add_hotplug_devices(adev->isp.parent, adev->isp.isp_cell, 1);
+	if (r) {
+		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
+		goto failure;
+	}
+
+	// Temporary WA added to disable MMHUB TLSi until the GART initialization
+	// is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
+	// using the TLSi path
+	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI5_V4_1 >> 2, 0xFE5FEAA8);
+	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI9_V4_1 >> 2, 0xFE5FEAA8);
+	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI10_V4_1 >> 2, 0xFE5FEAA8);
+	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI14_V4_1 >> 2, 0xFE5FEAA8);
+	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI19_V4_1 >> 2, 0xFE5FEAA8);
+	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI20_V4_1 >> 2, 0xFE5FEAA8);
+
+	return 0;
+
+failure:
+
+	kfree(adev->isp.isp_pdata);
+	kfree(adev->isp.isp_res);
+	kfree(adev->isp.isp_cell);
+
+	return r;
+}
+
+/**
+ * isp_hw_fini - stop the hardware block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ */
+static int isp_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	// remove isp mfd device
+	mfd_remove_devices(adev->isp.parent);
+
+	kfree(adev->isp.isp_res);
+	kfree(adev->isp.isp_cell);
+	kfree(adev->isp.isp_pdata);
+
+	return 0;
+}
+
+static int isp_suspend(void *handle)
+{
+	return 0;
+}
+
+static int isp_resume(void *handle)
+{
+	return 0;
+}
+
+static int isp_load_fw_by_psp(struct amdgpu_device *adev)
+{
+	const struct common_firmware_header *hdr;
+	char ucode_prefix[30];
+	char fw_name[40];
+	int r = 0;
+
+	// get isp fw binary name and path
+	amdgpu_ucode_ip_version_decode(adev, ISP_HWIP, ucode_prefix,
+				       sizeof(ucode_prefix));
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
+
+	// read isp fw
+	r = amdgpu_ucode_request(adev, &adev->isp.fw, fw_name);
+	if (r) {
+		DRM_ERROR("%s: failed to read isp fw %s\n", __func__, fw_name);
+		amdgpu_ucode_release(&adev->isp.fw);
+		return r;
+	}
+
+	hdr = (const struct common_firmware_header *)adev->isp.fw->data;
+
+	adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].ucode_id =
+		AMDGPU_UCODE_ID_ISP;
+	adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].fw = adev->isp.fw;
+
+	adev->firmware.fw_size +=
+		ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+
+	DRM_INFO("isp fw <%s> load success, (base_addr, size)=(%p,%d)\n", fw_name,
+		 adev->isp.fw->data, (int)adev->isp.fw->size);
+
+	return r;
+}
+
+static int isp_early_init(void *handle)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	ret = isp_load_fw_by_psp(adev);
+	if (ret) {
+		DRM_WARN("%s: isp fw load failed\n", __func__);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static bool isp_is_idle(void *handle)
+{
+	return true;
+}
+
+static int isp_wait_for_idle(void *handle)
+{
+	return 0;
+}
+
+static int isp_soft_reset(void *handle)
+{
+	return 0;
+}
+
+static int isp_set_clockgating_state(void *handle,
+				     enum amd_clockgating_state state)
+{
+	return 0;
+}
+
+static int isp_set_powergating_state(void *handle,
+				     enum amd_powergating_state state)
+{
+	return 0;
+}
+
+static const struct amd_ip_funcs isp_ip_funcs = {
+	.name = "isp_ip",
+	.early_init = isp_early_init,
+	.late_init = NULL,
+	.sw_init = isp_sw_init,
+	.sw_fini = isp_sw_fini,
+	.hw_init = isp_hw_init,
+	.hw_fini = isp_hw_fini,
+	.suspend = isp_suspend,
+	.resume = isp_resume,
+	.is_idle = isp_is_idle,
+	.wait_for_idle = isp_wait_for_idle,
+	.soft_reset = isp_soft_reset,
+	.set_clockgating_state = isp_set_clockgating_state,
+	.set_powergating_state = isp_set_powergating_state,
+};
+
+const struct amdgpu_ip_block_version isp_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_ISP,
+	.major = 4,
+	.minor = 1,
+	.rev = 0,
+	.funcs = &isp_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
new file mode 100644
index 000000000000..2adcb4b4dc6e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#ifndef __AMDGPU_ISP_H__
+#define __AMDGPU_ISP_H__
+
+#include <linux/mfd/core.h>
+#include <linux/mfd/core.h>
+
+#define ISP_REGS_OFFSET_END 0x629A4
+
+struct isp_platform_data {
+	void *adev;
+	u32 asic_type;
+	resource_size_t base_rmmio_size;
+};
+
+struct amdgpu_isp {
+	struct device *parent;
+	struct cgs_device *cgs_device;
+	struct mfd_cell *isp_cell;
+	struct resource *isp_res;
+	struct isp_platform_data *isp_pdata;
+	unsigned int harvest_config;
+	const struct firmware	*fw;
+};
+
+extern const struct amdgpu_ip_block_version isp_ip_block;
+
+#endif /* __AMDGPU_ISP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 37820dd03cab..b4bd943a7cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2539,6 +2539,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_JPEG_RAM:
 		*type = GFX_FW_TYPE_JPEG_RAM;
 		break;
+	case AMDGPU_UCODE_ID_ISP:
+		*type = GFX_FW_TYPE_ISP;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 75ece8a2f96b..a9de78bb96e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -712,6 +712,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "RS64_MEC_P2_STACK";
 	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
 		return "RS64_MEC_P3_STACK";
+	case AMDGPU_UCODE_ID_ISP:
+		return "ISP";
 	default:
 		return "UNKNOWN UCODE";
 	}
@@ -1411,6 +1413,9 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
 	case VPE_HWIP:
 		ip_name = "vpe";
 		break;
+	case ISP_HWIP:
+		ip_name = "isp";
+		break;
 	default:
 		BUG();
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index a3c04f711099..db745ab7b0c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -523,6 +523,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
 	AMDGPU_UCODE_ID_P2S_TABLE,
 	AMDGPU_UCODE_ID_JPEG_RAM,
+	AMDGPU_UCODE_ID_ISP,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
 
-- 
2.34.1

