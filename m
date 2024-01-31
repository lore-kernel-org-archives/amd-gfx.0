Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8676FC47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F43C10FCCB;
	Wed, 31 Jan 2024 20:16:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B5D10FCCB
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhed0fjTnVu7GRPbmUeywUrkUM2i++GOoOHcx/aTaerQYvyuP7YZ3tFe/KSF2rEf8Wt7n4OXHhgc2T5jafqsuj+ttPrUxfBMmvGBjsPSXJ6BoobOkBSJo1pZCzpAgGHyMWRP4Hkpyr9E2C4erUDurha2RW2v4lWHbv5Tgv7oc2Z/UJ4/2nF4dNBKumsH9OHMkns9YXBqEXTOyvZC+AfU6hvMMUTi4V/5iBhvMOyDwP1y4/wJQurFdM0cB7RDU5QydmLF/mdLzurPQ8zYI/0wN25XyBN2fyNSe1J5AFPHfbq3vZa1XeiUko6A8/5UQ509FVjmhMiQ5Dtt5a+H2/1bKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/9AZ4rgCOMeJMYSK3H+bDgm0QIanUbOZCRv0Ns2bg8=;
 b=dIsRy2eUax11bWAqAZ2DAic/tcIDkb9ekzsgMl0AFy0rtwghiFk+bqKqVWiU8tXBzlZRvGz+1wKEko6mlPaWgdzGvOAAIyRzsGt5DzFsMMPzvwQchCspY7WMXcmD0NroNatRxq6gOGQOIJTtF3ScFpZ36UVM4vmkyNptSH76WMurgor5nzsJ3Y1kAlSW0dLsFLOBKY8kVwWJ0jndYRr+2vdRj5VWESHTydEED7CQRouuIldCX3X2zJr4FYPZETiLZgNTDfB86DWmpdyB9IZGCoI6GM8DVUnhXuU8bEIaJJDiLWAMvsNYCSIXlJj2deJxdWD5xXogq8u5frv5J6XdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/9AZ4rgCOMeJMYSK3H+bDgm0QIanUbOZCRv0Ns2bg8=;
 b=pF7XfP5yOmajX0HbylaGZ4JVqhSh94iB56vYgRypXGLXFORWW9iU+ssncJrsn1oIAme82NqypEduoA8xeTfRjOGEubZDI5YmcVe2d7GOOku4BuXeVTBh+bQijkHzVKQwTaZPNGmrrIkGsD6wzx75rH6hf7on6YhUw1k2z+QBB/w=
Received: from DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 20:15:52 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::46) by DM6PR08CA0044.outlook.office365.com
 (2603:10b6:5:1e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:15:51 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:15:21 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/21] drm/amd/display: Drop some unnecessary guards
Date: Wed, 31 Jan 2024 15:11:26 -0500
Message-ID: <20240131201220.19106-21-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: f0856099-86b8-4a69-6175-08dc22996c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdnIMaWoBV/c3ssGrkUwUHgpylnwZvH9TRmwwZQFOb9zeqKeKaiSVNT8rmi78oRnvQk6tZ9VPyIbkE66WXRYSsrVBbjkD9oeP2qRQsRUYkgyoDMQIJGYrczMbzEWlcNEf2Aqr/YibyxvCKe0o/AwUGUjW4F6IthasZjRRNvBpK4obkOUSv0sAAveL3zdeGoA+fTSdelGNFyUaroFcv+RzKQeGXVqkXUtht4TLYei4ebCkrsA9zfpTSxWXFb2LybSui7xXtksvlgg1XYvrvS0uVDcNuhuMgdOwPkZyAQssnVabUuUHcxEQ64P+5YKdu0rUHDkjVKpGHZu7Z4NqCNpyn8DSkTOCM77roLfdHJa/VwYM253mvZGiMApSksZHTj8pg9kTxhQK6vY9jtC6Kz+i+yHfeG6G0cznL2g8kyY/mTmtvFhY1nCFidcrmxAAJiS5GZuTCNh+BMXfNNynwPn5KyYlHxZhnX3TgB0/U8TU6jpDnwMEbM4maf3uUbVtC/rXOd67YOdN68GxTu+oZGd9h6BqhYfIkbIf/b2uLVc+Ep8J+yigk54JzsJs8i28dH73hLuHi8H16PbZlQ2+66atJ8C8Ur+QTrLqlQOkul1uOVV+eQf1dRCaFIwN8mrCKArWBRtWsgHUrVN8DI2n40ddFvBotl6b+TjqwR3kZG13yervUBvH3wXx06o1Ln2VPOd7uv30Elye/Ch7kttlzSdOJNcBccairrnNe1jnT3+IP/mf98uxoGJNbGOCoqmtUR5uWcjw+ZTU8YTiDsoHss5mzqyLAo27BbikXsJX51G/g3yHv64CJZPEHWtTsJ8xpou
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(41300700001)(8936002)(8676002)(4326008)(2906002)(44832011)(5660300002)(86362001)(70586007)(70206006)(54906003)(6916009)(478600001)(36756003)(36860700001)(356005)(82740400003)(316002)(81166007)(47076005)(83380400001)(26005)(1076003)(426003)(16526019)(2616005)(336012)(40460700003)(40480700001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:15:51.9109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0856099-86b8-4a69-6175-08dc22996c2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Some of the CONFIG_DRM_AMD_DC_FP was added in some non-related FPU code,
which may cause confusion. This commit dropped some of the unnecessary
guards.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dc.h                        | 2 --
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h               | 2 --
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    | 2 --
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h | 2 --
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h               | 2 --
 drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h   | 2 --
 drivers/gpu/drm/amd/display/dc/link/link_validation.c      | 2 --
 8 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 0c6a4ab72b1d..e3e1940198a9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -707,9 +707,7 @@ void rn_clk_mgr_construct(
 	int is_green_sardine = 0;
 	struct clk_log_info log_info = {0};
 
-#if defined(CONFIG_DRM_AMD_DC_FP)
 	is_green_sardine = ASICREV_IS_GREEN_SARDINE(ctx->asic_id.hw_internal_rev);
-#endif
 
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn21_funcs;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b510c366ed12..07e6f25269e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2222,11 +2222,9 @@ struct dc_sink_dsc_caps {
 	// 'true' if these are virtual DPCD's DSC caps (immediately upstream of sink in MST topology),
 	// 'false' if they are sink's DSC caps
 	bool is_virtual_dpcd_dsc;
-#if defined(CONFIG_DRM_AMD_DC_FP)
 	// 'true' if MST topology supports DSC passthrough for sink
 	// 'false' if MST topology does not support DSC passthrough
 	bool is_dsc_passthrough_supported;
-#endif
 	struct dsc_dec_dpcd_caps dsc_dec_caps;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index fb4db3158e8f..aae2f3a2660d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -827,9 +827,7 @@ struct dc_dsc_config {
 	uint32_t version_minor; /* DSC minor version. Full version is formed as 1.version_minor. */
 	bool ycbcr422_simple; /* Tell DSC engine to convert YCbCr 4:2:2 to 'YCbCr 4:2:2 simple'. */
 	int32_t rc_buffer_size; /* DSC RC buffer block size in bytes */
-#if defined(CONFIG_DRM_AMD_DC_FP)
 	bool is_frl; /* indicate if DSC is applied based on HDMI FRL sink's capability */
-#endif
 	bool is_dp; /* indicate if DSC is applied based on DP's capability */
 	uint32_t mst_pbn; /* pbn of display on dsc mst hub */
 	const struct dc_dsc_rc_params_override *rc_params_ovrd; /* DM owned memory. If not NULL, apply custom dsc rc params */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 58eb918e2c10..a760f0c6fe98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -98,10 +98,8 @@ static void enable_memory_low_power(struct dc *dc)
 		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
 			if (dc->res_pool->stream_enc[i]->vpg)
 				dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
-#if defined(CONFIG_DRM_AMD_DC_FP)
 		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
 			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
-#endif
 	}
 
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index b3c62a82cb1c..554cfab5ab24 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -155,7 +155,6 @@ struct hwseq_private_funcs {
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
 	void (*enable_plane)(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			       struct dc_state *context);
-#ifdef CONFIG_DRM_AMD_DC_FP
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
 	void (*update_force_pstate)(struct dc *dc, struct dc_state *context);
 	void (*update_mall_sel)(struct dc *dc, struct dc_state *context);
@@ -170,7 +169,6 @@ struct hwseq_private_funcs {
 			struct dc_state *context,
 			struct dc *dc);
 	bool (*is_dp_dig_pixel_rate_div_policy)(struct pipe_ctx *pipe_ctx);
-#endif
 	void (*reset_back_end_for_pipe)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index dedc5370023e..72610cd7eae0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -157,9 +157,7 @@ struct hubp_funcs {
 
 	void (*set_blank)(struct hubp *hubp, bool blank);
 	void (*set_blank_regs)(struct hubp *hubp, bool blank);
-#ifdef CONFIG_DRM_AMD_DC_FP
 	void (*phantom_hubp_post_enable)(struct hubp *hubp);
-#endif
 	void (*set_hubp_blank_en)(struct hubp *hubp, bool blank);
 
 	void (*set_cursor_attributes)(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 9a00a99317b2..d98d72f35be5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -182,9 +182,7 @@ struct timing_generator_funcs {
 
 	bool (*enable_crtc)(struct timing_generator *tg);
 	bool (*disable_crtc)(struct timing_generator *tg);
-#ifdef CONFIG_DRM_AMD_DC_FP
 	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
-#endif
 	void (*disable_phantom_crtc)(struct timing_generator *tg);
 	bool (*immediate_disable_crtc)(struct timing_generator *tg);
 	bool (*is_counter_moving)(struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 8fe66c367850..1c038e2a527b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -125,11 +125,9 @@ static bool dp_active_dongle_validate_timing(
 		if (dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps > 0) { // DP to HDMI FRL converter
 			struct dc_crtc_timing outputTiming = *timing;
 
-#if defined(CONFIG_DRM_AMD_DC_FP)
 			if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
 				/* DP input has DSC, HDMI FRL output doesn't have DSC, remove DSC from output timing */
 				outputTiming.flags.DSC = 0;
-#endif
 			if (dc_bandwidth_in_kbps_from_timing(&outputTiming, DC_LINK_ENCODING_HDMI_FRL) >
 					dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps)
 				return false;
-- 
2.43.0

