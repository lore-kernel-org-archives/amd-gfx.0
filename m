Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B26C636D4
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896CA10E2EE;
	Sun, 12 Feb 2023 17:00:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A838410E302
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9ceLPGT7Z1I5sduNefq5boXHjxn/B6WG3FF6cvAq6cesHzVuIkkZKNAX70J/PiLtMpWsytjE7pFkTA0F+9/7e4nmbpVLBG/cGtRDqaOpUPdT7jHPUgxnoMCL/sSJYtmOgqTnaiDcz5XJeuEqUgN3Y48xWziROKzdwPP0BnAJCeaW7ijbe6++XMkQOmKdMDTKwoMvpx7D7SxJcR5hzddHee97rUu+6/vt5Sbea3IsWbYQI2cEJrwgDZAHUeXB85EGFgNwOIUNlxUEHX6b1YMKryQ8Famc4bDzthzLKaMydjwwBM0csJSZbM8oSDLWsReKtH/w6bAoytqNyVGEsEFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT/jpP07/N4DUAYayg0zalQv8Ed70LhAeVOvnUdRlC4=;
 b=URee6N7HsiMBib1a6zR/HIWKKqyKxe5WFufK7ig9BUGVRUwuKELb87G9kLLOfPeaVilyIO5Pfj95L++hWlv505I54t30E9q/TaZcC4we8OgK2rB3hkdKVecL4l3jGE1sq3bAxAc+GjbqdDsHQKDI9RUZdLTaEmbzcGB2Mb++GfNMiPpSt1Qz+BffyLIE/MwB756ys4RU3YUswKq6RiOlvcYIO69UdqyxGEsWmjQrTjYVpP2kWR/+oRBWJJrsyOmlBze8Pba6YRQk6BL4sAjirOrOdOe2B5SiKEU7/vA1NK+LpwU8mSC/9hzq/wX82fsdhwRlg2+zF3sjanuzJP4IHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT/jpP07/N4DUAYayg0zalQv8Ed70LhAeVOvnUdRlC4=;
 b=aOz6ebRJpSIGoRe9uowTqRwr6orC91uDm1T/dIQwIVCCjSe5Tkdrz23vu6J/nXRpOpXaFVAT6PAfxDd98YPadrhtjzLMAMtoIf4l1wJ0Tkp5716LeyUMLNuNb1OdX4WxU8tzxxz8YGT03O0w4xYYjSdRAWdfmR5Qoo0254mAJpM=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:47 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::b3) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:43 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:42 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/22] drm/amd/display: Remove stutter only configurations
Date: Sun, 12 Feb 2023 11:59:46 -0500
Message-ID: <20230212165955.1993601-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|SA0PR12MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 1485724a-1480-44c6-8ba1-08db0d1aafdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdGOroRI0yIzxL0ZjkIqdgEc4GFwuhdcaDpyebrzo5yITpVOkCATygmxwhM1dYxGMInCDL+5DqROVL7Iqr4xKgRTpVr3euz4d4XMcVnzZO/DplpmrvPzsfHc/QR9umK5eh1VbUPyekV5Pq2yQSyb7urdLMiRc/ejlRZkMy9T/jLmDKcuNBhCWoLet6yg4629q1kRVL9w4OOR62XJBFZEGWgo4TyRme0l2hKIm/JkLO6ldkwsQ9VjHJjikXHEz1V4CAaOc9eNFmHmrs/pP4VGurlo6bxQm1W1pgKL42xiem0yo9GtP3sRKzeFIj66XtASq1C/RDhTbiiLVdFyC7kGy6l4yLRl1PrU/8u5dF6Ij0I+meri/lETzrZKjJlxc83FRfUlKfdmSe/QAd8n2KKZXtkk4eXB1v0d6toifDqYmN1USpLD/B9Rua95msd9oJ+ARuah75UtFheaEshCDeSqgcOTtXeXREW9zM4NcY7cYI6YmeUy6Zh86V7enlB9Gd27Al/vwXYd7vYri1cO1T8AlNzfX6Esj6Og4/qXY8VUou4DC/MiF5PkL5l2JZ+FtOIFYJ+kSqlA2kBxZkBz3o/gid564Nlu/i5BQMpEr7oYZRdP6Ue2rZX0maCbU5q4TYJS0BvVkFwcEWQ46idw8gcaiJVOAwk8Tl0BHN+9jtXpOiFSwHE8KlpK1EGRzTpig+cmGPu66nY5h5udVHCrKWSGl3DDUyE+Gucc95RdbyOZSRs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(5660300002)(41300700001)(8936002)(44832011)(426003)(47076005)(81166007)(36860700001)(82740400003)(82310400005)(86362001)(36756003)(40480700001)(356005)(40460700003)(2906002)(316002)(54906003)(1076003)(26005)(186003)(16526019)(4326008)(6916009)(336012)(478600001)(2616005)(8676002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:47.2987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1485724a-1480-44c6-8ba1-08db0d1aafdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Nasir Osman <nasir.osman@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nasir Osman <nasir.osman@amd.com>

[why]
Newer ASICs such as DCN314 needs to allow for both self refresh and mem
clk switching rather than just self refresh only. Otherwise, we can see
some p-state hangs on ASICs that do support mem clk switching.

[how]
Added an allow_self_refresh_only flag for dcn30_internal_validate_bw
and created a validate_bw method for DCN314 with the allow_self_refresh_only
flag set to false (to support mem clk switching).

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nasir Osman <nasir.osman@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 16 +++---
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |  3 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   | 57 ++++++++++++++++++-
 .../amd/display/dc/dcn314/dcn314_resource.h   |  4 ++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  2 +-
 6 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index feb4bb491525..9353581d8b17 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1648,7 +1648,8 @@ noinline bool dcn30_internal_validate_bw(
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
 		int *vlevel_out,
-		bool fast_validate)
+		bool fast_validate,
+		bool allow_self_refresh_only)
 {
 	bool out = false;
 	bool repopulate_pipes = false;
@@ -1675,7 +1676,7 @@ noinline bool dcn30_internal_validate_bw(
 
 	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	if (!fast_validate) {
+	if (!fast_validate || !allow_self_refresh_only) {
 		/*
 		 * DML favors voltage over p-state, but we're more interested in
 		 * supporting p-state over voltage. We can't support p-state in
@@ -1688,11 +1689,12 @@ noinline bool dcn30_internal_validate_bw(
 		if (vlevel < context->bw_ctx.dml.soc.num_states)
 			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 	}
-	if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
-			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
+	if (allow_self_refresh_only &&
+	    (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
+			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported)) {
 		/*
-		 * If mode is unsupported or there's still no p-state support then
-		 * fall back to favoring voltage.
+		 * If mode is unsupported or there's still no p-state support
+		 * then fall back to favoring voltage.
 		 *
 		 * We don't actually support prefetch mode 2, so require that we
 		 * at least support prefetch mode 1.
@@ -2063,7 +2065,7 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 	BW_VAL_TRACE_COUNT();
 
 	DC_FP_START();
-	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
 
 	if (pipe_cnt == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 7d063c7d6a4b..8e6b8b7368fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -64,7 +64,8 @@ bool dcn30_internal_validate_bw(
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
 		int *vlevel_out,
-		bool fast_validate);
+		bool fast_validate,
+		bool allow_self_refresh_only);
 void dcn30_calculate_wm_and_dlg(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 3ca517dcc82d..d3918a10773a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1795,7 +1795,7 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 	BW_VAL_TRACE_COUNT();
 
 	DC_FP_START();
-	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
 
 	// Disable fast_validate to set min dcfclk in alculate_wm_and_dlg
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index bc7f2b735327..ea1cb90f8b92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1695,6 +1695,61 @@ static void dcn314_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
+bool dcn314_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
+		bool fast_validate)
+{
+	bool out = false;
+
+	BW_VAL_TRACE_SETUP();
+
+	int vlevel = 0;
+	int pipe_cnt = 0;
+	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	BW_VAL_TRACE_COUNT();
+
+	DC_FP_START();
+	// do not support self refresh only
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, false);
+	DC_FP_END();
+
+	// Disable fast_validate to set min dcfclk in calculate_wm_and_dlg
+	if (pipe_cnt == 0)
+		fast_validate = false;
+
+	if (!out)
+		goto validate_fail;
+
+	BW_VAL_TRACE_END_VOLTAGE_LEVEL();
+
+	if (fast_validate) {
+		BW_VAL_TRACE_SKIP(fast);
+		goto validate_out;
+	}
+
+	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
+
+	BW_VAL_TRACE_END_WATERMARKS();
+
+	goto validate_out;
+
+validate_fail:
+	DC_LOG_WARNING("Mode Validation Warning: %s failed validation.\n",
+		dml_get_status_message(context->bw_ctx.dml.vba.ValidationStatus[context->bw_ctx.dml.vba.soc.num_states]));
+
+	BW_VAL_TRACE_SKIP(fail);
+	out = false;
+
+validate_out:
+	kfree(pipes);
+
+	BW_VAL_TRACE_FINISH();
+
+	return out;
+}
+
 static struct resource_funcs dcn314_res_pool_funcs = {
 	.destroy = dcn314_destroy_resource_pool,
 	.link_enc_create = dcn31_link_encoder_create,
@@ -1702,7 +1757,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
 	.panel_cntl_create = dcn31_panel_cntl_create,
-	.validate_bandwidth = dcn31_validate_bandwidth,
+	.validate_bandwidth = dcn314_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn314_populate_dml_pipes_from_context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
index 0dd3153aa5c1..49ffe71018df 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
@@ -39,6 +39,10 @@ struct dcn314_resource_pool {
 	struct resource_pool base;
 };
 
+bool dcn314_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
+		bool fast_validate);
+
 struct resource_pool *dcn314_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index d4c0f9cdac8e..4fa636364793 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -634,7 +634,7 @@ int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 	while (dummy_latency_index < max_latency_table_entries) {
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
 				dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
-		dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
+		dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false, true);
 
 		if (context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank ==
 			dm_allow_self_refresh_and_mclk_switch)
-- 
2.25.1

