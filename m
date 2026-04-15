Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9AF428D3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 20:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C88E10E74A;
	Wed, 15 Apr 2026 20:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VRvbOhme";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE35610E14D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 20:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFzVEqVSwnu/ScLrIiEX4cS+Mb3R+mStQ6FJgTBwSD7TUQ6ITnzHrVffT3qA/zEIrtsghErCBvgpmNJdVLFoiHBGgC4fzGObSjkNS3Rq2WMnqWBdLNzU3/B6Gp7QNYQf48huk3lcFgdmGAo679IZpwBs6xejMidQU0C0ZBIFBK3Yg4DaCNrUyhNPT4xseIKmbIhssTNuW7LP+F55J+QPIriXep8SKMU+sCBtR9ftYfn8uUebj5ZMFjsOkI34pLajCudn5/LbDdsNk2KPhGT/zDg7sYfbkZ8do5qI7dQ0GX/Nk9YKS0N1x+USynQ9b+Uoayi2aKxqXm1CmqmDVf/UeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSENj+9NDdo2QJAhgM+1ys16+c3ymzBu8MG7El5vD4k=;
 b=SXJWDRFwPm2UQqcvZGMzI+KxNPrfKxksD8feIcAUjE6slXHE9YN9gqmAyPmlX1o+6/8oKvoxafDoE25w9+yxdjlJnVsyUerfJpLhvEvL9vAkFArqbNl5Np0Ua8LhM/4yiftm2YoFTrZ2oof9U8vmjL2iToSlAiLqyMgb9FUHc9YMykAIznPyH5sd37JI4TrRfc65mprEUUJOKWKOXECPN1fsw1rwArVClUkGDH+oKs5ffc7zf42p1k/VAnztJLfaEt1ZkQ8FoDo0MmcxZjfHZbgqY3K1m7TvmIgzEPg0ETB0YbpFJjaA/SvRXC3zqJSb+gv6fxBCVNZPInYntiS0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSENj+9NDdo2QJAhgM+1ys16+c3ymzBu8MG7El5vD4k=;
 b=VRvbOhmeo0+qdkSBTHvnF7rK1HJoGe5MaC2hV3xueOfDZp3Y7Mraa4yoDOrr7B09ARq9dx29tPvF+3+HhwhnDEVDmwYWg9/yuLtWAe47g08Via6xSbHnQkCNBgQlL6sW/7mYtY5ZadnBazbH5KDJ65bV3rBgAMGTorrgUkR0RT8=
Received: from CH2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:52::37)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 20:13:49 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::fb) by CH2PR04CA0027.outlook.office365.com
 (2603:10b6:610:52::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 20:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 20:13:49 +0000
Received: from bingma-dev0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 15:13:48 -0500
From: Bing Ma <bing.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
CC: Bing Ma <bing.ma@amd.com>, Bing Ma <Bing.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Add gc v12_1_1 ip headers v3
Date: Wed, 15 Apr 2026 13:13:25 -0700
Message-ID: <20260415201325.838342-1-bing.ma@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 363ed6c2-bfbf-474c-d865-08de9b2b817d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|18096099003;
X-Microsoft-Antispam-Message-Info: F+Xo1dsrCs4XBtkze3l+uOI6MxuCIwIavZNWUoogvoev1w9DW/yi1R3O43K1A847dAUntHaPHVJROFGTmYtCYsZl69ueu1/6/ITu/RsrWDI4+iBuVaebmxgsWZ0/ZqFUzKKP56Dr7E+d4Ah9euCEGqjESdxEDq8Nq7/yFx0GVBHV4KqLY71M1KVmIpmdAonnyBQIDMYYhhUpze1CF5FtFfpEVFRU9XzMNKNMgSimJKqFYqgF79Kku7VCDYWzKMLeV36yNPMjbM2ITbOra6DJr7MHLfFzVXOQm07C3SoSrJJ+JNLzPFSv3xv3qS1aJ5BiecAiTV6mdvelWM2SBV2UURDh0yggHnyqB2FCDx6OIygmYgfWIKBeNTiYBy938xgYHkXd1vZb1VSn0gncAR14nHRjmmXxB8a5DT98XfAJ67GSNZCV4pq63pe48KZYRH4sDgHOFbMTFgN0Gxn9fttlNS6fkGNy+v2AugQUdLGjyliqs2pPtgKEenYIO77XDRw+3XMTgrta+7xjjAJH1V9fE3cTM5+9/+wroN/iwKaDMs5x1/wLb5IyvaP0n9nCgtP9JCLUHNKO0DaX4eIfQ/SZTOiaPaonOkiCwsCFKvgebxLVwUt518GFcejovRIEJVe6QngEZgf99HHgYnKIbQ4UxjutNkRXBWha94cDSkWsJDuxttTbe9eBRoAjErYyhxsmTpHgWdb3aPfUnD1jZtlt9Kd+r5ddFsZ6cYexKwMVvSswrao50tfUwzDtedchjWtnFO9RIbckImlSRp/haE/tOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(18096099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HMb7V3Mph5Ofn7dY5fih9UkVjfyrGsZRHWaerGbKVjzWPwBdWs5+GT1DYBGS83YZ6sG6sS3c+TmHv5uRTEeBUCw4+dIDWtOfjpkubhfh2qFw4OCHBoP5D12Mqyj5EaCl0zsMayYOggYnyUIO6jtAlZX+N8llETffJbPMlNu848EonU0TSjIzAuzS+MexJyOyICv5dkm/8aHXoq0BmS1MK91+8wd/JXd8u59xLBBT+u+mavYR5PCNa9lNHsAGs4Vxi8iNV5dbabsyO/0Uao/15lfurOp0tw8HZLypzrLoNGooOUlR26P1LgEUpC/UF/xEkijRu0pQqwvobnSG3P+lf1s0c3CaRUyiVCJIbqnCP7GnO6/WGvBPThDH7aX22m4ZAlGgcht4Zse1pfivd8awwuNwnPzc2G0R8sIha3oGGL0Xvx6HdIO5NL2tpYR0x7or
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 20:13:49.1036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 363ed6c2-bfbf-474c-d865-08de9b2b817d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

Add header files for gc v12_1_1 register offsets
and shift masks
v2: Update gc v12_1_1 ip headers
v3: Update gc v12_1_1 ip headers

Signed-off-by: Bing Ma <Bing.Ma@amd.com>
---
 .../include/asic_reg/gc/gc_12_1_1_offset.h    | 149 +++++++
 .../include/asic_reg/gc/gc_12_1_1_sh_mask.h   | 377 ++++++++++++++++++
 2 files changed, 526 insertions(+)
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h
new file mode 100755
index 000000000000..f10e6168ad54
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_offset.h
@@ -0,0 +1,149 @@
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
+#ifndef _gc_12_1_1_OFFSET_HEADER
+#define _gc_12_1_1_OFFSET_HEADER
+
+
+
+// addressBlock: aigc_grbma_grbma_grbmadec
+// base address: 0x18000
+#define regGRBMA_GFX_INDEX                                                                              0x0011
+#define regGRBMA_GFX_INDEX_BASE_IDX                                                                     1
+
+
+// addressBlock: aigc_grbma_grbma_perfddec
+// base address: 0x19200
+#define regGRBMA_PERFCOUNTER0_LO                                                                        0x0480
+#define regGRBMA_PERFCOUNTER0_LO_BASE_IDX                                                               1
+#define regGRBMA_PERFCOUNTER0_HI                                                                        0x0481
+#define regGRBMA_PERFCOUNTER0_HI_BASE_IDX                                                               1
+#define regGRBMA_PERFCOUNTER1_LO                                                                        0x0482
+#define regGRBMA_PERFCOUNTER1_LO_BASE_IDX                                                               1
+#define regGRBMA_PERFCOUNTER1_HI                                                                        0x0483
+#define regGRBMA_PERFCOUNTER1_HI_BASE_IDX                                                               1
+
+
+// addressBlock: aigc_grbma_grbma_perfsdec
+// base address: 0x19300
+#define regGRBMA_PERFCOUNTER0_SELECT                                                                    0x04c0
+#define regGRBMA_PERFCOUNTER0_SELECT_BASE_IDX                                                           1
+#define regGRBMA_PERFCOUNTER1_SELECT                                                                    0x04c1
+#define regGRBMA_PERFCOUNTER1_SELECT_BASE_IDX                                                           1
+#define regAID_PERFMON_CNTL                                                                             0x04c2
+#define regAID_PERFMON_CNTL_BASE_IDX                                                                    1
+
+
+// addressBlock: aigc_gl2x_gfx_se_perfsdec
+// base address: 0x19300
+#define regGL2C_PERFCOUNTER0_SELECT                                                                     0x04e8
+#define regGL2C_PERFCOUNTER0_SELECT_BASE_IDX                                                            1
+#define regGL2C_PERFCOUNTER0_SELECT1                                                                    0x04e9
+#define regGL2C_PERFCOUNTER0_SELECT1_BASE_IDX                                                           1
+#define regGL2C_PERFCOUNTER1_SELECT                                                                     0x04ea
+#define regGL2C_PERFCOUNTER1_SELECT_BASE_IDX                                                            1
+#define regGL2C_PERFCOUNTER1_SELECT1                                                                    0x04eb
+#define regGL2C_PERFCOUNTER1_SELECT1_BASE_IDX                                                           1
+#define regGL2C_PERFCOUNTER2_SELECT                                                                     0x04ec
+#define regGL2C_PERFCOUNTER2_SELECT_BASE_IDX                                                            1
+#define regGL2C_PERFCOUNTER2_SELECT1                                                                    0x04ed
+#define regGL2C_PERFCOUNTER2_SELECT1_BASE_IDX                                                           1
+#define regGL2C_PERFCOUNTER3_SELECT                                                                     0x04ee
+#define regGL2C_PERFCOUNTER3_SELECT_BASE_IDX                                                            1
+#define regGL2C_PERFCOUNTER3_SELECT1                                                                    0x04ef
+#define regGL2C_PERFCOUNTER3_SELECT1_BASE_IDX                                                           1
+#define regGL2A_PERFCOUNTER0_SELECT                                                                     0x04f0
+#define regGL2A_PERFCOUNTER0_SELECT_BASE_IDX                                                            1
+#define regGL2A_PERFCOUNTER0_SELECT1                                                                    0x04f1
+#define regGL2A_PERFCOUNTER0_SELECT1_BASE_IDX                                                           1
+#define regGL2A_PERFCOUNTER1_SELECT                                                                     0x04f2
+#define regGL2A_PERFCOUNTER1_SELECT_BASE_IDX                                                            1
+#define regGL2A_PERFCOUNTER1_SELECT1                                                                    0x04f3
+#define regGL2A_PERFCOUNTER1_SELECT1_BASE_IDX                                                           1
+#define regGL2A_PERFCOUNTER2_SELECT                                                                     0x04f4
+#define regGL2A_PERFCOUNTER2_SELECT_BASE_IDX                                                            1
+#define regGL2A_PERFCOUNTER2_SELECT1                                                                    0x04f5
+#define regGL2A_PERFCOUNTER2_SELECT1_BASE_IDX                                                           1
+#define regGL2A_PERFCOUNTER3_SELECT                                                                     0x04f6
+#define regGL2A_PERFCOUNTER3_SELECT_BASE_IDX                                                            1
+#define regGL2A_PERFCOUNTER3_SELECT1                                                                    0x04f7
+#define regGL2A_PERFCOUNTER3_SELECT1_BASE_IDX                                                           1
+
+
+// addressBlock: aigc_gl2x_gfx_se_perfddec
+// base address: 0x19200
+#define regGL2C_PERFCOUNTER0_LO                                                                         0x04a0
+#define regGL2C_PERFCOUNTER0_LO_BASE_IDX                                                                1
+#define regGL2C_PERFCOUNTER0_HI                                                                         0x04a1
+#define regGL2C_PERFCOUNTER0_HI_BASE_IDX                                                                1
+#define regGL2C_PERFCOUNTER1_LO                                                                         0x04a2
+#define regGL2C_PERFCOUNTER1_LO_BASE_IDX                                                                1
+#define regGL2C_PERFCOUNTER1_HI                                                                         0x04a3
+#define regGL2C_PERFCOUNTER1_HI_BASE_IDX                                                                1
+#define regGL2C_PERFCOUNTER2_LO                                                                         0x04a4
+#define regGL2C_PERFCOUNTER2_LO_BASE_IDX                                                                1
+#define regGL2C_PERFCOUNTER2_HI                                                                         0x04a5
+#define regGL2C_PERFCOUNTER2_HI_BASE_IDX                                                                1
+#define regGL2C_PERFCOUNTER3_LO                                                                         0x04a6
+#define regGL2C_PERFCOUNTER3_LO_BASE_IDX                                                                1
+#define regGL2C_PERFCOUNTER3_HI                                                                         0x04a7
+#define regGL2C_PERFCOUNTER3_HI_BASE_IDX                                                                1
+#define regGL2A_PERFCOUNTER0_LO                                                                         0x04a8
+#define regGL2A_PERFCOUNTER0_LO_BASE_IDX                                                                1
+#define regGL2A_PERFCOUNTER0_HI                                                                         0x04a9
+#define regGL2A_PERFCOUNTER0_HI_BASE_IDX                                                                1
+#define regGL2A_PERFCOUNTER1_LO                                                                         0x04aa
+#define regGL2A_PERFCOUNTER1_LO_BASE_IDX                                                                1
+#define regGL2A_PERFCOUNTER1_HI                                                                         0x04ab
+#define regGL2A_PERFCOUNTER1_HI_BASE_IDX                                                                1
+#define regGL2A_PERFCOUNTER2_LO                                                                         0x04ac
+#define regGL2A_PERFCOUNTER2_LO_BASE_IDX                                                                1
+#define regGL2A_PERFCOUNTER2_HI                                                                         0x04ad
+#define regGL2A_PERFCOUNTER2_HI_BASE_IDX                                                                1
+#define regGL2A_PERFCOUNTER3_LO                                                                         0x04ae
+#define regGL2A_PERFCOUNTER3_LO_BASE_IDX                                                                1
+#define regGL2A_PERFCOUNTER3_HI                                                                         0x04af
+#define regGL2A_PERFCOUNTER3_HI_BASE_IDX                                                                1
+
+
+// addressBlock: aigc_gfx_gcea_se_gfx_se_perfsdec
+// base address: 0x19320
+#define regGC_EA_SE_PERFCOUNTER0_SELECT                                                                 0x04c8
+#define regGC_EA_SE_PERFCOUNTER0_SELECT_BASE_IDX                                                        1
+#define regGC_EA_SE_PERFCOUNTER0_SELECT1                                                                0x04c9
+#define regGC_EA_SE_PERFCOUNTER0_SELECT1_BASE_IDX                                                       1
+#define regGC_EA_SE_PERFCOUNTER1_SELECT                                                                 0x04ca
+#define regGC_EA_SE_PERFCOUNTER1_SELECT_BASE_IDX                                                        1
+
+
+// addressBlock: aigc_gfx_gcea_se_gfx_se_perfddec
+// base address: 0x19240
+#define regGC_EA_SE_PERFCOUNTER0_LO                                                                     0x0490
+#define regGC_EA_SE_PERFCOUNTER0_LO_BASE_IDX                                                            1
+#define regGC_EA_SE_PERFCOUNTER0_HI                                                                     0x0491
+#define regGC_EA_SE_PERFCOUNTER0_HI_BASE_IDX                                                            1
+#define regGC_EA_SE_PERFCOUNTER1_LO                                                                     0x0492
+#define regGC_EA_SE_PERFCOUNTER1_LO_BASE_IDX                                                            1
+#define regGC_EA_SE_PERFCOUNTER1_HI                                                                     0x0493
+#define regGC_EA_SE_PERFCOUNTER1_HI_BASE_IDX                                                            1
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h
new file mode 100755
index 000000000000..8d09c8150a53
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_1_sh_mask.h
@@ -0,0 +1,377 @@
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
+#ifndef _gc_12_1_1_SH_MASK_HEADER
+#define _gc_12_1_1_SH_MASK_HEADER
+
+
+// addressBlock: aigc_grbma_grbma_grbmadec
+//GRBMA_GFX_INDEX
+#define GRBMA_GFX_INDEX__INSTANCE_INDEX__SHIFT                                                                0x0
+#define GRBMA_GFX_INDEX__SA_INDEX__SHIFT                                                                      0x8
+#define GRBMA_GFX_INDEX__SE_INDEX__SHIFT                                                                      0x10
+#define GRBMA_GFX_INDEX__SA_BROADCAST_WRITES__SHIFT                                                           0x1d
+#define GRBMA_GFX_INDEX__INSTANCE_BROADCAST_WRITES__SHIFT                                                     0x1e
+#define GRBMA_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT                                                           0x1f
+#define GRBMA_GFX_INDEX__INSTANCE_INDEX_MASK                                                                  0x0000007FL
+#define GRBMA_GFX_INDEX__SA_INDEX_MASK                                                                        0x00000300L
+#define GRBMA_GFX_INDEX__SE_INDEX_MASK                                                                        0x000F0000L
+#define GRBMA_GFX_INDEX__SA_BROADCAST_WRITES_MASK                                                             0x20000000L
+#define GRBMA_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK                                                       0x40000000L
+#define GRBMA_GFX_INDEX__SE_BROADCAST_WRITES_MASK                                                             0x80000000L
+
+
+// addressBlock: aigc_grbma_grbma_perfddec
+//GRBMA_PERFCOUNTER0_LO
+#define GRBMA_PERFCOUNTER0_LO__PERFCOUNTER_LO__SHIFT                                                          0x0
+#define GRBMA_PERFCOUNTER0_LO__PERFCOUNTER_LO_MASK                                                            0xFFFFFFFFL
+//GRBMA_PERFCOUNTER0_HI
+#define GRBMA_PERFCOUNTER0_HI__PERFCOUNTER_HI__SHIFT                                                          0x0
+#define GRBMA_PERFCOUNTER0_HI__PERFCOUNTER_HI_MASK                                                            0xFFFFFFFFL
+//GRBMA_PERFCOUNTER1_LO
+#define GRBMA_PERFCOUNTER1_LO__PERFCOUNTER_LO__SHIFT                                                          0x0
+#define GRBMA_PERFCOUNTER1_LO__PERFCOUNTER_LO_MASK                                                            0xFFFFFFFFL
+//GRBMA_PERFCOUNTER1_HI
+#define GRBMA_PERFCOUNTER1_HI__PERFCOUNTER_HI__SHIFT                                                          0x0
+#define GRBMA_PERFCOUNTER1_HI__PERFCOUNTER_HI_MASK                                                            0xFFFFFFFFL
+
+
+// addressBlock: aigc_grbma_grbma_perfsdec
+//GRBMA_PERFCOUNTER0_SELECT
+#define GRBMA_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                                                            0x0
+#define GRBMA_PERFCOUNTER0_SELECT__GL1CC_BUSY_USER_DEFINED_MASK__SHIFT                                        0x6
+#define GRBMA_PERFCOUNTER0_SELECT__GL1XCC_BUSY_USER_DEFINED_MASK__SHIFT                                       0x7
+#define GRBMA_PERFCOUNTER0_SELECT__PMR_BUSY_USER_DEFINED_MASK__SHIFT                                          0x8
+#define GRBMA_PERFCOUNTER0_SELECT__SC_CLEAN_USER_DEFINED_MASK__SHIFT                                          0x9
+#define GRBMA_PERFCOUNTER0_SELECT__WGS_BUSY_USER_DEFINED_MASK__SHIFT                                          0xa
+#define GRBMA_PERFCOUNTER0_SELECT__DB_CLEAN_USER_DEFINED_MASK__SHIFT                                          0xb
+#define GRBMA_PERFCOUNTER0_SELECT__CB_CLEAN_USER_DEFINED_MASK__SHIFT                                          0xc
+#define GRBMA_PERFCOUNTER0_SELECT__TA_BUSY_USER_DEFINED_MASK__SHIFT                                           0xd
+#define GRBMA_PERFCOUNTER0_SELECT__SX_BUSY_USER_DEFINED_MASK__SHIFT                                           0xe
+#define GRBMA_PERFCOUNTER0_SELECT__GL2C_BUSY_USER_DEFINED_MASK__SHIFT                                         0xf
+#define GRBMA_PERFCOUNTER0_SELECT__SPI_BUSY_USER_DEFINED_MASK__SHIFT                                          0x10
+#define GRBMA_PERFCOUNTER0_SELECT__XCAC_BUSY_USER_DEFINED_MASK__SHIFT                                         0x11
+#define GRBMA_PERFCOUNTER0_SELECT__PA_BUSY_USER_DEFINED_MASK__SHIFT                                           0x12
+#define GRBMA_PERFCOUNTER0_SELECT__GL2A_BUSY_USER_DEFINED_MASK__SHIFT                                         0x13
+#define GRBMA_PERFCOUNTER0_SELECT__DB_BUSY_USER_DEFINED_MASK__SHIFT                                           0x14
+#define GRBMA_PERFCOUNTER0_SELECT__CB_BUSY_USER_DEFINED_MASK__SHIFT                                           0x15
+#define GRBMA_PERFCOUNTER0_SELECT__EA_LINK_BUSY_USER_DEFINED_MASK__SHIFT                                      0x17
+#define GRBMA_PERFCOUNTER0_SELECT__AIGC_CAC_BUSY_USER_DEFINED_MASK__SHIFT                                     0x18
+#define GRBMA_PERFCOUNTER0_SELECT__BCI_BUSY_USER_DEFINED_MASK__SHIFT                                          0x19
+#define GRBMA_PERFCOUNTER0_SELECT__RLC_BUSY_USER_DEFINED_MASK__SHIFT                                          0x1a
+#define GRBMA_PERFCOUNTER0_SELECT__TCP_BUSY_USER_DEFINED_MASK__SHIFT                                          0x1b
+#define GRBMA_PERFCOUNTER0_SELECT__GE_BUSY_USER_DEFINED_MASK__SHIFT                                           0x1c
+#define GRBMA_PERFCOUNTER0_SELECT__UTCL1_BUSY_USER_DEFINED_MASK__SHIFT                                        0x1d
+#define GRBMA_PERFCOUNTER0_SELECT__EA_BUSY_USER_DEFINED_MASK__SHIFT                                           0x1e
+#define GRBMA_PERFCOUNTER0_SELECT__PERF_SEL_MASK                                                              0x0000003FL
+#define GRBMA_PERFCOUNTER0_SELECT__GL1CC_BUSY_USER_DEFINED_MASK_MASK                                          0x00000040L
+#define GRBMA_PERFCOUNTER0_SELECT__GL1XCC_BUSY_USER_DEFINED_MASK_MASK                                         0x00000080L
+#define GRBMA_PERFCOUNTER0_SELECT__PMR_BUSY_USER_DEFINED_MASK_MASK                                            0x00000100L
+#define GRBMA_PERFCOUNTER0_SELECT__SC_CLEAN_USER_DEFINED_MASK_MASK                                            0x00000200L
+#define GRBMA_PERFCOUNTER0_SELECT__WGS_BUSY_USER_DEFINED_MASK_MASK                                            0x00000400L
+#define GRBMA_PERFCOUNTER0_SELECT__DB_CLEAN_USER_DEFINED_MASK_MASK                                            0x00000800L
+#define GRBMA_PERFCOUNTER0_SELECT__CB_CLEAN_USER_DEFINED_MASK_MASK                                            0x00001000L
+#define GRBMA_PERFCOUNTER0_SELECT__TA_BUSY_USER_DEFINED_MASK_MASK                                             0x00002000L
+#define GRBMA_PERFCOUNTER0_SELECT__SX_BUSY_USER_DEFINED_MASK_MASK                                             0x00004000L
+#define GRBMA_PERFCOUNTER0_SELECT__GL2C_BUSY_USER_DEFINED_MASK_MASK                                           0x00008000L
+#define GRBMA_PERFCOUNTER0_SELECT__SPI_BUSY_USER_DEFINED_MASK_MASK                                            0x00010000L
+#define GRBMA_PERFCOUNTER0_SELECT__XCAC_BUSY_USER_DEFINED_MASK_MASK                                           0x00020000L
+#define GRBMA_PERFCOUNTER0_SELECT__PA_BUSY_USER_DEFINED_MASK_MASK                                             0x00040000L
+#define GRBMA_PERFCOUNTER0_SELECT__GL2A_BUSY_USER_DEFINED_MASK_MASK                                           0x00080000L
+#define GRBMA_PERFCOUNTER0_SELECT__DB_BUSY_USER_DEFINED_MASK_MASK                                             0x00100000L
+#define GRBMA_PERFCOUNTER0_SELECT__CB_BUSY_USER_DEFINED_MASK_MASK                                             0x00200000L
+#define GRBMA_PERFCOUNTER0_SELECT__EA_LINK_BUSY_USER_DEFINED_MASK_MASK                                        0x00800000L
+#define GRBMA_PERFCOUNTER0_SELECT__AIGC_CAC_BUSY_USER_DEFINED_MASK_MASK                                       0x01000000L
+#define GRBMA_PERFCOUNTER0_SELECT__BCI_BUSY_USER_DEFINED_MASK_MASK                                            0x02000000L
+#define GRBMA_PERFCOUNTER0_SELECT__RLC_BUSY_USER_DEFINED_MASK_MASK                                            0x04000000L
+#define GRBMA_PERFCOUNTER0_SELECT__TCP_BUSY_USER_DEFINED_MASK_MASK                                            0x08000000L
+#define GRBMA_PERFCOUNTER0_SELECT__GE_BUSY_USER_DEFINED_MASK_MASK                                             0x10000000L
+#define GRBMA_PERFCOUNTER0_SELECT__UTCL1_BUSY_USER_DEFINED_MASK_MASK                                          0x20000000L
+#define GRBMA_PERFCOUNTER0_SELECT__EA_BUSY_USER_DEFINED_MASK_MASK                                             0x40000000L
+//GRBMA_PERFCOUNTER1_SELECT
+#define GRBMA_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                                                            0x0
+#define GRBMA_PERFCOUNTER1_SELECT__GL1CC_BUSY_USER_DEFINED_MASK__SHIFT                                        0x6
+#define GRBMA_PERFCOUNTER1_SELECT__GL1XCC_BUSY_USER_DEFINED_MASK__SHIFT                                       0x7
+#define GRBMA_PERFCOUNTER1_SELECT__PMR_BUSY_USER_DEFINED_MASK__SHIFT                                          0x8
+#define GRBMA_PERFCOUNTER1_SELECT__SC_CLEAN_USER_DEFINED_MASK__SHIFT                                          0x9
+#define GRBMA_PERFCOUNTER1_SELECT__WGS_BUSY_USER_DEFINED_MASK__SHIFT                                          0xa
+#define GRBMA_PERFCOUNTER1_SELECT__DB_CLEAN_USER_DEFINED_MASK__SHIFT                                          0xb
+#define GRBMA_PERFCOUNTER1_SELECT__CB_CLEAN_USER_DEFINED_MASK__SHIFT                                          0xc
+#define GRBMA_PERFCOUNTER1_SELECT__TA_BUSY_USER_DEFINED_MASK__SHIFT                                           0xd
+#define GRBMA_PERFCOUNTER1_SELECT__SX_BUSY_USER_DEFINED_MASK__SHIFT                                           0xe
+#define GRBMA_PERFCOUNTER1_SELECT__GL2C_BUSY_USER_DEFINED_MASK__SHIFT                                         0xf
+#define GRBMA_PERFCOUNTER1_SELECT__SPI_BUSY_USER_DEFINED_MASK__SHIFT                                          0x10
+#define GRBMA_PERFCOUNTER1_SELECT__XCAC_BUSY_USER_DEFINED_MASK__SHIFT                                         0x11
+#define GRBMA_PERFCOUNTER1_SELECT__PA_BUSY_USER_DEFINED_MASK__SHIFT                                           0x12
+#define GRBMA_PERFCOUNTER1_SELECT__GL2A_BUSY_USER_DEFINED_MASK__SHIFT                                         0x13
+#define GRBMA_PERFCOUNTER1_SELECT__DB_BUSY_USER_DEFINED_MASK__SHIFT                                           0x14
+#define GRBMA_PERFCOUNTER1_SELECT__CB_BUSY_USER_DEFINED_MASK__SHIFT                                           0x15
+#define GRBMA_PERFCOUNTER1_SELECT__EA_LINK_BUSY_USER_DEFINED_MASK__SHIFT                                      0x17
+#define GRBMA_PERFCOUNTER1_SELECT__AIGC_CAC_BUSY_USER_DEFINED_MASK__SHIFT                                     0x18
+#define GRBMA_PERFCOUNTER1_SELECT__BCI_BUSY_USER_DEFINED_MASK__SHIFT                                          0x19
+#define GRBMA_PERFCOUNTER1_SELECT__RLC_BUSY_USER_DEFINED_MASK__SHIFT                                          0x1a
+#define GRBMA_PERFCOUNTER1_SELECT__TCP_BUSY_USER_DEFINED_MASK__SHIFT                                          0x1b
+#define GRBMA_PERFCOUNTER1_SELECT__GE_BUSY_USER_DEFINED_MASK__SHIFT                                           0x1c
+#define GRBMA_PERFCOUNTER1_SELECT__UTCL1_BUSY_USER_DEFINED_MASK__SHIFT                                        0x1d
+#define GRBMA_PERFCOUNTER1_SELECT__EA_BUSY_USER_DEFINED_MASK__SHIFT                                           0x1e
+#define GRBMA_PERFCOUNTER1_SELECT__PERF_SEL_MASK                                                              0x0000003FL
+#define GRBMA_PERFCOUNTER1_SELECT__GL1CC_BUSY_USER_DEFINED_MASK_MASK                                          0x00000040L
+#define GRBMA_PERFCOUNTER1_SELECT__GL1XCC_BUSY_USER_DEFINED_MASK_MASK                                         0x00000080L
+#define GRBMA_PERFCOUNTER1_SELECT__PMR_BUSY_USER_DEFINED_MASK_MASK                                            0x00000100L
+#define GRBMA_PERFCOUNTER1_SELECT__SC_CLEAN_USER_DEFINED_MASK_MASK                                            0x00000200L
+#define GRBMA_PERFCOUNTER1_SELECT__WGS_BUSY_USER_DEFINED_MASK_MASK                                            0x00000400L
+#define GRBMA_PERFCOUNTER1_SELECT__DB_CLEAN_USER_DEFINED_MASK_MASK                                            0x00000800L
+#define GRBMA_PERFCOUNTER1_SELECT__CB_CLEAN_USER_DEFINED_MASK_MASK                                            0x00001000L
+#define GRBMA_PERFCOUNTER1_SELECT__TA_BUSY_USER_DEFINED_MASK_MASK                                             0x00002000L
+#define GRBMA_PERFCOUNTER1_SELECT__SX_BUSY_USER_DEFINED_MASK_MASK                                             0x00004000L
+#define GRBMA_PERFCOUNTER1_SELECT__GL2C_BUSY_USER_DEFINED_MASK_MASK                                           0x00008000L
+#define GRBMA_PERFCOUNTER1_SELECT__SPI_BUSY_USER_DEFINED_MASK_MASK                                            0x00010000L
+#define GRBMA_PERFCOUNTER1_SELECT__XCAC_BUSY_USER_DEFINED_MASK_MASK                                           0x00020000L
+#define GRBMA_PERFCOUNTER1_SELECT__PA_BUSY_USER_DEFINED_MASK_MASK                                             0x00040000L
+#define GRBMA_PERFCOUNTER1_SELECT__GL2A_BUSY_USER_DEFINED_MASK_MASK                                           0x00080000L
+#define GRBMA_PERFCOUNTER1_SELECT__DB_BUSY_USER_DEFINED_MASK_MASK                                             0x00100000L
+#define GRBMA_PERFCOUNTER1_SELECT__CB_BUSY_USER_DEFINED_MASK_MASK                                             0x00200000L
+#define GRBMA_PERFCOUNTER1_SELECT__EA_LINK_BUSY_USER_DEFINED_MASK_MASK                                        0x00800000L
+#define GRBMA_PERFCOUNTER1_SELECT__AIGC_CAC_BUSY_USER_DEFINED_MASK_MASK                                       0x01000000L
+#define GRBMA_PERFCOUNTER1_SELECT__BCI_BUSY_USER_DEFINED_MASK_MASK                                            0x02000000L
+#define GRBMA_PERFCOUNTER1_SELECT__RLC_BUSY_USER_DEFINED_MASK_MASK                                            0x04000000L
+#define GRBMA_PERFCOUNTER1_SELECT__TCP_BUSY_USER_DEFINED_MASK_MASK                                            0x08000000L
+#define GRBMA_PERFCOUNTER1_SELECT__GE_BUSY_USER_DEFINED_MASK_MASK                                             0x10000000L
+#define GRBMA_PERFCOUNTER1_SELECT__UTCL1_BUSY_USER_DEFINED_MASK_MASK                                          0x20000000L
+#define GRBMA_PERFCOUNTER1_SELECT__EA_BUSY_USER_DEFINED_MASK_MASK                                             0x40000000L
+//AID_PERFMON_CNTL
+#define AID_PERFMON_CNTL__PERFMON_STATE__SHIFT                                                                0x0
+#define AID_PERFMON_CNTL__SPM_PERFMON_STATE__SHIFT                                                            0x4
+#define AID_PERFMON_CNTL__PERFMON_ENABLE_MODE__SHIFT                                                          0x8
+#define AID_PERFMON_CNTL__PERFMON_SAMPLE_ENABLE__SHIFT                                                        0xa
+#define AID_PERFMON_CNTL__PERFMON_STATE_MASK                                                                  0x0000000FL
+#define AID_PERFMON_CNTL__SPM_PERFMON_STATE_MASK                                                              0x000000F0L
+#define AID_PERFMON_CNTL__PERFMON_ENABLE_MODE_MASK                                                            0x00000300L
+#define AID_PERFMON_CNTL__PERFMON_SAMPLE_ENABLE_MASK                                                          0x00000400L
+
+
+// addressBlock: aigc_gl2x_gfx_se_perfsdec
+//GL2C_PERFCOUNTER0_SELECT
+#define GL2C_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                                                             0x0
+#define GL2C_PERFCOUNTER0_SELECT__PERF_SEL1__SHIFT                                                            0xa
+#define GL2C_PERFCOUNTER0_SELECT__CNTR_MODE__SHIFT                                                            0x14
+#define GL2C_PERFCOUNTER0_SELECT__PERF_MODE1__SHIFT                                                           0x18
+#define GL2C_PERFCOUNTER0_SELECT__PERF_MODE__SHIFT                                                            0x1c
+#define GL2C_PERFCOUNTER0_SELECT__PERF_SEL_MASK                                                               0x000003FFL
+#define GL2C_PERFCOUNTER0_SELECT__PERF_SEL1_MASK                                                              0x000FFC00L
+#define GL2C_PERFCOUNTER0_SELECT__CNTR_MODE_MASK                                                              0x00F00000L
+#define GL2C_PERFCOUNTER0_SELECT__PERF_MODE1_MASK                                                             0x0F000000L
+#define GL2C_PERFCOUNTER0_SELECT__PERF_MODE_MASK                                                              0xF0000000L
+//GL2C_PERFCOUNTER0_SELECT1
+#define GL2C_PERFCOUNTER0_SELECT1__PERF_SEL2__SHIFT                                                           0x0
+#define GL2C_PERFCOUNTER0_SELECT1__PERF_SEL3__SHIFT                                                           0xa
+#define GL2C_PERFCOUNTER0_SELECT1__PERF_MODE3__SHIFT                                                          0x18
+#define GL2C_PERFCOUNTER0_SELECT1__PERF_MODE2__SHIFT                                                          0x1c
+#define GL2C_PERFCOUNTER0_SELECT1__PERF_SEL2_MASK                                                             0x000003FFL
+#define GL2C_PERFCOUNTER0_SELECT1__PERF_SEL3_MASK                                                             0x000FFC00L
+#define GL2C_PERFCOUNTER0_SELECT1__PERF_MODE3_MASK                                                            0x0F000000L
+#define GL2C_PERFCOUNTER0_SELECT1__PERF_MODE2_MASK                                                            0xF0000000L
+//GL2C_PERFCOUNTER1_SELECT
+#define GL2C_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                                                             0x0
+#define GL2C_PERFCOUNTER1_SELECT__PERF_SEL1__SHIFT                                                            0xa
+#define GL2C_PERFCOUNTER1_SELECT__CNTR_MODE__SHIFT                                                            0x14
+#define GL2C_PERFCOUNTER1_SELECT__PERF_MODE1__SHIFT                                                           0x18
+#define GL2C_PERFCOUNTER1_SELECT__PERF_MODE__SHIFT                                                            0x1c
+#define GL2C_PERFCOUNTER1_SELECT__PERF_SEL_MASK                                                               0x000003FFL
+#define GL2C_PERFCOUNTER1_SELECT__PERF_SEL1_MASK                                                              0x000FFC00L
+#define GL2C_PERFCOUNTER1_SELECT__CNTR_MODE_MASK                                                              0x00F00000L
+#define GL2C_PERFCOUNTER1_SELECT__PERF_MODE1_MASK                                                             0x0F000000L
+#define GL2C_PERFCOUNTER1_SELECT__PERF_MODE_MASK                                                              0xF0000000L
+//GL2C_PERFCOUNTER1_SELECT1
+#define GL2C_PERFCOUNTER1_SELECT1__PERF_SEL2__SHIFT                                                           0x0
+#define GL2C_PERFCOUNTER1_SELECT1__PERF_SEL3__SHIFT                                                           0xa
+#define GL2C_PERFCOUNTER1_SELECT1__PERF_MODE3__SHIFT                                                          0x18
+#define GL2C_PERFCOUNTER1_SELECT1__PERF_MODE2__SHIFT                                                          0x1c
+#define GL2C_PERFCOUNTER1_SELECT1__PERF_SEL2_MASK                                                             0x000003FFL
+#define GL2C_PERFCOUNTER1_SELECT1__PERF_SEL3_MASK                                                             0x000FFC00L
+#define GL2C_PERFCOUNTER1_SELECT1__PERF_MODE3_MASK                                                            0x0F000000L
+#define GL2C_PERFCOUNTER1_SELECT1__PERF_MODE2_MASK                                                            0xF0000000L
+//GL2C_PERFCOUNTER2_SELECT
+#define GL2C_PERFCOUNTER2_SELECT__PERF_SEL__SHIFT                                                             0x0
+#define GL2C_PERFCOUNTER2_SELECT__PERF_SEL1__SHIFT                                                            0xa
+#define GL2C_PERFCOUNTER2_SELECT__CNTR_MODE__SHIFT                                                            0x14
+#define GL2C_PERFCOUNTER2_SELECT__PERF_MODE1__SHIFT                                                           0x18
+#define GL2C_PERFCOUNTER2_SELECT__PERF_MODE__SHIFT                                                            0x1c
+#define GL2C_PERFCOUNTER2_SELECT__PERF_SEL_MASK                                                               0x000003FFL
+#define GL2C_PERFCOUNTER2_SELECT__PERF_SEL1_MASK                                                              0x000FFC00L
+#define GL2C_PERFCOUNTER2_SELECT__CNTR_MODE_MASK                                                              0x00F00000L
+#define GL2C_PERFCOUNTER2_SELECT__PERF_MODE1_MASK                                                             0x0F000000L
+#define GL2C_PERFCOUNTER2_SELECT__PERF_MODE_MASK                                                              0xF0000000L
+//GL2C_PERFCOUNTER2_SELECT1
+#define GL2C_PERFCOUNTER2_SELECT1__PERF_SEL2__SHIFT                                                           0x0
+#define GL2C_PERFCOUNTER2_SELECT1__PERF_SEL3__SHIFT                                                           0xa
+#define GL2C_PERFCOUNTER2_SELECT1__PERF_MODE3__SHIFT                                                          0x18
+#define GL2C_PERFCOUNTER2_SELECT1__PERF_MODE2__SHIFT                                                          0x1c
+#define GL2C_PERFCOUNTER2_SELECT1__PERF_SEL2_MASK                                                             0x000003FFL
+#define GL2C_PERFCOUNTER2_SELECT1__PERF_SEL3_MASK                                                             0x000FFC00L
+#define GL2C_PERFCOUNTER2_SELECT1__PERF_MODE3_MASK                                                            0x0F000000L
+#define GL2C_PERFCOUNTER2_SELECT1__PERF_MODE2_MASK                                                            0xF0000000L
+//GL2C_PERFCOUNTER3_SELECT
+#define GL2C_PERFCOUNTER3_SELECT__PERF_SEL__SHIFT                                                             0x0
+#define GL2C_PERFCOUNTER3_SELECT__PERF_SEL1__SHIFT                                                            0xa
+#define GL2C_PERFCOUNTER3_SELECT__CNTR_MODE__SHIFT                                                            0x14
+#define GL2C_PERFCOUNTER3_SELECT__PERF_MODE1__SHIFT                                                           0x18
+#define GL2C_PERFCOUNTER3_SELECT__PERF_MODE__SHIFT                                                            0x1c
+#define GL2C_PERFCOUNTER3_SELECT__PERF_SEL_MASK                                                               0x000003FFL
+#define GL2C_PERFCOUNTER3_SELECT__PERF_SEL1_MASK                                                              0x000FFC00L
+#define GL2C_PERFCOUNTER3_SELECT__CNTR_MODE_MASK                                                              0x00F00000L
+#define GL2C_PERFCOUNTER3_SELECT__PERF_MODE1_MASK                                                             0x0F000000L
+#define GL2C_PERFCOUNTER3_SELECT__PERF_MODE_MASK                                                              0xF0000000L
+//GL2C_PERFCOUNTER3_SELECT1
+#define GL2C_PERFCOUNTER3_SELECT1__PERF_SEL2__SHIFT                                                           0x0
+#define GL2C_PERFCOUNTER3_SELECT1__PERF_SEL3__SHIFT                                                           0xa
+#define GL2C_PERFCOUNTER3_SELECT1__PERF_MODE3__SHIFT                                                          0x18
+#define GL2C_PERFCOUNTER3_SELECT1__PERF_MODE2__SHIFT                                                          0x1c
+#define GL2C_PERFCOUNTER3_SELECT1__PERF_SEL2_MASK                                                             0x000003FFL
+#define GL2C_PERFCOUNTER3_SELECT1__PERF_SEL3_MASK                                                             0x000FFC00L
+#define GL2C_PERFCOUNTER3_SELECT1__PERF_MODE3_MASK                                                            0x0F000000L
+#define GL2C_PERFCOUNTER3_SELECT1__PERF_MODE2_MASK                                                            0xF0000000L
+//GL2A_PERFCOUNTER0_SELECT
+#define GL2A_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                                                             0x0
+#define GL2A_PERFCOUNTER0_SELECT__PERF_SEL1__SHIFT                                                            0xa
+#define GL2A_PERFCOUNTER0_SELECT__CNTR_MODE__SHIFT                                                            0x14
+#define GL2A_PERFCOUNTER0_SELECT__PERF_MODE1__SHIFT                                                           0x18
+#define GL2A_PERFCOUNTER0_SELECT__PERF_MODE__SHIFT                                                            0x1c
+#define GL2A_PERFCOUNTER0_SELECT__PERF_SEL_MASK                                                               0x000003FFL
+#define GL2A_PERFCOUNTER0_SELECT__PERF_SEL1_MASK                                                              0x000FFC00L
+#define GL2A_PERFCOUNTER0_SELECT__CNTR_MODE_MASK                                                              0x00F00000L
+#define GL2A_PERFCOUNTER0_SELECT__PERF_MODE1_MASK                                                             0x0F000000L
+#define GL2A_PERFCOUNTER0_SELECT__PERF_MODE_MASK                                                              0xF0000000L
+//GL2A_PERFCOUNTER0_SELECT1
+#define GL2A_PERFCOUNTER0_SELECT1__PERF_SEL2__SHIFT                                                           0x0
+#define GL2A_PERFCOUNTER0_SELECT1__PERF_SEL3__SHIFT                                                           0xa
+#define GL2A_PERFCOUNTER0_SELECT1__PERF_MODE3__SHIFT                                                          0x18
+#define GL2A_PERFCOUNTER0_SELECT1__PERF_MODE2__SHIFT                                                          0x1c
+#define GL2A_PERFCOUNTER0_SELECT1__PERF_SEL2_MASK                                                             0x000003FFL
+#define GL2A_PERFCOUNTER0_SELECT1__PERF_SEL3_MASK                                                             0x000FFC00L
+#define GL2A_PERFCOUNTER0_SELECT1__PERF_MODE3_MASK                                                            0x0F000000L
+#define GL2A_PERFCOUNTER0_SELECT1__PERF_MODE2_MASK                                                            0xF0000000L
+//GL2A_PERFCOUNTER1_SELECT
+#define GL2A_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                                                             0x0
+#define GL2A_PERFCOUNTER1_SELECT__PERF_SEL1__SHIFT                                                            0xa
+#define GL2A_PERFCOUNTER1_SELECT__CNTR_MODE__SHIFT                                                            0x14
+#define GL2A_PERFCOUNTER1_SELECT__PERF_MODE1__SHIFT                                                           0x18
+#define GL2A_PERFCOUNTER1_SELECT__PERF_MODE__SHIFT                                                            0x1c
+#define GL2A_PERFCOUNTER1_SELECT__PERF_SEL_MASK                                                               0x000003FFL
+#define GL2A_PERFCOUNTER1_SELECT__PERF_SEL1_MASK                                                              0x000FFC00L
+#define GL2A_PERFCOUNTER1_SELECT__CNTR_MODE_MASK                                                              0x00F00000L
+#define GL2A_PERFCOUNTER1_SELECT__PERF_MODE1_MASK                                                             0x0F000000L
+#define GL2A_PERFCOUNTER1_SELECT__PERF_MODE_MASK                                                              0xF0000000L
+//GL2A_PERFCOUNTER1_SELECT1
+#define GL2A_PERFCOUNTER1_SELECT1__PERF_SEL2__SHIFT                                                           0x0
+#define GL2A_PERFCOUNTER1_SELECT1__PERF_SEL3__SHIFT                                                           0xa
+#define GL2A_PERFCOUNTER1_SELECT1__PERF_MODE3__SHIFT                                                          0x18
+#define GL2A_PERFCOUNTER1_SELECT1__PERF_MODE2__SHIFT                                                          0x1c
+#define GL2A_PERFCOUNTER1_SELECT1__PERF_SEL2_MASK                                                             0x000003FFL
+#define GL2A_PERFCOUNTER1_SELECT1__PERF_SEL3_MASK                                                             0x000FFC00L
+#define GL2A_PERFCOUNTER1_SELECT1__PERF_MODE3_MASK                                                            0x0F000000L
+#define GL2A_PERFCOUNTER1_SELECT1__PERF_MODE2_MASK                                                            0xF0000000L
+//GL2A_PERFCOUNTER2_SELECT
+#define GL2A_PERFCOUNTER2_SELECT__PERF_SEL__SHIFT                                                             0x0
+#define GL2A_PERFCOUNTER2_SELECT__PERF_SEL1__SHIFT                                                            0xa
+#define GL2A_PERFCOUNTER2_SELECT__CNTR_MODE__SHIFT                                                            0x14
+#define GL2A_PERFCOUNTER2_SELECT__PERF_MODE1__SHIFT                                                           0x18
+#define GL2A_PERFCOUNTER2_SELECT__PERF_MODE__SHIFT                                                            0x1c
+#define GL2A_PERFCOUNTER2_SELECT__PERF_SEL_MASK                                                               0x000003FFL
+#define GL2A_PERFCOUNTER2_SELECT__PERF_SEL1_MASK                                                              0x000FFC00L
+#define GL2A_PERFCOUNTER2_SELECT__CNTR_MODE_MASK                                                              0x00F00000L
+#define GL2A_PERFCOUNTER2_SELECT__PERF_MODE1_MASK                                                             0x0F000000L
+#define GL2A_PERFCOUNTER2_SELECT__PERF_MODE_MASK                                                              0xF0000000L
+//GL2A_PERFCOUNTER2_SELECT1
+#define GL2A_PERFCOUNTER2_SELECT1__PERF_SEL2__SHIFT                                                           0x0
+#define GL2A_PERFCOUNTER2_SELECT1__PERF_SEL3__SHIFT                                                           0xa
+#define GL2A_PERFCOUNTER2_SELECT1__PERF_MODE3__SHIFT                                                          0x18
+#define GL2A_PERFCOUNTER2_SELECT1__PERF_MODE2__SHIFT                                                          0x1c
+#define GL2A_PERFCOUNTER2_SELECT1__PERF_SEL2_MASK                                                             0x000003FFL
+#define GL2A_PERFCOUNTER2_SELECT1__PERF_SEL3_MASK                                                             0x000FFC00L
+#define GL2A_PERFCOUNTER2_SELECT1__PERF_MODE3_MASK                                                            0x0F000000L
+#define GL2A_PERFCOUNTER2_SELECT1__PERF_MODE2_MASK                                                            0xF0000000L
+//GL2A_PERFCOUNTER3_SELECT
+#define GL2A_PERFCOUNTER3_SELECT__PERF_SEL__SHIFT                                                             0x0
+#define GL2A_PERFCOUNTER3_SELECT__PERF_SEL1__SHIFT                                                            0xa
+#define GL2A_PERFCOUNTER3_SELECT__CNTR_MODE__SHIFT                                                            0x14
+#define GL2A_PERFCOUNTER3_SELECT__PERF_MODE1__SHIFT                                                           0x18
+#define GL2A_PERFCOUNTER3_SELECT__PERF_MODE__SHIFT                                                            0x1c
+#define GL2A_PERFCOUNTER3_SELECT__PERF_SEL_MASK                                                               0x000003FFL
+#define GL2A_PERFCOUNTER3_SELECT__PERF_SEL1_MASK                                                              0x000FFC00L
+#define GL2A_PERFCOUNTER3_SELECT__CNTR_MODE_MASK                                                              0x00F00000L
+#define GL2A_PERFCOUNTER3_SELECT__PERF_MODE1_MASK                                                             0x0F000000L
+#define GL2A_PERFCOUNTER3_SELECT__PERF_MODE_MASK                                                              0xF0000000L
+//GL2A_PERFCOUNTER3_SELECT1
+#define GL2A_PERFCOUNTER3_SELECT1__PERF_SEL2__SHIFT                                                           0x0
+#define GL2A_PERFCOUNTER3_SELECT1__PERF_SEL3__SHIFT                                                           0xa
+#define GL2A_PERFCOUNTER3_SELECT1__PERF_MODE3__SHIFT                                                          0x18
+#define GL2A_PERFCOUNTER3_SELECT1__PERF_MODE2__SHIFT                                                          0x1c
+#define GL2A_PERFCOUNTER3_SELECT1__PERF_SEL2_MASK                                                             0x000003FFL
+#define GL2A_PERFCOUNTER3_SELECT1__PERF_SEL3_MASK                                                             0x000FFC00L
+#define GL2A_PERFCOUNTER3_SELECT1__PERF_MODE3_MASK                                                            0x0F000000L
+#define GL2A_PERFCOUNTER3_SELECT1__PERF_MODE2_MASK                                                            0xF0000000L
+
+
+// addressBlock: aigc_gfx_gcea_se_gfx_se_perfsdec
+//GC_EA_SE_PERFCOUNTER0_SELECT
+#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                                                         0x0
+#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_SEL1__SHIFT                                                        0xa
+#define GC_EA_SE_PERFCOUNTER0_SELECT__CNTR_MODE__SHIFT                                                        0x14
+#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_MODE1__SHIFT                                                       0x18
+#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_MODE__SHIFT                                                        0x1c
+#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_SEL_MASK                                                           0x000003FFL
+#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_SEL1_MASK                                                          0x000FFC00L
+#define GC_EA_SE_PERFCOUNTER0_SELECT__CNTR_MODE_MASK                                                          0x00F00000L
+#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_MODE1_MASK                                                         0x0F000000L
+#define GC_EA_SE_PERFCOUNTER0_SELECT__PERF_MODE_MASK                                                          0xF0000000L
+//GC_EA_SE_PERFCOUNTER0_SELECT1
+#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_SEL2__SHIFT                                                       0x0
+#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_SEL3__SHIFT                                                       0xa
+#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_MODE3__SHIFT                                                      0x18
+#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_MODE2__SHIFT                                                      0x1c
+#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_SEL2_MASK                                                         0x000003FFL
+#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_SEL3_MASK                                                         0x000FFC00L
+#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_MODE3_MASK                                                        0x0F000000L
+#define GC_EA_SE_PERFCOUNTER0_SELECT1__PERF_MODE2_MASK                                                        0xF0000000L
+//GC_EA_SE_PERFCOUNTER1_SELECT
+#define GC_EA_SE_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                                                         0x0
+#define GC_EA_SE_PERFCOUNTER1_SELECT__COUNTER_MODE__SHIFT                                                     0x1c
+#define GC_EA_SE_PERFCOUNTER1_SELECT__PERF_SEL_MASK                                                           0x000003FFL
+#define GC_EA_SE_PERFCOUNTER1_SELECT__COUNTER_MODE_MASK                                                       0xF0000000L
+
+
+// addressBlock: aigc_gfx_gcea_se_gfx_se_perfddec
+//GC_EA_SE_PERFCOUNTER0_LO
+#define GC_EA_SE_PERFCOUNTER0_LO__PERFCOUNTER_LO__SHIFT                                                       0x0
+#define GC_EA_SE_PERFCOUNTER0_LO__PERFCOUNTER_LO_MASK                                                         0xFFFFFFFFL
+//GC_EA_SE_PERFCOUNTER0_HI
+#define GC_EA_SE_PERFCOUNTER0_HI__PERFCOUNTER_HI__SHIFT                                                       0x0
+#define GC_EA_SE_PERFCOUNTER0_HI__PERFCOUNTER_HI_MASK                                                         0xFFFFFFFFL
+//GC_EA_SE_PERFCOUNTER1_LO
+#define GC_EA_SE_PERFCOUNTER1_LO__PERFCOUNTER_LO__SHIFT                                                       0x0
+#define GC_EA_SE_PERFCOUNTER1_LO__PERFCOUNTER_LO_MASK                                                         0xFFFFFFFFL
+//GC_EA_SE_PERFCOUNTER1_HI
+#define GC_EA_SE_PERFCOUNTER1_HI__PERFCOUNTER_HI__SHIFT                                                       0x0
+#define GC_EA_SE_PERFCOUNTER1_HI__PERFCOUNTER_HI_MASK                                                         0xFFFFFFFFL
+
+#endif
-- 
2.34.1

