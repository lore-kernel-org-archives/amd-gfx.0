Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAC5EB1070
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 15:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC03510E2AE;
	Tue, 10 Mar 2026 15:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hceGznZR";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A8810E2AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 15:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHyIxKfI/Uv2iMpEbYaKSOYNMPQWZuxpkTwK16YhD40M4xKHY6cCpwPmiJsCRugOhJ7vEGXNGDICsr8BqX0APhdi4gg7tY5poanxzCAZJQWv26JHqXPTA/Y0H9s9cflv0yGXon0fceJbDHmIXxSN0D/RbH/Jd3vF4leUEhI6ls9O1PPRvbVdE4P3Cf+YHDS/agx5CgffxdOkBAisUGY8LxNzoPnCf1GQX/vDPIpsQdYWfNAQ1ZSLggs8QgCGam4OkTRLyGovp0BisqZjOmjvqE7eXwxgeYrEXWEOBiwsEuv+p6wBqIwRcLq7mKftlSb/gM+pxlN67lyIKY5EQweMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E66lvewbriCBq65P+J+dFHFC6aLnQYmo9XOA44oTQpM=;
 b=kuDBDCkL9MPlarYb2RHEWcuZBMaFYNn4BXm+Y5lQ4FH6PWm1IH/EB5/UszvIiGb19D/UkQ477iEK3cq3VcoNpt+fiFrXMSapixEo/8PBiAIlTpv7+rR88J/cIt4ImFQjZuMJFwkll6fX5+WweCIsdHsOzwPQ2y8a6b1POXKEceBXx/yuQcALgKjrUh4eytImcS7R2I+QwFRI+Be+mguxp6AXT33YbQOjCV/byImLob0l93ou3IwhTfL/qrk6niUnlgWKt6ferHnovmj0zjpuqFjPjNxTo6g+T7r4ZC8mW0dCrKrO8BjoFhkFTcX9F2zoLnQQrYqemkc7D1yrIqITcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E66lvewbriCBq65P+J+dFHFC6aLnQYmo9XOA44oTQpM=;
 b=hceGznZRNQG+LNmjvGd+OtGIniM+w3BQRs81vGpZb1PaqVpAbj3mJY5rttoQWXKeEg1ekeg7MoRbbDvyq5AJFXedb/pA7erRIDDe017Xe0In2IYU7u8Ba0zil0z25CXKTm7k+OEbQd+w3ds7aB4FXd52z2QtvDPydWM9CvzKVzs=
Received: from CYZPR14CA0033.namprd14.prod.outlook.com (2603:10b6:930:a0::20)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Tue, 10 Mar
 2026 15:32:12 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:a0:cafe::31) by CYZPR14CA0033.outlook.office365.com
 (2603:10b6:930:a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 15:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 15:32:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 10:32:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 10:32:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 10:32:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add VCN v5_0_2
Date: Tue, 10 Mar 2026 11:32:00 -0400
Message-ID: <20260310153203.2883286-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 238bf506-68e7-496b-5fe6-08de7eba3346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DXhpKZY1Wd+Mp9KgDsjtzsZCVqt3d/KLq3co4pdaccEvYyGknqugQBlsXpTlZP3td57h/v1u8EaPsBkvsXO7sng0/oclCTVZxKX0dVmpd0bGlZbwLj/H5qHrPAOG3w9hy1Vc+EesxQhseUzgkdgpcwMfn5p0jZ/hemrk3n03ZijESMVVB9OPySdgJ0IgYuShmAHGzIgEXYAIqz8iTm2uMosTqQ6Mr0HYe6l7E+19juaIvTdC2qadwsQ4XRyWMJ5fz1aN+Uy5m1/A6O9BMpduc5+4fHHrsavBLjp/SvXNMOTxSYPyR4OSvZwgP6orLYUtDPgPbTiYQtE4D829X9QU2JxJOY/I/AdBItbAOI7D+X6boJCPkANU0j/lfHc+4GgD/fEYjZuhLgtlf4gxCCRx0ra0dLakkKjvKo89yHDv087O524XzgJpo/AfKymh4jsi4RM1K5l6aFzzlcUfcGvKOAkkXXXU865TJW1bP67zLby+l3NpddgK6IVzHv+CyCDQjLy+B4Y2NYY+iOZlzzya+inzasgkM1Znb5mWRFP6FW8gPoa2RwaQXJ0yDPuPrhsBo4JarcApmVfpzILyJfpho+Az/9v/ujL4b9Hu42YsKaidkUeTL+Ev7aHrhy7DU3+d8+qeStA+782F6DCmgO4zWwcTFE8W8/mUXAQkuW7H72gYb4tK93GurDx48ogaSGanYSA289e9DQeZeBm9R4M3Dk6MxpKGrRS745U/jQfb8X5IjsEGXlCHWggzj19pRsY4XBgWyKl+vqgF8guxcNJX/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tl6J4cvJjgncPw+K3zzB6iL8n2Sa0rgT2+c9bNciEzRFS3lOr/LDydtCggb9Jprh8EN+UIOsLYtMksshYCzYKtcGQFKjy2Ngg+wAH19C50MShZLqqC9FAer2J7wPOx4xc1fEJT99KpVbNzpSC1Qza0RwLvkzZ1fJkY8msb5xKk78xZ1aR5a7YsruuqqOlX+8V4PKMSnjKm0WiiViDBhbr52WeMeh6PeWvvYWRsuE1fDibf3InNNwsVRjUYWF08SjOHGNVCJ8gWxQsWA5GWrjEiHd1MjMcwukylg8BkJCHZjlTnUSUCoHcJyb520Z7/ay3frx6oZ6ZFWWReh/l1FSNhCzcWPoDzrmR3qCpi2gGY78yF0AersNCjJEZkB2jUU5VrYZP5XM6RXyovm0e4uJgShk5UVDUKqjJGKN55zbXCitidwiExDe+88uWB8aw3Mp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:32:12.1814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 238bf506-68e7-496b-5fe6-08de7eba3346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

From: Sonny Jiang <sonjiang@amd.com>

Add support for VCN_5_0_2

v2: squash in RRMT enable bit fix from Sonny (Alex)
v3: sqaush in doorbell enablement patch (Alex)
v4: drop some bringup leftovers (Alex)

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |    8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c       | 1219 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h       |   29 +
 5 files changed, 1259 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 9c9c73b73ac8e..37f2db4b7808a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -213,6 +213,7 @@ amdgpu-y += \
 	vcn_v4_0_5.o \
 	vcn_v5_0_0.o \
 	vcn_v5_0_1.o \
+	vcn_v5_0_2.o \
 	amdgpu_jpeg.o \
 	jpeg_v1_0.o \
 	jpeg_v2_0.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f77a03ea4d90e..1e73e791580dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -112,6 +112,7 @@
 #include "smuio_v15_0_8.h"
 #include "vcn_v5_0_0.h"
 #include "vcn_v5_0_1.h"
+#include "vcn_v5_0_2.h"
 #include "jpeg_v5_0_0.h"
 #include "jpeg_v5_0_1.h"
 #include "jpeg_v5_3_0.h"
@@ -2643,6 +2644,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v5_0_1_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_1_ip_block);
 			break;
+		case IP_VERSION(5, 0, 2):
+			amdgpu_device_ip_block_add(adev, &vcn_v5_0_2_ip_block);
+			break;
 		default:
 			dev_err(adev->dev,
 				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 75ae9b429420e..03d95dca93d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -63,6 +63,7 @@
 #define FIRMWARE_VCN4_0_6_1		"amdgpu/vcn_4_0_6_1.bin"
 #define FIRMWARE_VCN5_0_0		"amdgpu/vcn_5_0_0.bin"
 #define FIRMWARE_VCN5_0_1		"amdgpu/vcn_5_0_1.bin"
+#define FIRMWARE_VCN5_0_2		"amdgpu/vcn_5_0_2.bin"
 #define FIRMWARE_VCN5_3_0		"amdgpu/vcn_5_3_0.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
@@ -91,6 +92,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_6);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_6_1);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
+MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
 MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
@@ -1095,7 +1097,8 @@ int amdgpu_vcn_unified_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	long r;
 
 	if ((amdgpu_ip_version(adev, UVD_HWIP, 0) != IP_VERSION(4, 0, 3)) &&
-	    (amdgpu_ip_version(adev, UVD_HWIP, 0) != IP_VERSION(5, 0, 1))) {
+	    (amdgpu_ip_version(adev, UVD_HWIP, 0) != IP_VERSION(5, 0, 1)) &&
+	    (amdgpu_ip_version(adev, UVD_HWIP, 0) != IP_VERSION(5, 0, 2))) {
 		r = amdgpu_vcn_enc_ring_test_ib(ring, timeout);
 		if (r)
 			goto error;
@@ -1132,7 +1135,8 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int i)
 			return;
 
 		if ((amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 3) ||
-		     amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(5, 0, 1))
+		     amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(5, 0, 1) ||
+		     amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(5, 0, 2))
 		    && (i > 0))
 			return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
new file mode 100644
index 0000000000000..c3d3cc0230580
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -0,0 +1,1219 @@
+/*
+ * Copyright 2025-2026 Advanced Micro Devices, Inc. All rights reserved.
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
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_vcn.h"
+#include "amdgpu_pm.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "soc15_hw_ip.h"
+#include "vcn_v2_0.h"
+#include "vcn_v4_0_3.h"
+
+#include "vcn/vcn_5_0_0_offset.h"
+#include "vcn/vcn_5_0_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+#include "vcn_v5_0_0.h"
+#include "vcn_v5_0_1.h"
+#include "vcn_v5_0_2.h"
+
+#include <drm/drm_drv.h>
+
+static void vcn_v5_0_2_set_unified_ring_funcs(struct amdgpu_device *adev);
+static void vcn_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_2_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
+static void vcn_v5_0_2_unified_ring_set_wptr(struct amdgpu_ring *ring);
+
+/**
+ * vcn_v5_0_2_early_init - set function pointers and load microcode
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Set ring and irq function pointers
+ * Load microcode from filesystem
+ */
+static int vcn_v5_0_2_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, r;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		/* re-use enc ring as unified ring */
+		adev->vcn.inst[i].num_enc_rings = 1;
+
+	vcn_v5_0_2_set_unified_ring_funcs(adev);
+	vcn_v5_0_2_set_irq_funcs(adev);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v5_0_2_set_pg_state;
+
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static void vcn_v5_0_2_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
+{
+	struct amdgpu_vcn5_fw_shared *fw_shared;
+
+	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+
+	if (fw_shared->sq.is_enabled)
+		return;
+	fw_shared->present_flag_0 =
+		cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = 1;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
+}
+
+/**
+ * vcn_v5_0_2_sw_init - sw init for VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Load firmware and sw initialization
+ */
+static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int i, r, vcn_inst;
+
+	/* VCN UNIFIED TRAP */
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_VCN,
+		VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		vcn_inst = GET_INST(VCN, i);
+
+		r = amdgpu_vcn_sw_init(adev, i);
+		if (r)
+			return r;
+
+		amdgpu_vcn_setup_ucode(adev, i);
+
+		r = amdgpu_vcn_resume(adev, i);
+		if (r)
+			return r;
+
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		ring->use_doorbell = true;
+
+		ring->doorbell_index =
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 32 * vcn_inst;
+
+		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
+		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
+
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
+					AMDGPU_RING_PRIO_DEFAULT, &adev->vcn.inst[i].sched_score);
+		if (r)
+			return r;
+
+		vcn_v5_0_2_fw_shared_init(adev, i);
+	}
+
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
+	return amdgpu_vcn_sysfs_reset_mask_init(adev);
+}
+
+/**
+ * vcn_v5_0_2_sw_fini - sw fini for VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * VCN suspend and free up sw allocation
+ */
+static int vcn_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, r, idx;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			struct amdgpu_vcn5_fw_shared *fw_shared;
+
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			fw_shared->present_flag_0 = 0;
+			fw_shared->sq.is_enabled = 0;
+		}
+
+		drm_dev_exit(idx);
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		amdgpu_vcn_sw_fini(adev, i);
+
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
+	kfree(adev->vcn.ip_dump); //TODO check
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_2_hw_init - start and test VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Initialize the hardware, boot up the VCPU and do some testing
+ */
+static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int i, r, vcn_inst;
+	uint32_t tmp;
+
+	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x200)
+		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		vcn_inst = GET_INST(VCN, i);
+		ring = &adev->vcn.inst[i].ring_enc[0];
+
+		/* Remove Video Tiles antihang mechanism */
+		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS);
+		tmp &= (~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+		WREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS, tmp);
+
+		if (ring->use_doorbell)
+			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				 11 * vcn_inst),
+				adev->vcn.inst[i].aid_id);
+
+		/* Re-init fw_shared, if required */
+		vcn_v5_0_2_fw_shared_init(adev, i);
+
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_2_hw_fini - stop the hardware block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Stop the VCN block, mark ring as not ready any more
+ */
+static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		if (vinst->cur_state != AMD_PG_STATE_GATE)
+			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_2_suspend - suspend VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * HW fini and suspend VCN block
+ */
+static int vcn_v5_0_2_suspend(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r, i;
+
+	r = vcn_v5_0_2_hw_fini(ip_block);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(ip_block->adev, i);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+/**
+ * vcn_v5_0_2_resume - resume VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Resume firmware and hw init VCN block
+ */
+static int vcn_v5_0_2_resume(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		if (amdgpu_in_reset(adev))
+			vinst->cur_state = AMD_PG_STATE_GATE;
+
+		r = amdgpu_vcn_resume(ip_block->adev, i);
+		if (r)
+			return r;
+	}
+
+	r = vcn_v5_0_2_hw_init(ip_block);
+
+	return r;
+}
+
+/**
+ * vcn_v5_0_2_mc_resume - memory controller programming
+ *
+ * @vinst: VCN instance
+ *
+ * Let the VCN memory controller know it's offsets
+ */
+static void vcn_v5_0_2_mc_resume(struct amdgpu_vcn_inst *vinst)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
+	uint32_t offset, size, vcn_inst;
+	const struct common_firmware_header *hdr;
+
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+
+	vcn_inst = GET_INST(VCN, inst);
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst].tmr_mc_addr_lo));
+		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst].tmr_mc_addr_hi));
+		WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_OFFSET0, 0);
+		offset = 0;
+	} else {
+		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			lower_32_bits(adev->vcn.inst[inst].gpu_addr));
+		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			upper_32_bits(adev->vcn.inst[inst].gpu_addr));
+		offset = size;
+		WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_OFFSET0,
+				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+	}
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_SIZE0, size);
+
+	/* cache window 1: stack */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].gpu_addr + offset));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].gpu_addr + offset));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_OFFSET1, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
+
+	/* cache window 2: context */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_OFFSET2, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+
+	/* non-cache window */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_OFFSET0, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_SIZE0,
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)));
+}
+
+/**
+ * vcn_v5_0_2_mc_resume_dpg_mode - memory controller programming for dpg mode
+ *
+ * @vinst: VCN instance
+ * @indirect: indirectly write sram
+ *
+ * Let the VCN memory controller know it's offsets with dpg mode
+ */
+static void vcn_v5_0_2_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	uint32_t offset, size;
+	const struct common_firmware_header *hdr;
+
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
+	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (!indirect) {
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN +
+				 inst_idx].tmr_mc_addr_lo), 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN +
+				 inst_idx].tmr_mc_addr_hi), 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		} else {
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		}
+		offset = 0;
+	} else {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		offset = size;
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
+			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
+	}
+
+	if (!indirect)
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+	else
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
+
+	/* cache window 1: stack */
+	if (!indirect) {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+	} else {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+	}
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+
+	/* cache window 2: context */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+
+	/* non-cache window */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_NONCACHE_SIZE0),
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)), 0, indirect);
+
+	/* VCN global tiling registers */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+}
+
+/**
+ * vcn_v5_0_2_disable_clock_gating - disable VCN clock gating
+ *
+ * @vinst: VCN instance
+ *
+ * Disable clock gating for VCN block
+ */
+static void vcn_v5_0_2_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
+{
+}
+
+/**
+ * vcn_v5_0_2_enable_clock_gating - enable VCN clock gating
+ *
+ * @vinst: VCN instance
+ *
+ * Enable clock gating for VCN block
+ */
+static void vcn_v5_0_2_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
+{
+}
+
+/**
+ * vcn_v5_0_2_pause_dpg_mode - VCN pause with dpg mode
+ *
+ * @vinst: VCN instance
+ * @new_state: pause state
+ *
+ * Pause dpg mode for VCN block
+ */
+static int vcn_v5_0_2_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				struct dpg_pause_state *new_state)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	uint32_t reg_data = 0;
+	int vcn_inst;
+
+	vcn_inst = GET_INST(VCN, vinst->inst);
+
+	/* pause/unpause if state is changed */
+	if (vinst->pause_state.fw_based != new_state->fw_based) {
+		DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d %s\n",
+			vinst->pause_state.fw_based, new_state->fw_based,
+			new_state->fw_based ? "VCN_DPG_STATE__PAUSE" : "VCN_DPG_STATE__UNPAUSE");
+		reg_data = RREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE) &
+				(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			/* pause DPG */
+			reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
+
+			/* wait for ACK */
+			SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_DPG_PAUSE,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+		} else {
+			/* unpause DPG, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
+		}
+		vinst->pause_state.fw_based = new_state->fw_based;
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_2_start_dpg_mode - VCN start with dpg mode
+ *
+ * @vinst: VCN instance
+ * @indirect: indirectly write sram
+ *
+ * Start VCN block with dpg mode
+ */
+static int vcn_v5_0_2_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	struct amdgpu_vcn5_fw_shared *fw_shared =
+		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct amdgpu_ring *ring;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
+	int vcn_inst, ret;
+	uint32_t tmp;
+
+	vcn_inst = GET_INST(VCN, inst_idx);
+
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 1,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* enable dynamic power gating mode */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS);
+	tmp |= UVD_POWER_STATUS__UVD_PG_MODE_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS, tmp);
+
+	if (indirect) {
+		adev->vcn.inst[inst_idx].dpg_sram_curr_addr =
+			(uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
+		/* Use dummy register 0xDEADBEEF passing AID selection to PSP FW */
+		WREG32_SOC24_DPG_MODE(inst_idx, 0xDEADBEEF,
+				adev->vcn.inst[inst_idx].aid_id, 0, true);
+	}
+
+	/* enable VCPU clock */
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK | UVD_VCPU_CNTL__BLK_RST_MASK;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* disable master interrupt */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_MASTINT_EN), 0, 0, indirect);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = (UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		UVD_LMI_CTRL__REQ_MODE_MASK |
+		UVD_LMI_CTRL__CRC_RESET_MASK |
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
+		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
+		0x00100000L);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_CTRL), tmp, 0, indirect);
+
+	vcn_v5_0_2_mc_resume_dpg_mode(vinst, indirect);
+
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* enable LMI MC and UMC channels */
+	tmp = 0x1f << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_CTRL2), tmp, 0, indirect);
+
+	/* enable master interrupt */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
+
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
+		if (ret) {
+			dev_err(adev->dev, "vcn sram load failed %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* resetting ring, fw should not check RB ring */
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+
+	/* Pause dpg */
+	vcn_v5_0_2_pause_dpg_mode(vinst, &state);
+
+	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring->ring_size / sizeof(uint32_t));
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+
+	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	/* resetting done, fw can check RB ring */
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
+		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		VCN_RB1_DB_CTRL__EN_MASK);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_2_start - VCN start
+ *
+ * @vinst: VCN instance
+ *
+ * Start VCN block
+ */
+static int vcn_v5_0_2_start(struct amdgpu_vcn_inst *vinst)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
+	struct amdgpu_vcn5_fw_shared *fw_shared;
+	struct amdgpu_ring *ring;
+	uint32_t tmp;
+	int j, k, r, vcn_inst;
+
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v5_0_2_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
+
+	vcn_inst = GET_INST(VCN, i);
+
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	vcn_v5_0_2_mc_resume(vinst);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+			if (status & 2)
+				break;
+			mdelay(1000);
+			if (amdgpu_emu_mode == 1)
+				msleep(520);
+		}
+
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status & 2) {
+				r = 0;
+				break;
+			}
+		} else {
+			r = 0;
+			if (status & 2)
+				break;
+
+			dev_err(adev->dev,
+				"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
+			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+				 UVD_VCPU_CNTL__BLK_RST_MASK,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+			mdelay(10);
+			r = -1;
+		}
+	}
+
+	if (r) {
+		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
+		return r;
+	}
+
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+
+	ring = &adev->vcn.inst[i].ring_enc[0];
+
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
+		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		     VCN_RB1_DB_CTRL__EN_MASK);
+
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring->ring_size / 4);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_2_stop_dpg_mode - VCN stop with dpg mode
+ *
+ * @vinst: VCN instance
+ *
+ * Stop VCN block with dpg mode
+ */
+static void vcn_v5_0_2_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	uint32_t tmp;
+	int vcn_inst;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
+
+	vcn_inst = GET_INST(VCN, inst_idx);
+
+	/* Unpause dpg */
+	vcn_v5_0_2_pause_dpg_mode(vinst, &state);
+
+	/* Wait for power status to be 1 */
+	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* wait for read ptr to be equal to write ptr */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_RB_RPTR, tmp, 0xFFFFFFFF);
+
+	/* disable dynamic power gating mode */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
+		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+}
+
+/**
+ * vcn_v5_0_2_stop - VCN stop
+ *
+ * @vinst: VCN instance
+ *
+ * Stop VCN block
+ */
+static int vcn_v5_0_2_stop(struct amdgpu_vcn_inst *vinst)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
+	struct amdgpu_vcn5_fw_shared *fw_shared;
+	uint32_t tmp;
+	int r = 0, vcn_inst;
+
+	vcn_inst = GET_INST(VCN, i);
+
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v5_0_2_stop_dpg_mode(vinst);
+		return 0;
+	}
+
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
+
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
+
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
+
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
+
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* clear status */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_2_unified_ring_get_rptr - get unified read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware unified read pointer
+ */
+static uint64_t vcn_v5_0_2_unified_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	return RREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_RPTR);
+}
+
+/**
+ * vcn_v5_0_2_unified_ring_get_wptr - get unified write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware unified write pointer
+ */
+static uint64_t vcn_v5_0_2_unified_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	if (ring->use_doorbell)
+		return *ring->wptr_cpu_addr;
+	else
+		return RREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR);
+}
+
+/**
+ * vcn_v5_0_2_unified_ring_set_wptr - set enc write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the enc write pointer to the hardware
+ */
+static void vcn_v5_0_2_unified_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	if (ring->use_doorbell) {
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR,
+				lower_32_bits(ring->wptr));
+	}
+}
+
+static const struct amdgpu_ring_funcs vcn_v5_0_2_unified_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_ENC,
+	.align_mask = 0x3f,
+	.nop = VCN_ENC_CMD_NO_OP,
+	.get_rptr = vcn_v5_0_2_unified_ring_get_rptr,
+	.get_wptr = vcn_v5_0_2_unified_ring_get_wptr,
+	.set_wptr = vcn_v5_0_2_unified_ring_set_wptr,
+	.emit_frame_size = SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+			   SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+			   4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+			   5 +
+			   5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+			   1, /* vcn_v2_0_enc_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
+	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
+	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
+	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
+	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
+	.test_ring = amdgpu_vcn_enc_ring_test_ring,
+	.test_ib = amdgpu_vcn_unified_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vcn_v2_0_enc_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_vcn_ring_begin_use,
+	.end_use = amdgpu_vcn_ring_end_use,
+	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
+/**
+ * vcn_v5_0_2_set_unified_ring_funcs - set unified ring functions
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set unified ring functions
+ */
+static void vcn_v5_0_2_set_unified_ring_funcs(struct amdgpu_device *adev)
+{
+	int i, vcn_inst;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_2_unified_ring_vm_funcs;
+		adev->vcn.inst[i].ring_enc[0].me = i;
+		vcn_inst = GET_INST(VCN, i);
+		adev->vcn.inst[i].aid_id = vcn_inst / adev->vcn.num_inst_per_aid;
+	}
+}
+
+/**
+ * vcn_v5_0_2_is_idle - check VCN block is idle
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block structure
+ *
+ * Check whether VCN block is idle
+ */
+static bool vcn_v5_0_2_is_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, ret = 1;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) == UVD_STATUS__IDLE);
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_2_wait_for_idle - wait for VCN block idle
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Wait for VCN block idle
+ */
+static int vcn_v5_0_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, ret = 0;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		ret = SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, i), regUVD_STATUS, UVD_STATUS__IDLE,
+			UVD_STATUS__IDLE);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_2_set_clockgating_state - set VCN block clockgating state
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ * @state: clock gating state
+ *
+ * Set VCN block clockgating state
+ */
+static int vcn_v5_0_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					    enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool enable = state == AMD_CG_STATE_GATE;
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		if (enable) {
+			if (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) != UVD_STATUS__IDLE)
+				return -EBUSY;
+			vcn_v5_0_2_enable_clock_gating(vinst);
+		} else {
+			vcn_v5_0_2_disable_clock_gating(vinst);
+		}
+	}
+
+	return 0;
+}
+
+static int vcn_v5_0_2_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
+{
+	int ret = 0;
+
+	if (state == vinst->cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_2_stop(vinst);
+	else
+		ret = vcn_v5_0_2_start(vinst);
+
+	if (!ret)
+		vinst->cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_2_process_interrupt - process VCN block interrupt
+ *
+ * @adev: amdgpu_device pointer
+ * @source: interrupt sources
+ * @entry: interrupt entry from clients and sources
+ *
+ * Process VCN block interrupt
+ */
+static int vcn_v5_0_2_process_interrupt(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
+	struct amdgpu_iv_entry *entry)
+{
+	uint32_t i, inst;
+
+	i = node_id_to_phys_map[entry->node_id];
+
+	DRM_DEV_DEBUG(adev->dev, "IH: VCN TRAP\n");
+
+	for (inst = 0; inst < adev->vcn.num_vcn_inst; ++inst)
+		if (adev->vcn.inst[inst].aid_id == i)
+			break;
+
+	if (inst >= adev->vcn.num_vcn_inst) {
+		dev_WARN_ONCE(adev->dev, 1,
+				"Interrupt received for unknown VCN instance %d",
+				entry->node_id);
+		return 0;
+	}
+
+	switch (entry->src_id) {
+	case VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
+		amdgpu_fence_process(&adev->vcn.inst[inst].ring_enc[0]);
+		break;
+	default:
+		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
+			  entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs vcn_v5_0_2_irq_funcs = {
+	.process = vcn_v5_0_2_process_interrupt,
+};
+
+/**
+ * vcn_v5_0_2_set_irq_funcs - set VCN block interrupt irq functions
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set VCN block interrupt irq functions
+ */
+static void vcn_v5_0_2_set_irq_funcs(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		adev->vcn.inst->irq.num_types++;
+	adev->vcn.inst->irq.funcs = &vcn_v5_0_2_irq_funcs;
+}
+
+static const struct amd_ip_funcs vcn_v5_0_2_ip_funcs = {
+	.name = "vcn_v5_0_2",
+	.early_init = vcn_v5_0_2_early_init,
+	.late_init = NULL,
+	.sw_init = vcn_v5_0_2_sw_init,
+	.sw_fini = vcn_v5_0_2_sw_fini,
+	.hw_init = vcn_v5_0_2_hw_init,
+	.hw_fini = vcn_v5_0_2_hw_fini,
+	.suspend = vcn_v5_0_2_suspend,
+	.resume = vcn_v5_0_2_resume,
+	.is_idle = vcn_v5_0_2_is_idle,
+	.wait_for_idle = vcn_v5_0_2_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = vcn_v5_0_2_set_clockgating_state,
+	.set_powergating_state = vcn_set_powergating_state,
+};
+
+const struct amdgpu_ip_block_version vcn_v5_0_2_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_VCN,
+	.major = 5,
+	.minor = 0,
+	.rev = 2,
+	.funcs = &vcn_v5_0_2_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h
new file mode 100644
index 0000000000000..461bdda91eb60
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2025-2026 Advanced Micro Devices, Inc. All rights reserved.
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
+#ifndef __VCN_v5_0_2_H__
+#define __VCN_v5_0_2_H__
+
+extern const struct amdgpu_ip_block_version vcn_v5_0_2_ip_block;
+
+#endif /* __VCN_v5_0_2_H__ */
-- 
2.53.0

