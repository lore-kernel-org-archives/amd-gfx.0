Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9686606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L9LwjN08
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D52D10F8F0;
	Wed, 11 Nov 2026 01:44:33 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BFD10F8F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6HR19mXi/tcEmLZYmE6zvVu9E0JWCDaRBKvapbDe5fcwH2qeea3kpT4qeA92PKvB5soYPnytz11Kr/4+DoqGEN65UGRTrXh/6A5a/nDXpRN9jl9hqGmmulnuEst5TURN5U36ckEygNpvMi/PfqSzgHjcdmdPxFeD3z8CenzCSAhIAYaQD+IJgpJwotUh787zUwjIGREoQhtb63ke2neiMrC1WL6Cgi+nkKY2SwRGkNwyT8SwMhocM64pbKPsltUvteiCq9uCTsKViSL5XTOFY3nUEE3UqOs1fp/GWOQtOKIY9AvNsDyvHlAIxwJAT8XzHrePn4b+doD5e3C791HAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLsJAtOrp0ol1DAn96eqr3WXookcYDl3Sgb1WSIB52g=;
 b=YH7Q2D2zudineN868Mxbkuam2FH4sF7Gv2rt/FTUSwK2ghvH6Hy8NoEsSpWnFjcf3fCqSck/z6j1Oo+rg19GLABYOCezMK63aWd/6pr+lKSuFsZsjZhxsXz92skYz8MEcVBKCXQLoz1f14Wc2Wb7Wz/Hg719LP+zsBLq/MZdzbnEUlx6nrIFop1FoiTrEQyldJH6d08XtdVCj9Mov2VYCT1KXD/G2/YtUCnkeZhXgZf5SiSAI35OsWYNTkquaMUtGAblamV/pIwv3Su3uBfoBXINp5XYyD0MgntmG6aBXfzpHeMihwq+ikMs7sScCziX4+VeoDpDXkQx7Ycurf1KBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLsJAtOrp0ol1DAn96eqr3WXookcYDl3Sgb1WSIB52g=;
 b=L9LwjN08FoeCqEoZfdjRVOWedV5K5Uq8VTvAsQtRYzcH3GW4Yb+DweW0jJW/iP0NyNUz3Hxro41m7gDCjzqda6WeQ8I+mfea80wDQx5nb5ztPyZ8TA3lWzspk1D7qo2a+M0qDs29HxbAFTtqKAC3HdW1VqMqMn9QBKTP8GS6eYc=
Received: from CY8PR19CA0003.namprd19.prod.outlook.com (2603:10b6:930:44::12)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:44:20 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::3b) by CY8PR19CA0003.outlook.office365.com
 (2603:10b6:930:44::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 01:44:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:44:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:19 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:19 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:44:15 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabriel Abarca <Gabriel.Abarca@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 59/74] drm/amd/display: Update DCN6 Calcs
Date: Wed, 11 Nov 2026 09:29:05 +0800
Message-ID: <20261111014100.3596072-60-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bb0da6-9edc-4997-5a99-08df3f954e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261102123227099003|11063799006|5023799004|261021121427099003|261009223027099003|261021123027099003|56012099006|261026121527099003|261022075727099003|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: /TyOUCqRQrf6FrsHxjgDkr29/qle/JgFUogFoF2Vu6dmxm5uPk1a9SfGJQ9IH+H6x6MyKmpKciovjV04wPhm1W+7ArlgSZYKp8pU+YoqxKwLuJxHOa+4ehE6g3rSaK/GEwjQc6GT2hwaxNa8I7gC7yglPOgJxgFBg6qufOS18jtnW3wREKXlzJ99txQ8Up43aQGArhzwjZIqTF6P8J5ZFVoLznOiEtAifDnXlwNqN3zl9Bs+HTUHrxM6jABex5dXDZoJJsp43d9G6o0wBEmXK76X9B1qnGvHoTssJH2M8LgehCwr463L94CEejTUT0hQHRPpfWnM3Mdh+VEACkGOrz31QO7U16acyfcQtx1HT4pKf206bC/58XLcFp47V82vUtKxYZJ2TrsXXiG0vN+cVbDOdpW8/20xR82dq4LiflW+yT6SiH02d+tS+bwYeEp/Jc0lRbkKiCSV6e/t3j6OEAciBSRLCsG2z5kb2MJ4mxk6btOaalbO37w4ERATaOzCngp0r8UHNFRK85De7Ugin42tjP0C9pdHBFquHRRx/EN9byNPvLyB0dQZTthLZR9rJJgY+1LLCVd+u3aI8xkND8X5Q5OZrijntCmJSIxTTjQW65Srp+pKJEFZHhyECIPFfPKMSBOsy/nRaJKbwFpt+vLaY7f59xpqgmMqHiwhT9XSointfjR3O8DLz4IGxiH50F310DKk8aXNKqzXATY/Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261102123227099003)(11063799006)(5023799004)(261021121427099003)(261009223027099003)(261021123027099003)(56012099006)(261026121527099003)(261022075727099003)(18002099003)(22082099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fr7FqwgXAlhbeRFv9BQfaPv64iUdAJbjh5ZURdWkmt4DYImTbSkAu0LK8XA4AYCnbtuWmHQx3BZBA4I5b2yTXkctrxs1vGWCYaj5d8ZCxI+djQTOXsYdlCy+IjsVjPejfWTQ+jqnLwFZHXvkKOC62pZuT793CXKYYGZ/LFQFAjxiRZdT1kR+uLk5m3kLI07d2/I6ub2uSLv9cfD/zVzhpUAdVikvr6RhXfCgMbc0xNmz8Zxix/TMwylIiOysbRmXELIlPkpfW/6zASkmf6KFnBaZU97DKqW3Yzy2KT4AR9FpATiA4WdxCQSltLL/cxcZLUrPnipcxT95SXEEV3NRazzUesGdg2E86qm/CI7PDCgmeE55LlWi21uW5DrBTdtIc422BkKrHDhxzFoRhPP0ksX1e2h/abpB3ztDbOmD7pKluFqbjEE3vRqNVH5qYbIx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:44:20.0717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bb0da6-9edc-4997-5a99-08df3f954e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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

From: Gabriel Abarca <Gabriel.Abarca@amd.com>

Update dcfclk deep sleep calcs and register size limit accounting

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gabriel Abarca <Gabriel.Abarca@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
---
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  4 +--
 .../dml2_core_dcn6_funcs_mode_programming.c   | 25 +++----------------
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index b3a2858281ec..a61a1037bb73 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -1041,9 +1041,9 @@ static void dcn6_rq_dlg_get_dlg_reg(
 			if (disp_dlg_regs->refcyc_per_pte_group_nom_c >= (unsigned int)math_pow(2, 23))
 				disp_dlg_regs->refcyc_per_pte_group_nom_c = (unsigned int)(math_pow(2, 23) - 1);
 		}
-		DML_ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)math_pow(2, 13));
+		DML_ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)math_pow(2, 23));
 		if (l->dual_plane) {
-			DML_ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_c < (unsigned int)math_pow(2, 13));
+			DML_ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_c < (unsigned int)math_pow(2, 23));
 		}
 
 		DML_ASSERT(disp_dlg_regs->refcyc_per_line_delivery_pre_l < (unsigned int)math_pow(2, 13));
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
index 464b7b00e8c2..372691a263d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
@@ -519,26 +519,10 @@ static void dcn6_mp_calculate_dcfclk_deep_sleep_hysteresis(struct dml2_core_calc
 		struct dml2_core_internal_mode_program *states)
 {
 	const struct dml2_core_ip_params *ip = ctx->ip;
-	const struct dml2_utm_soc_bb *soc_bb = ctx->soc_bb;
-	struct dml2_core_internal_mode_program *inputs = states;
 	struct dml2_core_internal_mode_program *outputs = states;
-	const struct dml2_sop_table *sop_table = &soc_bb->sop_table;
-	struct dml2_soc_operating_point max_sop;
-	double min_return_latency_in_DCFCLK_cycles = 0;
-	const long min_return_uclk_cycles = 83;
-	const long min_return_fclk_cycles = 75;
-
-	sop_table->get_max_sop(sop_table, &max_sop);
-	min_return_latency_in_DCFCLK_cycles =
-			(min_return_uclk_cycles / (max_sop.uclk_khz / 1000.0)
-					+ min_return_fclk_cycles / (max_sop.fclk_khz / 1000.0))
-			* inputs->Dcfclk;
-
-	outputs->min_return_latency_in_dcfclk = (unsigned int)min_return_latency_in_DCFCLK_cycles;
-	outputs->dcfclk_deep_sleep_hysteresis = (unsigned int)math_max2(
-			32,
-			(double)ip->pixel_chunk_size_kbytes * 1024 * 3 / 4 / 64
-					- min_return_latency_in_DCFCLK_cycles);
+
+	outputs->min_return_latency_in_dcfclk = 0;
+	outputs->dcfclk_deep_sleep_hysteresis = (unsigned int)math_max2(32, (double)ip->pixel_chunk_size_kbytes * 1024 * 3 / 4 / 64);
 }
 
 void dcn6_calculate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
@@ -558,8 +542,6 @@ void dcn6_calculate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
 
 	dcn6_mp_calculate_vm_group_and_request_times(ctx, states);
 
-	dcn6_mp_calculate_vstartup_adjustment(ctx, states);
-
 	dcn6_mp_calculate_max_bandwidth_used(ctx, states);
 
 	dcn6_mp_calculate_stutter_efficiency(ctx, states);
@@ -1394,6 +1376,7 @@ enum dml2_status dml2_core_dcn6_funcs_populate_programming(struct dml2_core_inst
 	dcn6_mp_initialize_from_solution(&mode_lib->mp, solution, core->utm_soc_bb);
 	dcn6_mp_build_calculate_mp_context(calc_mp_ctx, core, solution);
 	dcn6_calculate_mode_programming(calc_mp_ctx, &mode_lib->mp);
+	dcn6_mp_calculate_vstartup_adjustment(calc_mp_ctx, &mode_lib->mp);
 	dcn6_populate_mode_programming(calc_mp_ctx, programming, &mode_lib->scratch, mode_lib, solution, core->utm_soc_bb);
 
 	DML_LOG_DEBUG("%s exit\n", __func__);
-- 
2.43.0

