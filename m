Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D7CCAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD67E10E5F3;
	Thu, 18 Sep 2025 01:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IYj+6Hve";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33DF10E5F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXrgtxOSL66yNS6o3e45ErYjoqklX1wk5FIU0JQN9CyPprSXvibTMaN6hNwYptFmDPu3gkvRsx8Q8cD0KTZQihOX8o6JH4zcQ2GirYsjHkHKLYN+K+UqM6SSSHh5/Oof5eA4twfv7Cg5QsF7X3BRjcy8wd/oeo8AiGweU1pM7rab4g+DBfCOPtLPcT40wYR7jbN6yCPBxyCD+Amj1KezzymeMHQVRp8nYmY6GubuDRsFA3e6vN3u426pvxrrTcdpaEvgxi3e+mEIbv04hmU+1dxywJ5GvQfxy2wY+Llk3nAiU3G0aSR3lFp2R4dzCemyVzfMjeJXFm9FghBArsT7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cadzOALXptvTGNy2kZoBbSUALNmj+lDRS0NjFbc/MVU=;
 b=yFMUU5HCthxd6Qq1op/5uUAFYAhMn/dXBzgkxeBPDygUEONkhGtRQ4ZehK5dzcW5S93izDFUZ5cQ/CkFbTkJFtBu04aFf5Jh/QpGDqUvD4p+QbbhLh/p+f16K+GDtpLeHSq4mLxPtwN9tE9j1KLSKwJOWHC82OQT3Hz7EjNXtaxUXJplEC14jPGGNAGwsqhb7qmTqU/eAl7JqMIqzofIWVzlv5tYvM8lmUU3xeuwX1g5euLdCLDNDEBQudnMBMBCoSrZ09+tegSfQf93h6egQohm1E4LENogLWEXVidBUXHptqbNZYM/iYINjHWkBCloSnVzzRQ6Bxj8esbo6GbW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cadzOALXptvTGNy2kZoBbSUALNmj+lDRS0NjFbc/MVU=;
 b=IYj+6HveU8xcgfBCrq4SjKjZl7A008OX/4mg1Im8FEqoFU2X3MF/n2Aveo9Xm2G3iThOtpaU9u3OjEjOayIakb1p83Nd0Jlv/5wUuSXi1Ur7cimBc94Atc1u9GqurtdDekr7hWMSd7N9vnlIXuU2cwOV93rIwjFt8srsSJh2Hic=
Received: from MW4PR03CA0183.namprd03.prod.outlook.com (2603:10b6:303:b8::8)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 01:33:30 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::d) by MW4PR03CA0183.outlook.office365.com
 (2603:10b6:303:b8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 01:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:29 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:26 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 11/21] drm/amd/ras: Add gfx v9_0 ras functions
Date: Thu, 18 Sep 2025 09:32:22 +0800
Message-ID: <20250918013232.2629215-11-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 99203edb-f08d-4239-90fd-08ddf6535f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kmv5BMeZ+lvcdUO5D6Z56GesRPXOkwIQNP/JZMtQB+p686lOMMlc80xOcpiB?=
 =?us-ascii?Q?t7AwlPC3WFSx76SDozFyCN13Mm329QysQRQpXvpERxKzLCuV7S+8FJ8HqIn9?=
 =?us-ascii?Q?5BUA4W84tvY5/jCju5W6rOqlWB6QmBPS6vJY6No2EnKeNBEGOvK7ZFOVTHNq?=
 =?us-ascii?Q?sz4mg8ms3XLbpopHNgtNVLabJn9M4B3FXgek4sZQk/eJxFcZM6CW3TtsKc9c?=
 =?us-ascii?Q?vGOfdRSCHclc4O3NzNyMAzCKYa/g6XDcSH4pz8CBOaSMeWvYCgeCoRHgJdNN?=
 =?us-ascii?Q?IyjRjFOUdPK8MMCrTIiv8vILO0FvjtaQJreoS79G2Z1D77LzgO7VyA5wCaJM?=
 =?us-ascii?Q?z9QNxh2t5KgRcMIxP4NOju3KjjfN7YzZ7HWzng0UsKFfekrX+u3lbDxmaQS0?=
 =?us-ascii?Q?3FcXUpGFDkPUR+5AJAVwNGbzHvh3o66JYX6/Mu555IChZlbKk8BU8KjRupKN?=
 =?us-ascii?Q?gJQ9GNvpn+fBRVOE4U+U0ndRxAISwwOmvyQQhm+Ob87lFS8T7rZGUmfRlkqw?=
 =?us-ascii?Q?0P7kCbenblwkaFdOhHdG5qKmokQQWnroKMjZsNnTc3Ag2vhFstL4Dxc714Jx?=
 =?us-ascii?Q?yaA2wSF7OsrZKmuTchxd1WeVw6PGftjSPkMwos68YHmWhT+yKjD/WnRvD/pK?=
 =?us-ascii?Q?8h7zH/hOZPyf5Zj8PeFZZpcbdpWZjnWOvbP4HMS53QYnMO5m0P3JbIaK7kjE?=
 =?us-ascii?Q?x+T81AhtngiBGAaU+02uT4lNfQjhqKWnkOqCisdyxN4mY0fY6l/1cd+E5EE4?=
 =?us-ascii?Q?nMS0MhW1Z5x768fVB268z7qoh3yayb2u4D8FXqlnOp8X0jaukAZCafKzdCUS?=
 =?us-ascii?Q?CNjcvM0lm2RnJ34rXJ5GLU8dt1OhLD3ZfPvmbcC4PopDcVelCBDs3iEzSpJU?=
 =?us-ascii?Q?V9z7YmLBALdpoGnSpR6eyW6l6UcGa2BPQguHmEYeWTuWQxPXyXqsBaL4t3Ov?=
 =?us-ascii?Q?8wAKYjXYM8fFEl/C4G2rL6bQ/CZB79SXI08UBvn0L/RbI6gMMLCGOaoUPOBc?=
 =?us-ascii?Q?Cm0QMJqcMdDvp2pE5QX0i+AOXYlOW4cWc8ScaaOLYFijGZDr4VDw8xIGTIWK?=
 =?us-ascii?Q?G9RAJF1hbYfuFRbn5qDx2vkt12EtiWISmveCKA+yN4ZcMeY848FDcY3Wt/TV?=
 =?us-ascii?Q?cKV5j+pKr7J46XVBY3zbJ6i4Ez2NRoYZnmXD7fCmDP5LpF83XLNPp4s6Obh8?=
 =?us-ascii?Q?d84Oiznke7ZmHYv5hgDdmiX33UPpYc9lYqeaK4qeX/0y62sxSldXeONlhhA7?=
 =?us-ascii?Q?Wn6HiHrDShuLekPIQqT/gbwyYWcOH+dJfT+Bl1y9wmnvexBOi9euBxqcnrls?=
 =?us-ascii?Q?e/zc/tL2ggktJoXWbbs9ndZttvpqPth2ZARa6GoMSaP24MZDmJnBZRhRDrc3?=
 =?us-ascii?Q?v8DYFIFpMHaFg9updwLVtDfZSVpTxYq7pHzPxfQpIyRmBt6PtMYIweECsRli?=
 =?us-ascii?Q?WaTVKOzfKG2UG+/iKtEkjS5egknWLol7RCTGiE318QT3jnJ+0AowglH5IDZM?=
 =?us-ascii?Q?s1lg7vaS9z4je31S42EtUURSfs0TxIZWEVK/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:29.2061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99203edb-f08d-4239-90fd-08ddf6535f05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

Add gfx v9_0 ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c    | 426 ++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h    | 259 +++++++++++
 2 files changed, 685 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c
new file mode 100644
index 000000000000..6213d3f125be
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: MIT
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
+#include "ras.h"
+#include "ras_gfx_v9_0.h"
+#include "ras_core_status.h"
+
+enum ta_gfx_v9_subblock {
+	/*CPC*/
+	TA_GFX_V9__GFX_CPC_INDEX_START = 0,
+	TA_GFX_V9__GFX_CPC_SCRATCH = TA_GFX_V9__GFX_CPC_INDEX_START,
+	TA_GFX_V9__GFX_CPC_UCODE,
+	TA_GFX_V9__GFX_DC_STATE_ME1,
+	TA_GFX_V9__GFX_DC_CSINVOC_ME1,
+	TA_GFX_V9__GFX_DC_RESTORE_ME1,
+	TA_GFX_V9__GFX_DC_STATE_ME2,
+	TA_GFX_V9__GFX_DC_CSINVOC_ME2,
+	TA_GFX_V9__GFX_DC_RESTORE_ME2,
+	TA_GFX_V9__GFX_CPC_INDEX_END = TA_GFX_V9__GFX_DC_RESTORE_ME2,
+	/* CPF*/
+	TA_GFX_V9__GFX_CPF_INDEX_START,
+	TA_GFX_V9__GFX_CPF_ROQ_ME2 = TA_GFX_V9__GFX_CPF_INDEX_START,
+	TA_GFX_V9__GFX_CPF_ROQ_ME1,
+	TA_GFX_V9__GFX_CPF_TAG,
+	TA_GFX_V9__GFX_CPF_INDEX_END = TA_GFX_V9__GFX_CPF_TAG,
+	/* CPG*/
+	TA_GFX_V9__GFX_CPG_INDEX_START,
+	TA_GFX_V9__GFX_CPG_DMA_ROQ = TA_GFX_V9__GFX_CPG_INDEX_START,
+	TA_GFX_V9__GFX_CPG_DMA_TAG,
+	TA_GFX_V9__GFX_CPG_TAG,
+	TA_GFX_V9__GFX_CPG_INDEX_END = TA_GFX_V9__GFX_CPG_TAG,
+	/* GDS*/
+	TA_GFX_V9__GFX_GDS_INDEX_START,
+	TA_GFX_V9__GFX_GDS_MEM = TA_GFX_V9__GFX_GDS_INDEX_START,
+	TA_GFX_V9__GFX_GDS_INPUT_QUEUE,
+	TA_GFX_V9__GFX_GDS_OA_PHY_CMD_RAM_MEM,
+	TA_GFX_V9__GFX_GDS_OA_PHY_DATA_RAM_MEM,
+	TA_GFX_V9__GFX_GDS_OA_PIPE_MEM,
+	TA_GFX_V9__GFX_GDS_INDEX_END = TA_GFX_V9__GFX_GDS_OA_PIPE_MEM,
+	/* SPI*/
+	TA_GFX_V9__GFX_SPI_SR_MEM,
+	/* SQ*/
+	TA_GFX_V9__GFX_SQ_INDEX_START,
+	TA_GFX_V9__GFX_SQ_SGPR = TA_GFX_V9__GFX_SQ_INDEX_START,
+	TA_GFX_V9__GFX_SQ_LDS_D,
+	TA_GFX_V9__GFX_SQ_LDS_I,
+	TA_GFX_V9__GFX_SQ_VGPR, /* VGPR = SP*/
+	TA_GFX_V9__GFX_SQ_INDEX_END = TA_GFX_V9__GFX_SQ_VGPR,
+	/* SQC (3 ranges)*/
+	TA_GFX_V9__GFX_SQC_INDEX_START,
+	/* SQC range 0*/
+	TA_GFX_V9__GFX_SQC_INDEX0_START = TA_GFX_V9__GFX_SQC_INDEX_START,
+	TA_GFX_V9__GFX_SQC_INST_UTCL1_LFIFO =
+		TA_GFX_V9__GFX_SQC_INDEX0_START,
+	TA_GFX_V9__GFX_SQC_DATA_CU0_WRITE_DATA_BUF,
+	TA_GFX_V9__GFX_SQC_DATA_CU0_UTCL1_LFIFO,
+	TA_GFX_V9__GFX_SQC_DATA_CU1_WRITE_DATA_BUF,
+	TA_GFX_V9__GFX_SQC_DATA_CU1_UTCL1_LFIFO,
+	TA_GFX_V9__GFX_SQC_DATA_CU2_WRITE_DATA_BUF,
+	TA_GFX_V9__GFX_SQC_DATA_CU2_UTCL1_LFIFO,
+	TA_GFX_V9__GFX_SQC_INDEX0_END =
+		TA_GFX_V9__GFX_SQC_DATA_CU2_UTCL1_LFIFO,
+	/* SQC range 1*/
+	TA_GFX_V9__GFX_SQC_INDEX1_START,
+	TA_GFX_V9__GFX_SQC_INST_BANKA_TAG_RAM =
+		TA_GFX_V9__GFX_SQC_INDEX1_START,
+	TA_GFX_V9__GFX_SQC_INST_BANKA_UTCL1_MISS_FIFO,
+	TA_GFX_V9__GFX_SQC_INST_BANKA_MISS_FIFO,
+	TA_GFX_V9__GFX_SQC_INST_BANKA_BANK_RAM,
+	TA_GFX_V9__GFX_SQC_DATA_BANKA_TAG_RAM,
+	TA_GFX_V9__GFX_SQC_DATA_BANKA_HIT_FIFO,
+	TA_GFX_V9__GFX_SQC_DATA_BANKA_MISS_FIFO,
+	TA_GFX_V9__GFX_SQC_DATA_BANKA_DIRTY_BIT_RAM,
+	TA_GFX_V9__GFX_SQC_DATA_BANKA_BANK_RAM,
+	TA_GFX_V9__GFX_SQC_INDEX1_END =
+		TA_GFX_V9__GFX_SQC_DATA_BANKA_BANK_RAM,
+	/* SQC range 2*/
+	TA_GFX_V9__GFX_SQC_INDEX2_START,
+	TA_GFX_V9__GFX_SQC_INST_BANKB_TAG_RAM =
+		TA_GFX_V9__GFX_SQC_INDEX2_START,
+	TA_GFX_V9__GFX_SQC_INST_BANKB_UTCL1_MISS_FIFO,
+	TA_GFX_V9__GFX_SQC_INST_BANKB_MISS_FIFO,
+	TA_GFX_V9__GFX_SQC_INST_BANKB_BANK_RAM,
+	TA_GFX_V9__GFX_SQC_DATA_BANKB_TAG_RAM,
+	TA_GFX_V9__GFX_SQC_DATA_BANKB_HIT_FIFO,
+	TA_GFX_V9__GFX_SQC_DATA_BANKB_MISS_FIFO,
+	TA_GFX_V9__GFX_SQC_DATA_BANKB_DIRTY_BIT_RAM,
+	TA_GFX_V9__GFX_SQC_DATA_BANKB_BANK_RAM,
+	TA_GFX_V9__GFX_SQC_INDEX2_END =
+		TA_GFX_V9__GFX_SQC_DATA_BANKB_BANK_RAM,
+	TA_GFX_V9__GFX_SQC_INDEX_END = TA_GFX_V9__GFX_SQC_INDEX2_END,
+	/* TA*/
+	TA_GFX_V9__GFX_TA_INDEX_START,
+	TA_GFX_V9__GFX_TA_FS_DFIFO = TA_GFX_V9__GFX_TA_INDEX_START,
+	TA_GFX_V9__GFX_TA_FS_AFIFO,
+	TA_GFX_V9__GFX_TA_FL_LFIFO,
+	TA_GFX_V9__GFX_TA_FX_LFIFO,
+	TA_GFX_V9__GFX_TA_FS_CFIFO,
+	TA_GFX_V9__GFX_TA_INDEX_END = TA_GFX_V9__GFX_TA_FS_CFIFO,
+	/* TCA*/
+	TA_GFX_V9__GFX_TCA_INDEX_START,
+	TA_GFX_V9__GFX_TCA_HOLE_FIFO = TA_GFX_V9__GFX_TCA_INDEX_START,
+	TA_GFX_V9__GFX_TCA_REQ_FIFO,
+	TA_GFX_V9__GFX_TCA_INDEX_END = TA_GFX_V9__GFX_TCA_REQ_FIFO,
+	/* TCC (5 sub-ranges)*/
+	TA_GFX_V9__GFX_TCC_INDEX_START,
+	/* TCC range 0*/
+	TA_GFX_V9__GFX_TCC_INDEX0_START = TA_GFX_V9__GFX_TCC_INDEX_START,
+	TA_GFX_V9__GFX_TCC_CACHE_DATA = TA_GFX_V9__GFX_TCC_INDEX0_START,
+	TA_GFX_V9__GFX_TCC_CACHE_DATA_BANK_0_1,
+	TA_GFX_V9__GFX_TCC_CACHE_DATA_BANK_1_0,
+	TA_GFX_V9__GFX_TCC_CACHE_DATA_BANK_1_1,
+	TA_GFX_V9__GFX_TCC_CACHE_DIRTY_BANK_0,
+	TA_GFX_V9__GFX_TCC_CACHE_DIRTY_BANK_1,
+	TA_GFX_V9__GFX_TCC_HIGH_RATE_TAG,
+	TA_GFX_V9__GFX_TCC_LOW_RATE_TAG,
+	TA_GFX_V9__GFX_TCC_INDEX0_END = TA_GFX_V9__GFX_TCC_LOW_RATE_TAG,
+	/* TCC range 1*/
+	TA_GFX_V9__GFX_TCC_INDEX1_START,
+	TA_GFX_V9__GFX_TCC_IN_USE_DEC = TA_GFX_V9__GFX_TCC_INDEX1_START,
+	TA_GFX_V9__GFX_TCC_IN_USE_TRANSFER,
+	TA_GFX_V9__GFX_TCC_INDEX1_END =
+		TA_GFX_V9__GFX_TCC_IN_USE_TRANSFER,
+	/* TCC range 2*/
+	TA_GFX_V9__GFX_TCC_INDEX2_START,
+	TA_GFX_V9__GFX_TCC_RETURN_DATA = TA_GFX_V9__GFX_TCC_INDEX2_START,
+	TA_GFX_V9__GFX_TCC_RETURN_CONTROL,
+	TA_GFX_V9__GFX_TCC_UC_ATOMIC_FIFO,
+	TA_GFX_V9__GFX_TCC_WRITE_RETURN,
+	TA_GFX_V9__GFX_TCC_WRITE_CACHE_READ,
+	TA_GFX_V9__GFX_TCC_SRC_FIFO,
+	TA_GFX_V9__GFX_TCC_SRC_FIFO_NEXT_RAM,
+	TA_GFX_V9__GFX_TCC_CACHE_TAG_PROBE_FIFO,
+	TA_GFX_V9__GFX_TCC_INDEX2_END =
+		TA_GFX_V9__GFX_TCC_CACHE_TAG_PROBE_FIFO,
+	/* TCC range 3*/
+	TA_GFX_V9__GFX_TCC_INDEX3_START,
+	TA_GFX_V9__GFX_TCC_LATENCY_FIFO = TA_GFX_V9__GFX_TCC_INDEX3_START,
+	TA_GFX_V9__GFX_TCC_LATENCY_FIFO_NEXT_RAM,
+	TA_GFX_V9__GFX_TCC_INDEX3_END =
+		TA_GFX_V9__GFX_TCC_LATENCY_FIFO_NEXT_RAM,
+	/* TCC range 4*/
+	TA_GFX_V9__GFX_TCC_INDEX4_START,
+	TA_GFX_V9__GFX_TCC_WRRET_TAG_WRITE_RETURN =
+		TA_GFX_V9__GFX_TCC_INDEX4_START,
+	TA_GFX_V9__GFX_TCC_ATOMIC_RETURN_BUFFER,
+	TA_GFX_V9__GFX_TCC_INDEX4_END =
+		TA_GFX_V9__GFX_TCC_ATOMIC_RETURN_BUFFER,
+	TA_GFX_V9__GFX_TCC_INDEX_END = TA_GFX_V9__GFX_TCC_INDEX4_END,
+	/* TCI*/
+	TA_GFX_V9__GFX_TCI_WRITE_RAM,
+	/* TCP*/
+	TA_GFX_V9__GFX_TCP_INDEX_START,
+	TA_GFX_V9__GFX_TCP_CACHE_RAM = TA_GFX_V9__GFX_TCP_INDEX_START,
+	TA_GFX_V9__GFX_TCP_LFIFO_RAM,
+	TA_GFX_V9__GFX_TCP_CMD_FIFO,
+	TA_GFX_V9__GFX_TCP_VM_FIFO,
+	TA_GFX_V9__GFX_TCP_DB_RAM,
+	TA_GFX_V9__GFX_TCP_UTCL1_LFIFO0,
+	TA_GFX_V9__GFX_TCP_UTCL1_LFIFO1,
+	TA_GFX_V9__GFX_TCP_INDEX_END = TA_GFX_V9__GFX_TCP_UTCL1_LFIFO1,
+	/* TD*/
+	TA_GFX_V9__GFX_TD_INDEX_START,
+	TA_GFX_V9__GFX_TD_SS_FIFO_LO = TA_GFX_V9__GFX_TD_INDEX_START,
+	TA_GFX_V9__GFX_TD_SS_FIFO_HI,
+	TA_GFX_V9__GFX_TD_CS_FIFO,
+	TA_GFX_V9__GFX_TD_INDEX_END = TA_GFX_V9__GFX_TD_CS_FIFO,
+	/* EA (3 sub-ranges)*/
+	TA_GFX_V9__GFX_EA_INDEX_START,
+	/* EA range 0*/
+	TA_GFX_V9__GFX_EA_INDEX0_START = TA_GFX_V9__GFX_EA_INDEX_START,
+	TA_GFX_V9__GFX_EA_DRAMRD_CMDMEM = TA_GFX_V9__GFX_EA_INDEX0_START,
+	TA_GFX_V9__GFX_EA_DRAMWR_CMDMEM,
+	TA_GFX_V9__GFX_EA_DRAMWR_DATAMEM,
+	TA_GFX_V9__GFX_EA_RRET_TAGMEM,
+	TA_GFX_V9__GFX_EA_WRET_TAGMEM,
+	TA_GFX_V9__GFX_EA_GMIRD_CMDMEM,
+	TA_GFX_V9__GFX_EA_GMIWR_CMDMEM,
+	TA_GFX_V9__GFX_EA_GMIWR_DATAMEM,
+	TA_GFX_V9__GFX_EA_INDEX0_END = TA_GFX_V9__GFX_EA_GMIWR_DATAMEM,
+	/* EA range 1*/
+	TA_GFX_V9__GFX_EA_INDEX1_START,
+	TA_GFX_V9__GFX_EA_DRAMRD_PAGEMEM = TA_GFX_V9__GFX_EA_INDEX1_START,
+	TA_GFX_V9__GFX_EA_DRAMWR_PAGEMEM,
+	TA_GFX_V9__GFX_EA_IORD_CMDMEM,
+	TA_GFX_V9__GFX_EA_IOWR_CMDMEM,
+	TA_GFX_V9__GFX_EA_IOWR_DATAMEM,
+	TA_GFX_V9__GFX_EA_GMIRD_PAGEMEM,
+	TA_GFX_V9__GFX_EA_GMIWR_PAGEMEM,
+	TA_GFX_V9__GFX_EA_INDEX1_END = TA_GFX_V9__GFX_EA_GMIWR_PAGEMEM,
+	/* EA range 2*/
+	TA_GFX_V9__GFX_EA_INDEX2_START,
+	TA_GFX_V9__GFX_EA_MAM_D0MEM = TA_GFX_V9__GFX_EA_INDEX2_START,
+	TA_GFX_V9__GFX_EA_MAM_D1MEM,
+	TA_GFX_V9__GFX_EA_MAM_D2MEM,
+	TA_GFX_V9__GFX_EA_MAM_D3MEM,
+	TA_GFX_V9__GFX_EA_INDEX2_END = TA_GFX_V9__GFX_EA_MAM_D3MEM,
+	TA_GFX_V9__GFX_EA_INDEX_END = TA_GFX_V9__GFX_EA_INDEX2_END,
+	/* UTC VM L2 bank*/
+	TA_GFX_V9__UTC_VML2_BANK_CACHE,
+	/* UTC VM walker*/
+	TA_GFX_V9__UTC_VML2_WALKER,
+	/* UTC ATC L2 2MB cache*/
+	TA_GFX_V9__UTC_ATCL2_CACHE_2M_BANK,
+	/* UTC ATC L2 4KB cache*/
+	TA_GFX_V9__UTC_ATCL2_CACHE_4K_BANK,
+	TA_GFX_V9__GFX_MAX
+};
+
+struct ras_gfx_subblock_t {
+	unsigned char *name;
+	int ta_subblock;
+	int hw_supported_error_type;
+	int sw_supported_error_type;
+};
+
+#define RAS_GFX_SUB_BLOCK(subblock, a, b, c, d, e, f, g, h)                             \
+	[RAS_GFX_V9__##subblock] = {                                     \
+		#subblock,                                                     \
+		TA_GFX_V9__##subblock,                                      \
+		((a) | ((b) << 1) | ((c) << 2) | ((d) << 3)),                  \
+		(((e) << 1) | ((f) << 3) | (g) | ((h) << 2)),                  \
+	}
+
+const struct ras_gfx_subblock_t ras_gfx_v9_0_subblocks[] = {
+	RAS_GFX_SUB_BLOCK(GFX_CPC_SCRATCH, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_CPC_UCODE, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_DC_STATE_ME1, 1, 0, 0, 1, 0, 0, 1, 0),
+	RAS_GFX_SUB_BLOCK(GFX_DC_CSINVOC_ME1, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_DC_RESTORE_ME1, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_DC_STATE_ME2, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_DC_CSINVOC_ME2, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_DC_RESTORE_ME2, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_CPF_ROQ_ME2, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_CPF_ROQ_ME1, 1, 0, 0, 1, 0, 0, 1, 0),
+	RAS_GFX_SUB_BLOCK(GFX_CPF_TAG, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_CPG_DMA_ROQ, 1, 0, 0, 1, 0, 0, 1, 0),
+	RAS_GFX_SUB_BLOCK(GFX_CPG_DMA_TAG, 0, 1, 1, 1, 0, 1, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_CPG_TAG, 0, 1, 1, 1, 1, 1, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_GDS_MEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_GDS_INPUT_QUEUE, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_GDS_OA_PHY_CMD_RAM_MEM, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_GDS_OA_PHY_DATA_RAM_MEM, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_GDS_OA_PIPE_MEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SPI_SR_MEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQ_SGPR, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQ_LDS_D, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_SQ_LDS_I, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQ_VGPR, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_UTCL1_LFIFO, 0, 1, 1, 1, 0, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_CU0_WRITE_DATA_BUF, 0, 1, 1, 1, 0, 0,
+			     0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_CU0_UTCL1_LFIFO, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_CU1_WRITE_DATA_BUF, 0, 1, 1, 1, 0, 0,
+			     0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_CU1_UTCL1_LFIFO, 0, 1, 1, 1, 1, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_CU2_WRITE_DATA_BUF, 0, 1, 1, 1, 0, 0,
+			     0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_CU2_UTCL1_LFIFO, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_BANKA_TAG_RAM, 0, 1, 1, 1, 1, 0, 0,
+			     1),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_BANKA_UTCL1_MISS_FIFO, 1, 0, 0, 1, 0,
+			     0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_BANKA_MISS_FIFO, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_BANKA_BANK_RAM, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKA_TAG_RAM, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKA_HIT_FIFO, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKA_MISS_FIFO, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKA_DIRTY_BIT_RAM, 1, 0, 0, 1, 0, 0,
+			     0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKA_BANK_RAM, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_BANKB_TAG_RAM, 0, 1, 1, 1, 1, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_BANKB_UTCL1_MISS_FIFO, 1, 0, 0, 1, 0,
+			     0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_BANKB_MISS_FIFO, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_INST_BANKB_BANK_RAM, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKB_TAG_RAM, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKB_HIT_FIFO, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKB_MISS_FIFO, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKB_DIRTY_BIT_RAM, 1, 0, 0, 1, 0, 0,
+			     0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_SQC_DATA_BANKB_BANK_RAM, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_TA_FS_DFIFO, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_TA_FS_AFIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TA_FL_LFIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TA_FX_LFIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TA_FS_CFIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCA_HOLE_FIFO, 1, 0, 0, 1, 0, 1, 1, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCA_REQ_FIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_CACHE_DATA, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_CACHE_DATA_BANK_0_1, 0, 1, 1, 1, 1, 0, 0,
+			     1),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_CACHE_DATA_BANK_1_0, 0, 1, 1, 1, 1, 0, 0,
+			     1),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_CACHE_DATA_BANK_1_1, 0, 1, 1, 1, 1, 0, 0,
+			     1),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_CACHE_DIRTY_BANK_0, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_CACHE_DIRTY_BANK_1, 0, 1, 1, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_HIGH_RATE_TAG, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_LOW_RATE_TAG, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_IN_USE_DEC, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_IN_USE_TRANSFER, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_RETURN_DATA, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_RETURN_CONTROL, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_UC_ATOMIC_FIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_WRITE_RETURN, 1, 0, 0, 1, 0, 1, 1, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_WRITE_CACHE_READ, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_SRC_FIFO, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_SRC_FIFO_NEXT_RAM, 1, 0, 0, 1, 0, 0, 1, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_CACHE_TAG_PROBE_FIFO, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_LATENCY_FIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_LATENCY_FIFO_NEXT_RAM, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_WRRET_TAG_WRITE_RETURN, 1, 0, 0, 1, 0, 0,
+			     0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCC_ATOMIC_RETURN_BUFFER, 1, 0, 0, 1, 0, 0, 0,
+			     0),
+	RAS_GFX_SUB_BLOCK(GFX_TCI_WRITE_RAM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCP_CACHE_RAM, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_TCP_LFIFO_RAM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCP_CMD_FIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCP_VM_FIFO, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCP_DB_RAM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCP_UTCL1_LFIFO0, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TCP_UTCL1_LFIFO1, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TD_SS_FIFO_LO, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_TD_SS_FIFO_HI, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_TD_CS_FIFO, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_DRAMRD_CMDMEM, 0, 1, 1, 1, 1, 0, 0, 1),
+	RAS_GFX_SUB_BLOCK(GFX_EA_DRAMWR_CMDMEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_DRAMWR_DATAMEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_RRET_TAGMEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_WRET_TAGMEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_GMIRD_CMDMEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_GMIWR_CMDMEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_GMIWR_DATAMEM, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_DRAMRD_PAGEMEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_DRAMWR_PAGEMEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_IORD_CMDMEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_IOWR_CMDMEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_IOWR_DATAMEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_GMIRD_PAGEMEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_GMIWR_PAGEMEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_MAM_D0MEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_MAM_D1MEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_MAM_D2MEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(GFX_EA_MAM_D3MEM, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(UTC_VML2_BANK_CACHE, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(UTC_VML2_WALKER, 0, 1, 1, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(UTC_ATCL2_CACHE_2M_BANK, 1, 0, 0, 1, 0, 0, 0, 0),
+	RAS_GFX_SUB_BLOCK(UTC_ATCL2_CACHE_4K_BANK, 0, 1, 1, 1, 0, 0, 0, 0),
+};
+
+static int gfx_v9_0_get_ta_subblock(struct ras_core_context *ras_core,
+			uint32_t error_type, uint32_t subblock, uint32_t *ta_subblock)
+{
+	const struct ras_gfx_subblock_t *gfx_subblock;
+
+	if (subblock >= ARRAY_SIZE(ras_gfx_v9_0_subblocks))
+		return -EINVAL;
+
+	gfx_subblock = &ras_gfx_v9_0_subblocks[subblock];
+	if (!gfx_subblock->name)
+		return -EPERM;
+
+	if (!(gfx_subblock->hw_supported_error_type & error_type)) {
+		RAS_DEV_ERR(ras_core->dev, "GFX Subblock %s, hardware do not support type 0x%x\n",
+			gfx_subblock->name, error_type);
+		return -EPERM;
+	}
+
+	if (!(gfx_subblock->sw_supported_error_type & error_type)) {
+		RAS_DEV_ERR(ras_core->dev, "GFX Subblock %s, driver do not support type 0x%x\n",
+			gfx_subblock->name, error_type);
+		return -EPERM;
+	}
+
+	*ta_subblock = gfx_subblock->ta_subblock;
+
+	return 0;
+}
+
+const struct ras_gfx_ip_func gfx_ras_func_v9_0 = {
+	.get_ta_subblock = gfx_v9_0_get_ta_subblock,
+};
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h
new file mode 100644
index 000000000000..659b56619747
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __RAS_GFX_V9_0_H__
+#define __RAS_GFX_V9_0_H__
+
+enum ras_gfx_v9_subblock {
+	/* CPC */
+	RAS_GFX_V9__GFX_CPC_INDEX_START = 0,
+	RAS_GFX_V9__GFX_CPC_SCRATCH =
+		RAS_GFX_V9__GFX_CPC_INDEX_START,
+	RAS_GFX_V9__GFX_CPC_UCODE,
+	RAS_GFX_V9__GFX_DC_STATE_ME1,
+	RAS_GFX_V9__GFX_DC_CSINVOC_ME1,
+	RAS_GFX_V9__GFX_DC_RESTORE_ME1,
+	RAS_GFX_V9__GFX_DC_STATE_ME2,
+	RAS_GFX_V9__GFX_DC_CSINVOC_ME2,
+	RAS_GFX_V9__GFX_DC_RESTORE_ME2,
+	RAS_GFX_V9__GFX_CPC_INDEX_END =
+		RAS_GFX_V9__GFX_DC_RESTORE_ME2,
+	/* CPF */
+	RAS_GFX_V9__GFX_CPF_INDEX_START,
+	RAS_GFX_V9__GFX_CPF_ROQ_ME2 =
+		RAS_GFX_V9__GFX_CPF_INDEX_START,
+	RAS_GFX_V9__GFX_CPF_ROQ_ME1,
+	RAS_GFX_V9__GFX_CPF_TAG,
+	RAS_GFX_V9__GFX_CPF_INDEX_END = RAS_GFX_V9__GFX_CPF_TAG,
+	/* CPG */
+	RAS_GFX_V9__GFX_CPG_INDEX_START,
+	RAS_GFX_V9__GFX_CPG_DMA_ROQ =
+		RAS_GFX_V9__GFX_CPG_INDEX_START,
+	RAS_GFX_V9__GFX_CPG_DMA_TAG,
+	RAS_GFX_V9__GFX_CPG_TAG,
+	RAS_GFX_V9__GFX_CPG_INDEX_END = RAS_GFX_V9__GFX_CPG_TAG,
+	/* GDS */
+	RAS_GFX_V9__GFX_GDS_INDEX_START,
+	RAS_GFX_V9__GFX_GDS_MEM = RAS_GFX_V9__GFX_GDS_INDEX_START,
+	RAS_GFX_V9__GFX_GDS_INPUT_QUEUE,
+	RAS_GFX_V9__GFX_GDS_OA_PHY_CMD_RAM_MEM,
+	RAS_GFX_V9__GFX_GDS_OA_PHY_DATA_RAM_MEM,
+	RAS_GFX_V9__GFX_GDS_OA_PIPE_MEM,
+	RAS_GFX_V9__GFX_GDS_INDEX_END =
+		RAS_GFX_V9__GFX_GDS_OA_PIPE_MEM,
+	/* SPI */
+	RAS_GFX_V9__GFX_SPI_SR_MEM,
+	/* SQ */
+	RAS_GFX_V9__GFX_SQ_INDEX_START,
+	RAS_GFX_V9__GFX_SQ_SGPR = RAS_GFX_V9__GFX_SQ_INDEX_START,
+	RAS_GFX_V9__GFX_SQ_LDS_D,
+	RAS_GFX_V9__GFX_SQ_LDS_I,
+	RAS_GFX_V9__GFX_SQ_VGPR,
+	RAS_GFX_V9__GFX_SQ_INDEX_END = RAS_GFX_V9__GFX_SQ_VGPR,
+	/* SQC (3 ranges) */
+	RAS_GFX_V9__GFX_SQC_INDEX_START,
+	/* SQC range 0 */
+	RAS_GFX_V9__GFX_SQC_INDEX0_START =
+		RAS_GFX_V9__GFX_SQC_INDEX_START,
+	RAS_GFX_V9__GFX_SQC_INST_UTCL1_LFIFO =
+		RAS_GFX_V9__GFX_SQC_INDEX0_START,
+	RAS_GFX_V9__GFX_SQC_DATA_CU0_WRITE_DATA_BUF,
+	RAS_GFX_V9__GFX_SQC_DATA_CU0_UTCL1_LFIFO,
+	RAS_GFX_V9__GFX_SQC_DATA_CU1_WRITE_DATA_BUF,
+	RAS_GFX_V9__GFX_SQC_DATA_CU1_UTCL1_LFIFO,
+	RAS_GFX_V9__GFX_SQC_DATA_CU2_WRITE_DATA_BUF,
+	RAS_GFX_V9__GFX_SQC_DATA_CU2_UTCL1_LFIFO,
+	RAS_GFX_V9__GFX_SQC_INDEX0_END =
+		RAS_GFX_V9__GFX_SQC_DATA_CU2_UTCL1_LFIFO,
+	/* SQC range 1 */
+	RAS_GFX_V9__GFX_SQC_INDEX1_START,
+	RAS_GFX_V9__GFX_SQC_INST_BANKA_TAG_RAM =
+		RAS_GFX_V9__GFX_SQC_INDEX1_START,
+	RAS_GFX_V9__GFX_SQC_INST_BANKA_UTCL1_MISS_FIFO,
+	RAS_GFX_V9__GFX_SQC_INST_BANKA_MISS_FIFO,
+	RAS_GFX_V9__GFX_SQC_INST_BANKA_BANK_RAM,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKA_TAG_RAM,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKA_HIT_FIFO,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKA_MISS_FIFO,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKA_DIRTY_BIT_RAM,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKA_BANK_RAM,
+	RAS_GFX_V9__GFX_SQC_INDEX1_END =
+		RAS_GFX_V9__GFX_SQC_DATA_BANKA_BANK_RAM,
+	/* SQC range 2 */
+	RAS_GFX_V9__GFX_SQC_INDEX2_START,
+	RAS_GFX_V9__GFX_SQC_INST_BANKB_TAG_RAM =
+		RAS_GFX_V9__GFX_SQC_INDEX2_START,
+	RAS_GFX_V9__GFX_SQC_INST_BANKB_UTCL1_MISS_FIFO,
+	RAS_GFX_V9__GFX_SQC_INST_BANKB_MISS_FIFO,
+	RAS_GFX_V9__GFX_SQC_INST_BANKB_BANK_RAM,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKB_TAG_RAM,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKB_HIT_FIFO,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKB_MISS_FIFO,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKB_DIRTY_BIT_RAM,
+	RAS_GFX_V9__GFX_SQC_DATA_BANKB_BANK_RAM,
+	RAS_GFX_V9__GFX_SQC_INDEX2_END =
+		RAS_GFX_V9__GFX_SQC_DATA_BANKB_BANK_RAM,
+	RAS_GFX_V9__GFX_SQC_INDEX_END =
+		RAS_GFX_V9__GFX_SQC_INDEX2_END,
+	/* TA */
+	RAS_GFX_V9__GFX_TA_INDEX_START,
+	RAS_GFX_V9__GFX_TA_FS_DFIFO =
+		RAS_GFX_V9__GFX_TA_INDEX_START,
+	RAS_GFX_V9__GFX_TA_FS_AFIFO,
+	RAS_GFX_V9__GFX_TA_FL_LFIFO,
+	RAS_GFX_V9__GFX_TA_FX_LFIFO,
+	RAS_GFX_V9__GFX_TA_FS_CFIFO,
+	RAS_GFX_V9__GFX_TA_INDEX_END = RAS_GFX_V9__GFX_TA_FS_CFIFO,
+	/* TCA */
+	RAS_GFX_V9__GFX_TCA_INDEX_START,
+	RAS_GFX_V9__GFX_TCA_HOLE_FIFO =
+		RAS_GFX_V9__GFX_TCA_INDEX_START,
+	RAS_GFX_V9__GFX_TCA_REQ_FIFO,
+	RAS_GFX_V9__GFX_TCA_INDEX_END =
+		RAS_GFX_V9__GFX_TCA_REQ_FIFO,
+	/* TCC (5 sub-ranges) */
+	RAS_GFX_V9__GFX_TCC_INDEX_START,
+	/* TCC range 0 */
+	RAS_GFX_V9__GFX_TCC_INDEX0_START =
+		RAS_GFX_V9__GFX_TCC_INDEX_START,
+	RAS_GFX_V9__GFX_TCC_CACHE_DATA =
+		RAS_GFX_V9__GFX_TCC_INDEX0_START,
+	RAS_GFX_V9__GFX_TCC_CACHE_DATA_BANK_0_1,
+	RAS_GFX_V9__GFX_TCC_CACHE_DATA_BANK_1_0,
+	RAS_GFX_V9__GFX_TCC_CACHE_DATA_BANK_1_1,
+	RAS_GFX_V9__GFX_TCC_CACHE_DIRTY_BANK_0,
+	RAS_GFX_V9__GFX_TCC_CACHE_DIRTY_BANK_1,
+	RAS_GFX_V9__GFX_TCC_HIGH_RATE_TAG,
+	RAS_GFX_V9__GFX_TCC_LOW_RATE_TAG,
+	RAS_GFX_V9__GFX_TCC_INDEX0_END =
+		RAS_GFX_V9__GFX_TCC_LOW_RATE_TAG,
+	/* TCC range 1 */
+	RAS_GFX_V9__GFX_TCC_INDEX1_START,
+	RAS_GFX_V9__GFX_TCC_IN_USE_DEC =
+		RAS_GFX_V9__GFX_TCC_INDEX1_START,
+	RAS_GFX_V9__GFX_TCC_IN_USE_TRANSFER,
+	RAS_GFX_V9__GFX_TCC_INDEX1_END =
+		RAS_GFX_V9__GFX_TCC_IN_USE_TRANSFER,
+	/* TCC range 2 */
+	RAS_GFX_V9__GFX_TCC_INDEX2_START,
+	RAS_GFX_V9__GFX_TCC_RETURN_DATA =
+		RAS_GFX_V9__GFX_TCC_INDEX2_START,
+	RAS_GFX_V9__GFX_TCC_RETURN_CONTROL,
+	RAS_GFX_V9__GFX_TCC_UC_ATOMIC_FIFO,
+	RAS_GFX_V9__GFX_TCC_WRITE_RETURN,
+	RAS_GFX_V9__GFX_TCC_WRITE_CACHE_READ,
+	RAS_GFX_V9__GFX_TCC_SRC_FIFO,
+	RAS_GFX_V9__GFX_TCC_SRC_FIFO_NEXT_RAM,
+	RAS_GFX_V9__GFX_TCC_CACHE_TAG_PROBE_FIFO,
+	RAS_GFX_V9__GFX_TCC_INDEX2_END =
+		RAS_GFX_V9__GFX_TCC_CACHE_TAG_PROBE_FIFO,
+	/* TCC range 3 */
+	RAS_GFX_V9__GFX_TCC_INDEX3_START,
+	RAS_GFX_V9__GFX_TCC_LATENCY_FIFO =
+		RAS_GFX_V9__GFX_TCC_INDEX3_START,
+	RAS_GFX_V9__GFX_TCC_LATENCY_FIFO_NEXT_RAM,
+	RAS_GFX_V9__GFX_TCC_INDEX3_END =
+		RAS_GFX_V9__GFX_TCC_LATENCY_FIFO_NEXT_RAM,
+	/* TCC range 4 */
+	RAS_GFX_V9__GFX_TCC_INDEX4_START,
+	RAS_GFX_V9__GFX_TCC_WRRET_TAG_WRITE_RETURN =
+		RAS_GFX_V9__GFX_TCC_INDEX4_START,
+	RAS_GFX_V9__GFX_TCC_ATOMIC_RETURN_BUFFER,
+	RAS_GFX_V9__GFX_TCC_INDEX4_END =
+		RAS_GFX_V9__GFX_TCC_ATOMIC_RETURN_BUFFER,
+	RAS_GFX_V9__GFX_TCC_INDEX_END =
+		RAS_GFX_V9__GFX_TCC_INDEX4_END,
+	/* TCI */
+	RAS_GFX_V9__GFX_TCI_WRITE_RAM,
+	/* TCP */
+	RAS_GFX_V9__GFX_TCP_INDEX_START,
+	RAS_GFX_V9__GFX_TCP_CACHE_RAM =
+		RAS_GFX_V9__GFX_TCP_INDEX_START,
+	RAS_GFX_V9__GFX_TCP_LFIFO_RAM,
+	RAS_GFX_V9__GFX_TCP_CMD_FIFO,
+	RAS_GFX_V9__GFX_TCP_VM_FIFO,
+	RAS_GFX_V9__GFX_TCP_DB_RAM,
+	RAS_GFX_V9__GFX_TCP_UTCL1_LFIFO0,
+	RAS_GFX_V9__GFX_TCP_UTCL1_LFIFO1,
+	RAS_GFX_V9__GFX_TCP_INDEX_END =
+		RAS_GFX_V9__GFX_TCP_UTCL1_LFIFO1,
+	/* TD */
+	RAS_GFX_V9__GFX_TD_INDEX_START,
+	RAS_GFX_V9__GFX_TD_SS_FIFO_LO =
+		RAS_GFX_V9__GFX_TD_INDEX_START,
+	RAS_GFX_V9__GFX_TD_SS_FIFO_HI,
+	RAS_GFX_V9__GFX_TD_CS_FIFO,
+	RAS_GFX_V9__GFX_TD_INDEX_END = RAS_GFX_V9__GFX_TD_CS_FIFO,
+	/* EA (3 sub-ranges) */
+	RAS_GFX_V9__GFX_EA_INDEX_START,
+	/* EA range 0 */
+	RAS_GFX_V9__GFX_EA_INDEX0_START =
+		RAS_GFX_V9__GFX_EA_INDEX_START,
+	RAS_GFX_V9__GFX_EA_DRAMRD_CMDMEM =
+		RAS_GFX_V9__GFX_EA_INDEX0_START,
+	RAS_GFX_V9__GFX_EA_DRAMWR_CMDMEM,
+	RAS_GFX_V9__GFX_EA_DRAMWR_DATAMEM,
+	RAS_GFX_V9__GFX_EA_RRET_TAGMEM,
+	RAS_GFX_V9__GFX_EA_WRET_TAGMEM,
+	RAS_GFX_V9__GFX_EA_GMIRD_CMDMEM,
+	RAS_GFX_V9__GFX_EA_GMIWR_CMDMEM,
+	RAS_GFX_V9__GFX_EA_GMIWR_DATAMEM,
+	RAS_GFX_V9__GFX_EA_INDEX0_END =
+		RAS_GFX_V9__GFX_EA_GMIWR_DATAMEM,
+	/* EA range 1 */
+	RAS_GFX_V9__GFX_EA_INDEX1_START,
+	RAS_GFX_V9__GFX_EA_DRAMRD_PAGEMEM =
+		RAS_GFX_V9__GFX_EA_INDEX1_START,
+	RAS_GFX_V9__GFX_EA_DRAMWR_PAGEMEM,
+	RAS_GFX_V9__GFX_EA_IORD_CMDMEM,
+	RAS_GFX_V9__GFX_EA_IOWR_CMDMEM,
+	RAS_GFX_V9__GFX_EA_IOWR_DATAMEM,
+	RAS_GFX_V9__GFX_EA_GMIRD_PAGEMEM,
+	RAS_GFX_V9__GFX_EA_GMIWR_PAGEMEM,
+	RAS_GFX_V9__GFX_EA_INDEX1_END =
+		RAS_GFX_V9__GFX_EA_GMIWR_PAGEMEM,
+	/* EA range 2 */
+	RAS_GFX_V9__GFX_EA_INDEX2_START,
+	RAS_GFX_V9__GFX_EA_MAM_D0MEM =
+		RAS_GFX_V9__GFX_EA_INDEX2_START,
+	RAS_GFX_V9__GFX_EA_MAM_D1MEM,
+	RAS_GFX_V9__GFX_EA_MAM_D2MEM,
+	RAS_GFX_V9__GFX_EA_MAM_D3MEM,
+	RAS_GFX_V9__GFX_EA_INDEX2_END =
+		RAS_GFX_V9__GFX_EA_MAM_D3MEM,
+	RAS_GFX_V9__GFX_EA_INDEX_END =
+		RAS_GFX_V9__GFX_EA_INDEX2_END,
+	/* UTC VM L2 bank */
+	RAS_GFX_V9__UTC_VML2_BANK_CACHE,
+	/* UTC VM walker */
+	RAS_GFX_V9__UTC_VML2_WALKER,
+	/* UTC ATC L2 2MB cache */
+	RAS_GFX_V9__UTC_ATCL2_CACHE_2M_BANK,
+	/* UTC ATC L2 4KB cache */
+	RAS_GFX_V9__UTC_ATCL2_CACHE_4K_BANK,
+	RAS_GFX_V9__GFX_MAX
+};
+
+extern const struct ras_gfx_ip_func gfx_ras_func_v9_0;
+
+#endif
-- 
2.34.1

