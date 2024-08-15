Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F7AC53211
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FD210E36E;
	Thu, 15 Aug 2024 00:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YAvJHpd8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC7110E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bicE3koLQrVeDuPOWYCm10+HYpkh0WPBZNQc/so+NF7NNPm2Lce0xL/nY32z1Ez/+aOtNS+e9nty1ZM6HlTNKJD1zdqwateL1XHqc/gEHqtGXHth+p/cCiPS3ps/d1QQ8p6zfNN1QrrfJtowIBfLRzbMegzd5+WV5uUDSOcu9ML7km1WM+rC64+0jAdrLX8LcfHMcOU4dSKiVxrEQY9C5L9e3ddGr7arOHTj0x/J4woDkf+ojeQWEyiiCC69FCFiBYpJgqLPKOuvsSD3vRKNR54T+pPw/6mf9eTtIgVRfg65liSPIMlUkLSAEkO0PRdmco5T48lVZ0KU/Q53s1dHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExGhRnKAsOq4gAQoOHXRS8sI2lU8w6KHEMbgFaHDmeg=;
 b=N1jIRtfOC5NSaMlwV/5UvUrm9ufDLbX3xavCjRQJqg1jjLQzdzpyrbok5AA3bNWnripgyxWPgvWoKkuGNoC1bHAeKmkcbUc4oo1sYq2sR92V/vOFqlh3dk33b7YkaNe0MU8XGqDZcCKbkJsqiCwCJyjG4iY9C4FBLP0yPC0QRUrmjlVohwNlZfEE3Gy1yEEMKUtn7YcxQhveCqXclnpsiBNtKF2BUedu5niuXjkscAEfbVKIZ3m4Abmb3KrZJIpsejyu8iTT4AVu4rGgxICjqpSzPr5BR+r+VG3kzUBbSKBvbS2RhioH0kieLGugWX/NsmA/KfMr+CTbyC1PoMl/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExGhRnKAsOq4gAQoOHXRS8sI2lU8w6KHEMbgFaHDmeg=;
 b=YAvJHpd8IAr9k8ExiKmjdeM+5Xx5dYUJYWyx/8/ERWbS2gm7YI60qwzVtRZZt8clImptky4sEIFRtpJlBmGtdXnwTCgUZ+pV5R+XCQELZjjyLvJmj1pGwoJgqjbxM2SieYEX9Lx7HrhB7ER2zqI5hPj78zYaHpkyEZ7BGkEaALw=
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Thu, 15 Aug
 2024 00:05:25 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::4e) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 11/17] drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.3
Date: Wed, 14 Aug 2024 20:04:55 -0400
Message-ID: <20240815000501.1845226-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 95342a2b-48ae-4648-ea5e-08dcbcbdf687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXlvWmx3RzRsWC9XU3lVQ2RVVlRwL0R0Z0pvSHBpMHlrb3V1RDVhYitORGtN?=
 =?utf-8?B?MDRDaXd5ZXUyRmd2VTJ6NE9UQXI0Q0xyZmROdUdGNDh5amVIVWRSekxLeTVU?=
 =?utf-8?B?clI3NGxuVHZWdm1ITk9JTnV0WlNKZU5FUzFXYTdWL1RJTWQ4MHhGNzk2N2hB?=
 =?utf-8?B?MFdmVkYrTWo1Nll5VDVvT3dFMXhnZC9FSVdoeERxa2VzNXBLb1BzRGtoSFg5?=
 =?utf-8?B?MDJ4TjY1TFJBejREWE1NcnY3NUZzdzhmR3N5bmd3b3BOems1RitUdmsyTThR?=
 =?utf-8?B?U0VTcUdXSU16T0xzTno1bVU0Wm42MzY4cnNFbkhvNGFaN2o2TG1COXE1V2hE?=
 =?utf-8?B?dkE4d01yQTFiNS9CSVhGTm05bWgwYmRpOUtKaDMrZXFmYlduUDlCdVpxRG51?=
 =?utf-8?B?eHdicHJEeW1mbW9GUEVTWkhnallIS0Z1Z1BIajdkeGNFRStHQXJZMzl3aFg1?=
 =?utf-8?B?ZTQ2aDVQRlVOQXI5cG0wckMyamh0dG03YUkyYzZUMkQyVkhUcStxUU05dmU3?=
 =?utf-8?B?cGY0SWU1dWdRUFFiR3Z0cFluL2l2RWY5OFpFa2wycC9GMFB3ZVNsenUvaE1I?=
 =?utf-8?B?OG5ra3l3cjNVaTN5bmt0MnBPdEJ0YlF6OXlKNENwWXFKZVlmUExwMWR6S2dW?=
 =?utf-8?B?SHI5N3A5Yk1OMWN2ckRTTEJ6LzB2OHQ5U3dzaEhQd2xadTFTeDJwa2tOMWxX?=
 =?utf-8?B?d0RKSFFJL3RzTDJ0cnM4RnVVbmpIcWhtT0FoRXdIcEVNQTRHTFN5R080Wlhq?=
 =?utf-8?B?TkdvblE3eU8xVFY5YTZkMjFFT0tDK2tkL0Z5Yks1R1kwZm4ya3hnQys4d2xX?=
 =?utf-8?B?dGY2Yng1NTk1M1VtQXhqeDU2NWxRbmNnNW1LTEVLbUpPN3RoTWI3ZXJpL2Rw?=
 =?utf-8?B?L1VFY0VpQmQ2dlU5L0ptMGVVeTB4YW9Fd2dnSWVEaGw3QXZmKzIya1JwVDNV?=
 =?utf-8?B?SkFpRzl3Q2ppQTJZbmk0SStKeUZHMHYxNGVIYjg2U1IvU25nOEhscXloOUtX?=
 =?utf-8?B?eHh6c3VBWUMzZlRXZU94K1FRQTBWb1o5NEZ6cFliR0JjUmdOczcrcGZFYW8y?=
 =?utf-8?B?bTR4RnRaRmN1eG5NU3ZFV2FFcWZ3dEFCVExTcUlBUll5dkRUbzBLdkNod0du?=
 =?utf-8?B?MVBiU2w3K0V0QXhhdHF0aTE4cHFiSmJtOWNwcW5ST0xib0NOMDdlV1ovN1NB?=
 =?utf-8?B?bVFhMUVyeVdMZTNIWUMrVytnaVdwODNpTEhiWWRPT2NLQklVcStWbmZOSTdz?=
 =?utf-8?B?cS9hWUhZY2I3c0JTRW1zME5JWCs2RUJqTVN5RGtSek5Nemo0dDZrMDNlcGc5?=
 =?utf-8?B?WDQ2c0RsRFZHVjNVT3hKb1JHWDFPYzRZbkphK2pmdmNDRXAvbzA0RnBxYmsw?=
 =?utf-8?B?eURvUzA5cXgvZW5MTnozbHBlT2VTMmZpd0luTVVEWlZpUjRIb3Bpclg0dTdq?=
 =?utf-8?B?NU9mejdqbVZYd1Rwd21yVm1HQlRrYmlCaGNtYU9IRnY0Rlh5SnVCVlViRFZp?=
 =?utf-8?B?Z1BJRjJVUkdCd1BHdWFvaUhPN0hpeDVQSGJXam5YQjRGS3NLVElwN0JGdlJQ?=
 =?utf-8?B?MmNyNEF2VnhGOXZlYmxuZDJCOHJmT3BITkd6VHcxeFVsaUlZOVhZUUljMkZJ?=
 =?utf-8?B?QkRlYkpkaVV6aG9nT2VXY0FNZmJqclpzeVl6dm55eHNFY0VBWjVsd01kNHRx?=
 =?utf-8?B?YUlUeWxFQzRDRWxkS0t0RkhWMXNnZ2dTc1hZTzI3RlJURVljaG1YYlQrTWVO?=
 =?utf-8?B?MklqY0ZjbERtSjd1MXEvejU0endWakt1VUp2S1ZOci83WG5rVjQ2RENUMnZK?=
 =?utf-8?B?ZkVnamtCUFlQMzJBOFhNSGNVNmozS0xJdGl6Vi9RSWI3S2tKRjFEMmpra0Yy?=
 =?utf-8?B?QnhDdlhnQWVEY1JWNVlYZlk2T01ZYldEMTZxc2Vxb2JZY3NZWkZaamZDRisx?=
 =?utf-8?Q?elEl+R4MIr7i6AJ9CYEKookfXF9v6Hwx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:24.9929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95342a2b-48ae-4648-ea5e-08dcbcbdf687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit adds the cleaner shader microcode for GFX9.4.3 GPUs. The
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
(`gfx_9_4_3_cleaner_shader_hex`). This array is the binary
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
cleaner shader feature helps improve GPU performance and resource
utilization by cleaning up GPU resources after they are used. It also
enhances security and reliability by preventing data leaks between
workloads.

v2: fix copyright date (Alex)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 153 ++++++++++++++++++
 .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.h    |  38 +++++
 2 files changed, 191 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
new file mode 100644
index 000000000000..d5325ef80ab0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
@@ -0,0 +1,153 @@
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
+// MI300 : Clear SGPRs, VGPRs and LDS
+//   Uses two kernels launched separately:
+//   1. Clean VGPRs, LDS, and lower SGPRs
+//        Launches one workgroup per CU, each workgroup with 4x wave64 per SIMD in the CU
+//        Waves are "wave64" and have 128 VGPRs each, which uses all 512 VGPRs per SIMD
+//        Waves in the workgroup share the 64KB of LDS
+//        Each wave clears SGPRs 0 - 95. Because there are 4 waves/SIMD, this is physical SGPRs 0-383
+//        Each wave clears 128 VGPRs, so all 512 in the SIMD
+//        The first wave of the workgroup clears its 64KB of LDS
+//        The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
+//          before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
+//    2. Clean remaining SGPRs
+//        Launches a workgroup with 24 waves per workgroup, yielding 6 waves per SIMD in each CU
+//        Waves are allocating 96 SGPRs
+//          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent these waves from allocating SGPRs 0-223.
+//          As such, these 6 waves per SIMD are allocated physical SGPRs 224-799
+//        Barriers do not work for >16 waves per workgroup, so we cannot start with S_BARRIER
+//          Instead, the shader starts with an S_SETHALT 1. Once all waves are launched CP will send unhalt command
+//        The shader then clears all SGPRs allocated to it, cleaning out physical SGPRs 224-799
+ 
+shader main
+  asic(MI300)
+  type(CS)
+  wave_size(64)
+// Note: original source code from SQ team
+
+//   (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 2176 clks)
+
+  s_cmp_eq_u32 s0, 1                                // Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3
+  s_cbranch_scc0  label_0023                        // Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s3 == 1)
+  S_BARRIER
+
+  s_movk_i32    m0, 0x0000
+  s_mov_b32     s2, 0x00000078  // Loop 128/8=16 times  (loop unrolled for performance)
+  //
+  // CLEAR VGPRs
+  //
+  s_set_gpr_idx_on  s2, 0x8    // enable Dest VGPR indexing
+label_0005:
+  v_mov_b32     v0, 0
+  v_mov_b32     v1, 0
+  v_mov_b32     v2, 0
+  v_mov_b32     v3, 0
+  v_mov_b32     v4, 0
+  v_mov_b32     v5, 0
+  v_mov_b32     v6, 0
+  v_mov_b32     v7, 0
+  s_sub_u32     s2, s2, 8
+  s_set_gpr_idx_idx  s2
+  s_cbranch_scc0  label_0005
+  s_set_gpr_idx_off
+ 
+  //
+  //
+ 
+  s_mov_b32     s2, 0x80000000                      // Bit31 is first_wave
+  s_and_b32     s2, s2, s1                          // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
+  s_cbranch_scc0  label_clean_sgpr_1                // Clean LDS if its first wave of ThreadGroup/WorkGroup
+  // CLEAR LDS
+  //
+  s_mov_b32 exec_lo, 0xffffffff
+  s_mov_b32 exec_hi, 0xffffffff
+  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..63)
+  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         // Set V1 to thread-ID (0..63)
+  v_mul_u32_u24  v1, 0x00000008, v1           // * 8, so each thread is a double-dword address (8byte)
+  s_mov_b32     s2, 0x00000003f               // 64 loop iteraions
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
+label_clean_sgpr_1:
+  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop unrolled for performance)
+  s_nop 0
+label_sgpr_loop:
+  s_movreld_b32     s0, 0
+  s_movreld_b32     s1, 0
+  s_movreld_b32     s2, 0
+  s_movreld_b32     s3, 0
+  s_sub_u32         m0, m0, 4
+  s_cbranch_scc0  label_sgpr_loop
+ 
+  //clear vcc, flat scratch
+  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR 
+  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR 
+  s_mov_b64 vcc, 0               //clear vcc
+  s_mov_b64 ttmp0, 0             //Clear ttmp0 and ttmp1 
+  s_mov_b64 ttmp2, 0             //Clear ttmp2 and ttmp3 
+  s_mov_b64 ttmp4, 0             //Clear ttmp4 and ttmp5 
+  s_mov_b64 ttmp6, 0             //Clear ttmp6 and ttmp7 
+  s_mov_b64 ttmp8, 0             //Clear ttmp8 and ttmp9 
+  s_mov_b64 ttmp10, 0            //Clear ttmp10 and ttmp11 
+  s_mov_b64 ttmp12, 0            //Clear ttmp12 and ttmp13 
+  s_mov_b64 ttmp14, 0            //Clear ttmp14 and ttmp15 
+s_endpgm
+
+label_0023:
+
+  s_sethalt 1
+
+  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop unrolled for performance)
+  s_nop 0
+label_sgpr_loop1:
+
+  s_movreld_b32     s0, 0
+  s_movreld_b32     s1, 0
+  s_movreld_b32     s2, 0
+  s_movreld_b32     s3, 0
+  s_sub_u32         m0, m0, 4
+  s_cbranch_scc0  label_sgpr_loop1
+ 
+  //clear vcc, flat scratch
+  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR 
+  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR 
+  s_mov_b64 vcc, 0xee            //clear vcc
+
+s_endpgm
+end  
+  
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h
index 042944ac75df..69aa567c6c1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h
@@ -23,4 +23,42 @@
 
 /* Define the cleaner shader gfx_9_4_3 */
 static const u32 gfx_9_4_3_cleaner_shader_hex[] = {
+	0xbf068100, 0xbf84003b,
+	0xbf8a0000, 0xb07c0000,
+	0xbe8200ff, 0x00000078,
+	0xbf110802, 0x7e000280,
+	0x7e020280, 0x7e040280,
+	0x7e060280, 0x7e080280,
+	0x7e0a0280, 0x7e0c0280,
+	0x7e0e0280, 0x80828802,
+	0xbe803202, 0xbf84fff5,
+	0xbf9c0000, 0xbe8200ff,
+	0x80000000, 0x86020102,
+	0xbf840011, 0xbefe00c1,
+	0xbeff00c1, 0xd28c0001,
+	0x0001007f, 0xd28d0001,
+	0x0002027e, 0x10020288,
+	0xbe8200bf, 0xbefc00c1,
+	0xd89c2000, 0x00020201,
+	0xd89c6040, 0x00040401,
+	0x320202ff, 0x00000400,
+	0x80828102, 0xbf84fff8,
+	0xbefc00ff, 0x0000005c,
+	0xbf800000, 0xbe802c80,
+	0xbe812c80, 0xbe822c80,
+	0xbe832c80, 0x80fc847c,
+	0xbf84fffa, 0xbee60080,
+	0xbee70080, 0xbeea0180,
+	0xbeec0180, 0xbeee0180,
+	0xbef00180, 0xbef20180,
+	0xbef40180, 0xbef60180,
+	0xbef80180, 0xbefa0180,
+	0xbf810000, 0xbf8d0001,
+	0xbefc00ff, 0x0000005c,
+	0xbf800000, 0xbe802c80,
+	0xbe812c80, 0xbe822c80,
+	0xbe832c80, 0x80fc847c,
+	0xbf84fffa, 0xbee60080,
+	0xbee70080, 0xbeea01ff,
+	0x000000ee, 0xbf810000,
 };
-- 
2.46.0

