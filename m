Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B625CAC59F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99A210E619;
	Thu, 18 Sep 2025 01:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tOxJ0kaL";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAE710E624
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdB1d6zTVEez1LrouPfk08+VIaZBuIbDhkDHVfYd1YoEjSZ1yNfmUEmbr3qaxX+ejsK8Cs8r7HhSuqsfEW4Z+ajFTel0S8IPd+/+g2xMo5xRj2Lo0vRA3ILTU+sEw0/mHNEvv67CX/0Hvy4r1BFGUczV2srcirbCKvxXZVlFZ+AHzhQP/WEa/JGZQabJO+PHD05sH+Z0WBriVH7rl6kLLkZwINl7orIICPQsW9QZ448VfoFsImH+aUqLOhfucI4CMKX61lvSPmN4EZBinonWiIWMyY6Tb66m0iw5bx2/DGhuyGT6i4IFAFK2cdti24fvb5AiVOQVp71IyzarMNLF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crKin8U0uXl4t88CBZqq9n41VTocLGipfCRXkr7f1SM=;
 b=MOYoTXt8ZKfrr0lw4CSJepO8Ro1INfk0wuZrkeHvD4xdZ1y3KEwihi+zEK+gmZDJMfVArr8xAmlodEo1Cprpg9rwYQVQ38KiabFapRdQiAeOrAYxDZy6KZfSvn4PDjSGlXfcmb8OZlBfudBupMCmWzGQ9WFQXtM4pgoIrUd0FGT1CIZwMbTxirdptTeWCLBTYhwG3sYI6ZFkGg1kMp7yxXomoIH+ERHsdpE4mMTCaNSm59VmUYhXQrLMBLsMeQhnn1NQguYxXhg4yi06dvFrqR3yPTX05nQ5UjUDydcN/ckCYiDJPxoUEDrqH7kUatRPK1yCZRGn/Y5AfTPUEZik7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crKin8U0uXl4t88CBZqq9n41VTocLGipfCRXkr7f1SM=;
 b=tOxJ0kaLh44BfPsKMKf9MoLMEx5R8Mso166NPaempNBEKr4AqDWppNkWJME4sbcQZr6yZjyJnkQDxRwK7QjO/J/9WdruTK70UZlui7ineUuxPZol6aJeh3npwcVEjAopSiz4RUOQjQQqrocohW763rQdk1EQyq8396TwxWlEOhY=
Received: from SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) by MW4PR12MB7440.namprd12.prod.outlook.com
 (2603:10b6:303:223::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 01:37:01 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::db) by SN6PR2101CA0022.outlook.office365.com
 (2603:10b6:805:106::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.2 via Frontend Transport; Thu,
 18 Sep 2025 01:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:37:00 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:58 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 09/10] drm/amd/ras: Add files to amdgpu ras manager makefile
Date: Thu, 18 Sep 2025 09:35:06 +0800
Message-ID: <20250918013507.2629620-9-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef8d5ab-361f-4169-9f1b-08ddf653dd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6D2K5EngAo1Z86g6OukeruKhLvfes0xl0kDIbbcrnv+Q3xtGxpwru3xc8beZ?=
 =?us-ascii?Q?EhoFWHJsg9sLbxCLs8xxwhDfRocQz8J7jgIgdhUvjf1gxGTXnmQFHc3xBxbN?=
 =?us-ascii?Q?vAnS1WkOU3qlzm3JIya8Fz8PeqaJeU7XC8QDjrHm8AGq1sD95B+LTtiMChZA?=
 =?us-ascii?Q?iuFdRl9ED3x7fzMXbSpLfbvcv7gu+9TlP7SV72ieYxpsKT4RocsmR4+tLjSB?=
 =?us-ascii?Q?CJJryxwp71noc12uiDDeWg3tWBp0pcufzR9yc/Rj9W9L+JTduNDgahl4v7W8?=
 =?us-ascii?Q?qO1UljKGdPOZJX75vSkSKSX8hNZWN1kZ1oZOU66GLWesyJ6gyFvddCs9DMUT?=
 =?us-ascii?Q?dEAE6A8a8gyQAAlKT0YoV6CbvfgufExLfA+AdSIydJkwo5ILhCa9zpF4qWb0?=
 =?us-ascii?Q?KW9vTqG4EsB4IgQyqGCqQLaM4Y0YTUdcT7MqKEq5NYunkfJuYTqrxmLVkIcd?=
 =?us-ascii?Q?NOFs1YAoByM/hCLoN9oGfXtlN5e5r8YO2Af2DnGRu7mJ6IlUSIe69WtsHbtn?=
 =?us-ascii?Q?/zRTi1HhbOCJSmlGjtOmtOUESz/ghZf9JOwuB6TA4jMz5ZvoVoIVbu8iGDEQ?=
 =?us-ascii?Q?xGVC5JGLUJSdahVNImdaxd4tNq7r8+2Km1e2SO+d6qdgZE3y8NC4624eSdkA?=
 =?us-ascii?Q?/yzEAt9EM39VIB0vydKcQOk6vFo3FUhlSPL8zMtzsZvB4cGB5guKmuFYgAek?=
 =?us-ascii?Q?IWKCnkYDaPbVip5uzXWe6Fohzev92B2UIytwW69rAE6fWDBgH4HpaoSTDX5T?=
 =?us-ascii?Q?v/CbDELqryhfVJQyJqWbf5abAKlVFK/AMtFLAOSvSMfXLMiy/uXbp0m0+6G9?=
 =?us-ascii?Q?+m1YW43U9fc4HuACFH1lloHfWrniutaLfDGN/fSWuiyhhv6uFTOvwSUBvbRs?=
 =?us-ascii?Q?xdfmMXep23/ovE3Ea3XJeqOOMAuXxUFmMvWFU65GmxeIrBEjVHXafVRcknAA?=
 =?us-ascii?Q?IV6CoOzevhiL6ljiwfvuEYl5PNjdczMxOdEmeUctokSBpvHH2ySFmgKVkF8I?=
 =?us-ascii?Q?KcLUR5FD4+gv/Y7Kx8dehcfTMWlTwragcBwWwiwD+DpUFC9LT1drnPBGwZkr?=
 =?us-ascii?Q?WmVoI5vEsRDSQSSikNp3C7sy84QPn7sneOfnfD7GB/f+D8EbM1gmZMJzHCqQ?=
 =?us-ascii?Q?203eG/KJ1iW00zC/eN1zzPDva7LS+j0XdtSRHkr2xdUDhxaf2rCFyePsjdpF?=
 =?us-ascii?Q?vOJVRoEPzuesXhpdzv7CfisyxCUOzWFnZjTNmuBOTxMG/jMNQLCtXUQP+8pb?=
 =?us-ascii?Q?8fWOrdPHNIs5sCkYi2ZfRhu32BxJC0r1Ijp1iYe16A7hue3oFJIRCfZ+YAvu?=
 =?us-ascii?Q?pUZVcGR0ryn+F2cSc5CLwFvINOyJRiTlBrq38rpyL8mYlZeNs/nEIziqfoZP?=
 =?us-ascii?Q?FVyPgknHuExlf1wMBkEdvZQMRYV4r8fE8Zysno2xErjH2E/zjW7BphrydiUx?=
 =?us-ascii?Q?s7esSmAhR3QYMWUMl2Zyrdftw/yc6ByDzGfMT2uTUcV/j12LJrGE8i63Dc6O?=
 =?us-ascii?Q?xrLU3XX5K6xjGWMVhFldGpGrmJ5i0fJoU9Nl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:37:00.8471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef8d5ab-361f-4169-9f1b-08ddf653dd20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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

Add files to amdgpu ras manager makefile.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
index e69de29bb2d1..5e5a2cfa4068 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
@@ -0,0 +1,33 @@
+# Copyright 2025 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+
+RAS_MGR_FILES = amdgpu_ras_sys.o  \
+		amdgpu_ras_mgr.o \
+		amdgpu_ras_eeprom_i2c.o \
+		amdgpu_ras_mp1_v13_0.o \
+		amdgpu_ras_cmd.o \
+		amdgpu_ras_process.o \
+		amdgpu_ras_nbio_v7_9.o
+
+
+RAS_MGR = $(addprefix $(AMD_GPU_RAS_PATH)/ras_mgr/, $(RAS_MGR_FILES))
+
+AMD_GPU_RAS_FILES += $(RAS_MGR)
+
-- 
2.34.1

