Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985F3FEA819
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345AF10E7B0;
	Wed, 25 Mar 2026 07:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZcev1q6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CEE10E7AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS4/xvrnE4jdGUEsNsh2N0TprnkrYSikzM7bH6IMpvcvODVWxmG4Zntn4ArjRA6lY5mVXCZcBIJiGKXjhP1K+G0JNziFuI1cuhceJe8VmJ4biZGd/JJNUMdMNYx7N0pp+BFl9Sm78otSOD6NUGAm4GZx93k6ugJKRCDmyglU6Y+bW2IUT9WT8lRBDl5m5BeMZGfE9SVUgQAEWZ2pky70oohXZFHI7cz6P8aM8GjWo/iR8gQ8H0lRIly5fQ7BFqDA8ONhsFWdyQ5VmlZPzeRq1Aag/BN+DCTS5tDhOIXCbiYSqAYEoEY+BDpdE3sy4ZA24jhihjKuzB90VnM4bAIYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP74PP93hZ6ukU0AuPDpX92Xl+tvTWsFbPcxtGZ196A=;
 b=LIH6HDAxzyW2001Xe68xJDSHfeGTJIpTxqz5NUrScxMMt2NyesVy0sdXzdgXkSxQHJwqxeS37Lv1xXU97IKhC31J2AYCmQAk8HEtnAnFY8v9dCWj4G8SeHBA7797+AhKmeCPErO0NdzIQ3dIAIgqe2dAfHsxSBQHtB2RpVG4/RCn0cg5EHzAB1YubkjTDY4NkC6SVeaCSJKb/0+gRJcOyNsB21czgBti/LQDKSmtxDnXGoQQJbFkG1rCsh4fEg8/LrE/o5fuyWd1xstf3w0C7Nkt8s8un6PW9hke/on46xeNY8juHZk5JOHKT7xT9eH1QhvTaUXLfktq3dalfAD1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP74PP93hZ6ukU0AuPDpX92Xl+tvTWsFbPcxtGZ196A=;
 b=hZcev1q6Np1BPduUQ5DXSLP77YW27RoYsRJwOEfs2PJio3f5NMCIl4jHn9TwAhzCp5RJsRWmp8vYgu3urBF6AvFwuU8UduBlMWhjfxGu6ABNy9V/qPjyC7IXRrZQOCsoAE4fHm4a1flM7TtXPJpS5xCB+pkGOuZh3LcG87ZwkoU=
Received: from BLAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:32d::8)
 by DS4PR12MB999100.namprd12.prod.outlook.com (2603:10b6:8:2f9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 07:10:17 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::ce) by BLAPR03CA0033.outlook.office365.com
 (2603:10b6:208:32d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:10:17 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:10:13 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 24/29] drm/amd/display: Move FPU Guards From DML To DC - Part 3
Date: Wed, 25 Mar 2026 15:06:30 +0800
Message-ID: <20260325071003.4022594-25-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS4PR12MB999100:EE_
X-MS-Office365-Filtering-Correlation-Id: f849bea3-7d97-4de7-38e2-08de8a3d9198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /Gg62rHrwph6l4XaNbaDEU7V2eJYUefgvir+ZVWyohe8//MjAaJM4n12Rin8OlU0n6lk2sWrvEdl7KqbDeI+rSyz0j7mrdGM9NOYPOVS5eoyke3D/s3kuFtsPs+M5d4W980XuFHl1qBzMIJ8nh36Pa/Jy57dD7ZA5hvELtMO+mdVcDfySCCv6gzCFl/s0/m2QAO89WieOQT6FF/o8CNPwCVSPbYrb2lAHit+4EUBchFl+xE1L3eRaL++uflQ87O9B+2Az1KSlZvmc28iJaPOx9uS8nZUus+A5Zuo8hTR7iI1Jz8st1qQ1xHQJJtpXsVKJpyE05v8dfRsnwLm0KRxOo0wUXipIJ30PALXZF2HSLQrprMvtJcxL2KqbJl6hNWbLlicjtlXApgyzEJbwukuqCFahcRC8msZyY2M87OYsDjh9ZayanxNoUzGqlQ+tTJe0V3dNzKIUbz5vSAxw2tZTeV3v7EhCL7nXtwelIA6gbYaCcRj3wIt4QeAOFAeWKND6L38uFJVw/VLilH45C/iZHGL7mwRYTK6AIMcjm7eYqkwFIyo++v7KNNKp88JzVBNrRPETZP/G+0wW8ARxFWz9s5fFi1ExR7P81ItglcU6QH8ie5xWaTFgbUj+k07k7K5b1hs0JvKXcxejdfCmjIfaE4euohOJ8D07kojB2a99nzg3Zd0jKodAhxP0lWDdBxUGhqa2zgJ0/udmBLFIXMmAI/oSqHYfmy2mQvCbAYN18MLOF7HwrPDFJWVsS5F/+Ugmf4H+BTmHyLrJu7jQ0qG1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Av5596bwttjF20G/X+gTouvlzV3LBPHjqcHNTU0uKnPY1i5NFKY6mPOcvOTs/ugHKdt36BLYZpNUP79ot1P1HczkX4KiKNDBzDRBkPdqO5fhIoPntEZFLaU7bKGz38mLX4ELUdpyQM82saNwRCnQqORwLiJFZTh1EO7wc8ssywA99tzEdBW/k2nhZz3V4ygOfQPMX3+hn0hBgQyLp/Y1foKBp+LgyTY8V+f9i1zzg9QwhdKU8LVHGk5VMYH/fRLXPoW418UhrUV2r7KxYo3+8qA0MzZaHldq5i6F9nFztf/Xb/gRkoPetVBXPhPn84WFY0Xfgqlq4AA6Hh4Vh0F5kBfz4UvGAN7+cZcm/PoOEbxzLxnf+xK2xnZeW1b/n4OsVw5zRoPhqquPspDmUQ4hkeHvVrV+ZGgsqBbznGfrnGBo0AVmhbVeJMdi9boKw9KM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:10:17.3052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f849bea3-7d97-4de7-38e2-08de8a3d9198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999100
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code that
can manipulates floats. To do this properly, the FPU guards must be used
in a file that is not compiled as a FPU unit. If the guards are used in
a file that is a FPU unit, other sections in the file that aren't guarded
may be end up being compiled to use FPU operations.

[How]
Added DC_FP_START and DC_FP_END to DC functions that call DML functions
using FPU.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile              | 1 +
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c | 1 +
 .../gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c | 4 +---
 .../gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c        | 6 +++++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 5cb3035b814c..2625943d7f7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -85,6 +85,7 @@ AMD_DAL_DML2 = $(addprefix $(AMDDALPATH)/dc/dml2_0/,$(DML2))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DML2)
 
+
 DML21 := src/dml2_top/dml2_top_interfaces.o
 DML21 += src/dml2_top/dml2_top_soc15.o
 DML21 += src/dml2_core/dml2_core_dcn4.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 1a98578f223c..7398f8b69adb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -38,6 +38,7 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
 	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming)));
+
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
index d5885bbd14c4..f3abfdbe6805 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: MIT
 //
-// Copyright 2024 Advanced Micro Devices, Inc.
+// Copyright 2026 Advanced Micro Devices, Inc.
 
 #include "dml2_internal_types.h"
 #include "dml_top.h"
@@ -377,5 +377,3 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		}
 	}
 }
-
-
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
index 2972c6eed21a..e5d9a456645f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: MIT
 //
-// Copyright 2024 Advanced Micro Devices, Inc.
+// Copyright 2026 Advanced Micro Devices, Inc.
 
 #ifndef _DML21_WRAPPER_FPU_H_
 #define _DML21_WRAPPER_FPU_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
index f8250c80be02..93b7613fc4f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -13,6 +13,10 @@
 
 #include "dc_fpu.h"
 
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif // !DC_RUN_WITH_PREEMPTION_ENABLED
+
 struct dml2_context *dml2_allocate_memory(void)
 {
 	struct dml2_context *dml2;
@@ -20,7 +24,6 @@ struct dml2_context *dml2_allocate_memory(void)
 	DC_RUN_WITH_PREEMPTION_ENABLED(dml2 = vzalloc(sizeof(struct dml2_context)));
 	return dml2;
 }
-
 bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2,
 	enum dc_validate_mode validate_mode)
 {
@@ -84,6 +87,7 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
+
 }
 
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
-- 
2.43.0

