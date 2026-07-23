Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9CFC531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B7910F1F3;
	Thu, 23 Jul 2026 20:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SA2Y5aFf";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B50710F1F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFOpzSBol2Rx70+NuK/yNIAJSgtY6G6LnWhJN0Zh6tR/82HKTpNtJ6tOIjP7QP9TOgtC+rJ3kcA+3n+7mR1el1dnaB2RapnAInAcz35k68f+fRmFlZrVk84sPVYbM/rX89JOYbbTSlrfG1ZpBJ5kw6CUg42k/xzqDawhNDXKvmZtic+92SI/m5VivscrwoH9q0rQopB6fGroC5WsPLankAAjxIkTeUO3wtPNFiFOQhaVzNpp7qLmfMiez7M1hEJtaRiE6FH01fUJNaqNd+q1lCu77bSFZtvSxiSRil9e5GZxIfEioCPaJTrF2PgN7CfxqpGiLzZIai1x7xPzJrB2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWJ9OLWZTrBV+GeaG2lOHPqSM1VSa9oJpcQrmyMxA4U=;
 b=W/Fgb15pzFVnI+yhYZUDF1DC1D1oeE8+pcYVeEcXUHBU4Hb3PzY9fRQG+QSls0VXDMgnJXC4+fTPZR8nZcQfPGxa7FogHUlGF2sa7bMRjTwDWGtUXoJPBA6/joml/Mx9xCbZ6UEEGFg9wTITngksYIq36pNU/22K3qb5wXQnPG2ZcbVGBWqwZ52eLyJ/n4PBa3ILmlB6WhilH/q+eJAXP5T/C3A3lvMQB0O+OgIsE/y/ZiFzoW6cbtcrA/Mg7IGzwtZdAe+c8Gg8hbwhy8AwMGqt3bJwVIDa65DGY/8XarTAegAP/buHTHeYujKhj+2RYDb7fFiH7k7QjEwi5lPhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWJ9OLWZTrBV+GeaG2lOHPqSM1VSa9oJpcQrmyMxA4U=;
 b=SA2Y5aFf9RlcebX7sQeus/aFlKp/izNQpfFOrFM6JdJW+iqKerM4MFtro+Xly68USXfo8N9z47kW0szFsuMIdx8nbFA5i7LqAkMtB12Bc9dR2HAUcjCI8D62HAPr4tsPvlCmag93bY5DzzFK8CiQdR/kQxX1A0werubufqN3NUk=
Received: from MN0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::22)
 by CH1PPF9C964DBFE.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:20:05 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::42) by MN0P223CA0005.outlook.office365.com
 (2603:10b6:208:52b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:20:05 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:23 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alexander Chechik <alexander.chechik@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 47/49] drm/amd/display: plumb PMO per-plane pstate methods
 into mode_support
Date: Thu, 23 Jul 2026 16:13:55 -0400
Message-ID: <20260723201908.373300-48-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH1PPF9C964DBFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0690d4-b262-4b93-1ae3-08dee8f7c87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|11063799006|5023799004|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OqgaOeDvsweOCAHuCQ079SH+ShGTVlGwJLJ7UBVqm3+4trDanIAkQ9K4flV829gLHUK8xRLGBz6yv3JmRyxzOr39KPbKDqkjpyacV2TONVmgUtqeHPyKwsXfSncKz0ODOews+UafDPGst0fAn3XqqlL/RAowMFJ/uskKswiIfq7gwB7Sb49dKAzuhhGd+lyX7lM0ui04kKC55Js1zNrwtphpkByc2xsmIhiHEgIX0kcvgNTYycc8BpM/bh7Tve111N018tObeztuWz9lLJyp+W2uL3aLmLfYfn6x0tI9tQkGTmqrN5c0O6eU5TQXdUGyzFwFNP+oLUarguZj7a7CRy9fUE5PqtAuMVm+kuglypr2tzQDQvcibWlE9nfm1fjFzD9QLzGakuX+MIkE21dAgcOATlszXHzHkQPk6KJxZUdYGgO02ZuKUsp2tlNQBJ6/W7P2Sv1LsnBN63unhc5l7aBYs5RG/Vm67Ly4NvzMuclgtSAesmmXltLRUE19uedZRQ81YQs5uqwUUpyy16APb5bWb2jkykBM4AJf/mUQJgUPqJJpDa6tppyDLlMutoAAgHQM+o3SN0BeliFevmyTBhHzr42Tm1voN0t6tOjrqU0FPub/fMOW5/7ILXg0rBK170oMXZyzXmXKgy1bNgQFR6GvbK92giPjTuchlB6pbK8mmxJyXZKKKE+6AmVXtLCHZWQmgqX7fh+dvJiKX+ciLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(11063799006)(5023799004)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RdFrsgxWsQ0HzycjChlxnZJUbkR+QLmwjgBEMNKHdsTcIgBIF4AgWLVz8d9RtYh5UPu6vkajFr8WQZ2cXit7rSZJllTJrySbZL30GaX+N0zpOKVYbKYaHRjz2+5lY50N3UBsRt0u1w2sYM/NV1DF9tdAYadI4mwVTqyoyMTocJOeMaB3WY2Meji4efokvUAVh1XOzClaLVITLoLY0Y1o/uVjtcmQa80p+ZaMLLM6IHVjWl50nXA1J72FJaagm03T6HdnjuE4tbFX674UiWEkLzMWThat0oQ5M9KHq1ZIjFeBhnzZJTe7Dyh8CnIdqAoEcvWaYDEt2hZEXjJERDSJTX4vjHmiEGbwl0mX/pYQWCuKiX6ReXN4pH+4hfQZ9Juoad1IKDuVs6hH/ibQDFFEHRFAMwmUJwUU7aASvf/Jp2s0rbH2mczVk07HHVfIR8PV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:20:05.0961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0690d4-b262-4b93-1ae3-08dee8f7c87d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF9C964DBFE
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

From: Alexander Chechik <alexander.chechik@amd.com>

[Why]
mode_support reads mode_lib.ms.uclk_pstate_switch_modes to enforce the
vactive pstate margin, but nothing populates it: the memset clears it and
the PMO selection is never passed in. The check always sees na and never
runs, so a plane with negative vactive margin can still pass and blank the
display.

[How]
Add a const per-plane pstate-method pointer to mode_support_ex, point it at
stage3.pstate_switch_modes when stage 3 has run (NULL otherwise), and copy
it into mode_lib.ms after the memset. Scope the support-required check to
the vactive methods it governs (vactive, fw_vactive_drr) so SVP, DRR and
vblank planes are not rejected by the vactive support flag.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Alexander Chechik <alexander.chechik@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c | 10 +++-------
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c  | 17 +++++++++++++----
 .../src/dml2_core/dml2_core_shared_types.h      |  1 +
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 45f1bf5e14bf..6ea36aedcf20 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -554,13 +554,9 @@ bool core_dcn4_mode_support(struct dml2_core_mode_support_in_out *in_out)
 	l->mode_support_ex_params.min_clk_index = in_out->min_clk_index;
 	l->mode_support_ex_params.out_evaluation_info = &in_out->mode_support_result.cfg_support_info.clean_me_up.support_info;
 
-	for (i = 0; i < l->svp_expanded_display_cfg.num_planes; i++) {
-		if (i < in_out->display_cfg->display_config.num_planes)
-			core->clean_me_up.mode_lib.ms.uclk_pstate_switch_modes[i] =
-				in_out->display_cfg->stage3.pstate_switch_modes[i];
-		else
-			core->clean_me_up.mode_lib.ms.uclk_pstate_switch_modes[i] = dml2_pstate_method_na;
-	}
+	l->mode_support_ex_params.uclk_pstate_switch_modes =
+		in_out->display_cfg->stage3.performed ?
+			in_out->display_cfg->stage3.pstate_switch_modes : NULL;
 
 	result = dml2_core_calcs_mode_support_ex(&l->mode_support_ex_params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 4ca6a4521f11..09452f3e49db 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -8057,6 +8057,16 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	memset(&mode_lib->ms, 0, sizeof(struct dml2_core_internal_mode_support));
 
 	mode_lib->ms.num_active_planes = display_cfg->num_planes;
+
+	for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+		if (in_out_params->uclk_pstate_switch_modes &&
+				!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k]))
+			mode_lib->ms.uclk_pstate_switch_modes[k] =
+				in_out_params->uclk_pstate_switch_modes[k];
+		else
+			mode_lib->ms.uclk_pstate_switch_modes[k] = dml2_pstate_method_na;
+	}
+
 	get_stream_output_bpp(s->OutputBpp, display_cfg);
 
 	mode_lib->ms.state_idx = in_out_params->min_clk_index;
@@ -9644,14 +9654,13 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 
 	if (!display_cfg->overrides.all_streams_blanked) {
 		for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-			if (mode_lib->ms.uclk_pstate_switch_modes[k] == dml2_pstate_method_na)
+			if (mode_lib->ms.uclk_pstate_switch_modes[k] != dml2_pstate_method_vactive &&
+					mode_lib->ms.uclk_pstate_switch_modes[k] != dml2_pstate_method_fw_vactive_drr)
 				continue;
 
 			mode_lib->ms.support.global_dram_clock_change_support_required = true;
 
-			if ((mode_lib->ms.uclk_pstate_switch_modes[k] == dml2_pstate_method_vactive ||
-					mode_lib->ms.uclk_pstate_switch_modes[k] == dml2_pstate_method_fw_vactive_drr) &&
-					mode_lib->ms.VActiveLatencyHidingMargin[k] < 0)
+			if (mode_lib->ms.VActiveLatencyHidingMargin[k] < 0)
 				mode_lib->ms.support.global_dram_clock_change_supported = false;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 131cec64aa48..b8af72392176 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -2333,6 +2333,7 @@ struct dml2_core_calcs_mode_support_ex {
 	int min_clk_index;
 	//unsigned int in_state_index;
 	struct dml2_core_internal_mode_support_info *out_evaluation_info;
+	const enum dml2_pstate_method *uclk_pstate_switch_modes;
 };
 
 struct core_display_cfg_support_info;
-- 
2.53.0

