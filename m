Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A97C25B4F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 21:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF52510F678;
	Thu,  9 May 2024 21:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DZzK2dYi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EEC710F678
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 21:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktzjflNCjLyZRK50goshqRU90H3kxVXp6AES6e6p01g8DYlzDZqD8Dwe0mlaHlhAimpFRfJfCBkcExhaqYSAQWqC2sxyaly0ooGKRmhjiywzzBHTYGdnPsW29ZtlNgGycDf5e+DMgEvm5FamozhD7MnMQgQvihEu1r95LC5XkIyC1PaKeV/oLaZ+81tpSk2WsacVtsCRexDDBySsS5VZkfgLwD0LLqoLomz74fL4/mD0A2Dkj5Tj5W7L9i5SMlP37D6yGjBGNpOUySWOHXPaVozmg/mkj4AL5184m92iC1HiUKnsnjhYk4Jshf+HjLva3k/oXcoLzty4k3rh6HVRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1tx99jymqZxfw1PGz5F2IdyhSTd3SmbaWoTA4MAUe4=;
 b=H++ZKJQm9WwHvVkUV0BATktM1pLd0d7n8FUxVWVv9lhigOuEOvCdNZ30CrOsoohsc+1FdZH+av66ZrqBWFFt0r5Coo48bi9pUA2lMPvKpqA1ShRUrSn7bGDpZ+icVJJB5EJKMt4BR3LJyNR76EkXYFbUHQAiLys+EXvZS1DUIHmnwEE1vfhzHFEha6flE3cdC8svIyAnJHfG9mpjisoWtv5dWr5y0OycsCZVqxgWedhFVRY9umT9Pkg4BbJmnUH1AfhcMqNOf07jVjoY60wV5mV9PxEdcV6IB+HCVEb3cpkboPKE6u4ZqESrnz0B3uyDDLEMhz+M57msxvpbkhHqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1tx99jymqZxfw1PGz5F2IdyhSTd3SmbaWoTA4MAUe4=;
 b=DZzK2dYiM145pxXIBv0h2Yz7gkUk4yHZrsEp/EKZQ/gund19TDzIu3kpJ9km20IJUsO7PtHtYjrpADSFgE9IRiHt9uIkUBQ1Pd5PzZkvZnK/HstxGBQMUKa1zb5NH0l1dmr08b5dZhRZqYIATnV0amnZR8KdLGOVJjGLi04pmKQ=
Received: from BL0PR02CA0115.namprd02.prod.outlook.com (2603:10b6:208:35::20)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 21:50:19 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::f8) by BL0PR02CA0115.outlook.office365.com
 (2603:10b6:208:35::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Thu, 9 May 2024 21:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 21:50:19 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 16:50:19 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <mlimonci@amd.com>, <benjamin.chan@amd.com>, 
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v3 2/3] drm/amd/amdgpu: Add ISP driver support
Date: Thu, 9 May 2024 17:50:00 -0400
Message-ID: <20240509215001.515866-3-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509215001.515866-1-pratap.nirujogi@amd.com>
References: <20240509215001.515866-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 315d5a62-87aa-4161-e24e-08dc70720543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1KpVh4RLo2Z8viXe/XTE1daQwdhLsn46rDkHQBfTR/hn1ey5qalA+21Iq2Kh?=
 =?us-ascii?Q?D51j28eh7nkYBcmCgXn1pwTp2ghTdvpDehHL5ZDtL5vduNAgGNHiW4pJKeYU?=
 =?us-ascii?Q?rFErBVFOcDX8jffKne9q0XhMWFm5CIclGhsAb0QGNyMfb8v6SYjeh9vvdDH8?=
 =?us-ascii?Q?2y47mW+kKbyLBPLRoB3ac/nTkRctQ11DGyp8GjVNu+t7q94y42eijuH3tODZ?=
 =?us-ascii?Q?DZTVbHIBChONuLrHAsmvei8gGdtGdyyCYUYkkVFYtqqdqJ1lIAU1Fctw9n66?=
 =?us-ascii?Q?QDXeJie93jHcZtTqm/fk+EWBZa+hefixcHpYWmzK6x49/BntjkW8DAAczOOK?=
 =?us-ascii?Q?t6VWjPZjMTGw+f2Rl+bYJC2WF9sel6MsX8mPtEwPRlsKu6jrkS54CBeu6C0g?=
 =?us-ascii?Q?DqCSpw9zQUPnkpN7EO3x4rDqhrFAl1VS8PfHZCi4QCmfFjA1Fg47gTih3PYL?=
 =?us-ascii?Q?DueHploJRL60o+iOTtOaeNZgTF14ixauwZN/hVoUlKvfBQHqhrTk/AIlSgAg?=
 =?us-ascii?Q?EAlZn+a8010z6Dk9pXpn0D9mB9Bymw3XKBc3RPWJCwuWbcoCQcianZN5UF38?=
 =?us-ascii?Q?UtdpyvaBpGPK6Ar6NShCGyLPVhOK22U/pUmwPB7m6GoO/PMCYN+A/tEFDaLA?=
 =?us-ascii?Q?vh1C6h+BELfM1DHxlUG6LHDYnL033cInYqjhLDH1Ga9+5/UjSxk3np4XwcQ8?=
 =?us-ascii?Q?dlRS6p8g1p7dBb3ruouHtvsVmihleC229q4csfI7hnNFLXkdRmjHpTFzov/5?=
 =?us-ascii?Q?CSh5SJbKakHX74mdaRK5RSmQUitcScTZmNquFpABJWX2Qj9TsGBdxOWLwLpY?=
 =?us-ascii?Q?U037OhGsoQSbAiKKTj62HC5Qkvu5H7fNACcywXgridoEb9zsjaLXr1g5sUV+?=
 =?us-ascii?Q?uMlM+oIAdMtlw8QknYCgtxtx28L/bBNeFMZIfElteDfoaryo89HgS7fGpl0l?=
 =?us-ascii?Q?bEsUFrvvTnVZ1bCTlOfrmEyHyfAbuk58W6QaLj2EjFe/m+85gEPkfAPJdalr?=
 =?us-ascii?Q?QfvihAn7fQgdaToaeJcpPHomU4aV6jwgxXPnjeUszml1a9MOhX9nIE5LTbS0?=
 =?us-ascii?Q?tTVOL3Z1Czx2GsduhQqlJNgFfeqyOJyD6RPqb9yLChez4ahiPthHZEZz1yJS?=
 =?us-ascii?Q?XiDEPFooiGd+ocBvbO5WH4nPaKd/iE3RcNQMCdEbktINwEDrrKoyBRWluNhl?=
 =?us-ascii?Q?Xlwy0xd9NESN5tC4ulcfqOASr/T3HijX2IVsXegTKJ72Mr1hDnOiqRlvHo6W?=
 =?us-ascii?Q?GCcdzVoE6QSBU13YoU5LKH/xzYm3p0DEqt2ZTnOpi/+8HsD3sfGYYy/Tcmi2?=
 =?us-ascii?Q?yFkb5aN7XamqJXAk/rFPGEFiMZ0H43a+1Da5uiTzOcRdXLmTfSfaoHzzH5jf?=
 =?us-ascii?Q?ON/n4HWCzZYrNBksZSo1E1aDL4Ce?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:50:19.6372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315d5a62-87aa-4161-e24e-08dc70720543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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
Changes made in v3:

  - Remove unwanted header files
  - Remove suprious lines, duplicate error prints
  - Fix multi-line comment style

 drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c   | 278 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h   |  51 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   1 +
 7 files changed, 345 insertions(+)
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
index 000000000000..25e88661ac60
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -0,0 +1,278 @@
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
+#include <linux/firmware.h>
+#include <linux/mfd/core.h>
+
+#include "amdgpu.h"
+#include "amdgpu_isp.h"
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
+	if (adev->isp.cgs_device)
+		amdgpu_cgs_destroy_device(adev->isp.cgs_device);
+
+	return 0;
+}
+
+/**
+ * isp_hw_init - start and test isp block
+ *
+ * @handle: handle for amdgpu_device pointer
+ *
+ */
+static int isp_hw_init(void *handle)
+{
+	int r;
+	u64 isp_base;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
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
+	adev->isp.isp_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
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
+	/* initialize isp platform data */
+	adev->isp.isp_pdata->adev = (void *)adev;
+	adev->isp.isp_pdata->asic_type = adev->asic_type;
+	adev->isp.isp_pdata->base_rmmio_size = adev->rmmio_size;
+
+	adev->isp.isp_res[0].name = "isp_reg";
+	adev->isp.isp_res[0].flags = IORESOURCE_MEM;
+	adev->isp.isp_res[0].start = isp_base;
+	adev->isp.isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
+
+	adev->isp.isp_cell[0].name = "amd_isp_capture";
+	adev->isp.isp_cell[0].num_resources = 1;
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
+	/*
+	 * Temporary WA added to disable MMHUB TLSi until the GART initialization
+	 * is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
+	 * using the TLSi path
+	 */
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
+ * @handle: handle for amdgpu_device pointer
+ *
+ */
+static int isp_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	/* remove isp mfd device */
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
+	/* get isp fw binary name and path */
+	amdgpu_ucode_ip_version_decode(adev, ISP_HWIP, ucode_prefix,
+				       sizeof(ucode_prefix));
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
+
+	/* read isp fw */
+	r = amdgpu_ucode_request(adev, &adev->isp.fw, fw_name);
+	if (r) {
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
+		DRM_WARN("%s: isp fw load failed %d\n", __func__, ret);
+		/* allow amdgpu init to proceed though isp fw load fails */
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
index 000000000000..a11ec0543b93
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -0,0 +1,51 @@
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

