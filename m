Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D375D5CCB4
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 14:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15AA10E7B0;
	Wed, 30 Oct 2024 14:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XgW5FBKv";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B6910E7B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 14:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYLiLBNO1lfFlyxRiEwkkUFFVXnWGUpdtRTVsek3ffsPY+wT3dKty9XM0BZ9U5Dk1mvzCVSkvU+qGHHI9Z+cph0TpXSuY1hhRPmx8jO8d16h5oaOcgTs+jPqf7NrNYhh2RjcJHbeGTmRgmXZZQ61hbnNyuz37qqYSHnwshZX1OVS9pckzFNDceuyjtPw62Ap0wOOKSvewl3uPl3EXqMIKXwc3b+YDuvICWpl1rQGYm8vJwYPQy35dhvXxlTyJ7siBY7sdrwVMRksYfoEAg6FvxJe0qDhQPFmzY64KY6+UiYO1E8DVMAstWqyENRsg4WUVeLcHaM3ahOOgWDMaOF8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEMm8p9xod8aGqG2QVxU3A3Fl1Wnyg1I007Mh7eT+xo=;
 b=NAmdklh4b/zlIucUccDmzpXEOxyKaeS37yLC95SlKmf4upS2vmc2PggfFEot1+gBoDHojUUmPm+5pzXfVN09n6ltjKr4N1f+yyOAcIUQ5rvB4P5fy64dSE+MrWiGaGQTnSOrd9u7jkMBFnCJ8ZcuM5Iq4H9Aevo61xtiCtWcTzuew0wNJhbDJ7BGMWtjRcRU5TxYvn7unE+R1vhDuwiN9jWSSWts0H48/yQQKQTu6ZKcD6oLP4AgNmis8wocoEg+cpTRMO/DkBPD+WNRQqegc/tKfbn/DVJYip7feLV6NRz5ffC7m64Tmgu9kJktH391mkQ3myRk17Jlll5rWU3glA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEMm8p9xod8aGqG2QVxU3A3Fl1Wnyg1I007Mh7eT+xo=;
 b=XgW5FBKvOOgWWOFfAorXII3yGJn6f/VcSxUxQsHAVNPYTPeN2TAmY61cQ9xvXjZTRTjyQB1UigOGfAvfdqGTkvpHQPT5k7lo7Dlu6YjKvurJe1xindtiyqQgS1IKp879eya2e8TDtlCj+y+TDzSY8JovMJzkooL0SS1vhB24IIw=
Received: from BN9PR03CA0735.namprd03.prod.outlook.com (2603:10b6:408:110::20)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:52:25 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::46) by BN9PR03CA0735.outlook.office365.com
 (2603:10b6:408:110::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Wed, 30 Oct 2024 14:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 14:52:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 09:52:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx9: Add cleaner shader for GFX11.0.3
Date: Wed, 30 Oct 2024 20:22:06 +0530
Message-ID: <20241030145206.1531581-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: b03a2622-fbaa-467d-6142-08dcf8f27794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVRoVHYvSFg3ZjFQQitLSEh2bzBLQWtBZzE3clh5U3Y3SHFIeWcvTFJzbHgv?=
 =?utf-8?B?cjRDRitUVGJOUmtwbzY1bVFhcWd0azVRdjRBbTlTNjRlTGpwREpTNXVBYjF2?=
 =?utf-8?B?M08wb01NZ1BzUGM0bHdSc3dIbmdIQm5tam4rdnJXREJWUGFRTms5YVhOWUVS?=
 =?utf-8?B?S1dWT3VTQms3T1BuNDFJamJwUldQUFBGODFEdlc0VmljYStsR1F0TVBYWVFl?=
 =?utf-8?B?YjVUaXQvQlh3a2VmL0tCdnI3M2VJSFNRY1dIMFdXSURaS2tISTdqZW9CSFFC?=
 =?utf-8?B?QWo2NG93eWNRYVk5UHE1MHc4VS9RblYxUEtFZTU5aGl3V2JsK3lyZE1SQ1ZE?=
 =?utf-8?B?V2xSbnB3WW9Bc0ZwckxITXFiaDVqMldiM3JpK0F2U3VqbmdZaElzMGs2byto?=
 =?utf-8?B?Q05jMUl4clpFS3pZM2VuOU1Ndm5HcXBvSGFnRWNaWGEzR0t6cmlnUUxUNWU4?=
 =?utf-8?B?a2FEU0hUcDBiMEVOekJwT09LZkRYTjFWVkdmNXlTQ0JpTXBJQXlEUGhPREU2?=
 =?utf-8?B?SytQdDNHTzNYWGU3T3JmT3ZJMzhBQ3dybzdpLzR2Zk5CUEtleHVVV255YWZa?=
 =?utf-8?B?STA3QzM2eUx2cUxwVjl6VlNsNmJkQ3hGV2FJVGVtdDZ4SFJacThDTnVTREhM?=
 =?utf-8?B?cUFUa3RRZDJnYThOdFk1azBXS0laWnduYWRLejhhb2NYOXBJcHFtR1FMbEQx?=
 =?utf-8?B?YVdLT3A3ajFZaVlPUzJuT1FRaHZXSjlMQW1lczhLcWtiMEFMOTJBY2tJb1Mz?=
 =?utf-8?B?bmQ5ZWpSSFdtSFozQmVSbHRZWDdkM1FRdGMrL28zTXkwRGxkYUNHQU0zcDJi?=
 =?utf-8?B?dC9HUUZNMFBoVEs2MGlTbUlMcld3TUIwOGtEcysvM0h1MitmTUYrR3VEWlJ2?=
 =?utf-8?B?Um9jTk9Ra3FpK09VUUJybkprY2ppY0ZqaWpYS29xZGhZMXBVdG5zRnIwSFlS?=
 =?utf-8?B?bHBON2w3WTVRMERiRWNtaVhvcWZ0L3hrSDMzOTk3U1BQcmdBNlpCY0hFVzA2?=
 =?utf-8?B?M2FHVHhXSXRxSFhhWi8yQkVNOWtSbmdGNW9rQ0xDU1pXN0JlZ0FXWTRmWkFt?=
 =?utf-8?B?N01Wazl0Q0hkZWFWeHg3TC84UGdhd1c3d1d2dVRWVHRJOHlkV280VnlPWm9E?=
 =?utf-8?B?a1RZWXRHbXlQcC9sVzFYQjFDUmhDSVo0cjBCK2F3aXdpcHdvcnVtZXdOZ0ZL?=
 =?utf-8?B?NW81b1pJL0xzaDdSOTk2TEFHZDN3TC84b01QdjV2TjlvM01YaXo3dE83Ymo1?=
 =?utf-8?B?Tmw1dXNCT051U0FwVHpFVFNQZEpYVzRnQ3k3N0RobGppWGRCb2J2bzF6KzI0?=
 =?utf-8?B?bSt5MnRVQ0wwRC9zbHFtZGlEMVFtcGZ4eU5uV050WkczYkc1akQ2UCtTYjRs?=
 =?utf-8?B?UElnZXprT0UxUFYyNnkrVlNsUDN3b2h4NElGUENvbGphK0JFdTAxcThzUmxE?=
 =?utf-8?B?dkE4NVBjVGc1MkphU3hFbEVxS3BINEk3TGcxYnZTSXJjaDFjaGl2SjQrRHZs?=
 =?utf-8?B?T2N1d2IvNlFFaWpyS0kzWEtQd3pkVEt3Yno5bWxlTTc2VlIwWFJSY0E0ZUJB?=
 =?utf-8?B?UTYyR1RRank3K1lRTFg2OTBWRlJxQmJmTFBYTDR5OUtNekMvdDhQOHpINjJk?=
 =?utf-8?B?TTUwVmtvU3p3WXpGcU55Wk1lNFBxQ1d5Y25LWUs3cG1IbWpCVkxQV0hxS0VO?=
 =?utf-8?B?RkRvSWI0Sm9hZVlRT1g4T2p3TVJlRHowUWN3djdqeDVuWlFkOXpJNEFwNmNW?=
 =?utf-8?B?dWJmWTBJVm9HMGVGMWszR0ZZWW1UT1dMMTdkZU1iZytXYm5HU2tKUWE5dVQx?=
 =?utf-8?B?R2xiTnR0R3hqV1VSSCtMNTBxMjdWWUFXbkxjTmtnY0VpTnVYTUFRUFJIUXA5?=
 =?utf-8?B?RGc1RGVaaGx0OGpwMDE3alpCSUc5Y1IwNkVRVDZ1Z090ZVE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:52:25.1129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03a2622-fbaa-467d-6142-08dcf8f27794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
 - Updated comments to "// Note: original source code from SQ team" (Alex)
 - The file now uses GFX11 (Alex)

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
index 000000000000..9b90b66368c7
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
+  asic(GFX11)
+  type(CS)
+  wave_size(32)
+// Note: original source code from SQ team
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

