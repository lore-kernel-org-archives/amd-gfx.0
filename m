Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A37E7F13B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB4310E440;
	Tue, 26 Sep 2023 21:54:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B1110E442
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKjOfwlFC/VCsN3t2Wg/VYxuPAH5m85zKvYay/fnJw6MVFP0iYxGC9e5Cmdj8I4zla3HK8Icj8dAUEXLy7g+jwXKLrelVcWdAWwRh91TLoDxsjEC+qvFk4cgjXx870Z4cwtZ8KZ4mOqmmYyw/xAb09LXfmYHX5ZA62RbhKD756KAtUxoJsi6W9qnzuWirSPTw0jM/nhARUXlGv4qWHWta9bFEU3sBdCIdWBcpZcnICYi2TgpqiZTr4bFIhHNkNuxyvoPrkFtrH0MH1Ot/PcFEykHGRNwDAfDgI59GeFcdzfTelhY5RD3Kv+OegoYTzX7Arfh8pu0kkrBhojCRcIjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5RZ70+9uIPyGBoNJtZRVUIusaGrZqSk3B9ODndbFD8=;
 b=J414H3JmGQYd7bPDkuh94CUVmVyhVTXRdFoZfNFU1vXa/3idP7N95rTkA5+h7ercFjS6loGrfGLSM/2HgXqd4/vAbvdJvwn20RBtCcGpZ31k33sKyLDPPXvsnqezkazq5Z3hdgsc4u7xbkfgRzi5qAdnqHguILlm99CTRzIOGe0HVTylw111bP2PahDINzQcSI+d88VVpJpTZt+C79njgT1MCcVY9yl622AY4xpsns8T01GGbWfGcMIXow5TkvQWn5pQz+6UB0O1LjCaQPnMUftn+vbp4P2yj2t9UQwefJURKCjE7uH+AH96Oa3CroGYEyoh2fxBZpvYqhke8cSkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5RZ70+9uIPyGBoNJtZRVUIusaGrZqSk3B9ODndbFD8=;
 b=XtC1lsMiSh5k7Y3GusyNh+m9WmMa+2eOnxfJO1FhjcU91EKJiGu0f7Mhgy4OZXqreK5bZ9JPS4q5WntNBInmnWLXE3msccoFsmCJOW8I6WrvYqjek+2+o1+xefLnVTP5QTZjUHdWRAKD9otQ/ffAhg2lNHy3+l00EDmn8SWwcKA=
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 21:53:56 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::17) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:55 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:54 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: Adjust code style for hw_sequencer.h
Date: Tue, 26 Sep 2023 17:47:04 -0400
Message-ID: <20230926215335.200765-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH2PR12MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: b03f5f2b-6bbc-4cdd-1e17-08dbbedb1512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyrvmKuledEooOypXesfIOe55nEYfwtQp0nqFot3npiusv98ZHOfZnef4kHUe+gGd9xMw1HwqusULK+8yF7+FsRp816vzymeStPectNIQWUZxC5/bvb+lx5n0NhIM+o6C1lZ722//7hxNKdvqzO7aZKAIXCvcI5Raz8PSzcFHI5kGs9Hzxhn0R76t5NFho8W0rX9RR4g/XRHjN3K4HYyarVzhn94uDy3TKyyPI9OF4wkMR3MyE2I/Vgot8zeIYmpU5wWBJJb1eZhcDcvQfS8yaAt3gms7dRGiM3c1rLPHGRkPn9XM9vOC1QgHMyI58PtnzztWOPs9mH+CF1e5VC8AiYocm3zWkiaEg85PKT/bdkh2giy5c+UA8ig/IZSuT06c26qEIqazazh4fXkx51xFtzSzJWTwxSVs0QKK+XZiyi0qVqunPiORHSqmKdk9/B4TtJuFVNLTtLlVAP1BcZk8phvnOqh7ht36EW3xBDO10dCffhGcOQdoqXr9H518P5UjREMsxOo3RvqFq2zNpy5qsER7SZv1k+DTtwkl6Var1nEsfW1T4lqM3qlDi0lPDL0Z8Xq/N/i1huXGzEU89mxPivBxGGDTMlm99bJpsGNgR6/1hfllpXoULEjHMnvgfNU4QwkK2uuCNPKJVfyisvlbybPfxPbvAQLHencGPYgxysEcqHLAkbWSvkH5vKCv6TeX4F+9SV6VkGOT9yQs7K5XcFw1pXTBgDhpyZ6FPbbDHD1aYSl/foH81V9AEgHwzXV6DUFaI/xyk4DkE9FuxQnmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(70206006)(2906002)(30864003)(5660300002)(54906003)(70586007)(478600001)(44832011)(6666004)(7696005)(2616005)(1076003)(26005)(336012)(426003)(8676002)(6916009)(4326008)(40460700003)(41300700001)(316002)(83380400001)(8936002)(86362001)(36756003)(356005)(81166007)(82740400003)(40480700001)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:56.2900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03f5f2b-6bbc-4cdd-1e17-08dbbedb1512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
* Rearrange some definitions for consistency
* Drop legacy code

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 17 ------
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  7 ---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  6 --
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 27 ---------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  6 --
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  3 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  3 -
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h | 56 ++++++++-----------
 8 files changed, 23 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index dad1c85a1df3..0a495e8600fa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -288,23 +288,6 @@ static void program_cursor_attributes(
 	}
 }
 
-#ifndef TRIM_FSFT
-/*
- * dc_optimize_timing_for_fsft() - dc to optimize timing
- */
-bool dc_optimize_timing_for_fsft(
-	struct dc_stream_state *pStream,
-	unsigned int max_input_rate_in_khz)
-{
-	struct dc  *dc;
-
-	dc = pStream->ctx->dc;
-
-	return (dc->hwss.optimize_timing_for_fsft &&
-		dc->hwss.optimize_timing_for_fsft(dc, &pStream->timing, max_input_rate_in_khz));
-}
-#endif
-
 static bool is_subvp_high_refresh_candidate(struct dc_stream_state *stream)
 {
 	uint32_t refresh_rate;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 100d62162b71..9649934ea186 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -769,9 +769,6 @@ struct dc_crtc_timing_flags {
 	uint32_t LTE_340MCSC_SCRAMBLE:1;
 
 	uint32_t DSC : 1; /* Use DSC with this timing */
-#ifndef TRIM_FSFT
-	uint32_t FAST_TRANSPORT: 1;
-#endif
 	uint32_t VBLANK_SYNCHRONIZABLE: 1;
 };
 
@@ -950,10 +947,6 @@ struct dc_crtc_timing {
 	enum dc_aspect_ratio aspect_ratio;
 	enum scanning_type scan_type;
 
-#ifndef TRIM_FSFT
-	uint32_t fast_transport_output_rate_100hz;
-#endif
-
 	struct dc_crtc_timing_flags flags;
 	uint32_t dsc_fixed_bits_per_pixel_x16; /* DSC target bitrate in 1/16 of bpp (e.g. 128 -> 8bpp) */
 	struct dc_dsc_config dsc_cfg;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e03bb0e32e1d..e61eea6db29c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -520,12 +520,6 @@ struct dc_stream_status *dc_stream_get_status_from_state(
 struct dc_stream_status *dc_stream_get_status(
 	struct dc_stream_state *dc_stream);
 
-#ifndef TRIM_FSFT
-bool dc_optimize_timing_for_fsft(
-	struct dc_stream_state *pStream,
-	unsigned int max_input_rate_in_khz);
-#endif
-
 /*******************************************************************************
  * Cursor interfaces - To manages the cursor within a stream
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 21b94adab575..f5a7002302f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2927,33 +2927,6 @@ void dcn20_fpga_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->init_crb)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
 }
-#ifndef TRIM_FSFT
-bool dcn20_optimize_timing_for_fsft(struct dc *dc,
-		struct dc_crtc_timing *timing,
-		unsigned int max_input_rate_in_khz)
-{
-	unsigned int old_v_front_porch;
-	unsigned int old_v_total;
-	unsigned int max_input_rate_in_100hz;
-	unsigned long long new_v_total;
-
-	max_input_rate_in_100hz = max_input_rate_in_khz * 10;
-	if (max_input_rate_in_100hz < timing->pix_clk_100hz)
-		return false;
-
-	old_v_total = timing->v_total;
-	old_v_front_porch = timing->v_front_porch;
-
-	timing->fast_transport_output_rate_100hz = timing->pix_clk_100hz;
-	timing->pix_clk_100hz = max_input_rate_in_100hz;
-
-	new_v_total = div_u64((unsigned long long)old_v_total * max_input_rate_in_100hz, timing->pix_clk_100hz);
-
-	timing->v_total = new_v_total;
-	timing->v_front_porch = old_v_front_porch + (timing->v_total - old_v_total);
-	return true;
-}
-#endif
 
 void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 351b66e3f38b..ab02e4e9c8c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -136,12 +136,6 @@ int dcn20_init_sys_ctx(struct dce_hwseq *hws,
 		struct dc *dc,
 		struct dc_phy_addr_space_config *pa_config);
 
-#ifndef TRIM_FSFT
-bool dcn20_optimize_timing_for_fsft(struct dc *dc,
-		struct dc_crtc_timing *timing,
-		unsigned int max_input_rate_in_khz);
-#endif
-
 void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		enum controller_dp_test_pattern test_pattern,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index e4b44e691ce6..15b66ed66ad6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -93,9 +93,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
-#ifndef TRIM_FSFT
-	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
-#endif
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index f024157bd6eb..647e666f692a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -96,9 +96,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
-#ifndef TRIM_FSFT
-	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
-#endif
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index d4d59a916668..844ad5eb8e35 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -260,11 +260,6 @@ struct hw_sequencer_funcs {
 	void (*set_static_screen_control)(struct pipe_ctx **pipe_ctx,
 			int num_pipes,
 			const struct dc_static_screen_params *events);
-#ifndef TRIM_FSFT
-	bool (*optimize_timing_for_fsft)(struct dc *dc,
-			struct dc_crtc_timing *timing,
-			unsigned int max_input_rate_in_khz);
-#endif
 
 	/* Stream Related */
 	void (*enable_stream)(struct pipe_ctx *pipe_ctx);
@@ -381,7 +376,18 @@ struct hw_sequencer_funcs {
 
 	bool (*does_plane_fit_in_mall)(struct dc *dc, struct dc_plane_state *plane,
 			struct dc_cursor_attributes *cursor_attr);
+	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
+	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
+	void (*subvp_pipe_control_lock)(struct dc *dc,
+			struct dc_state *context,
+			bool lock,
+			bool should_lock_all_pipes,
+			struct pipe_ctx *top_pipe_to_program,
+			bool subvp_prev_use);
+	void (*subvp_pipe_control_lock_fast)(union block_sequence_params *params);
 
+	void (*z10_restore)(const struct dc *dc);
+	void (*z10_save_init)(struct dc *dc);
 	bool (*is_abm_supported)(struct dc *dc,
 			struct dc_state *context, struct dc_stream_state *stream);
 
@@ -392,27 +398,17 @@ struct hw_sequencer_funcs {
 			enum dc_color_depth color_depth,
 			const struct tg_color *solid_color,
 			int width, int height, int offset);
-
-	void (*subvp_pipe_control_lock_fast)(union block_sequence_params *params);
-	void (*z10_restore)(const struct dc *dc);
-	void (*z10_save_init)(struct dc *dc);
-
 	void (*blank_phantom)(struct dc *dc,
 			struct timing_generator *tg,
 			int width,
 			int height);
-
 	void (*update_visual_confirm_color)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			int mpcc_id);
-
 	void (*update_phantom_vp_position)(struct dc *dc,
 			struct dc_state *context,
 			struct pipe_ctx *phantom_pipe);
 	void (*apply_update_flags_for_phantom)(struct pipe_ctx *phantom_pipe);
-	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
-			const struct dc_state *cur_ctx,
-			const struct dc_state *new_ctx);
 
 	void (*calc_blocks_to_gate)(struct dc *dc, struct dc_state *context,
 		struct pg_block_update *update_state);
@@ -424,15 +420,9 @@ struct hw_sequencer_funcs {
 		struct pg_block_update *update_state, bool power_on);
 	void (*set_idle_state)(const struct dc *dc, bool allow_idle);
 	uint32_t (*get_idle_state)(const struct dc *dc);
-	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
-	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
-	void (*subvp_pipe_control_lock)(struct dc *dc,
-			struct dc_state *context,
-			bool lock,
-			bool should_lock_all_pipes,
-			struct pipe_ctx *top_pipe_to_program,
-			bool subvp_prev_use);
-
+	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
+			const struct dc_state *cur_ctx,
+			const struct dc_state *new_ctx);
 };
 
 void color_space_to_black_color(
@@ -447,25 +437,25 @@ const uint16_t *find_color_matrix(
 		enum dc_color_space color_space,
 		uint32_t *array_size);
 
+void get_surface_tile_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color);
 void get_surface_visual_confirm_color(
 		const struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
 
-void get_subvp_visual_confirm_color(
-	struct dc *dc,
-	struct dc_state *context,
-	struct pipe_ctx *pipe_ctx,
-	struct tg_color *color);
-
 void get_hdr_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
 void get_mpctree_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
-void get_surface_tile_visual_confirm_color(
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color);
+
+void get_subvp_visual_confirm_color(
+	struct dc *dc,
+	struct dc_state *context,
+	struct pipe_ctx *pipe_ctx,
+	struct tg_color *color);
 
 void get_mclk_switch_visual_confirm_color(
 		struct dc *dc,
-- 
2.42.0

