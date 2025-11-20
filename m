Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A59CF9C7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4024910E7BC;
	Thu, 20 Nov 2025 18:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rd/jw4cO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD1210E7BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8W+9Q8QCbwzuAS7JiEeqJ1tCXzWYDsIAaKXxfLgVZ6CS8b1zLpDyflR9dJsdctrhIwbfcLguwE4synWjvHuGkiVtjK+47zQT853+cVM98HOH76rj0vsLlf9+H1Oih8TcnATWb81u6Pmy9cv7rRDi50zo3vVkns7AA/6EoPn8Agl+euqCBL6gfCzfknTv14OHHrxFWHOcFTf5wcc0ypKHp/Ix3PufgjS/QSj8pSPI+hCNmInkSMwejqDncYyVbv6iEoKN9Ol+Qc01P3foqJ6SYP8Rlc9+MVocm351SLx0tsYa/HYZKxJ6zvfL0dGMRsBUv+8I88pSmShWxbLJwmU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da70HpRDhAvxVbkmrnyO9BPl/WdMHWdYjzvOpATaIeo=;
 b=glm72aILfqYf/m48YXndv+3fNUfcJ7pZ5EICZPUh41ES0BJo20Rz2j/+OcjQFFANqwe47SE0xy+7/Zuo6RtqWIAGPmbnVkFWkxqHYXz5uX2PJNobTfjsyCBcPcids2C4KcR5BQJvTRgCOuvOGP4gmomBrcF5aX9aUyL+HG8cwhWGvRjB0Cw9pY/WLR4K5wc1Gok1rP8F0PqbH7xKZe0TpRZvKJxZ3XfnscvoO3MDLbu+sCb++2KNeg3BzFaEWjhdESYoW2LJCUKQbcHhzvlmCzDqyoyNL3s8MGzgGNadR+7apUfeh50yVqrQLnOkQstj9FFgoNimtMI9Zod9hiw5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da70HpRDhAvxVbkmrnyO9BPl/WdMHWdYjzvOpATaIeo=;
 b=Rd/jw4cOpmCZ2RupxIO3dvHdx4y+0hxZAzUZ5stS3Vtpy3R8Ibj5p1AJbBs07ILGZvkoO36W59XHGvjgvrp40L4vQ/Jxy+zIH2ykPkMCPNKp2alNXnI7BAYxDrJUQReYjwG5YEL+x2M8U9LTxsOO9WZhVyfaxglaxqD6foN4w1I=
Received: from DM6PR13CA0020.namprd13.prod.outlook.com (2603:10b6:5:bc::33) by
 BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 18:21:24 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::6e) by DM6PR13CA0020.outlook.office365.com
 (2603:10b6:5:bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 18:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:21:24 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:21:22 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 18/26] drm/amd/display: Move dml2_create and init to the
 non-FPU dml2_wrapper
Date: Thu, 20 Nov 2025 11:03:14 -0700
Message-ID: <20251120181527.317107-19-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca9f0af-84d2-4e5b-29fa-08de28619d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D59hXTrMdJ8iiZi0G5gYR2ZsF9J1SqSXvpmvOCJsgOAlQVbesBTMxUSBSehj?=
 =?us-ascii?Q?szmUpf/GE7bFbKkApaRLCPhA5i7xBzchT6JOWxNI3XSzPhq0SXK9Rze0dmPU?=
 =?us-ascii?Q?LY/aHk1fQxU61ubXDyOZu+LF2KHmLC1rmM6oa0+rmTP/EivlNUQWaCma+jVW?=
 =?us-ascii?Q?LeHzH5NgbwLMfPEGK5P87m1JMKGLj8rTkzhnNimBBBE8VqbxvIx5S4rHWQCl?=
 =?us-ascii?Q?GYX8EiUC7F2HGrZ0gJutwZm9CMyNksvoXP2bhzKVAfyRmJZLcajnIH52x00I?=
 =?us-ascii?Q?eNSKCWMfSRtpKvBZdwbJWo4/EwL8vd0A/pr1BGedQMLfRjjDs7PGT2Rm5uWg?=
 =?us-ascii?Q?2aII8L5Xd79P9LYa59uX7qrLNNUifTLr/7OoGDNHlXjAzBFgLBlGlxCW8YSe?=
 =?us-ascii?Q?17IbIZdaauP02s4tH5z7HQ0XuT6Y/aY5NGnpptGqzfThxsH4YhuuC4eQt1E+?=
 =?us-ascii?Q?tDZeHPHr3uRrwtJ+hSAImxT3N98tQ9HXSzdSWsX3HmAS0ui8KhYmrsf47Xrv?=
 =?us-ascii?Q?6b2atArqUmv8VHSRvRGEqTmTmzXpAHXLG/ysMm+G0Gao/LVOA7WD/G8GwyZ7?=
 =?us-ascii?Q?zFEw1AqYmSzAxArkTjI+j4bI9Y5cuu+J9O9yxYRcyQdVmSG6AVuF7AvLzAUO?=
 =?us-ascii?Q?2ypsg+pLZRu08IiixGFyeIS933UaAN5CRMYT1voWBx7hqcsl0pSB2PPIWqyy?=
 =?us-ascii?Q?xWDf9lMleM3a0d+Qw2bzICbk21sGUNOnW/ViE5+Zg7jvbvAsV5obZKTtz8Ry?=
 =?us-ascii?Q?kGYylwipmFksvSoAyveUq+6lSqMeCczDmasNjLCdcFSQSq4IP388BvSxytF0?=
 =?us-ascii?Q?sW9iim5Q8GZ3KJydY9a1RjheTbWRshyiMddG98Dd32uHa2coH3n8CjzE7DPj?=
 =?us-ascii?Q?WjkIr1nRLAgbeZqDDg0TmyQ5py9omHKfm21dMaJGFK6hnkKD7xu3KJglXf/1?=
 =?us-ascii?Q?1YOH5f+pzwaIdHg2sqCtBuX3ZRDKjV804zvygHhTEX903FmP6TxdyTDMJJ+S?=
 =?us-ascii?Q?OddXnwTG3ClFE3sKn6Fir2CtYoPHyX5vMZDZI8o+uoQ09J+B0+Yt7nPRF3FC?=
 =?us-ascii?Q?4DH6q1Z4DtVcZgEPRhzOoboYIO0hkGT+vGCqDaLNiVmkYd/9EnSwVETraw5e?=
 =?us-ascii?Q?lliGVRDhi7+/1klEZXf5oMBsdNJEDYBWVUHAyWlxWuiGf8O150J/mihsX3sT?=
 =?us-ascii?Q?2bdPNsaSW7MNOsDtAl0ORcM5iitfO/ZT1gQl622PaHCtgKZAOYNz7YHe7yH3?=
 =?us-ascii?Q?tqPg2+sNyqmOnDJCjC/Naf7EWZVaE4IL9SCu0lR51CTpEX+ExQv+nPrR4j98?=
 =?us-ascii?Q?rjgfCxRyiO8ujZy/hxhRxXasNxiKP9qbMzScXuYucqCbhbnzC6h4fKnirzWy?=
 =?us-ascii?Q?INsQDzgW8T23hrSan2+bXQcgtiIDWvDfvqBSSYH0f1YLEmGlZKUQKKLJtbIn?=
 =?us-ascii?Q?XLEhdgz0WmNVoqDffnqErDvk2T5mJ8ymdKRMWyCnC5E+uFG0F52myCV3iRV6?=
 =?us-ascii?Q?Wy9m3CXeAU4L9LiL2uyJAqmWACUlVzGHUsAVWuPfK/iW4l7FAt4AWdaVxusq?=
 =?us-ascii?Q?nKTRGLTSG4DcL/XnH80=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:21:24.4817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca9f0af-84d2-4e5b-29fa-08de28619d15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
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
dml2_init calls DC_FP_START/END and needs to be moved out
of the FPU compilation unit.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  | 75 +++++++++++++++++
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |  2 +
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  | 82 ++-----------------
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.h  | 25 ++++++
 4 files changed, 107 insertions(+), 77 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
index b665bd4569a5..307186eb6af0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -6,6 +6,7 @@
  */
 
 #include "dml2_internal_types.h"
+#include "dml2_wrapper_fpu.h"
 
 bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2,
 	enum dc_validate_mode validate_mode)
@@ -34,3 +35,77 @@ bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2
 
 	return out;
 }
+
+static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+{
+	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01)) {
+		dml21_reinit(in_dc, *dml2, config);
+		return;
+	}
+
+	// Store config options
+	(*dml2)->config = *config;
+
+	switch (in_dc->ctx->dce_version) {
+	case DCN_VERSION_3_5:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn35;
+		break;
+	case DCN_VERSION_3_51:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn351;
+		break;
+	case DCN_VERSION_3_6:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn36;
+		break;
+	case DCN_VERSION_3_2:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn32;
+		break;
+	case DCN_VERSION_3_21:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn321;
+		break;
+	case DCN_VERSION_4_01:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn401;
+		break;
+	default:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_default;
+		break;
+	}
+
+	DC_FP_START();
+
+	initialize_dml2_ip_params(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.ip);
+
+	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
+
+	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
+
+	DC_FP_END();
+}
+
+bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+{
+	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
+	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01))
+		return dml21_create(in_dc, dml2, config);
+
+	// Allocate Mode Lib Ctx
+	*dml2 = dml2_allocate_memory();
+
+	if (!(*dml2))
+		return false;
+
+	dml2_init(in_dc, config, dml2);
+
+	return true;
+}
+
+void dml2_reinit(const struct dc *in_dc,
+				 const struct dml2_configuration_options *config,
+				 struct dml2_context **dml2)
+{
+	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01)) {
+		dml21_reinit(in_dc, *dml2, config);
+		return;
+	}
+
+	dml2_init(in_dc, config, dml2);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
index ee6051737204..9a9c27962f68 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
@@ -312,5 +312,7 @@ bool dml2_validate_only(struct dc_state *context, enum dc_validate_mode validate
 bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_state *context,
 		enum dc_validate_mode validate_mode);
 
+struct dml2_context *dml2_allocate_memory(void);
+
 #endif //_DML2_WRAPPER_H_
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
index e1a41bf5e546..203eef747262 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
@@ -32,8 +32,9 @@
 #include "dml2_mall_phantom.h"
 #include "dml2_dc_resource_mgmt.h"
 #include "dml21_wrapper.h"
+#include "dml2_wrapper_fpu.h"
 
-static void initialize_dml2_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out)
+void initialize_dml2_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out)
 {
 	if (dml2->config.use_native_soc_bb_construction)
 		dml2_init_ip_params(dml2, in_dc, out);
@@ -41,7 +42,7 @@ static void initialize_dml2_ip_params(struct dml2_context *dml2, const struct dc
 		dml2_translate_ip_params(in_dc, out);
 }
 
-static void initialize_dml2_soc_bbox(struct dml2_context *dml2, const struct dc *in_dc, struct soc_bounding_box_st *out)
+void initialize_dml2_soc_bbox(struct dml2_context *dml2, const struct dc *in_dc, struct soc_bounding_box_st *out)
 {
 	if (dml2->config.use_native_soc_bb_construction)
 		dml2_init_socbb_params(dml2, in_dc, out);
@@ -49,7 +50,7 @@ static void initialize_dml2_soc_bbox(struct dml2_context *dml2, const struct dc
 		dml2_translate_socbb_params(in_dc, out);
 }
 
-static void initialize_dml2_soc_states(struct dml2_context *dml2,
+void initialize_dml2_soc_states(struct dml2_context *dml2,
 	const struct dc *in_dc, const struct soc_bounding_box_st *in_bbox, struct soc_states_st *out)
 {
 	if (dml2->config.use_native_soc_bb_construction)
@@ -545,73 +546,11 @@ void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *dml2)
 	}
 }
 
-static inline struct dml2_context *dml2_allocate_memory(void)
+inline struct dml2_context *dml2_allocate_memory(void)
 {
 	return (struct dml2_context *) vzalloc(sizeof(struct dml2_context));
 }
 
-static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
-{
-	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01)) {
-		dml21_reinit(in_dc, *dml2, config);
-		return;
-	}
-
-	// Store config options
-	(*dml2)->config = *config;
-
-	switch (in_dc->ctx->dce_version) {
-	case DCN_VERSION_3_5:
-		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn35;
-		break;
-	case DCN_VERSION_3_51:
-		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn351;
-		break;
-	case DCN_VERSION_3_6:
-		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn36;
-		break;
-	case DCN_VERSION_3_2:
-		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn32;
-		break;
-	case DCN_VERSION_3_21:
-		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn321;
-		break;
-	case DCN_VERSION_4_01:
-		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn401;
-		break;
-	default:
-		(*dml2)->v20.dml_core_ctx.project = dml_project_default;
-		break;
-	}
-
-	DC_FP_START();
-
-	initialize_dml2_ip_params(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.ip);
-
-	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
-
-	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
-
-	DC_FP_END();
-}
-
-bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
-{
-	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
-	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01))
-		return dml21_create(in_dc, dml2, config);
-
-	// Allocate Mode Lib Ctx
-	*dml2 = dml2_allocate_memory();
-
-	if (!(*dml2))
-		return false;
-
-	dml2_init(in_dc, config, dml2);
-
-	return true;
-}
-
 void dml2_destroy(struct dml2_context *dml2)
 {
 	if (!dml2)
@@ -663,14 +602,3 @@ bool dml2_create_copy(struct dml2_context **dst_dml2,
 	return true;
 }
 
-void dml2_reinit(const struct dc *in_dc,
-				 const struct dml2_configuration_options *config,
-				 struct dml2_context **dml2)
-{
-	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01)) {
-		dml21_reinit(in_dc, *dml2, config);
-		return;
-	}
-
-	dml2_init(in_dc, config, dml2);
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.h
new file mode 100644
index 000000000000..573df874b901
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Authors: AMD
+ */
+
+#ifndef _DML2_WRAPPER_FPU_H_
+#define _DML2_WRAPPER_FPU_H_
+
+#include "os_types.h"
+
+struct dml2_context;
+struct dc;
+struct ip_params_st;
+struct soc_bounding_box_st;
+struct soc_states_st;
+
+void initialize_dml2_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out);
+void initialize_dml2_soc_bbox(struct dml2_context *dml2, const struct dc *in_dc, struct soc_bounding_box_st *out);
+void initialize_dml2_soc_states(struct dml2_context *dml2,
+	const struct dc *in_dc, const struct soc_bounding_box_st *in_bbox, struct soc_states_st *out);
+
+#endif //_DML2_WRAPPER_FPU_H_
+
-- 
2.43.0

