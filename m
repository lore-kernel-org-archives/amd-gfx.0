Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C36DC47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6AC410E4D2;
	Thu,  4 Jan 2024 15:53:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9884D10E4CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdRdHpuncaFMwgUSN0dWmRcMHvnuck1kUQCf3wJZRrq9e4CDnJ/h4CPfmSZmMdaPNjGCnGhUVNCgE1Ey1JWJ5bNBtWbtt1eurnR/znJREk5/qHzOq6pYJ2t3o1ZRPT3nQ/G0CHf+Ym4Rx4qaQeZZAPAHWJZUzVqdB3BdnG2pkT1L8FJ34aj8NXolQiQ4vmFCIxRfiP4yYFYfmrYKY+3nxgOknQenN4RGce5NKvolHHE+4/yqcOFLyc2HvGa+//X9AYfPvCnQAUDqiFz1r9/nhx59etq4AZ6+PbQOJbJiobqh9PfYNLSeUQY4xffZr1kQCPoOOBOYWvGpDp+XkuMpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4/kBNQuBBtaa6jZHIaOJXJf6bT3PkuJXp3G2MQog6I=;
 b=Q8Qjd9U/7J28eFXChH3hxFfKpJvTJZu/UhuS0ucHzDdLFe9Izn5fbL68wJI+t1DhhoX9/MDAxNmuqtcePLycZKI0hsQkGWJ/yukMU5YIiVxv8BOMel6iHgi/DqUWLwx6f2isX6L6fnvhGFFRyurNLBuCg2okL/1q7OnIubeLHcGJ9Iu7V3Zkrvcvo3nu2s/neeZwBNkvB+gGBikJxdKuTdFrLiJwGpkzqIW4a6ll6UJcT/AjyRujbs8xLA9UGz2odTjsmXnHg+wQCDuhmJi7coF1yJp0Nv/DEKULfeQl/CHJn13dsXpTLJ4kkjWFWfG8U+oFA4KDJf3Zw/jw2oMwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4/kBNQuBBtaa6jZHIaOJXJf6bT3PkuJXp3G2MQog6I=;
 b=0unv/qQB+yfb9Z7OXhh0gitlI73TxA4MXVBHB9VkIvgoxmh5e+MM6djAQzDugyyG6K6ELNNISIn8l5I+N5c6gwSBNcwJhzstgAA8coBHxNqgHdjD8ERSighCAmAQtbQdm+thIBK80ThFH/qYF7FTuUuspiv2zp/J2GMX4oPv9NE=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 15:53:25 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::80) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:24 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:19 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amd/display: revert "Optimize VRR updates to only
 necessary ones"
Date: Thu, 4 Jan 2024 08:51:01 -0700
Message-ID: <20240104155238.454117-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ceaba4-4b2d-4d42-8add-08dc0d3d490d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +z72hAs6HXREvCFL5CXwPOZZu40nYDZq4z+pvJWeYuerffYaFjbqdT/d2AYbI+EJ0x7ufSIAk9bQKIfq8BaJWNPOPbu3X4rkA6H8dQUUmWslSA4+hpPzzSRYOUTsII0+toVnPkuhP2LB/KECqgHWxs4elvjx9vEbuR4W9O0CaVugY4zfUuSXb9WMZUYoYJfxr7mS9YHu+hsFWirb2iqbn0/aZ8aZfV8M5TruMNE18vxHVuoq0nnSkCumthh9TLl4e0sl5jz8819AHv4BbRBWpfDuSLNY2YXHoLgI3PbubpWMHgXv/WBjZ9sI5YrB0lUjp4O5uIHk9Qesr7KpzXp4Moomjlp/A64gNeUivWgM9j9m2uPeXEr4jdgK39tn7Xg3UE06RkeVCKyXnyXQI82c85G/ruTztyifAeujzYjcb3P9zg3XIc7iaqP/hDQ1BEfbazb+UkytOQDfxyoiauEdMw0xjHn7mkfhBfSAAu7U0Isil2rM/gzN02CnMFGSsURNquc6sS5EZsoPG2UW3my0sGQIp/bKAOhZSZin8m7Xrj6F5hrgrGZM8nY1eZTPzf2k6O7hEq8tJcAJBWbfElA7m0mW4Mpa+KBvUra7gFhVIC+bJNvCtbCnqid31SPY+dGbaOOXUU5Kfj1mRGE3D3R8dqndx+4t8hVjSUYsWF/1pVsRJ5x1NfQdDQYXlyftcLNDQq9TAZ2pF9zARyFEX7MsxQ45UmHWoRcBbjAepGpljWO0zjIHXy0jEiM026AtdnmLpxYpHRHLqc/HXw0biNceyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(36840700001)(46966006)(40470700004)(2906002)(47076005)(2616005)(70206006)(83380400001)(4326008)(1076003)(336012)(356005)(41300700001)(15650500001)(81166007)(26005)(426003)(36860700001)(82740400003)(8676002)(8936002)(316002)(16526019)(5660300002)(54906003)(478600001)(6666004)(70586007)(6916009)(86362001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:24.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ceaba4-4b2d-4d42-8add-08dc0d3d490d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

This reverts commit 64d446649677255bc6b4e1fc757d8b772b6166b1.

The original commit causes regression in corner case with HDMI at
specific timings.  reverting from staging to get the full suite to
retest

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 14 +++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  2 ++
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  2 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  8 ++++----
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2d7205058c64..69e726630241 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -411,12 +411,9 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	 * avoid conflicting with firmware updates.
 	 */
 	if (dc->ctx->dce_version > DCE_VERSION_MAX)
-		if (dc->optimized_required)
+		if (dc->optimized_required || dc->wm_optimized_required)
 			return false;
 
-	if (!memcmp(&stream->adjust, adjust, sizeof(*adjust)))
-		return true;
-
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
@@ -2230,6 +2227,7 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 	}
 
 	dc->optimized_required = false;
+	dc->wm_optimized_required = false;
 }
 
 bool dc_set_generic_gpio_for_stereo(bool enable,
@@ -2652,6 +2650,8 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
 			dc->optimized_required = true;
 		}
+
+		dc->optimized_required |= dc->wm_optimized_required;
 	}
 
 	return type;
@@ -2859,6 +2859,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_active_fixed)
 		stream->vrr_active_fixed = *update->vrr_active_fixed;
 
+	if (update->crtc_timing_adjust)
+		stream->adjust = *update->crtc_timing_adjust;
+
 	if (update->dpms_off)
 		stream->dpms_off = *update->dpms_off;
 
@@ -4288,7 +4291,8 @@ static bool full_update_required(struct dc *dc,
 			stream_update->mst_bw_update ||
 			stream_update->func_shaper ||
 			stream_update->lut3d_func ||
-			stream_update->pending_test_pattern))
+			stream_update->pending_test_pattern ||
+			stream_update->crtc_timing_adjust))
 		return true;
 
 	if (stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f30a341bc090..7222f63caf28 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1036,6 +1036,7 @@ struct dc {
 
 	/* Require to optimize clocks and bandwidth for added/removed planes */
 	bool optimized_required;
+	bool wm_optimized_required;
 	bool idle_optimizations_allowed;
 	bool enable_c20_dtm_b0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index a23eebd9933b..ee10941caa59 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -139,6 +139,7 @@ union stream_update_flags {
 		uint32_t wb_update:1;
 		uint32_t dsc_changed : 1;
 		uint32_t mst_bw : 1;
+		uint32_t crtc_timing_adjust : 1;
 		uint32_t fams_changed : 1;
 	} bits;
 
@@ -325,6 +326,7 @@ struct dc_stream_update {
 	struct dc_3dlut *lut3d_func;
 
 	struct test_pattern *pending_test_pattern;
+	struct dc_crtc_timing_adjust *crtc_timing_adjust;
 };
 
 bool dc_is_stream_unchanged(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 51dd2ae09b2a..6dd479e8a348 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3076,7 +3076,7 @@ void dcn10_prepare_bandwidth(
 			context,
 			false);
 
-	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
+	dc->wm_optimized_required = hubbub->funcs->program_watermarks(hubbub,
 			&context->bw_ctx.bw.dcn.watermarks,
 			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 			true);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 0dfcb3cdcd20..e931342fcf4c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2159,10 +2159,10 @@ void dcn20_prepare_bandwidth(
 	}
 
 	/* program dchubbub watermarks:
-	 * For assigning optimized_required, use |= operator since we don't want
+	 * For assigning wm_optimized_required, use |= operator since we don't want
 	 * to clear the value if the optimize has not happened yet
 	 */
-	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
+	dc->wm_optimized_required |= hubbub->funcs->program_watermarks(hubbub,
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
@@ -2175,10 +2175,10 @@ void dcn20_prepare_bandwidth(
 	if (hubbub->funcs->program_compbuf_size) {
 		if (context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes) {
 			compbuf_size_kb = context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes;
-			dc->optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
+			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
 		} else {
 			compbuf_size_kb = context->bw_ctx.bw.dcn.compbuf_size_kb;
-			dc->optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
+			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
 		}
 
 		hubbub->funcs->program_compbuf_size(hubbub, compbuf_size_kb, false);
-- 
2.43.0

