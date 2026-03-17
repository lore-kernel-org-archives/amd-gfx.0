Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0619BFD708D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BB410E63A;
	Tue, 17 Mar 2026 20:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5qphiMrK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6ED10E63A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBUdpB7TE/kytLl/4H4i/g/Ne6B3gDl59XV9krDl4o2oo9qjU7Y//wdgDF1otIhNZTe2se096XjbCePN1QW65lHutQtIeSfqmdSN2Z8+5hQAicp+tRqcFCCYH0HZYu19PKgyo4/bmp360szwUBLoZz/iJOMF/TBxP1iOlKMT6wdrqvxqUjWHykPfXD/Wu/WT+6g/UZ9jzXC5fmAGgkwMgJXVIjSc4+3E84KGQKheasLTIoVnp4/7GONeAz6usGQTRH0FtlOWez6Gp9EZawa5jFvd2H6QTNUsYUiT7xye3IYVHhVp9fnARLpglAG1uPeGlMa0UQ9QnjIg/PzesIpSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT8KSIjLRJN6SLt4eoL87KxrO2e/BjdKBYFIpuqGMHs=;
 b=YRWlgD2i4AUm5SxEDCbFWMihzhgSPo4RyPVGyiRHbBy08OPWrUuOwer3xjxTVclO2CCCIidc9VKfEmWFS11utVtfLJAcZDxW8h833ldf3XvoVBLyvu/yvor1zGsP/NO8lMHvfTpvmq9nLyGKrJM+7WltgWB7nrMrFT+NDgORFAxdYyfA9RHZ2AEX6mksEXcGjpg7APvu2RxAA1p0Fz52etYHL5kDp1UUakdAAyjc8fdhRBYdLa3cUxzqSvN4sd+aZ5XVr0NdmgLJc3FXtnxkRpZuWy6vn5Cj4OOZ5e5CMkzvyKgmSI2zlZDAr3eEgYoAb53W9ollconh2SbKQbMauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT8KSIjLRJN6SLt4eoL87KxrO2e/BjdKBYFIpuqGMHs=;
 b=5qphiMrKk0C7GtWj6vcJb13mqMsRRVE4/lFT2YSGE/3mhAtl/D0EzsmvQVl3VmbhtypVJfHmxVa+qZGLr2ttaIXaR2k8r7WKNc81hoTxQMxafLBNqluASoE7GLvkM1OnSbC/l8rf5tmeVbC/9eusCWXmdq5BGjgz3o0am6qWGBM=
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 20:12:58 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::4b) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:12:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:12:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:12:55 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:12:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Yang
 Wang <kevinyang.wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/25] drm/amd/pm: Add smu v15_0_8 message header
Date: Tue, 17 Mar 2026 16:12:18 -0400
Message-ID: <20260317201242.3808136-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 716bd03f-6e59-43ba-fe7e-08de84619484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: eN3N8JkJJ8jy0bk6/KkzXMVBnYFAhluT/20NZPbZG7RJVRBwnruKbvklDxeBtM0fYt/Skn5EqC4pTASldeeQeE50qsYI7gvJQdJ55xFaFI89R2gCy3u7xoHIPQiboLQgqUlhVu8IaU2hYgqnijYIT50sx9a00MDOObycM/VPvCwQXBE4x6TgVTB4kkpsedTe7cfsVHtxsaLkUlaLB1w2lXndL4rltz1EKGONmSBF3eSyno5XB+4Vvcn7/08G3Qvu2UOGjI/rqRfQONu1qy9w7rr0geA9SAe4/Zop3u4aUURijY5deNTHIacTXztsz7jMsP1pUpKyMMkVvCLAb2iaGpzHN4ilUY3RuF/XhAUytr3iQTHyWpO1XLTg5cTQ29LPilojN/0UrqkWwotP8rXj11Zs28cMi58lOEWw22wF/sUYjNb5E5RZVl1RMHkwrtGaWqwOj/FGTTSIB0tIZTQtYwsL4YBl+nRsxnVOwbxiNw3is9kPPus6yF1ag7dQDLmBKmqZzm3MpUJ346bOZwO73YIKeIOY8u3ofc0alnYPhOyG6a9xv/ufj3y9uC5n298+54Urn/splmYrIzaQzGTWCQZ54ZR3FSTXh+sqBNiTiqmPlbMIrz2NP8ytx7pNhYFQ1R284plFYgUhE5d6CiL9JCFs1RRWAivbxxwnB8IKgu4Z3KRR/I44f7KhX7ik8MdZqGOpUA941jtEUzlQzKMfDUHql7GJy3I2IqkSD83JpGg+sITpYkPm4rpj8BggDDbQp/aiGhqAmv2qfIz4+xiTHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V4j9OQpmNtRhjWa9RYMDKcHwq1rWqRlNV6qbMPN6zJeuQJ0PvlR0Gu486PPnqaexsNGt4z7ku3wZ0NfkI37C7aalhbSP6zLdp7RcDG2Wl1MsXBB53fcfiWgukCsFrIZSvzjktiSa3YJH5+vDGeqne2GYGqWxPMpLj6o6DxcVZAheZZTF9g4cT9Wl2R51+fIQ2kjWHHnoo2G/wV1CFRfiLsD+iQ6ySwXlCDw9rVHknL0/9h32sYTcxQG8U0f5MyxbUdtaUS6F1qrtI1gYTJCqz3le5jY4q5WzMSdY+BfL6BTZbj3B0G5jcZ0x6aDaBt7CsDEmc0Np/861cVVxSMA7Ur5TyVMk6J0bBE/2E4QzaBe+nV/sN23JsIAStTthoSavwLaQozKmLV+DEi6WRVDngv1tWCSCnieUu9JIdn7/ONHd96kvbVrMeajKV1XsHA4M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:12:56.9828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 716bd03f-6e59-43ba-fe7e-08de84619484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add smu v15_0_8 message header

v2: squash in updates (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h  | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
new file mode 100644
index 0000000000000..7ffb445f4c0cc
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h
@@ -0,0 +1,100 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef SMU_15_0_8_PPSMC_H
+#define SMU_15_0_8_PPSMC_H
+
+/* SMU Response Codes */
+#define PPSMC_Result_OK                             0x1
+#define PPSMC_Result_Failed                         0xFF
+#define PPSMC_Result_UnknownCmd                     0xFE
+#define PPSMC_Result_CmdRejectedPrereq              0xFD
+#define PPSMC_Result_CmdRejectedBusy                0xFC
+
+/* Message Definitions */
+#define PPSMC_MSG_TestMessage	                    0x1
+#define PPSMC_MSG_GetSmuVersion	                    0x2
+#define PPSMC_MSG_GfxDriverReset	                0x3
+#define PPSMC_MSG_GetDriverIfVersion	            0x4
+#define PPSMC_MSG_EnableAllSmuFeatures	            0x5
+#define PPSMC_MSG_GetMetricsVersion	                0x6
+#define PPSMC_MSG_GetMetricsTable	                0x7
+#define PPSMC_MSG_GetEnabledSmuFeatures	            0x8
+#define PPSMC_MSG_SetDriverDramAddr	                0x9 //ARG0: low address, ARG1: high address
+#define PPSMC_MSG_SetToolsDramAddr	                0xA //ARG0: low address, ARG1: high address
+//#define PPSMC_MSG_SetSystemVirtualDramAddr	        0xB
+#define PPSMC_MSG_SetSoftMaxByFreq	                0xC
+#define PPSMC_MSG_SetPptLimit	                    0xD
+#define PPSMC_MSG_GetPptLimit	                    0xE
+#define PPSMC_MSG_DramLogSetDramAddr	            0xF //ARG0: low address, ARG1: high address, ARG2: size
+#define PPSMC_MSG_HeavySBR	                        0x10
+#define PPSMC_MSG_DFCstateControl	                0x11
+#define PPSMC_MSG_GfxDriverResetRecovery	        0x12
+#define PPSMC_MSG_TriggerVFFLR	                    0x13
+#define PPSMC_MSG_SetSoftMinGfxClk	                0x14
+#define PPSMC_MSG_SetSoftMaxGfxClk	                0x15
+#define PPSMC_MSG_PrepareForDriverUnload	        0x16
+#define PPSMC_MSG_QueryValidMcaCount	            0x17
+#define PPSMC_MSG_McaBankDumpDW	                    0x18
+#define PPSMC_MSG_ClearMcaOnRead	                0x19
+#define PPSMC_MSG_QueryValidMcaCeCount	            0x1A
+#define PPSMC_MSG_McaBankCeDumpDW	                0x1B
+#define PPSMC_MSG_SelectPLPDMode	                0x1C
+#define PPSMC_MSG_SetThrottlingPolicy	            0x1D
+#define PPSMC_MSG_ResetSDMA	                        0x1E
+#define PPSMC_MSG_GetRasTableVersion	            0x1F
+#define PPSMC_MSG_GetRmaStatus	                    0x20
+#define PPSMC_MSG_GetBadPageCount	                0x21
+#define PPSMC_MSG_GetBadPageMcaAddress	            0x22
+#define PPSMC_MSG_GetBadPagePaAddress	            0x23
+#define PPSMC_MSG_SetTimestamp	                    0x24
+#define PPSMC_MSG_GetTimestamp	                    0x25
+#define PPSMC_MSG_GetRasPolicy	                    0x26
+#define PPSMC_MSG_GetBadPageIpIdLoHi	            0x27
+#define PPSMC_MSG_EraseRasTable	                    0x28
+#define PPSMC_MSG_GetStaticMetricsTable	            0x29
+#define PPSMC_MSG_ResetVfArbitersByIndex	        0x2A
+#define PPSMC_MSG_GetBadPageSeverity	            0x2B
+#define PPSMC_MSG_GetSystemMetricsTable	            0x2C
+#define PPSMC_MSG_GetSystemMetricsVersion	        0x2D
+#define PPSMC_MSG_ResetVCN	                        0x2E
+#define PPSMC_MSG_SetFastPptLimit	                0x2F
+#define PPSMC_MSG_GetFastPptLimit	                0x30
+#define PPSMC_MSG_SetSoftMinGl2clk	                0x31
+#define PPSMC_MSG_SetSoftMaxGl2clk	                0x32
+#define PPSMC_MSG_SetSoftMinFclk	                0x33
+#define PPSMC_MSG_SetSoftMaxFclk	                0x34
+#define PPSMC_Message_Count                         0x35
+
+/* PSMC Reset Types for driver msg argument */
+#define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
+#define PPSMC_RESET_TYPE_DRIVER_MODE_2_RESET        0x2
+#define PPSMC_RESET_TYPE_DRIVER_MODE_3_RESET        0x3
+
+/* PLPD modes */
+#define PPSMC_PLPD_MODE_DEFAULT                     0x1
+#define PPSMC_PLPD_MODE_OPTIMIZED                   0x2
+
+typedef uint32_t PPSMC_Result;
+typedef uint32_t PPSMC_MSG;
+
+#endif
-- 
2.53.0

