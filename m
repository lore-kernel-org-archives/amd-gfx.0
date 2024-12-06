Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669D6E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 09:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153D610E606;
	Fri,  6 Dec 2024 09:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hg9Wavlr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393A410E606
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 09:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTh4GJdzDn9NXK/QJx9X2ZLmYlncwLn8ahRB5Ql/5V0MLddiZPaO9tqaW22iVwOqePNnCEayiXAPt6W9wC4QhK37SDkY5C0vdCt4Mm8QoHECg45aGuLZTRfCaGfkVHbV5h0IAqLQ7/0jZnlQMMDYbVFlirilRXrBRkIAIN2I+BaXVESuC58x8rwljxd/J2iZIveBhn/pc+wVZbp71D3/3J0NzMyX7h5WBXbOUs16+HAiu2Dp/dY7pfE0GsyfHA67TUm0CaRUBxXsurchuTfTUMaLsFDaX2N7xCGJeG1CKZjjiatzXt8XA6+Cg+hAChROEKwqo1Tm+AVDULDe2LvmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok+PzQ5kKeeGgxIXffASTxnyVEeUOECd+EAWLl5kT/Y=;
 b=xjxHi58xxNv5OWJa9xYsYETST67G3PgntlRQa8AxfxZ1LLGaB+Mp6k859Tqjq3Dr8CfNILFvrxhELOCoEqKx76b8qSJtVlDAsaLmzKkN3Cf3QkD8J+gJ6XLPKIfDvzrOeFsp+VYS5JzTAYZvoj9p5Q5sWwmqd5X59CB5ZOFb7rQOZsq9dz/yg3zSoZtq7JUdZvIOeqwJ3x+fyzGb6bWNIyrbyHqymK8AHNBVf2i21LBAt58Dz7wiQQ3d0mrlYjwahs1SiWz5PMqwQ0kt2PiynT+nvFne/7j+TLGGhhlGHFwYW44DHsFC5N4p6Y4ucnH1j/VgosydfSOU818IqGx8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok+PzQ5kKeeGgxIXffASTxnyVEeUOECd+EAWLl5kT/Y=;
 b=hg9WavlrvsaifAFYKH80PaaPD5n+m/8QflHN4Yt57McAtgwwlfF6VKoCHoaJM29IlRHP1DxeZj3eaw/SpSLxxlJKZmv8NXExKeh67y9fwHurg17omFlFGnoKIegqP/w8hjdw5aIVkl4xNXDjsAq6M05lQCdRAAu5NEJtD8p75+o=
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 09:05:23 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::f9) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.22 via Frontend Transport; Fri,
 6 Dec 2024 09:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 09:05:23 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 03:05:21 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add umc v8_14_0 ip headers
Date: Fri, 6 Dec 2024 17:04:53 +0800
Message-ID: <20241206090455.182520-2-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206090455.182520-1-candice.li@amd.com>
References: <20241206090455.182520-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e31b086-ae40-408f-8dd3-08dd15d51e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j5o/rUs9Lv1gi40Qf483Va0BzQiomXSggZZgJn24OcWqK3jfwI25Kau3Jgp0?=
 =?us-ascii?Q?rGEUhdmFIuteIblEnDkb1DzDpD+F+Oy1HpiZTwcsGmRWgqBSMiHVgQ+10B5K?=
 =?us-ascii?Q?lksKhtaOg2ywnL7rY7ZIHOmnUewmrgRgWXHa8GL11SFpxnCuF3w7Ya5m2Bl3?=
 =?us-ascii?Q?5I67hOp72sepcZYffSp26SuXNYUtlunFWht62CVSBrI6L8SjFDKb7KJTqOMt?=
 =?us-ascii?Q?KzpVOX7iF2OG3J+5KZ+LWdzNZi4hzddUVt6GJ2vk/rm1iZBcuzES05OrNVX5?=
 =?us-ascii?Q?NmX5qR2pZgV+gogz58+9n4D+1EAlKrVGe96rtbL4q9xtGEMrH+V++k9ivjOW?=
 =?us-ascii?Q?UF3BWQ8LzBUYbvkWVRvxnO51heW94vvciPO0N9kDiGqdEw792e+o7hS8nPCl?=
 =?us-ascii?Q?GibFLFG714AwFUpdiUFEqbrQSAMuYjN2jPDBzvSqRdphg7AjR8MldTTXAxrV?=
 =?us-ascii?Q?YfJr2bPNR21lmXeFoglJi3ugYKzXIBYGnTkD7g2uKIbkQlPF9jhmBdS49Lh7?=
 =?us-ascii?Q?n3obuXxE5hOiso1BFUHyYtcNg0QgCl/WDLYRopn3cfWg9WcLqzjy66BL54Kc?=
 =?us-ascii?Q?BpdnRNgG6a2DagQG0mLZ3eV10B40XhTxCt8rQjCJIcE7NgdDMAFglzZ3L8Wa?=
 =?us-ascii?Q?pHpS1oBVbpHTjYNjM+HN13PJsUlQNcBBb6RxKJlpp7t+WvbOMjRz29hQtY1d?=
 =?us-ascii?Q?p6gmAa8PHjMIgTevBaKHYWoy/NvbvdSFdy6/vdhuhouH3HN2MAy3eCtFkU1R?=
 =?us-ascii?Q?Ko2P/9NYwcbTE24OxjRwEyzRQtSr4maFn5oHF+LS1OZqq5j7RVBq4JabSI9W?=
 =?us-ascii?Q?XWdIwE55m3r//ERddF7UKiV9WsiRw5DH9kgwVGMVmm17sUXfYLomatxEmVQB?=
 =?us-ascii?Q?xcvhIAmlIE/esDdQgZDMPaioPpMZQbZWa4nPGalh2r2SxOpwn0qMNF+TjsEk?=
 =?us-ascii?Q?cOfyNyxognD94Amb+pNkk1aBeaMP40bxgXWCYHBlJARPkAO+kaOclrAIXof9?=
 =?us-ascii?Q?oZMLj1Y7R29mV6WQ3PUFPbsvHDCy24lGcDqxvP32p8Mk0QqhfgLZ1BEXmlzR?=
 =?us-ascii?Q?DL8F+/FMykxHIzcQ70YpvljGfOoNdCzjjbWtIESK7PTZWK2g/b+Nzwhz9xGR?=
 =?us-ascii?Q?BUCOi9sRjKYpTyjfxJASRDlR5erUXc+Q2PJDaDh7TS6tSDEnNtdh5QInDkc0?=
 =?us-ascii?Q?vfyjO/Bj3gJe7o2ktI/CWXeeNdGuAT+3JBz0VrIGC2lonmJzmrHdp5s4kZJ3?=
 =?us-ascii?Q?5lVO2w/gJ44SLSVy8xdJnM5GALGFV4rtMzSCWGiFzGmzoXaoHvrUM/sg114E?=
 =?us-ascii?Q?4xDI25pebaRX68NQjkIksN4LWBrSNZV3sqwuVWNJzNBsDucZE7DgOKic26t5?=
 =?us-ascii?Q?nm3lJbG4Hb3Zgg8O3PRBtKb4M/Bu0pT20ppGfSqbQbYKhKwtSE4sgvuYnmvJ?=
 =?us-ascii?Q?mXg9376EjoTgRbzHEkFQM7dsbCXek8GT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:05:23.4786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e31b086-ae40-408f-8dd3-08dd15d51e44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

Add umc v8_14_0 ip headers.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 .../include/asic_reg/umc/umc_8_14_0_offset.h  | 29 +++++++++++++++
 .../include/asic_reg/umc/umc_8_14_0_sh_mask.h | 37 +++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_14_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_14_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_14_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_14_0_offset.h
new file mode 100644
index 00000000000000..0e8f12728d5f48
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_14_0_offset.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2024  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _umc_8_14_0_OFFSET_HEADER
+#define _umc_8_14_0_OFFSET_HEADER
+
+#define regUMCCH0_GeccErrCntSel                                         0x0328
+#define regUMCCH0_GeccErrCntSel_BASE_IDX                                0
+#define regUMCCH0_GeccErrCnt                                            0x0329
+#define regUMCCH0_GeccErrCnt_BASE_IDX                                   0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_14_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_14_0_sh_mask.h
new file mode 100644
index 00000000000000..5d723b5d9b87b8
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_14_0_sh_mask.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2024  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _umc_8_14_0_SH_MASK_HEADER
+#define _umc_8_14_0_SH_MASK_HEADER
+
+//UMCCH0_GeccErrCntSel
+#define UMCCH0_GeccErrCntSel__GeccErrInt__SHIFT              0xc
+#define UMCCH0_GeccErrCntSel__GeccErrCntEn__SHIFT            0xf
+#define UMCCH0_GeccErrCntSel__PoisonCntEn__SHIFT             0x10
+#define UMCCH0_GeccErrCntSel__GeccErrInt_MASK                0x00003000L
+#define UMCCH0_GeccErrCntSel__GeccErrCntEn_MASK              0x00008000L
+#define UMCCH0_GeccErrCntSel__PoisonCntEn_MASK               0x00030000L
+//UMCCH0_GeccErrCnt
+#define UMCCH0_GeccErrCnt__GeccErrCnt__SHIFT                 0x0
+#define UMCCH0_GeccErrCnt__GeccUnCorrErrCnt__SHIFT           0x10
+#define UMCCH0_GeccErrCnt__GeccErrCnt_MASK                   0x0000FFFFL
+#define UMCCH0_GeccErrCnt__GeccUnCorrErrCnt_MASK             0xFFFF0000L
+
+#endif
-- 
2.25.1

