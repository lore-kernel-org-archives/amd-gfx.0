Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DAFCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E12010E7BA;
	Thu, 20 Nov 2025 18:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2xyPpj0O";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C668610E7BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI5H24Zrdu5dc/dNaoRSTwD0glrP4lh2NruA4HLPG+mT22EiSPeJSPeD8LwfqweRzjg6M71jrSU54D/V1+cBbONdXHBc2jBWq/GwGw1wPPEhs3qK0CvL8b2aBA2ujMaGuO+Maj1Ty6l5OUn1NmBbwdxFo48vbYw20asDHww5cNPf13dS5ulTiDEQ9vba2US42sxaPfvqifBkEsuiaYOvBSMwolNZ2+KJz+QD5B/ah2IT6I4/OMYvbgvTqk2W9UElwc9hM8xY/epbY1YO4KsFlh2ack8xFae1I/lTWAVQVPY74VG/jbkJdwE4egDBnVVChumbpZFBxms0FasO3sOFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGAzWBpiYh902IkbQor/K/JvyuUbXhCx8lxBpj3qBGg=;
 b=RdU3qt6/XbSGVH7Gh3fqeZ+zovS3f7LKSzfQSV6fFzLltnfUciYXhsI+A2wtMmbMW6ZsJpwt+60osl5osRnPX164DFLH5xKjSH6QGE5RloWWiMy1L3b3ogqXQFT7jfD6Pd9pukFSDCIEn2AYWelQTPbw/k5IkSpiEM2n7dklcszxxpY2PdLeAIPMrtEI9qo8mzFD232kYW6Ca8F6VTNe5EZnQyj5+e+q060p4jKOwC822Qwot87hKmF2b8AtnoD0am7+AYtFiar+4dSY+o0VZuoVQ+Id96amTJpoDRDkA2ELBlvBE58wv2GW9m9ZZrTl08mbLUntZm6aIx4/i7Wg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGAzWBpiYh902IkbQor/K/JvyuUbXhCx8lxBpj3qBGg=;
 b=2xyPpj0OGbNfUp5KuUE9HNNassFJRIkFcMcBqVrlQwnW05sVDUqQyaXQ+atjsLPN74Y6v0kG0jZAzA0py8yibfRkig5JQ+7bq6wlFOrKryW+Cu2LFo3644+zU63Gjjd7gmmxtjB/MxttpMRt/goJvtgs3FOwnS4BwiXFEfohQHU=
Received: from CH0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:610:e6::34)
 by DS4PR12MB999100.namprd12.prod.outlook.com (2603:10b6:8:2f9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 18:21:10 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::2d) by CH0PR03CA0299.outlook.office365.com
 (2603:10b6:610:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:21:10 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:21:04 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 17/26] drm/amd/display: Move dml2_validate to the non-FPU
 dml2_wrapper
Date: Thu, 20 Nov 2025 11:03:13 -0700
Message-ID: <20251120181527.317107-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS4PR12MB999100:EE_
X-MS-Office365-Filtering-Correlation-Id: c30950a8-fdac-4a61-f348-08de28619488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5c0U84+WWVogI9glYGfIXGQUGrTQkbag+nCxwz812in+VwdkAwt3FjtIl3hV?=
 =?us-ascii?Q?lS/5Pw8DdPxwlGRmIFUQoHOFK3v8f1wOMD1Weln4guvVFpEFNv+AwwR9WcIw?=
 =?us-ascii?Q?ZJ/zl0bPhApBLlE8W5doGcxoTZfhPZ7EtWAO0ohCCnFn3cbm6CH7rh4Gk2vT?=
 =?us-ascii?Q?ACC0C4xznV4zXEUIk4RTbR1U6Zl1sSKohC4qLXhc3EDs8S7liNEArJxn60Jp?=
 =?us-ascii?Q?q1eD9JkqXgofaTBCcBbOJU+zwOw4HxRNQXiOUYAMJotZuxZhZXUeSGEt2Nz0?=
 =?us-ascii?Q?slvk/f34q84VBI/rhk6x7lznrxA8zclsRTGifBifbdHfPs3CJlD00RgHJs7r?=
 =?us-ascii?Q?y9mY4C0jtMDePR+vd435uDtuqdWpPHUd5rl1Bnr+vGxFMyRtKF1FqTBUoLss?=
 =?us-ascii?Q?nMDwTOjJO3rnsGGjp+B/pjQJKk/11H+IgvEHoKfnGV4OPiw7tJs9hsaNPwsv?=
 =?us-ascii?Q?bG0CzoKf6hTqBmCStwIwvDmprimQ0e3MZNafeOP51VvVLJIce90BbfdKSrgs?=
 =?us-ascii?Q?oyqUmVdspyswC2pph0ok7O3xAYhE5yAWx4thRwREzk1tc81T5fuxjySK+32Y?=
 =?us-ascii?Q?HSyvs9fVRjcdmpigfeFTPNEl599UtPcUgmWpbWwU4TeRWJHqMOPvLfx3fr8Z?=
 =?us-ascii?Q?SJ17bsnLvd3MXJiJtFVuwTFMnun9jbeHoNx5cblHUMO6OEMVL+DG9kEc5y/9?=
 =?us-ascii?Q?nUkyQj/BnWAhflljbAjb4/w2+mNkWO1bw/UwvK5UJgQdqISiTDBNBZpkIV8o?=
 =?us-ascii?Q?y8uoZVzPnzWnFEBqQ800kT0Y3gpcD0XCwE86Y99UflzQzzrlEK+lCWELH/fa?=
 =?us-ascii?Q?UjG9uc2ICdw7xsWblZqfY+ONUaKoxU6wR3tXP91bz3TC1+9Q1vCXvOO1VPkI?=
 =?us-ascii?Q?THecaLvGs3mPiKqSwsN07MtTTD1ejuwr8u98gONfI8Oy7TxmUh/Zc0UiPUm3?=
 =?us-ascii?Q?x/d/GSxAZ5HUbkdnLvky72F8O7Ty7jIZvb+JHuVW1nHDnrrpn2CKhEG8Rl2K?=
 =?us-ascii?Q?+KOOeb8t9pmuXmkfL1Ci6a7JOAvRmha8AatjeDRnNcxBr1i4XoDLukvVV+Sh?=
 =?us-ascii?Q?zJ58BxtlYfvC2C/7uhpp5A5/j4YJgJIUmGmxZYaQWr8MJU5HVxB/CpWKUrJK?=
 =?us-ascii?Q?CPuVkRWyzPKpRoUrtZvIAiHSneIpSTuHvwFxRXiRbhqzLYTuGTfxds9nVdtq?=
 =?us-ascii?Q?Bv/3aKQqWryydm6OlCKoLwXFS+mFq7O9vFDwT9vB1fvjLXKCrwZ7LBWRRRjx?=
 =?us-ascii?Q?exL+/m1gGJOYCB/t3egHmbcoG8b1P62YFRAQSdJtm9MwBxotF/DrH+z8P6MU?=
 =?us-ascii?Q?Q3PjoFhlVjbCJ2BDUyL4vu98w3C6c3IVUC+vWsa84ElAZUr9GfN3Jv+ss9uR?=
 =?us-ascii?Q?QgfQoL3SwVj5YC1FjFjXApv8ugpl1Yfr7fmOjJF7A+lqkjnQDGNiNbtbLA1r?=
 =?us-ascii?Q?2NpEiJGGONrcL80jGA5GaFSDyptKIDVIgmzobVAk0vEi1RH/d4jx9l2lI1RV?=
 =?us-ascii?Q?lSfC3bLMaLPDhz/CC2TQrCSrIwfbWkvsNVPe2k1VifELHNZdu3xWWBdnWw3w?=
 =?us-ascii?Q?aKYBwZRWsgXWhl8YrXk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:21:10.1348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30950a8-fdac-4a61-f348-08de28619488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
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

From: Harry Wentland <harry.wentland@amd.com>

[WHAT]
It calls DC_FP_START/END and shouldn't be living inside an
FPU compilation unit.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |  2 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  | 36 +++++++++++++++++++
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |  7 ++++
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  | 34 ++----------------
 4 files changed, 47 insertions(+), 32 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index a112931007b1..631ea04059a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -73,7 +73,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_mall_phantom.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml_display_rq_dlg_calc.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_dc_resource_mgmt.o := $(dml2_rcflags)
 
-DML2 = display_mode_core.o display_mode_util.o dml2_wrapper_fpu.o \
+DML2 = display_mode_core.o display_mode_util.o dml2_wrapper_fpu.o dml2_wrapper.o \
 		dml2_utils.o dml2_policy.o dml2_translation_helper.o dml2_dc_resource_mgmt.o dml2_mall_phantom.o \
 		dml_display_rq_dlg_calc.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
new file mode 100644
index 000000000000..b665bd4569a5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Authors: AMD
+ */
+
+#include "dml2_internal_types.h"
+
+bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2,
+	enum dc_validate_mode validate_mode)
+{
+	bool out = false;
+
+	if (!dml2)
+		return false;
+	dml2_apply_debug_options(in_dc, dml2);
+
+	/* DML2.1 validation path */
+	if (dml2->architecture == dml2_architecture_21) {
+		out = dml21_validate(in_dc, context, dml2, validate_mode);
+		return out;
+	}
+
+	DC_FP_START();
+
+	/* Use dml_validate_only for DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX path */
+	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
+		out = dml2_validate_only(context, validate_mode);
+	else
+		out = dml2_validate_and_build_resource(in_dc, context, validate_mode);
+
+	DC_FP_END();
+
+	return out;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
index c384e141cebc..ee6051737204 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
@@ -306,4 +306,11 @@ bool dml2_validate(const struct dc *in_dc,
 void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,
 	unsigned int *fclk_change_support, unsigned int *dram_clk_change_support);
 void dml2_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2);
+
+void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *dml2);
+bool dml2_validate_only(struct dc_state *context, enum dc_validate_mode validate_mode);
+bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_state *context,
+		enum dc_validate_mode validate_mode);
+
 #endif //_DML2_WRAPPER_H_
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
index 9deb03a18ccc..e1a41bf5e546 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
@@ -395,7 +395,7 @@ static bool call_dml_mode_support_and_programming(struct dc_state *context, enum
 	return result;
 }
 
-static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_state *context,
+bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_state *context,
 		enum dc_validate_mode validate_mode)
 {
 	struct dml2_context *dml2 = context->bw_ctx.dml2;
@@ -505,7 +505,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 	return result;
 }
 
-static bool dml2_validate_only(struct dc_state *context, enum dc_validate_mode validate_mode)
+bool dml2_validate_only(struct dc_state *context, enum dc_validate_mode validate_mode)
 {
 	struct dml2_context *dml2;
 	unsigned int result = 0;
@@ -538,41 +538,13 @@ static bool dml2_validate_only(struct dc_state *context, enum dc_validate_mode v
 	return result == 1;
 }
 
-static void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *dml2)
+void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *dml2)
 {
 	if (dc->debug.override_odm_optimization) {
 		dml2->config.minimize_dispclk_using_odm = dc->debug.minimize_dispclk_using_odm;
 	}
 }
 
-bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2,
-	enum dc_validate_mode validate_mode)
-{
-	bool out = false;
-
-	if (!dml2)
-		return false;
-	dml2_apply_debug_options(in_dc, dml2);
-
-	/* DML2.1 validation path */
-	if (dml2->architecture == dml2_architecture_21) {
-		out = dml21_validate(in_dc, context, dml2, validate_mode);
-		return out;
-	}
-
-	DC_FP_START();
-
-	/* Use dml_validate_only for DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX path */
-	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
-		out = dml2_validate_only(context, validate_mode);
-	else
-		out = dml2_validate_and_build_resource(in_dc, context, validate_mode);
-
-	DC_FP_END();
-
-	return out;
-}
-
 static inline struct dml2_context *dml2_allocate_memory(void)
 {
 	return (struct dml2_context *) vzalloc(sizeof(struct dml2_context));
-- 
2.43.0

