Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3104CCAC5AA
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C816710E381;
	Mon, 22 Sep 2025 02:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukCb6P7t";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013049.outbound.protection.outlook.com
 [40.93.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55ED810E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slleSTJOD2O8IsBo/pIcICrPEtIDkjdJpCAsAxiL92R2yDzB/KTt+5hyjOoIup9q2BnOb38T60dZpbS9RLYbduXHX+rQKqn9+oORsMzxDK3C84dnqU8uvP0VZucncslYssl6atzVQnBAmDFtIhYGQfRlOJ9vCjioQYIZLR+r6gnK8SgoN08+lqNY7BU6J59QgbHPUaZzi8/IcKK4CzzGzI/V4IfqxZoAKB+xIah10W/iQidWW2fxiApFfNKJkwWd3kKBwWv+yZ8SrMGTvb4U8NcCrCORzpDg448leAmNaSi1kWH2Fn5kqdXpaUfeeziLyoi+Uof21v+WyutUgq6hKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V08bINl9ILhQ/uiP8OV65JK7GAXvAv2jTHZvjFwQnPY=;
 b=jYYyJ1bT4L2Fo08Km68G/S/Anj/Pd9C3LEEWb/SmnHoON4R8fFu60BGh7HrywtedKL+aj51BdcMyZX5O1PWPP+gJQss9nFU7OmazEWjBaU4xuW2n77VvMY257BtQDeZJZ4WSk5CEOcqhq0VtraFW1HBSN7/bbmbiuDCa/R8Jr0xhX2BnZk02qBtu4ceP3kIFP2DoOlQzpkGmVsXjjQ6wY6iTWvOSLPJoygd4HeNwXoYTsv9LC6MPkyrMOGFNCs+wjV0IR/aUcPuSWgDmBFe9QQ4cgqdx/2L7DACiwju2eIiIwG7nNftOZ51uNdvq+vtm2i+75+07IkyqqxhAkKExaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V08bINl9ILhQ/uiP8OV65JK7GAXvAv2jTHZvjFwQnPY=;
 b=ukCb6P7tFEPskIcGhP1EjKC9LNjSB4xR9bo2aft3JgrA8RT6wTbdcseYGX2TTE81yD6VX63qCFCLvMq3GwLWYf7vOYzkjASQ+CFVV+2XtQZDDrwddHwV93jHQV23T40z1Kq5SIQTBn0X9Y+fi5NSykT8g/Uzz5JfPs1nIiuIA2o=
Received: from BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15) by
 SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:43 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::52) by BYAPR01CA0038.outlook.office365.com
 (2603:10b6:a03:94::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 02:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:43 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:40 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 10/20] drm/amd/ras: Add gfx v9_0 ras functions
Date: Mon, 22 Sep 2025 10:38:34 +0800
Message-ID: <20250922023844.3108065-10-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
References: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 88287e3e-fff3-4040-a506-08ddf981493e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N45FhUpXrEooyq6yW/X86xBM0zNpNSVSoIRiU4ilXjzdHRVoXQhn8YZFXh/j?=
 =?us-ascii?Q?289GfNDV07DjJE19H0/b0NYOuwDbI/sRusVVRVxDRXeTGwKeiN4AZtNFnkjV?=
 =?us-ascii?Q?yjDsKjpVvmvs7UOEXtMg5rdR3Imk0m+fi6tXzN57aHIFbEiBHO5SDsXJfDFU?=
 =?us-ascii?Q?YWT9Y5y8kLd6ZR49G0ZeFn3S+Nc5VQegyWk7QDTiialVBLR7onsDgoCCQSEF?=
 =?us-ascii?Q?atBdMHSkgFIkcRIyvcfpjThy0lClT0e0Ap+TruW6h1eQlfwyTJaziqaOvoIF?=
 =?us-ascii?Q?Tfd2Hw6JVuFT1BYUbFP4xnDtSDOj1W7fzpeqqNssabXoFk9v0HC6MEKhkWgQ?=
 =?us-ascii?Q?gZOiajixUMYUlj3EEWsUEKMh0SsddOPL7sEIF/16pGlqSaOT+8YmQVmqSDMd?=
 =?us-ascii?Q?wvALDBp+7Gcu54AHPsZREWw7isXbVyWl9juvzTSlhZOyfFHBrVFxro/9A+l/?=
 =?us-ascii?Q?HrQjku1OHXmmU8/FNGU/rPClriT1P1J68Whms8Kvu16cf+p9irWedk3J922d?=
 =?us-ascii?Q?fJNpw94rjh4XI1Bf38DHbC7ydKHsnwFcx7fQhpG/wtJp18ugBfpPdBfgX/AR?=
 =?us-ascii?Q?gx4fHck6Cn4m69Pjg6flSTkpQ+StAnY12NHEUyRNG2tlcPXji+tuq8hPnUOA?=
 =?us-ascii?Q?9HZUUIS1R+yzkF9BqURXragfLy9mHmxlC2WMsAuQmN1g5LpmTYJpTE4Npj+G?=
 =?us-ascii?Q?BNNEDvOp617IRqAW1RasK6mfjF080o+sFB65u1JlP7CS7Z1/fNRaaYporXn3?=
 =?us-ascii?Q?fQ7FXX2YCOqKviIZtw85nKP4gfZGvj+ZL7rfQ5vLxWmWqg/uD8ODpRjv+e/b?=
 =?us-ascii?Q?DmWhrM1lVV3RYiR5HvGUGcn3YHYHNq8x5Zs261FcLdFeVAEGUSUOMuoBr0l5?=
 =?us-ascii?Q?jAKAaBm4lKwaYpignbY5VdCoGs+MTXnh4QnRSWpFRQdmCu8dNvj0WdWXHQux?=
 =?us-ascii?Q?vxFfe67FD+Dk0nD8NiYCSoUvKTFGAcu4wKA2GOFHHC2Zi4pg07t2rNh7Ev5Y?=
 =?us-ascii?Q?Ip6JpAF8W9JkuvuHmlA27+BfgtM/cLgdt3qmHWuwe251sTot00s0rzlPkp6Q?=
 =?us-ascii?Q?xBF+s0OpQqaeSwfvbpfGz7u2EXMpf6t/nAm0vi64WxIBdLju0qPrU0feB69R?=
 =?us-ascii?Q?yKkM5pONz9VraxwQcDxgUlXb2D3syUny9L2mesqFFpnLpL287cWV7GGn8GSZ?=
 =?us-ascii?Q?YMOqIKK5WD7Pnt8fk8wnYrvgSMJYpU4ScQ6BDpgAkENHxUBl7rrJOL5jTzg8?=
 =?us-ascii?Q?BRaLwvE1CDBPtXRqHqLQTAwXsTv4ICfV6jowvP2wlenZYKMFz7H7MmnkZLoT?=
 =?us-ascii?Q?UuEnVQKkqaZgSlgydqX9LyzjlSTpeoNqldMhZn3G28T5qTDPgvYYzoj1+KRG?=
 =?us-ascii?Q?Q5rO18HaGPtW4HzgsKI/159hMJKZxKx0vBHi42/g4jaSjnQ22VQnK5IpMC1U?=
 =?us-ascii?Q?id7IS8u/4wEGC/NfdS3obTTjxAF7JMDdbArhutlpNK7kGG+CgQ3aEDRZIFj8?=
 =?us-ascii?Q?kEXC768wWSR3bkDkWUT2zAYm8+5Cy0ZbZ1VZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:43.0077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88287e3e-fff3-4040-a506-08ddf981493e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651
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
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
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

