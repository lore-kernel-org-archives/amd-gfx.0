Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F32D3C522
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFED10E885;
	Thu, 17 Oct 2024 16:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TfXyzNu3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CCA10E884
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLCDN4p5hrSkPQESnVuqlSNMw5sE0vSYIya5zT+XqHeeEPccteGOqRFH7NplxZq+rR792uuTlUNpGQAwwgi9758HVSh/bapry+FOTPWoqUrDl/LoqrFQDX4K7bjVoJ3PezKBkmwUjXby2PKkbSWTiRdHkf+nKk691/j9sgDQSbVxlf2iAjeFaDNGavj+VxnM1roWHuhXZSqnl+MsoUzqHr4SPeZPSgi9ZPvZq+xG/xxCNewhXyb1uUNk+hjirHlVkzlV/dyuBNvPt2XK8+NVE+Qa0j+C6XiNjND+Q3PpQcav5yEANpIscXVULnGBnJZVI4PrGG7JV5/Laqd30B+c5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X8vEB0NUO/UsJTWohfdmjika0jIzXwpH0i3jQOk9OY=;
 b=HjhjISY6OgXTaEK2qjmI7xkqxidrUqWQ2ojxIi7utixWiLj99aFH374YEY0e5TGIxW98oAjih6gzlcY2hzavW0DYt8a72M0iPNnu70jYGc18yF8xQyJ4ZhrqxTnGCsWwboOdZMgV21MbZs1BHmTcGnD/PW5kmvJoyrUh9GO+QzqYAzFsR0G4TCAqynkXK6Kic1rKE0ZZvDpDNV24r8NAp4o68kPfwPx8ecyjugfDShLnyhol5L7sbczRiGRD4Q01dKeevZxdeXkxnyrI+ChkBiq6DjG3gmgopbigZs7aOa1C+1yigrRoUsd5/AxoKXuqMipS2BbwRssrEEuoClWv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X8vEB0NUO/UsJTWohfdmjika0jIzXwpH0i3jQOk9OY=;
 b=TfXyzNu3Crj4U5utdeECq6Ilm5Y3QnZ56LlANpdrpycRKxXH4VE1wk96cTJj9Bl0bznuEKmGqpJGaStvcnYiltNtKFYUxZQ8lENVWcNRdhzzPzdW0Ce9T7rz/uvG9Zuc+Dt/qlQs4fGwpZC3HFdUy50ExaxCme6JnUxNAmhxH6g=
Received: from CH2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:610:51::35)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:44:49 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::31) by CH2PR15CA0025.outlook.office365.com
 (2603:10b6:610:51::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:44:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 11:44:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.2
Date: Thu, 17 Oct 2024 22:14:29 +0530
Message-ID: <20241017164430.3674916-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: b091cd64-1fe3-4382-af4a-08dceecb03b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Snc2Tm1lSDVnNXQwT0tRdnNUT1ZXcUdQWGxIdWxGaWV6bDlNc2RIZXZrWU0y?=
 =?utf-8?B?dDVxdXh6Nkt3UmJOalJoZHVsOXlpOUJhNy94ZzlHZ2I3SUZrNlRMdHNxc3hH?=
 =?utf-8?B?aDc3bFlieVZhWi81Tmh4Z0hjTU5zMXJSbEc2NFh6aWtEc1JJVDFuM2R6Yklu?=
 =?utf-8?B?Z25OTU5BWFVuMUEvV0NnQ092blRsYm96Y2hGMDRYOHBzeWIyTFc1cnpoYkRm?=
 =?utf-8?B?Qjkva0VIdnJKcTcya2ZUMVZZVTBQRldWN2lKeWYyRktiOUYwMkZ3NVViWFhF?=
 =?utf-8?B?bUcxS094amlRcy9ib3kzNk9TdWJTL2J4dk13S0d5N0VWN2o5d0x0WURzNmg3?=
 =?utf-8?B?YlVKY3A1Zy9MWHo0dDZYazBsZzU2SHIvQmgyRXB0bDcyd2JtQVVvdmVvRGRB?=
 =?utf-8?B?L1ZtRDhKMWNKL1g5QnErdEpTMFE4ZWdGVnQrNFRJVkthdTB2T2VFbEZwbk5L?=
 =?utf-8?B?Tjdta08wV0RvUmduaXhaTE5OVWVpRkRNTkliVTd3bVk3L2JDRUN6QVNZREVG?=
 =?utf-8?B?WktTNFg2MitIS2tOWDRsL2J2TXI2c3h2U3pSb1pEV3dZazB5YjRESG5vNmxr?=
 =?utf-8?B?ck9YMzBLellWcDFrcmxUTG54SFZ5NU1mYzYwRm91MzFIbTUyRHUyanU2eHla?=
 =?utf-8?B?bXkzVFI4clRVOWtHV1JsdGgwOXhLRWtDR1c3aWU4UHR3dTZYK1MyVER5cXcy?=
 =?utf-8?B?L3U0cnpzRFZnOElFcTd5c0Z4ZXhpQkdXU1NDNEhueHozc1FMeHZjbEtmWHBV?=
 =?utf-8?B?S1B3MTNXUEJQQm5LOHEvSXBpMnRHd0dNMlZYemJMb3dUZ2JEL2NhZjBNVDVY?=
 =?utf-8?B?VVpWU1UzQ0hsQk5FY1hVZUh2NHNRUEU3cC92MG1xTWJvL2VRamx5M2RSRHgy?=
 =?utf-8?B?RGFWRnF4UHZ1TDdXczhHR2JnTUZTZ2hCZHFCblEwU253RXR5L0JYblNLUVJz?=
 =?utf-8?B?UVJmTGR1MUQwa3lHOXNjM3kveEgwcVZnQXNjUkZOSExKRWx5cUkxZWt3OFYx?=
 =?utf-8?B?ZzNLVnphZlU2eFNxSkpmWWNVTFdwSzI0VGREUTRqTnNmMy9Ic0R1RGE3eXV3?=
 =?utf-8?B?bnRqOGY5R2Fkbk92c0U1QWJSUjBiV2t3SnI3VHh1bDBWVEllRmVkM29qaW44?=
 =?utf-8?B?d1lZbEZpVklmL3hqVjVmZjdsQkZYTUJGZWt1eHFhVW04MGNsQWhLclczZ2F5?=
 =?utf-8?B?cVp2YmJJQ1N5V3UrTFFhaGw5T2s0aU4xbWs5dWhPeVpveS9JbXo0eUpxQXZi?=
 =?utf-8?B?MVg4bkRLUVUvVUtPTXllMEFHN1VFRXd1eXlrTmhjbVVJYmZhZHd0K0lDOGRE?=
 =?utf-8?B?WjVTeCtzOVdoWTI4blJIbndnK3I3ZXdWOXgxaTVSLzRrOVl1K2sraDVmOFZ4?=
 =?utf-8?B?L25rbkZLMmhIcjRRSWRuOHBBNDNDeGNmbHQyRzdVd0h6YWJGM1J4VzZTZjJB?=
 =?utf-8?B?Z1J1U280UDVScVM5ajEwUzAwbWRKMEw2cGJJUmVYaXVUK2Mxam1PRy9rZ0p4?=
 =?utf-8?B?N3Q2ZGdkeG5hQm9uUDVnZm53R1RlZ3FmZG01UkdNUUpya09nMVh3cS9XMUM2?=
 =?utf-8?B?OEEyR0dxY2pxVXRzUmNCV1Z6SEZMWFFoeHRIVi9RdUR5SVB0T0dJczc3czRl?=
 =?utf-8?B?dzBkN0xSRU4ya00vbFBDOW1qWGJMVVE3VGtSeFhrc0RKWHMvM2dYK2VHY1M0?=
 =?utf-8?B?K3NMNXJUQVFZS3l6OHlmSm14K1VLRWRpWkdOT0lETU1Ya1dWWWNtbFhqMjFQ?=
 =?utf-8?B?TWxPaTQzSXBjdjhTL1BzVnBqeEJoSFgyUlE0TXVUWisrRWsrVk53WU9zaitt?=
 =?utf-8?B?QTdiNTdYY1RjNUFBc3FEQzBWdlFxU2hOY1BEU1liVHFjRWtibGhnOUNSVkFx?=
 =?utf-8?B?ZXJlNVkzU000aEtKVHp3U2JjMVIxdmQ5djkxQTRqZG82YUE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:44:48.6931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b091cd64-1fe3-4382-af4a-08dceecb03b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
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

This commit adds the cleaner shader microcode for GFX9.4.2 GPUs. The
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
(`gfx_9_4_2_cleaner_shader_hex`). This array is the binary
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
  - Reordered the patches 1 & 2 (Alex)
  - Updated comments to "// Note: original source code from SQ team"
    (Alex)

 .../drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h  |  44 ++++-
 .../amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm  | 153 ++++++++++++++++++
 2 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100755 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
index 36c0292b5110..0b6bd09b7529 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2024 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -24,3 +24,45 @@
 static const u32 __maybe_unused gfx_9_0_cleaner_shader_hex[] = {
 	/* Add the cleaner shader code here */
 };
+
+/* Define the cleaner shader gfx_9_4_2 */
+static const u32 gfx_9_4_2_cleaner_shader_hex[] = {
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
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm
new file mode 100755
index 000000000000..ebc64cb6c7c9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm
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
+// MI200 : Clear SGPRs, VGPRs and LDS
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
+  asic(MI200)
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
-- 
2.34.1

