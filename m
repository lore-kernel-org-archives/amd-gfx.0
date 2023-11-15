Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0FFC5AD4C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0935210E210;
	Wed, 15 Nov 2023 19:44:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C3710E1DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeOYDi2C58O1EFd3V8a7wPXPklzrHyntFHwbiQE81euzCMgU1w/rq7IfTUHCD5S9/bUxIr8H++9htkhKcQHDbMSWnlvDys5RMs9LSE1sbpZxd3+OufsimzI3LsdrtIFZeK9UMVq9t11qCSWwAnORYm5OabC2elo3J7D10ScQZbotVf6L/cgzRBuxXP0pjF7lUK+pgTSJzwFP058WJitr0jozMVeBKG2ZbDccXjuWNz7xqMKF1Yh1MPN4iF1IP+xahRVpFZKtJG63slrBCqCgYZ6buomeMt028XycLcO92GknwL987fvY2CneirAU8gLvbnFcH9bHWZQx7CVwodERpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI6ZUAj2beRbvT3R/r8YL6ZTEYcXynVErFW1L2kD/6s=;
 b=E165VULx3zZ1wwyEV/HbLxT+9RF8XDyuyxsdvT8eAm9O4CSTLK3oooLssnFc5VPrTCUrt6AxwuAVesAIGeE2JRfM9jFr53wXkUBAH4TOeEyp3epf1AOFLak9zJdvn5HPRXkF8Jsb3+10uLdWHNrWcd+hJZjakcMRyXcQhEWEtycYlUUIxaK4ZCo5BMcvHzojWTXR6i038rCbOJfBYLKXLGnUqQuEKP+hmEPT7VtcH30UnQrJ62SQDA6tSjMkeoYd6wINqW95RCf24AUoA9UkV01HKdh6/0lj3jl2DYxRIOuFCyMPzCwOwvh8tLkZHQ94NX6rm4k/7rLAj/thc2p42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI6ZUAj2beRbvT3R/r8YL6ZTEYcXynVErFW1L2kD/6s=;
 b=Q/m6tBoG3PAifO1zfDdHnpTnRjalkv3tQSkcjYwN5IBJpVN5a7XyjDlZQHaOjDg//R6N5mbyuKgCoKNcHoeNjS3fsHwsBOUJYCvGPATNVkeXlq/FsjluA8wMRJbOZM0dxXSxIcuTJxFvM9n8tgO8bwzme2HdT1cADQYm5bpxpDI=
Received: from BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:18 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::85) by BL1PR13CA0115.outlook.office365.com
 (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:17 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:14 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/35] drm/amd/display: update pixel clock params after stream
 slice count change in context
Date: Wed, 15 Nov 2023 14:40:20 -0500
Message-ID: <20231115194332.39469-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd30626-ee21-4e58-c2bb-08dbe6134178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGdY+7VggR6LqmqsXC1vsBAhizRw+5AyDBdKyKz3SyH+Yy0sV55XRAHe5pFnD6hq2BW25XZD9SlzZktXmw5JJ4hzluKphK9KO7BtodmSbzQ9bzjHaEoCq3m0FpUdJBGgfdnNiYPMlZyiyyDUoKRCDtUhL9GmUi+slxO0KNXGTzdCE7TqE4DAlUbA1Zj8RRMh3vQ7Fv+gupS8EQ+8D/ztTu0nBbZfpwj+h5zyPfBpAD2r0O1cDHeg4dOlqBqagwN3RpNp5TTK09t6QMDLtVjk+3xtEI1EMHKn+LqjqnnDpdhEgtn82EQ9z9by/Dly/iX8vIJjItkWIz0n0IYUQCknkWpX5gZg9nfP8UyvoXXBWCpMRUijvhpkvspcUxFBSc3EoA6ZBjHPg50r6SC7g+TC3HqreeQ3fiIyjGYD2ck5yyweN0XuhrwVLh6QeHEQqylMYgXnM1FXtRqE89H17Yz14c0YMpfna1M1/0agrwVDXcUAfqEXxMC4f10vA87R95ztxQNDmLzGcLunYznevL/mWnp0ElqJeQojRCftYHvCGIMsDO4L3pytgqRRHDquPkXh+pVCuKsr5IjOtEABXQEI+gI2bqY47pvkq5n9HX1PcIOJc3jYEPC4YMud88zzZu9wsaOWhQzLukcUtQ41tD5ECzGueM9LIudio2BHFV3ec1IXrl7/56D9hMAXiAfUWKNrhjNwGtaGRaCAQcoohZoHZV3NBO+LRQkKne4F+xY40BW3d064JsNOqrRuwDBFjaSv7ctNW4WCXFoGsyefk64qwgblDiV/cbc8LWAamLguZZR9ePyerV2E8CCnKt9h/J43
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(81166007)(356005)(2906002)(36860700001)(15650500001)(40460700003)(47076005)(41300700001)(5660300002)(83380400001)(40480700001)(8676002)(8936002)(4326008)(86362001)(6666004)(316002)(70206006)(478600001)(70586007)(6916009)(54906003)(336012)(2616005)(16526019)(426003)(26005)(1076003)(44832011)(82740400003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:17.9788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd30626-ee21-4e58-c2bb-08dbe6134178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When ODM slice count is changed, otg master pipe's pixel clock params is
no longer valid as the value is dependent on ODM slice count.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c    |  9 ++++++---
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c |  6 +-----
 drivers/gpu/drm/amd/display/dc/inc/core_types.h  |  1 +
 .../display/dc/resource/dcn20/dcn20_resource.c   | 16 ++++++++++------
 .../display/dc/resource/dcn20/dcn20_resource.h   |  1 +
 .../display/dc/resource/dcn32/dcn32_resource.c   |  1 +
 .../display/dc/resource/dcn321/dcn321_resource.c |  1 +
 7 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 42a927710743..84d632700949 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2256,7 +2256,7 @@ static struct pipe_ctx *get_last_dpp_pipe_in_mpcc_combine(
 }
 
 static bool update_pipe_params_after_odm_slice_count_change(
-		const struct dc_stream_state *stream,
+		struct pipe_ctx *otg_master,
 		struct dc_state *context,
 		const struct resource_pool *pool)
 {
@@ -2266,9 +2266,12 @@ static bool update_pipe_params_after_odm_slice_count_change(
 
 	for (i = 0; i < pool->pipe_count && result; i++) {
 		pipe = &context->res_ctx.pipe_ctx[i];
-		if (pipe->stream == stream && pipe->plane_state)
+		if (pipe->stream == otg_master->stream && pipe->plane_state)
 			result = resource_build_scaling_params(pipe);
 	}
+
+	if (pool->funcs->build_pipe_pix_clk_params)
+		pool->funcs->build_pipe_pix_clk_params(otg_master);
 	return result;
 }
 
@@ -2951,7 +2954,7 @@ bool resource_update_pipes_for_stream_with_slice_count(
 					otg_master, new_ctx, pool);
 	if (result)
 		result = update_pipe_params_after_odm_slice_count_change(
-				otg_master->stream, new_ctx, pool);
+				otg_master, new_ctx, pool);
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 44b0666e53b0..e7f13e28caa3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1237,15 +1237,11 @@ static void update_pipes_with_slice_table(struct dc *dc, struct dc_state *contex
 {
 	int i;
 
-	for (i = 0; i < table->odm_combine_count; i++) {
+	for (i = 0; i < table->odm_combine_count; i++)
 		resource_update_pipes_for_stream_with_slice_count(context,
 				dc->current_state, dc->res_pool,
 				table->odm_combines[i].stream,
 				table->odm_combines[i].slice_count);
-		/* TODO: move this into the function above */
-		dcn20_build_mapped_resource(dc, context,
-				table->odm_combines[i].stream);
-	}
 
 	for (i = 0; i < table->mpc_combine_count; i++)
 		resource_update_pipes_for_plane_with_slice_count(context,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index bac1420b1de8..10397d4dfb07 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -205,6 +205,7 @@ struct resource_funcs {
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 	void (*save_mall_state)(struct dc *dc, struct dc_state *context, struct mall_temp_config *temp_config);
 	void (*restore_mall_state)(struct dc *dc, struct dc_state *context, struct mall_temp_config *temp_config);
+	void (*build_pipe_pix_clk_params)(struct pipe_ctx *pipe_ctx);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index f04bb5b1471d..f9c5bc624be3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1273,15 +1273,19 @@ static void build_clamping_params(struct dc_stream_state *stream)
 	stream->clamping.pixel_encoding = stream->timing.pixel_encoding;
 }
 
-static enum dc_status build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
+void dcn20_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 {
-
 	get_pixel_clock_parameters(pipe_ctx, &pipe_ctx->stream_res.pix_clk_params);
-
 	pipe_ctx->clock_source->funcs->get_pix_clk_dividers(
-		pipe_ctx->clock_source,
-		&pipe_ctx->stream_res.pix_clk_params,
-		&pipe_ctx->pll_settings);
+			pipe_ctx->clock_source,
+			&pipe_ctx->stream_res.pix_clk_params,
+			&pipe_ctx->pll_settings);
+}
+
+static enum dc_status build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
+{
+
+	dcn20_build_pipe_pix_clk_params(pipe_ctx);
 
 	pipe_ctx->stream->clamping.pixel_encoding = pipe_ctx->stream->timing.pixel_encoding;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h
index 37ecaccc5d12..4cee3fa11a7f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h
@@ -165,6 +165,7 @@ enum dc_status dcn20_add_stream_to_ctx(struct dc *dc, struct dc_state *new_ctx,
 enum dc_status dcn20_add_dsc_to_stream_resource(struct dc *dc, struct dc_state *dc_ctx, struct dc_stream_state *dc_stream);
 enum dc_status dcn20_remove_stream_from_ctx(struct dc *dc, struct dc_state *new_ctx, struct dc_stream_state *dc_stream);
 enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_state);
+void dcn20_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx);
 
 #endif /* __DC_RESOURCE_DCN20_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 36e4c7bef403..f6cbcc9b4006 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2041,6 +2041,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
 	.save_mall_state = dcn32_save_mall_state,
 	.restore_mall_state = dcn32_restore_mall_state,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index bedb70b98162..12986fe0b289 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1609,6 +1609,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
 	.save_mall_state = dcn32_save_mall_state,
 	.restore_mall_state = dcn32_restore_mall_state,
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
-- 
2.42.0

