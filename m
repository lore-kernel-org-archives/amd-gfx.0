Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3446EB1072
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 15:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBC710E750;
	Tue, 10 Mar 2026 15:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o7fdA6NL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C9510E72B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 15:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZrsjsgToQgNSYy3edKnboMIqYAkrzx38lNvXZXjFfh42i611V/6qCReXwnPPwys/kKiqlm2GHYYQ2CgmbEVyWGqkjF8O1T+zJiPNASmRu/d2YCMAGqUKEcHpXep6sMMyKqhGSRVwIV52d/M6aApvV4ryQTU/oS/UETflOOcLWJ5ouIilAuevpLmnNRTw/LYirEreuhlrES7uxDxz+hH5BkA0W7JVE7OcH/a2Y9hYc6iYF3XIkby64p6rJYhrQDEA1rQ1jolKuFUR6XSlmpj4ztbUDozm6PSbVS4AlCweT8IxOw0g46M/zPNyq0cd39m5EzxHrecv4KfZCqrT0tG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeY2xhRBJMu0cq1z1g+nWW3cBto5+FI7JmRemmcHdQg=;
 b=ecOXH53ymXbaIhEJY/UXSeeL+BrhFvTZHSmY0gcEi3wKf2bHfeJ81hL0/HxqxUlu/FItJ1Zuo4GxbrNXkyqvtMAcqzr/qc00+okWg0CVauo3oEadxBHB3lEctJjqj2tjYHG3BTjOksznvFsF/p/1lhS2pZKtujaIGOyDRx99XJd6ODcfUgauLmSwur24ILV0Ye8O2JPZKmJm+NaQCl3iUznvbcJPju13YL4INtIt/nxwcfIUlXfszRu75Yi65r/vq1/bU2s8V7O9rI8aCqSSyW+2mhuqzvjbZOWFLi4k6ij2o2RTZaYfcCHrjiF+VBH6Bi7jzj4/scwp0sR00sw5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeY2xhRBJMu0cq1z1g+nWW3cBto5+FI7JmRemmcHdQg=;
 b=o7fdA6NL3SCzg6abL4RGeucRPVxhvdcnYWR/4QL/kSfLJ05HWZy03yGRRDxM9rrm3FIuWMfEk9DxvBfXtwbbSa1bY4Gc/SvFEo5izFto6MXOxd5PhXskAzCyWcRkuYATEylBAijq2P8P4wAezgF9SZhg+BPIXytyDzZi1K04RmU=
Received: from CYZPR14CA0042.namprd14.prod.outlook.com (2603:10b6:930:a0::18)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 15:32:13 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:a0:cafe::6b) by CYZPR14CA0042.outlook.office365.com
 (2603:10b6:930:a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 15:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 15:32:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 10:32:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 10:32:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Add JPEG_v5_0_2 IP block
Date: Tue, 10 Mar 2026 11:32:03 -0400
Message-ID: <20260310153203.2883286-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310153203.2883286-1-alexander.deucher@amd.com>
References: <20260310153203.2883286-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d774781-d5d1-4f59-55e5-08de7eba3431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0vavbLxiuOO5Xsg5cfOvviaHAQU3OHIR/9MfuZSrfHavXve6hMCNcc9ZOMbA7ieyzu78VU6F3GGtIo/zsckxJA+2zS13cYNjl82j3TxzW/ri31yjqkmRIG+A2hm4C5iJgKIPbFTHop54YYbL86c6yo+iX0acjg6KpyfFDUFzeKVjTfj6Q4mWRgaqpH4kYE0GCmPT6EmtntR/N8kEWOW/cojeavXTbJ4Ge5Y7o+0dX1PiYt+qPTqDDiyF0IW48Xb12fRHcp8TcsmFqYOh3k2pAZchzsD/GKLfBLBqHdXBUOs1wDFZURgLabMZ7LAL4qjaxkO/soxNfnQVM4GREIGCffGJFIW9U+jCN6SwlFUDer8mS2DnfVc8+m9f2afta4E/WL1wL68Vey0Fl+vPckFS/HLYcOo93KCkihfCV+ukw1X/fthr8PmjS5DBrnsnSVeGr/ZaD9stOeZzBe3lfPqnOhwn1OseF70GkGi4sAnVnZPl0xAUymPJrEy4ARfl+CpXuu5j6UYWKgR9UGyL10NkNsBfz5c4it+jly9gu71XKf2F3pijO/yKHzDD+Uk8HdiARwWE/NtvUS9jWuRSIv+8DljPGMIVD/bqe3mY44OewCjcdsuMHWGoGopBTz5p41W84UtQ2nyt6xE1l1zjMNxEpudJFOCcS+igpVjvG8Htpq1SgSQSeiNAM3Iov4VytSiXU41YwcVm05c2RKphDr/z3GpDMxAjXdRwr+k+NzEyN0zusKYC7AYS+O/vQx1uzxOezLy8jWleOLTh1SEJAGUTOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tHNehNtlK9DBkovWBg5Om8m64xufgQr974qTpGpqA/Hju3JqmC+hpVcN+WL/Ywf3estwNP6r6LWAoq+3x/z9eI3hZFXTnmhWI51yMAQEEn1hBkqsfPGp/XulaiKn90iUA4WJcG4+OJADamsL6VtouSXA841XsWGfOr2aQezPNQRJQmlbqJIT2wbiugUVaO3x2yRK9fddsRMUbknkytPECtz6U6KVPJJjIM2phnB0PlaGvKSiQ7SgWhp6+jeowMJUrL742PaMxht1V/8kAfdNcVvS3nR6OOipPZTIQFBe5tfFEB0MGEN0Gt/KSxDYhdP8GTanVDLXqNh4G8hYAA1HJQg1zi8jdEM/qtye2nye38yCbThDBm4JkifALVSVmb+8NgDtyljAPzxooJdW0yTkEzR3YSfivPHuOuhsDhggD26ZjtG5G0dv8nPgYIwuhyAL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:32:13.7196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d774781-d5d1-4f59-55e5-08de7eba3431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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

Add support for JPEG_5_0_2

v2: comment out RAS for now (Alex)
v3: drop some bringup leftovers (Alex)

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      | 840 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h      | 111 +++
 4 files changed, 954 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 37f2db4b7808a..6a7e9bfec59eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -224,6 +224,7 @@ amdgpu-y += \
 	jpeg_v4_0_5.o \
 	jpeg_v5_0_0.o \
 	jpeg_v5_0_1.o \
+	jpeg_v5_0_2.o \
 	jpeg_v5_3_0.o
 
 # add VPE block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 1e73e791580dd..a2c7aac82ae82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -115,6 +115,7 @@
 #include "vcn_v5_0_2.h"
 #include "jpeg_v5_0_0.h"
 #include "jpeg_v5_0_1.h"
+#include "jpeg_v5_0_2.h"
 #include "jpeg_v5_3_0.h"
 
 #include "amdgpu_ras_mgr.h"
@@ -2646,6 +2647,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			break;
 		case IP_VERSION(5, 0, 2):
 			amdgpu_device_ip_block_add(adev, &vcn_v5_0_2_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_2_ip_block);
 			break;
 		default:
 			dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
new file mode 100644
index 0000000000000..285c459379c4a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -0,0 +1,840 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_jpeg.h"
+#include "amdgpu_pm.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "jpeg_v4_0_3.h"
+#include "jpeg_v5_0_2.h"
+#include "mmsch_v5_0.h"
+
+#include "vcn/vcn_5_0_0_offset.h"
+#include "vcn/vcn_5_0_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+
+static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
+static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
+static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					     enum amd_powergating_state state);
+static void jpeg_v5_0_2_dec_ring_set_wptr(struct amdgpu_ring *ring);
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
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_5_0_2[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_STATUS),
+};
+
+static int jpeg_v5_0_2_core_reg_offset(u32 pipe)
+{
+	if (pipe <= AMDGPU_MAX_JPEG_RINGS_4_0_3)
+		return ((0x40 * pipe) - 0xc80);
+	else
+		return ((0x40 * pipe) - 0x440);
+}
+
+/**
+ * jpeg_v5_0_2_early_init - set function pointers
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Set ring and irq function pointers
+ */
+static int jpeg_v5_0_2_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (!adev->jpeg.num_jpeg_inst || adev->jpeg.num_jpeg_inst > AMDGPU_MAX_JPEG_INSTANCES)
+		return -ENOENT;
+
+	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
+	jpeg_v5_0_2_set_dec_ring_funcs(adev);
+	jpeg_v5_0_2_set_irq_funcs(adev);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_2_sw_init - sw init for JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Load firmware and sw initialization
+ */
+static int jpeg_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
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
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				1 + j + 11 * jpeg_inst;
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
+						  (j ? jpeg_v5_0_2_core_reg_offset(j) : 0));
+		}
+	}
+
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_5_0_2, ARRAY_SIZE(jpeg_reg_list_5_0_2));
+	if (r)
+		return r;
+
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_0_2_sw_fini - sw fini for JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * JPEG suspend and free up sw allocation
+ */
+static int jpeg_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_jpeg_suspend(adev);
+	if (r)
+		return r;
+
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
+	r = amdgpu_jpeg_sw_fini(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_0_2_hw_init - start and test JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ */
+static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int i, j, r, jpeg_inst, tmp;
+
+	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+		adev->jpeg.caps |= AMDGPU_JPEG_CAPS(RRMT_ENABLED);
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		jpeg_inst = GET_INST(JPEG, i);
+		ring = adev->jpeg.inst[i].ring_dec;
+
+		/* Remove JPEG Tile antihang mechanism */
+		tmp = RREG32_SOC15(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS);
+		tmp &= (~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+		WREG32_SOC15(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS, tmp);
+
+		if (ring->use_doorbell)
+			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				 (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * jpeg_inst,
+				 adev->jpeg.inst[i].aid_id);
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			if (ring->use_doorbell)
+				WREG32_SOC15_OFFSET(VCN, GET_INST(VCN, i), regVCN_JPEG_DB_CTRL,
+						    ring->pipe,
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
+ * jpeg_v5_0_2_hw_fini - stop the hardware block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Stop the JPEG block, mark ring as not ready any more
+ */
+static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+
+		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
+			ret = jpeg_v5_0_2_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+
+	return ret;
+}
+
+/**
+ * jpeg_v5_0_2_suspend - suspend JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * HW fini and suspend JPEG block
+ */
+static int jpeg_v5_0_2_suspend(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = jpeg_v5_0_2_hw_fini(ip_block);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_suspend(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_0_2_resume - resume JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Resume firmware and hw init JPEG block
+ */
+static int jpeg_v5_0_2_resume(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	r = jpeg_v5_0_2_hw_init(ip_block);
+
+	return r;
+}
+
+static void jpeg_v5_0_2_init_inst(struct amdgpu_device *adev, int i)
+{
+	int jpeg_inst = GET_INST(JPEG, i);
+
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS), 0,
+		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* keep the JPEG in static PG mode */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS), 0,
+		 ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
+		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+}
+
+static void jpeg_v5_0_2_deinit_inst(struct amdgpu_device *adev, int i)
+{
+	int jpeg_inst = GET_INST(JPEG, i);
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
+		 UVD_JMI_CNTL__SOFT_RESET_MASK,
+		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
+		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+}
+
+static void jpeg_v5_0_2_init_jrbc(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 reg, data, mask;
+	int jpeg_inst = GET_INST(JPEG, ring->me);
+	int reg_offset = ring->pipe ? jpeg_v5_0_2_core_reg_offset(ring->pipe) : 0;
+
+	/* enable System Interrupt for JRBC */
+	reg = SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN);
+	if (ring->pipe < AMDGPU_MAX_JPEG_RINGS_4_0_3) {
+		data = JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe;
+		mask = ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe);
+		WREG32_P(reg, data, mask);
+	} else {
+		data = JPEG_SYS_INT_EN__DJRBC0_MASK << (ring->pipe+12);
+		mask = ~(JPEG_SYS_INT_EN__DJRBC0_MASK << (ring->pipe+12));
+		WREG32_P(reg, data, mask);
+	}
+
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_LMI_JRBC_RB_VMID,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_CNTL,
+			    reg_offset,
+			    (0x00000001L | 0x00000002L));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+			    reg_offset, lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+			    reg_offset, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_RPTR,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_WPTR,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_CNTL,
+			    reg_offset, 0x00000002L);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_SIZE,
+			    reg_offset, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC_RB_WPTR,
+					 reg_offset);
+}
+
+/**
+ * jpeg_v5_0_2_start - start JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the JPEG block
+ */
+static int jpeg_v5_0_2_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	int i, j;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		jpeg_v5_0_2_init_inst(adev, i);
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			jpeg_v5_0_2_init_jrbc(ring);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_2_stop - stop JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * stop the JPEG block
+ */
+static int jpeg_v5_0_2_stop(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
+		jpeg_v5_0_2_deinit_inst(adev, i);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_2_dec_ring_get_rptr - get read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware read pointer
+ */
+static uint64_t jpeg_v5_0_2_dec_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC_RB_RPTR,
+				   ring->pipe ? jpeg_v5_0_2_core_reg_offset(ring->pipe) : 0);
+}
+
+/**
+ * jpeg_v5_0_2_dec_ring_get_wptr - get write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware write pointer
+ */
+static uint64_t jpeg_v5_0_2_dec_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell)
+		return adev->wb.wb[ring->wptr_offs];
+
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC_RB_WPTR,
+				   ring->pipe ? jpeg_v5_0_2_core_reg_offset(ring->pipe) : 0);
+}
+
+/**
+ * jpeg_v5_0_2_dec_ring_set_wptr - set write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the write pointer to the hardware
+ */
+static void jpeg_v5_0_2_dec_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me),
+				    regUVD_JRBC_RB_WPTR,
+				    (ring->pipe ? jpeg_v5_0_2_core_reg_offset(ring->pipe) : 0),
+				    lower_32_bits(ring->wptr));
+	}
+}
+
+static bool jpeg_v5_0_2_is_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool ret = false;
+	int i, j;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			int reg_offset = (j ? jpeg_v5_0_2_core_reg_offset(j) : 0);
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
+static int jpeg_v5_0_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+	int i, j;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			int reg_offset = (j ? jpeg_v5_0_2_core_reg_offset(j) : 0);
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
+static int jpeg_v5_0_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					     enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool enable = state == AMD_CG_STATE_GATE;
+
+	int i;
+
+	if (!enable)
+		return 0;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (!jpeg_v5_0_2_is_idle(ip_block))
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					     enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret;
+
+	if (state == adev->jpeg.cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = jpeg_v5_0_2_stop(adev);
+	else
+		ret = jpeg_v5_0_2_start(adev);
+
+	if (!ret)
+		adev->jpeg.cur_state = state;
+
+	return ret;
+}
+
+static int jpeg_v5_0_2_set_interrupt_state(struct amdgpu_device *adev,
+					   struct amdgpu_irq_src *source,
+					   unsigned int type,
+					   enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static int jpeg_v5_0_2_process_interrupt(struct amdgpu_device *adev,
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
+static void jpeg_v5_0_2_core_stall_reset(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int jpeg_inst = GET_INST(JPEG, ring->me);
+	int reg_offset = ring->pipe ? jpeg_v5_0_2_core_reg_offset(ring->pipe) : 0;
+
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
+			    reg_offset, 0x1F);
+	SOC15_WAIT_ON_RREG_OFFSET(JPEG, jpeg_inst,
+				  regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS,
+				  reg_offset, 0x1F, 0x1F);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_JPEG_LMI_DROP,
+			    reg_offset, 0x1F);
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 1 << ring->pipe);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
+			    reg_offset, 0x00);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_JPEG_LMI_DROP,
+			    reg_offset, 0x00);
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
+}
+
+static int jpeg_v5_0_2_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	jpeg_v5_0_2_core_stall_reset(ring);
+	jpeg_v5_0_2_init_jrbc(ring);
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
+static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
+	.name = "jpeg_v5_0_2",
+	.early_init = jpeg_v5_0_2_early_init,
+	.late_init = NULL,
+	.sw_init = jpeg_v5_0_2_sw_init,
+	.sw_fini = jpeg_v5_0_2_sw_fini,
+	.hw_init = jpeg_v5_0_2_hw_init,
+	.hw_fini = jpeg_v5_0_2_hw_fini,
+	.suspend = jpeg_v5_0_2_suspend,
+	.resume = jpeg_v5_0_2_resume,
+	.is_idle = jpeg_v5_0_2_is_idle,
+	.wait_for_idle = jpeg_v5_0_2_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = jpeg_v5_0_2_set_clockgating_state,
+	.set_powergating_state = jpeg_v5_0_2_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
+};
+
+static const struct amdgpu_ring_funcs jpeg_v5_0_2_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_JPEG,
+	.align_mask = 0xf,
+	.get_rptr = jpeg_v5_0_2_dec_ring_get_rptr,
+	.get_wptr = jpeg_v5_0_2_dec_ring_get_wptr,
+	.set_wptr = jpeg_v5_0_2_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* jpeg_v5_0_2_dec_ring_emit_vm_flush */
+		22 + 22 + /* jpeg_v5_0_2_dec_ring_emit_fence x2 vm fence */
+		8 + 16,
+	.emit_ib_size = 22, /* jpeg_v5_0_2_dec_ring_emit_ib */
+	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
+	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
+	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
+	.emit_hdp_flush = jpeg_v4_0_3_ring_emit_hdp_flush,
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
+	.reset = jpeg_v5_0_2_ring_reset,
+};
+
+static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev)
+{
+	int i, j, jpeg_inst;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			adev->jpeg.inst[i].ring_dec[j].funcs = &jpeg_v5_0_2_dec_ring_vm_funcs;
+			adev->jpeg.inst[i].ring_dec[j].me = i;
+			adev->jpeg.inst[i].ring_dec[j].pipe = j;
+		}
+		jpeg_inst = GET_INST(JPEG, i);
+		adev->jpeg.inst[i].aid_id =
+			jpeg_inst / adev->jpeg.num_inst_per_aid;
+	}
+}
+
+static const struct amdgpu_irq_src_funcs jpeg_v5_0_2_irq_funcs = {
+	.set = jpeg_v5_0_2_set_interrupt_state,
+	.process = jpeg_v5_0_2_process_interrupt,
+};
+
+static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
+		adev->jpeg.inst->irq.num_types += adev->jpeg.num_jpeg_rings;
+
+	adev->jpeg.inst->irq.funcs = &jpeg_v5_0_2_irq_funcs;
+}
+
+const struct amdgpu_ip_block_version jpeg_v5_0_2_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_JPEG,
+	.major = 5,
+	.minor = 0,
+	.rev = 2,
+	.funcs = &jpeg_v5_0_2_ip_funcs,
+};
+
+#if 0
+static int jpeg_v5_0_2_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
+					enum aca_smu_type type, void *data)
+{
+	struct aca_bank_info info;
+	u64 misc0;
+	int ret;
+
+	ret = aca_bank_info_decode(bank, &info);
+	if (ret)
+		return ret;
+
+	misc0 = bank->regs[ACA_REG_IDX_MISC0];
+	switch (type) {
+	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
+		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
+						1ULL);
+		break;
+	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
+						ACA_REG__MISC0__ERRCNT(misc0));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/* reference to smu driver if header file */
+static int jpeg_v5_0_2_err_codes[] = {
+	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-9][S|D] */
+	24, 25, 26, 27, 28, 29, 30, 31,
+	48, 49, 50, 51,
+};
+
+static bool jpeg_v5_0_2_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					enum aca_smu_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	if (aca_bank_check_error_codes(handle->adev, bank,
+					jpeg_v5_0_2_err_codes,
+					ARRAY_SIZE(jpeg_v5_0_2_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops jpeg_v5_0_2_aca_bank_ops = {
+	.aca_bank_parser = jpeg_v5_0_2_aca_bank_parser,
+	.aca_bank_is_valid = jpeg_v5_0_2_aca_bank_is_valid,
+};
+
+static const struct aca_info jpeg_v5_0_2_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &jpeg_v5_0_2_aca_bank_ops,
+};
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h
new file mode 100644
index 0000000000000..c201a2c42a0dc
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.h
@@ -0,0 +1,111 @@
+/*
+ * Copyright 2025-2026 Advanced Micro Devices, Inc.
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
+#ifndef __JPEG_V5_0_2_H__
+#define __JPEG_V5_0_2_H__
+
+extern const struct amdgpu_ip_block_version jpeg_v5_0_2_ip_block;
+
+#define regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET			0x4094
+#define regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET			0x1bffe
+
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR                                                         0x0640
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR_BASE_IDX                                                1
+#define regUVD_JRBC0_UVD_JRBC_STATUS                                                          0x0649
+#define regUVD_JRBC0_UVD_JRBC_STATUS_BASE_IDX                                                 1
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR                                                         0x064a
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR_BASE_IDX                                                1
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR                                                         0x0000
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC1_UVD_JRBC_STATUS                                                          0x0009
+#define regUVD_JRBC1_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR                                                         0x000a
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR                                                         0x0040
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC2_UVD_JRBC_STATUS                                                          0x0049
+#define regUVD_JRBC2_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR                                                         0x004a
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR                                                         0x0080
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC3_UVD_JRBC_STATUS                                                          0x0089
+#define regUVD_JRBC3_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR                                                         0x008a
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR                                                         0x00c0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC4_UVD_JRBC_STATUS                                                          0x00c9
+#define regUVD_JRBC4_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR                                                         0x00ca
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR                                                         0x0100
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC5_UVD_JRBC_STATUS                                                          0x0109
+#define regUVD_JRBC5_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR                                                         0x010a
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR                                                         0x0140
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC6_UVD_JRBC_STATUS                                                          0x0149
+#define regUVD_JRBC6_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR                                                         0x014a
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR                                                         0x0180
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC7_UVD_JRBC_STATUS                                                          0x0189
+#define regUVD_JRBC7_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR                                                         0x018a
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR                                                         0x01c0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC8_UVD_JRBC_STATUS                                                          0x01c9
+#define regUVD_JRBC8_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR                                                         0x01ca
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR                                                         0x0440
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR_BASE_IDX                                                1
+#define regUVD_JRBC9_UVD_JRBC_STATUS                                                          0x0449
+#define regUVD_JRBC9_UVD_JRBC_STATUS_BASE_IDX                                                 1
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR                                                         0x044a
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX                                                1
+#define regUVD_JMI0_JPEG_LMI_DROP                                                             0x0663
+#define regUVD_JMI0_JPEG_LMI_DROP_BASE_IDX                                                    1
+#define regUVD_JMI0_UVD_JMI_CLIENT_STALL                                                      0x067a
+#define regUVD_JMI0_UVD_JMI_CLIENT_STALL_BASE_IDX                                             1
+#define regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS                                               0x067b
+#define regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                      1
+#define regJPEG_CORE_RST_CTRL                                                                 0x072e
+#define regJPEG_CORE_RST_CTRL_BASE_IDX                                                        1
+
+#define regVCN_RRMT_CNTL                          0x0940
+#define regVCN_RRMT_CNTL_BASE_IDX                 1
+
+enum amdgpu_jpeg_v5_0_2_sub_block {
+	AMDGPU_JPEG_V5_0_2_JPEG0 = 0,
+	AMDGPU_JPEG_V5_0_2_JPEG1,
+
+	AMDGPU_JPEG_V5_0_2_MAX_SUB_BLOCK,
+};
+
+#endif /* __JPEG_V5_0_2_H__ */
-- 
2.53.0

