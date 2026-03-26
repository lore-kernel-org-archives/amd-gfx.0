Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEF5109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FABB10E942;
	Thu, 26 Mar 2026 03:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TH5GSNra";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7BF10E943
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRHwL1nlvzoWMgGGEOFqjgsDp6RjYjmRiCTEA9I3KOw5IoH4S+914vEvP67N6iFwvfVpxMfxaYbmMBuCYY8/3UZC+C+4C5d3Bc6S8gkxcbyAPkMTrmUZ1NllsmzO4C65oV1o7OfvqL3hzyr5UiIG66S/WL8KO91fIdMUp5sl02th2o+/6K2zq/bLRvno0v2DaR3zt9hAXLv6uRctc9zeggEH4tIhhJJZmry1IFpHlLrHswAmSIvlkgVZZ0UqbmK48acqhWNGSW/CDn9VcSKN5Z67m6iFp33tnYDsEMkBX7lo/vGs5O1Rc3C9KV/NpVEoJ9foW7BQYqcKH2oJbCgMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP74PP93hZ6ukU0AuPDpX92Xl+tvTWsFbPcxtGZ196A=;
 b=VcA0mv9ferQT8RWofhPqIxse+iJNw9ZxN1jw472B9u5w9OfZw3sRsN9JHM8L2ehU/MOQRxePXBTKRofr+a1oRDKYhEMfBC3XsRhvuSKB5Pg/jnLKN67hr4e5H6dFEh6Zy8HOVELOww+Y5NNFMScM+E0IxyemxCIWVnUoutS5GaP/XjyQ8Ld5pGt5Pzp97yBkmv6Y5wqkznpRxm8TwyMDF9SaKOx4OvHwoR05HOMraiVz7p4y8oO2BbJxSyzQPHR6dWBl1bN+qYN0A0bQkdnFsuyJ952EC+rhqamzhSg+IVnr6NhGt4GU3VWRPzeik3AiUt3MoOhiA5p2Bui9Vz87gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP74PP93hZ6ukU0AuPDpX92Xl+tvTWsFbPcxtGZ196A=;
 b=TH5GSNraLpaKARz+inYxeoOtJE0UdHcIwNZZCZGLaIdZFKJbkrW7NqlKebRAGXaDYeiowDEmS9lMQI0xHfhb+pAz5toYE8DDif+KNFK6o8rk5MK4OsvJXkJjQuTTzcTVUTpqg1wtUJdIWRAYNcFVyiEgXTCl+I9anGFPwNkvGqw=
Received: from IA4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::6)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 03:02:19 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::4) by IA4P221CA0008.outlook.office365.com
 (2603:10b6:208:559::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 03:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:02:19 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:02:15 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH v2 25/30] drm/amd/display: Move FPU Guards From DML To DC -
 Part 3
Date: Thu, 26 Mar 2026 10:57:16 +0800
Message-ID: <20260326030153.406612-26-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b36b52-36e2-404b-181b-08de8ae4180b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U7J9K6+wzkUBSfCYI66VPghNTMbiy3GCFRnNRKwLoD3JDlx6AGwIeWqrR4TGwSzSQpZQN47fLzaepkKYWtBNGJb9MhAWTSqUdQmMdYyjznBT/uf8TsORc58qSq5RvnP3i0YNUC7FM+4LckL2236OlGDuuLnngLSPY+4jBwmx6RUmAAUm9uhaSEmIh5cJXzlbWB85ULhnQwkepd2MeBnQwmiP+iwGK+URz+sbg18wgs0n6D/bENIff7pvASMm5xIwJujYxD+KFY63ZYr9v5uLl5bAg3CuEXcOtZV+D6ZeY+vnxgtnosDngRqDTUqFNhJYqm00noD9ZC+AUuH93jaKIUOEhNqO2scrYlKJmG5aKWZ1EgkOB4Nap3dDR73tD4Xf3nwqT4iGQ48MLynmvJl2OBcH4xqAiygQv9AdeHS4nKxv1nMXk3Tu1xZ1DbLU1kUHG97M6trgW39BHf1VmFJVJZoUp8hhw5WFUiCk7N9k0Q1QObalelBdafTU2db8wlIPtFyvejtocFhG/y1YDBt/FwF52f9BR+5jCB2/V+ugghkXxIHWUIHcWvsKXq1nFpfHpsu3tDWNzwJCHpNFhIBecYc/KLJBhMFBo+Fg3s6Mwf1n3mwOpeE2gr+wP4oJuxbAPIbSMx0hkDh+d92Tuk5SjySxh3i+8OnoVDflvcTLIstfAzG5nZ9yAdBhYE5njWcfhurDM3i5lkHjkoav7801CB966fvMpipIUYIMpPyrDVA34CwC/dI+UdLpNdXrRaFHwTGrwQY2cxio6sSXikCWXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E6G9hytHzBgVQJSNCI+J0yamLMTwDSclLvUYpNxCan+MZ+n1rhJhY99SDrSSB11VsRv2Q4qHorhOC8pBDdS2kV+u9X2IWXnR+XPNuRgEDmzteyoi1BzSjpca+SchX7psRQPGBZH1JiTWoe8Y60sYqxsHfQnNuw4Ooav2uQMm97i/4lhTYpnWILhi844iXMMG3atkDNND5iYsOOhYbcA4ZRL1Tkql345gbErv9WcPFy6hxmqig5GY1L++a0EcBYziNSyQngZ0AEkNmGAGCtcEa6FqQoTBa420iykw6hoY2KCPLAUnTnSOYhBbbhwhCCzVBbKg51YaejOpFKrT0btKOJ4qcCp838/mU2T0Tv0x8qAXUBIJx8sA3okY0CYnykBVtJq/WRGcpHg6snGxtbvtS8LhLqXoc3sMp44Xvg/6P/lyGd6ip2tv2uEIX06qmo6P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:02:19.3375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b36b52-36e2-404b-181b-08de8ae4180b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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

