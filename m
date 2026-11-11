Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CD606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=U7U5fAoP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7FC10F8C1;
	Wed, 11 Nov 2026 01:41:47 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E59710F8C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3GrAHyv2oNXxhoZgmwByZrQX4UHRUcExurWLDtOuO4DgilccxF9s8pdiMfCxdwdx7X6AtwVM+HZpb1NbrvG/mP96w9oxQd9wywj6Gsws0Y4uO88qPNEnpyJRiNiWZi+zdacQQlB9vvuf8DJy6zl4ZEKz2Iywg5/LBqvSI3xLRaMHp05K6PBNbWg5PuM228yZvj0pwNOiDHhoaZKeQ96CKT0kjENr39lK3ROhNY5IicC9BfRSspyH+0uZdYLHNAgZp+EWxaiTcKX1cSatRH48St9qoGGZgWkI/cLG2sC8Uc2AjIEEp3fdI/RJC1/GvgT2PQD3um/77Oi0oDpryS0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKcrWTbOlc+30xrl6sGprW+dqIV4dq5I9wr+XkdYAUQ=;
 b=ykgXJxN9bINBjcnOuAs5cnCVlng27s0c5sPrebyYqsod1Lx786S7JklxY0Bf7BSj6xS7OACo0RS3WM4VmkLJJg1zWPKbT+H7Zge54IKGlhFGirPyuE3+UhuPwJdOKrT9HUvdzKX0q0cy0oPYEvkQBlnnPXK9Ep6rfde5yxkH0JTOYLVoL/tL67NqEu27HOwcToGWjOf3SZs4HmGPHaRDAW9SBqiNjCuz5AHjOzvop1NqNsE47MSpXjX+luuKnDRyLTx9xQghfcfIuFTpDryRTec8deNvgl8fVXV6nvuN9FF1wXq6bYwJORxaSn7xxuGfVWY/Ng3tNVDZ/pLIkGnUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKcrWTbOlc+30xrl6sGprW+dqIV4dq5I9wr+XkdYAUQ=;
 b=U7U5fAoP1z2WRr+LFHmhJlFNZiNoBj7BzqoztNPClAdNmcuur7JW9f7y0KrKkjgBgtDfugSGBWEbhiuBBAt6oonBPpOcayuGlIET2jbxudeScSSei7UZ1p04YuWvKWULv4mkmZ76Q8PjxJg40CN6a1Fjp4jcnvB39szsNsccWHg=
Received: from CH2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:610:53::12)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 01:41:05 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::63) by CH2PR17CA0002.outlook.office365.com
 (2603:10b6:610:53::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:04 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:01 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>
Subject: [PATCH 11/74] drm/amd/display: Relax stutter constraints for DRR
 streams
Date: Wed, 11 Nov 2026 09:28:17 +0800
Message-ID: <20261111014100.3596072-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf68668-279d-4872-a566-08df3f94da07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|261102123227099003|56012099006|11063799006|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: pNwTxsqa0KLcFzFh6Fm+ckolRhDM/8w3YTAwQW/6c65YZeHzR5y7Fw4mX/SC++EffgtcrgLBlQ0/YwjHBaQbaefabdNfPCgasCqofVfomr6sj8X9jIGZe9fcZRG0yvhav7T155+/IlG+KWqGrbWG/SMX3WCp++moV6MsZ4Zo/PLNSURDuWgkYQQpPHY/dqZGycPiMEMKjLoo7ATgelG4GoNWjYQxAGMvaJQA2vDk5XD1l434eSPZG0YZAKcdYOkr693+89yJIXFJdwCUnAhh/BMIWmn0UiGqD3LzB/DkAHYVx0kkdsE5uiXYJWpztYiIED9K1RpjnBRHPuEz1XqP0wwxovsSEguNLM1suq3AQRHNA/vMtPRcqWwgfdxUcI1Hh9XGDk+ymdAsMM2RhpiGHUdJddaN3x1t61EQy4Of560rOzvBA2SQRUrq5CxEJso3OgsBz0arviVgIRJLulHgMBzdDfbeh83TCuC6domC2XZDUv9vCGLmj+hDCfZ0cMDK3d7jlaEbFGr5aQLYoNYUmgdVlMUpCzvtgYTrNcrWYnl5e8KEwfzUBUHJKoNZ9fczuYB9l2L+f/qSxotPqhuqZpI8sn4B0Yn7C2Mua+EBl7nR3aGtwGUR28fuPexRUlnUr+Jud4nL+weqUOtcDH0gF6I8cwK/WfVQ56a1I7ExXKOJBbit/5AnfHTOicTrH/vi9XYVFq+lHTxxyJRkYK0a5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(261102123227099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 461Dw+FBQGoIUymIojfK0PmR8aFDPQiy9vgZ14293TkKymgjrIDbunN5xMSGoJ051BMSAFcwMjqyXTF6/tmu5fldmK1oO1/x3mTzVEaDcHSQEY8Uj3MNtz9Hmg3fjr7Z1QU8HzNkcQQLeS7bm/5erSyltnN+zSSBCcU+AwbZ9PIm1ZLvHGl7Huh5OyHEG/T7QeOdl9qVWDG8kCPzeaKNjyc2pCsRhFMNjYqE0svCDJox+I03/bTyTB8etY+L3HaxmIVv6eChEy2glZ1eqLKh/OPYUPoItVm6VvhloH5UFVfIsenL2F8aOEh8IEfnz7PuzFJvkgm7u80dd99rmczjXsx3tgc7y12D7O5mhtCO4KbvQtONxHwQ/htUbeqLqa/YRrUGPVIuOFquCS9A0JQQ87z9JbCOsLJsTXym/yFUVMCwn3auPIiRSH+bPa84JqiS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:05.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf68668-279d-4872-a566-08df3f94da07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dillon Varone <Dillon.Varone@amd.com>

Why:
DRR can extend blanking beyond nominal vblank, but the existing stutter
eligibility checks can reject streams using the nominal blanking duration.

How:
Add a PMO option to relax the blanking factor for fixed-DRR streams,
and apply the relaxed threshold when checking Z8 and regular stutter
latency requirements.

Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index 75a24a85775e..fd7ccefc7fb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -83,6 +83,7 @@ struct dml2_pmo_options {
 	bool force_optional_uclk_pstate_support;
 	bool force_optional_mcache_support;
 	bool force_optional_ppt_temp_read_admissibility;
+	bool relax_stutter_constraint_for_drr;
 	struct dml2_pmo_pstate_strategy *override_strategy_lists[DML2_MAX_PLANES];
 	unsigned int num_override_strategies_per_list[DML2_MAX_PLANES];
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index de078ccd91a2..3584dbe4c9fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -8,7 +8,7 @@
 #include "dml2_pmo_dcn4_fams2.h"
 
 static const double MIN_VACTIVE_MARGIN_PCT = 0.25; // We need more than non-zero margin because DET buffer granularity can alter vactive latency hiding
-static const double MIN_BLANK_STUTTER_FACTOR = 3.0;
+static const double MIN_BLANK_STUTTER_FACTOR = 3.0f;
 
 static const struct dml2_pmo_pstate_strategy base_strategy_list_1_display[] = {
 	// VActive Preferred
@@ -2357,6 +2357,16 @@ bool pmo_dcn4_fams2_optimize_for_pstate_support(struct dml2_pmo_optimize_for_pst
 	return success;
 }
 
+static bool should_relax_stutter_constraint_for_stream(const struct dml2_pmo_init_for_stutter_in_out *in_out,
+		unsigned int stream_index)
+{
+	// relax the stutter constraint when:
+	// 1. Stream has DRR fixed enabled (assumed blank is extended sufficiently beyond nominal)
+	// 2. The option to relax stutter constraint is enabled in PMO options.
+	return in_out->base_display_config->display_config.stream_descriptors[stream_index].timing.drr_config.drr_active_fixed &&
+			in_out->instance->options->relax_stutter_constraint_for_drr;
+}
+
 bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in_out)
 {
 	bool success = true;
@@ -2365,6 +2375,7 @@ bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in
 	bool z8_stutter_optimization_too_expensive = false;
 	bool stutter_optimization_too_expensive = false;
 	double line_time_us, vblank_nom_time_us;
+	double stutter_factor;
 
 	unsigned int i;
 
@@ -2382,15 +2393,17 @@ bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in
 	}
 
 	for (i = 0; i < in_out->base_display_config->display_config.num_streams; i++) {
+		stutter_factor = should_relax_stutter_constraint_for_stream(in_out, i) ? 1.0f : MIN_BLANK_STUTTER_FACTOR;
+
 		line_time_us = (double)in_out->base_display_config->display_config.stream_descriptors[i].timing.h_total / (in_out->base_display_config->display_config.stream_descriptors[i].timing.pixel_clock_khz * 1000) * 1000000;
 		vblank_nom_time_us = line_time_us * in_out->base_display_config->display_config.stream_descriptors[i].timing.vblank_nom;
 
-		if (vblank_nom_time_us < pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us * MIN_BLANK_STUTTER_FACTOR) {
+		if (vblank_nom_time_us < pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us * stutter_factor) {
 			z8_stutter_optimization_too_expensive = true;
 			break;
 		}
 
-		if (vblank_nom_time_us < pmo->soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us * MIN_BLANK_STUTTER_FACTOR) {
+		if (vblank_nom_time_us < pmo->soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us * stutter_factor) {
 			stutter_optimization_too_expensive = true;
 			break;
 		}
-- 
2.43.0

