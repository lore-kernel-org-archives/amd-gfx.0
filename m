Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB32D5CCAF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 14:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2883A10E7A6;
	Wed, 30 Oct 2024 14:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IR9m5IjU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB96A10E7A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 14:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qx1ZZJ0C8D8U7zeSQBWz07n+15MuF4zRa7tfHlLrg0IQ2eW67/290HQRV7zbJBuFhS0vOPH0kmp06H7lSKacjFdlCH06pcVP87RVG3h9TbYXu41RKvy8eEUGSKq3bfhPp3UQgvjQbGO+yJXsxp3vixcANoEJey8ksMmjRpaVbkmCZiAGFiko3Vn14+7yiXTLmv9k75KwXRpnfN+dxwU3CM9aodcqlzFgv9CFkjQVrF+GZyEhsIBNaAGLSfTj66h+vufAckJ0vqcqhHOHg9YyqHglVaX3a0oG0UqgLcl0yky2uv6/5VZmmiVPxJINJ7TywDoZhfGPhqM7mwHodRIMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL1AdlEGlhUbvDiHTN47MPyw6A3D6q+xMmcQQ6JQ4PM=;
 b=ViQvJvTL322KSC59VGJ+EK4AKdeWEh3kSbg/lemeWYP3o1+Zr6ZZeodru/WQOQkB4IcCb4GLJFiLWuJk2HgPc3zz2uIaiRLsxGysjCYL4mO0ldpt8m7yuvrp6Mcad+u55rRe8xqXB1aPuPUsnZmuxo56OHp3AN25iSgQegwLcu0fanM9YlPT9OU43HgR/Ll/5BN/5F5A0HvZedKNhxyVgrPYhx10hVRNVhJRuebCYVXx7mKX7kiH8/ue5GuGnOZ0JveQhLEnEWMYs7ghZb4OceULyyqq8EEYO3AgcXCoCTjKo+aD/Hj/4l35S4ajxascDylgdras3NCaoYT4yo589g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL1AdlEGlhUbvDiHTN47MPyw6A3D6q+xMmcQQ6JQ4PM=;
 b=IR9m5IjUQaqX0kOTUaCjUwDjrBOiKnEROUSZkJBVAFJ7/7CKaE2awxlEwGnB7JRNVkQ+NpakROV9TZBdM03mkr7Gc/5Q/qSamrhD+So1xBd2vnx1g+qGWNL2a2N0MxlYHuJLyQvXtREO7EBvpUlFnJIT0GCxz/e0CGTDXuVPB7g=
Received: from CH0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:610:e6::26)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:29:40 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::d6) by CH0PR03CA0291.outlook.office365.com
 (2603:10b6:610:e6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 14:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 14:29:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 09:29:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9: Add cleaner shader for GFX11.0.3
Date: Wed, 30 Oct 2024 19:59:20 +0530
Message-ID: <20241030142920.1525517-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: a8992e4a-aa2f-411f-32c2-08dcf8ef4a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkpFcDhrdlZFcUVLRUdDWW44UGRmb2ZqMldyUXJDOWF6WFd2NlJFYXBRdzIw?=
 =?utf-8?B?MWVRUThNWnlhdTFwd2E4MFc1NlRuK2NYRGRQZW5Ec3FscEgrSzhZSlBIOFkv?=
 =?utf-8?B?T01NeHhqZWlaOXU2ZjVrWG9CWENEUHgzRkd2TkVXMGhmSGFrVTQwUjNYRGVt?=
 =?utf-8?B?VjhZQUpkQUtoOXRXT0dWME81Szg0ajJEZlkxUGJldWVqN0N5R1cxT0s1WVN6?=
 =?utf-8?B?cHU0NlNTSStFNVFSSDZ0TGNkRTZIRmsyU3cvcUxvd1JGRlZ0U2VLR214SmtH?=
 =?utf-8?B?cGNrQ3NrSldMa0wzZlNoRkJsd3ZtcFlVanZmRVVCYmNuRlZzTGQ5Y3pkNk1W?=
 =?utf-8?B?cG9HVENnOEZqQSs5a0t6YzVsckVlYWVLU0ZGR0dsVEZGUzdXa1BmK1NJZHdh?=
 =?utf-8?B?RXRydFovZFZONWVrcUdsb3QvU1NZaEJ4K20rV2N0VFlVOFBnWTVsSm1LK3Rq?=
 =?utf-8?B?Sm02YjdIdlVLV2owY3VzaXVTU2N1UkliRVlnbGY1bHdIOXpabXVBbUJVMVRw?=
 =?utf-8?B?NG9VQzdrWkZ3cnFSY2RhUkhqSVBPVjJCUFF1ZW9rR0RXQTlLVDdmekdYUG9U?=
 =?utf-8?B?dEdnVFpGalFLZkkxRHRsKy9kV1NwcDJQalUvU3poc2FtSTQ3MnZCUmdScDZW?=
 =?utf-8?B?OG1Da1Z4TzB2Z0ljOEZQd1RYdmxQRE1hRlpBR1hycUhudFBrblIwWERNZll2?=
 =?utf-8?B?bCtsdFhsdURSWEdqbFJ2MUs1S2laM0MzSENUMHI4Nm8yTmx5RmdTN0ZkZHBT?=
 =?utf-8?B?TXlzYmFOaGU1bldFSS9DbEVhWVJ1bzk5Y2kwdkJQNHlPcGk2M3JBVXo3WVZH?=
 =?utf-8?B?RGxuSFY2V09mNm1FUElrQlBoV295WjhXWE1QYmxDYTV0Mndvdy8xZmhzOXhV?=
 =?utf-8?B?aklSM1dBSDU5VnJhSXRxaEhNRmJkT0ZraTVudFFTbE8rZVlFV2hkU0xVV1Rx?=
 =?utf-8?B?WVAvS2dzVkRYM213dC9hUVV0bEYycjJYb0hsVzVhcEd3bm9pN2VsNzlMaTdk?=
 =?utf-8?B?MTQrRHZBNENKdkgzZWVFRFh5QkhXSGF2eDRDbGFROFpxM3Y0UVFhcmN0ZEhV?=
 =?utf-8?B?V1A3R0E1VmpFN2k3L25taDZvdlpPK1VQRW1BcE5WR3drTWNpbnZoYjBhR0Z0?=
 =?utf-8?B?UzR3dmF6bWkxOHBhYWZTNmptTmd0a2llUGJCSlZmZ2F6aWIyRzJSckJScXhQ?=
 =?utf-8?B?dTQyRW9FSmtXVlVmM1NHZXl4aFdwSzBrY21BV2lENHRGYW9LaDIrUUdPSks2?=
 =?utf-8?B?eWgyNWZUSjM2cmt0QklhcGU3aVUvVVlLaVJpUUVGTXZTOTdhZGI5YkpxSzlm?=
 =?utf-8?B?UzNZV0t0RjV1VlpMZ1JWMmRBTi9MUHpXTWlhQ2ltMlBhU0VGckZ4TEdRZmtj?=
 =?utf-8?B?M09aT3FJQ083KzRoeUJTY1JoQWRXUmJ4WUEvWURoOW54QTFIUEFVUTMydUFL?=
 =?utf-8?B?Q0UxdFJNOGxDZ3psWlQ5anpHNWtDdWhtQ2RETWhMTUs2WTVIQW84eENjWHMw?=
 =?utf-8?B?S1lmWkp1cCtpSW56SFFWZ1lzMlRXVVhRTWdhZVQ5YXFVd05RNjdaczh3VkJH?=
 =?utf-8?B?WW8wSzNscTBBSVVhTGFQOTU3TFIzbFYrUnhoaHA1QTZhRWlmRHhwcnJpcHZO?=
 =?utf-8?B?TEJQekZCYlMvMDBNckVTMHJxaDQ2N3VRQVQ3ZmxuRFI0NWJmeHhwVks4TjlW?=
 =?utf-8?B?R0tHbGVpTk1xZkh1eTUyemZTOUVtUWs4Rk1rUmI5cmIxRFk5aS9IbVB6VWNh?=
 =?utf-8?B?MHo3cDlXa2dPM1FENWh4dXc1Y2kvaUEzbDRsOThyMGVvbWsvdDF1Q3pkLzhM?=
 =?utf-8?B?YTZyVE9sZkZrc1NlcDVFRlBPb2R2NUxSTEFEdTFhNmQ2QkJnUllzNnFBd28z?=
 =?utf-8?B?Z1dxcXRqclN3anpjWDVZa1pDeStRd0NYS2Q0VzFjeVgveVE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:29:40.3442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8992e4a-aa2f-411f-32c2-08dcf8ef4a1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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

This commit adds the cleaner shader microcode for GFX11.0.3 GPUs. The
cleaner shader is a piece of GPU code that is used to clear or
initialize certain GPU resources, such as Local Data Share (LDS), Vector
General Purpose Registers (VGPRs), and Scalar General Purpose Registers
(SGPRs).

Clearing these resources is important for ensuring data isolation
between different workloads running on the GPU. Without the cleaner
shader, residual data from a previous workload could potentially be
accessed by a subsequent workload, leading to data leaks and incorrect
computation results.

The cleaner shader microcode is represented as an array of 32-bit words
(`gfx_11_0_3_cleaner_shader_hex`). This array is the binary
representation of the cleaner shader code, which is written in a
low-level GPU instruction set.

When the cleaner shader feature is enabled, the AMDGPU driver loads this
array into a specific location in the GPU memory. The GPU then reads
this memory location to fetch and execute the cleaner shader
instructions.

The cleaner shader is executed automatically by the GPU at the end of
each workload, before the next workload starts. This ensures that all
GPU resources are in a clean state before the start of each workload.

This addition is part of the cleaner shader feature implementation. The
cleaner shader feature helps resource utilization by cleaning up GPU
resources after they are used. It also enhances security and reliability
by preventing data leaks between workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  18 +++
 .../amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm | 118 ++++++++++++++++++
 .../drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h |  56 +++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..ce05b7161e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -46,6 +46,7 @@
 #include "clearstate_gfx11.h"
 #include "v11_structs.h"
 #include "gfx_v11_0.h"
+#include "gfx_v11_0_cleaner_shader.h"
 #include "gfx_v11_0_3.h"
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
@@ -1545,6 +1546,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, j, k, r, ring_id = 0;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	u32 mes_ver = adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
@@ -1588,8 +1590,24 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(11, 0, 3):
+		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
+		if (adev->gfx.mec_fw_version >= 2450 &&
+		    adev->gfx.me_fw_version  >= 2280 &&
+		    adev->gfx.pfp_fw_version >= 2370 &&
+		    mes_ver >= 99) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
+		break;
 	}
 
 	/* Enable CG flag in one VF mode for enabling RLC safe mode enter/exit */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm
new file mode 100644
index 000000000000..3c0c63a07d97
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: MIT */
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
+ */
+
+// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 192 Dwords cleaner shader.
+//To turn this shader program on for complitaion change this to main and lower shader main to main_1
+
+// Navi3 : Clear SGPRs, VGPRs and LDS
+//   Launch 32 waves per CU (16 per SIMD) as a workgroup (threadgroup) to fill every wave slot
+//   Waves are "wave32" and have 64 VGPRs each, which uses all 1024 VGPRs per SIMD
+//   Waves are launched in "CU" mode, and the workgroup shares 64KB of LDS (half of the WGP's LDS)
+//      It takes 2 workgroups to use all of LDS: one on each CU of the WGP
+//   Each wave clears SGPRs 0 - 107
+//   Each wave clears VGPRs 0 - 63
+//   The first wave of the workgroup clears its 64KB of LDS
+//   The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
+//       before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
+
+shader main
+  asic(NAVI31)
+  type(CS)
+  wave_size(32)
+// Note: original source code from Brian (SQ team)
+
+// Takes about 2500 clocks to run.
+//   (theorhetical fastest = 1024clks vgpr + 640lds = 1660 clks)
+//
+  S_BARRIER
+
+  //
+  // CLEAR VGPRs
+  //
+  s_mov_b32     m0, 0x00000058  // Loop 96/8=12 times  (loop unrolled for performance)
+
+label_0005:
+  v_movreld_b32     v0, 0
+  v_movreld_b32     v1, 0
+  v_movreld_b32     v2, 0
+  v_movreld_b32     v3, 0
+  v_movreld_b32     v4, 0
+  v_movreld_b32     v5, 0
+  v_movreld_b32     v6, 0
+  v_movreld_b32     v7, 0
+  s_sub_u32     m0, m0, 8
+  s_cbranch_scc0  label_0005
+  //
+  //
+
+  s_mov_b32     s2, 0x80000000                      // Bit31 is first_wave
+  s_and_b32     s2, s2, s0                          // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
+  s_cbranch_scc0  label_0023                        // Clean LDS if its first wave of ThreadGroup/WorkGroup
+  // CLEAR LDS
+  //
+  s_mov_b32 exec_lo, 0xffffffff
+  s_mov_b32 exec_hi, 0xffffffff
+  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..63)
+  v_mbcnt_hi_u32_b32  v1, exec_lo, v1        // Set V1 to thread-ID (0..63)
+  v_mul_u32_u24  v1, 0x00000008, v1          // * 8, so each thread is a double-dword address (8byte)
+  s_mov_b32     s2, 0x00000003f                    // 64 loop iterations
+  s_mov_b32     m0, 0xffffffff
+  // Clear all of LDS space
+  // Each FirstWave of WorkGroup clears 64kbyte block
+
+label_001F:
+  ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
+  ds_write2_b64  v1, v[4:5], v[4:5] offset0:64 offset1:96
+  v_add_co_u32     v1, vcc, 0x00000400, v1
+  s_sub_u32     s2, s2, 1
+  s_cbranch_scc0  label_001F
+  //
+  // CLEAR SGPRs
+  //
+label_0023:
+  s_mov_b32     m0, 0x00000068  // Loop 108/4=27 times  (loop unrolled for performance)
+label_sgpr_loop:
+  s_movreld_b32     s0, 0
+  s_movreld_b32     s1, 0
+  s_movreld_b32     s2, 0
+  s_movreld_b32     s3, 0
+  s_sub_u32         m0, m0, 4
+  s_cbranch_scc0  label_sgpr_loop
+
+  //clear vcc
+  s_mov_b64 vcc, 0          //clear vcc
+  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
+  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
+  s_mov_b64 ttmp0, 0        //Clear ttmp0 and ttmp1
+  s_mov_b64 ttmp2, 0        //Clear ttmp2 and ttmp3
+  s_mov_b64 ttmp4, 0        //Clear ttmp4 and ttmp5
+  s_mov_b64 ttmp6, 0        //Clear ttmp6 and ttmp7
+  s_mov_b64 ttmp8, 0        //Clear ttmp8 and ttmp9
+  s_mov_b64 ttmp10, 0       //Clear ttmp10 and ttmp11
+  s_mov_b64 ttmp12, 0       //Clear ttmp12 and ttmp13
+  s_mov_b64 ttmp14, 0       //Clear ttmp14 and ttmp15
+
+ s_endpgm
+
+end
+
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h
new file mode 100644
index 000000000000..3218cc04f543
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: MIT */
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
+ */
+
+/* Define the cleaner shader gfx_11_0_3 */
+static const u32 gfx_11_0_3_cleaner_shader_hex[] = {
+	0xb0804006, 0xbe8200ff,
+	0x00000058, 0xbefd0080,
+	0x7e008480, 0x7e028480,
+	0x7e048480, 0x7e068480,
+	0x7e088480, 0x7e0a8480,
+	0x7e0c8480, 0x7e0e8480,
+	0xbefd0002, 0x80828802,
+	0xbfa1fff5, 0xbe8200ff,
+	0x80000000, 0x8b020002,
+	0xbfa10012, 0xbefe00c1,
+	0xbeff00c1, 0xd71f0001,
+	0x0001007f, 0xd7200001,
+	0x0002027e, 0x16020288,
+	0xbe8200bf, 0xbefd00c1,
+	0xd9382000, 0x00020201,
+	0xd9386040, 0x00040401,
+	0xd7006a01, 0x000202ff,
+	0x00000400, 0x80828102,
+	0xbfa1fff7, 0xbefd00ff,
+	0x00000068, 0xbe804280,
+	0xbe814280, 0xbe824280,
+	0xbe834280, 0x80fd847d,
+	0xbfa1fffa, 0xbeea0180,
+	0xbeec0180, 0xbeee0180,
+	0xbef00180, 0xbef20180,
+	0xbef40180, 0xbef60180,
+	0xbef80180, 0xbefa0180,
+	0xbfb00000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+};
-- 
2.34.1

