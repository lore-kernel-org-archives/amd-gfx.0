Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C59DC7EE3A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E4C10E32F;
	Fri, 27 Jun 2025 14:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="41vZfT4o";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3E010E32F
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm2sSVACYCrNZUTWqiENVoZyLs97F283UsW//eFdv2g2Lku1RlzUV9A8Vslyotokd84y/JK+ir4eIAUud8PLyGeGjEkfIAuj/yBeQvFGWpUKhc5fpP2PDrpyL3aSKhZ21K0vyDn4v9F3AOCkMwFsm/8gG4bpVouytZYSuvtONBax/V2/hS1j+iCI8Db6brmn9ZP1arbqD3noAFtoeJ1gwiuRMGiLbfOQWTVlCS1SuNtUJu2NdCYgxoe135ZYju/CDSCDEdYj/y+osSvLjfm40tRZkU1YZgEn1Yhe740FKV7qD9wGMTNHDzxBgOV0SpiGchQPxfqloqn7pGMg5uTgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X+3xUJWIU42ZGX5g0/C2BmBLKgEzI9gSu5oWXUYLnU=;
 b=Tf7B208niibWs2+c452cwSQdlZLixKhkdAsqVgtKPRHzmVpboBqDI3/bLs7AdUNZKnEEjafHSpTN88fMrSS8fte7n8PDP8B5r9+ZUDkZSH8yhmIRLC1emAaO5XN0FcUOZSlG554A8H7wwB38nXnrwMt42WCYIkg3MBiX2KxtXmAMTvtWvZKTPshhjwCnkM7UEjDF/xFtGEh9goPvEAc6V6zbY17Nl05X8cU+I+TV0/a7XDPJGZMhW+Pezd77PkSa6IHoQYOQ7/c5ROAcdFgbnEuIZEcPlmZPSY2nw8p3tt5y60p7U+MzozGcjXP8f9iKjuq4BcGJqvqoxmepMvQvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X+3xUJWIU42ZGX5g0/C2BmBLKgEzI9gSu5oWXUYLnU=;
 b=41vZfT4oL8t3TuhJ9bdH0Q2L/fxUx8w0mPgctdDC0EzpHHDw8qYuMwgkQ71g8NYs/rSSeR/C7cIKLbwUjrBZBphzVxQxoWrYP+ErLJgRrF7HPzG4+9Jsn2MBCvO/N29qmLOJPVlvykCBxTPkdDnJOBhLp1KbjKCDD24npZmf9go=
Received: from BY5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:1d0::27)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 27 Jun
 2025 14:34:09 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::55) by BY5PR04CA0017.outlook.office365.com
 (2603:10b6:a03:1d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 14:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 14:34:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 09:34:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: add ip offset support for cyan skillfish
Date: Fri, 27 Jun 2025 10:33:39 -0400
Message-ID: <20250627143342.23856-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627143342.23856-1-alexander.deucher@amd.com>
References: <20250627143342.23856-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d7f655-e810-4ad3-e485-08ddb587ad1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tfk2o1SvX9KdM39BVwjrCiEW86OOxPkoyAoDGKzslXJ+YKDJPlFtKabRnRwH?=
 =?us-ascii?Q?AOGQa0Y4IsofrldIhqNrbJ9YSD1NOidv/Rr7PqG4uJ43kOEYd7YWOIEHSGe3?=
 =?us-ascii?Q?YXxUomu/l41Ool6CuAen9NxGevwoegt0dxy82Kxj6pKPvyOYqz8PLCOZcinw?=
 =?us-ascii?Q?LrHOa3gVRkSB+fMnDjauni07UxH71lDjzf6/6OVuKcBum0tUDReg++uVlbFu?=
 =?us-ascii?Q?D+7Ks2RHwSFmCSiZsZbUxtd84tkDCH1wODYHnizYtgDirbFwUQz2O1OZd983?=
 =?us-ascii?Q?zz4zKUJRlGE0gvD7R05+CzS4BzS7vcI2F4eV2ChlTsn26wBj8bLs4EGWi+od?=
 =?us-ascii?Q?dlC5KKO0QELtQOS0P9NvJx9ImWeH2P9+gTNRpJzGxS+c4w4KLUe1Kbegdexz?=
 =?us-ascii?Q?YQGOcuNBMcRdQpi9XT6/WiW+fDQrQb00P8HQ3nUK/PGsFWVSvLmQnWOYMxke?=
 =?us-ascii?Q?ffgrbia+EDlHIj/xNx5eVx5/lQYgz7LbtBm1WYgybfC9wW6Y8NFq7ebFYjXP?=
 =?us-ascii?Q?dUaL0DQSe7jn4ePmzsTHAuV2nwvVEnA/FtaplFy4zAXuyr7pDzfioD6uE/st?=
 =?us-ascii?Q?qoRPe2tpU6wvM7qakqhM95PCuIP04oAI2m9vqdh12bQ4hMv5ryCevl297Q0v?=
 =?us-ascii?Q?eIwfYa2YPBWbhJOHXD8VnnbkVH1P3C13mYdFEV5BgRH7Zphdv0pQmj6zBeGh?=
 =?us-ascii?Q?XD6SdFEefZ46pswGjY4R6RF/QM0c+sigXL7fLXTqPHKH9tqxQ4S/1t6hCZpX?=
 =?us-ascii?Q?wD7rOTZpPiramdbHDwdltUDKU8VDS4Ovfn0eX4bsrOcq9y83C6qk+9FqtuLu?=
 =?us-ascii?Q?+pucMs79khc/ekBGoKYtqv5rylAtN7MxWag80bEfnjORGWlDcUQ8fV2DOo/p?=
 =?us-ascii?Q?7iur9jp3T34WiVYJBS4ELHwdetgErDULepXWe5SCwBgVGVuvrRxaovv/j9Kf?=
 =?us-ascii?Q?gdNva6NCeoVJmKQ5aXDVw1SweT8jHPQvL2tvhKeyEge9hzoil9e7NhfIf2qX?=
 =?us-ascii?Q?mg2MVmqVVQ1Mh2qNDV2qTw2UsKFLBubxYqSHA+Bl087TzqZNESTOznQfxuXo?=
 =?us-ascii?Q?RJP0vRUlaV++3vTDyBLqtroHawsGst0WFbzl1e8GAz49YX2CtBrRcxrhdPs4?=
 =?us-ascii?Q?3rZJIT7NY6YDV6X2MATdQoEfodj0fWkNA2XDNshHelbEAIUq3G53AneuhFbw?=
 =?us-ascii?Q?Q6EmO2nB9I4zWSgUCKSw5O7rVdA5dyLQ3zSpiKukWT1x9/lEe+kERGFAxViH?=
 =?us-ascii?Q?ftldnS2IjmaxI0dRU8qSyR0VtFor7DcoBiWX+SyF4VsMpJVwIzh5ZGY7ROZ/?=
 =?us-ascii?Q?miURaYcaFIUkYrgic6eOxNrDfEZLUs+cRrzE9NFWhZiqTx7F62qhKMawlt/l?=
 =?us-ascii?Q?lB3BxUu7sOIhnGN9e9h7QucwyRGRrS+3hizDqaENMXb50cP3+3QU4R0E8peG?=
 =?us-ascii?Q?HXN+wtZEOTec+yi8mhlGfOMZwhF7Z1MxqT6vIQGCqbJZmvbqjxMDSnXF/1Ne?=
 =?us-ascii?Q?nut+KkCXIhro7KW6UbznJCq1MCDF0Unmnb+l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:34:08.4786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d7f655-e810-4ad3-e485-08ddb587ad1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

For chips that don't have IP discovery tables.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 +-
 .../drm/amd/amdgpu/cyan_skillfish_reg_init.c  | 56 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.h               |  1 +
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 930de203d533c..2d0fea87af79f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -84,7 +84,8 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o
+	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
+	cyan_skillfish_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
new file mode 100644
index 0000000000000..96616a865aac7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "nv.h"
+
+#include "soc15_common.h"
+#include "soc15_hw_ip.h"
+#include "cyan_skillfish_ip_offset.h"
+
+int cyan_skillfish_reg_base_init(struct amdgpu_device *adev)
+{
+	/* HW has more IP blocks,  only initialized the blocke needed by driver */
+	uint32_t i;
+
+	adev->gfx.xcc_mask = 1;
+	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
+		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
+		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
+		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
+		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
+		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
+		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
+		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(UVD0_BASE.instance[i]));
+		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
+		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DMU_BASE.instance[i]));
+		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
+		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
+		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
+		adev->reg_offset[CLK_HWIP][i] = (uint32_t *)(&(CLK_BASE.instance[i]));
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 83e9782aef39d..8f4817404f10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -31,5 +31,6 @@ extern const struct amdgpu_ip_block_version nv_common_ip_block;
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void nv_set_virt_ops(struct amdgpu_device *adev);
+int cyan_skillfish_reg_base_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.50.0

