Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF85C47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F6010F651;
	Wed, 24 Jan 2024 07:02:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279DA10F64D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwKoKRHarxBxjk+iTgRveN1swT8Qmxgkj+Gag7pJJkKDYmYrYBmWvYIYSMPNOtqE+309LLtnZmZYnOdTSusYhtE/aHHP8LL4DEagmP6J62S3niUzcKsF3H8B/Hq0QfE0OWJMebog8yi3m6YJ6Ob9JwGeG5YBURu67OvIUgsEoDX0UBrw/jBhgcBxOFNEfhjgIetusKNOqujwmUMEaadVMxwcyeIJfcDh9XgxDe4UM3fO187LsK0LATrBB6Jbwe1m7+slEinVsw1dIZhvNpro0/sx3azL7qBOwitrqbZs0Ns5ROJssNywBf4KcI6dNF0KQng1Ut1kbJEgJjO4xDfdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFkqURr3QiTeW0jMP0ZtdfcLHnMu8Iavbgs+/yOawdE=;
 b=UIdXhiDLcvLitMbnUgmgY3wrUgMwP4NylsXPVYUl9ylwHo+M5vUL5pmxsXyhoFPwJge7cMfgwTzoFj5rrLl/EC2lqmmzwzl0nUczolktFf7BmPxH4QZRGkt4H43A+oATr4BPoSE/N7Gn4hvw2T3QIpMQV9auE7s0EmQeQwKo/u+x9AJhKlTh73bgPEyqigi5h9KWbPV1JRw0HLTPiR7HgXKv8TzYyvZtsbt3Qrjj+uvY+mF2ux+iNJNA63iafCQP+oXAUazrjb8lTVK2dlxILBoybEFmHs8Vlz0Jaf90p7svkGjij50yce8VmhZAXrE+Ja4KBsN4zpEhUEyiUUIjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFkqURr3QiTeW0jMP0ZtdfcLHnMu8Iavbgs+/yOawdE=;
 b=DSH7QInWwSFxJSxzv3Q0ge193ygV+Yep5PNHdING6UBQR+hWuymSF83VsZGfB2YUjNGvdStNDES7gx3rzmzu4DqjrkPZVQHp4Ilq4GFfO8PBPbEO/SK/kmrsJwl6q4w56c/BAihRjWJ1mwPCR94ezNXXP6tDejXaN31GWQfHhA8=
Received: from MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39) by
 DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.34; Wed, 24 Jan 2024 07:02:30 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::c) by MW2PR16CA0026.outlook.office365.com
 (2603:10b6:907::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:28 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:25 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/22] drm/amd/display: Unify optimize_required flags and VRR
 adjustments
Date: Wed, 24 Jan 2024 15:01:43 +0800
Message-ID: <20240124070159.1900622-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ac72a1-2748-4643-48c8-08dc1caa6e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Obg999XMTjcKmxoiFh8UX52qLC7oDJcOsaWGYQdLg0yP6w6pJotBlTsa85u20fC155C39q/weh/63Zom2hasM/2s74XCCjZTOdR1s52zIHXGLKKVKriBI551PQnJmrSPx0Yqy4Mj8zTURfr8RYbERO46chBt0N6xuh0Q0x5rKIUtTRi7bo/IIPUIM6GeUp1drbWn9z8OBHWTIcVzRglHu8ve6lKWSHVJZgMRyjGACjnBk/Bt5KfXrMWErDhYn4zCbKte/i7vpb6N/1ZgnW7q6ejnD1h3eznXFoHjj+WxT5YiD27rYZaRxoxuuxSA3E3TYTxAn0uxabUUAg93FSbLzVJKto0ujW0sva19jra6qrzSsfZz3omdCl+mWkmCdHp7T3p1Df3ulnEZ41Ts0+b/beN4ILyXBRwFj+wiDy8sLP14+6hdbogGZl1d6Gxk88ZlXzqAdkso1nE3Na+bb5jqAgHORD47AqS25CXDBPl5q/y/5IdZBYMY0WcPFMbSCyXkPnYgBIsF6B6Lhm0pBNH/Kwhk1vzz6phDEF+qfb46VVo20tutRAsCRAJVRqSsN6ZrLkKnXaq0rZJHXYd6V8Eb+KK3+qgbWLJISscY5P4HxIOR0ZaiwhzgGEv3gwcSOaqtcHkawvfaMBnEn07hyBy5T9uAzAZgftPAhAoai86j++MX1PLNe8pAg75mCUoI2FLy4JAN9V90izvwmqEodBdBJWUTED9GDaMaV+yDijAxT4xHLAKbU3lMHCiGc4qb4AQ/rM5bqsFyQEyhcskmx4MFiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(6666004)(7696005)(426003)(1076003)(26005)(2616005)(336012)(83380400001)(356005)(86362001)(36756003)(81166007)(82740400003)(47076005)(36860700001)(41300700001)(478600001)(5660300002)(2906002)(54906003)(70206006)(8676002)(4326008)(8936002)(316002)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:30.1075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ac72a1-2748-4643-48c8-08dc1caa6e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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
Cc: Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why]
There is only a single call to dc_post_update_surfaces_to_stream
so there is no need to have two flags to control it. Unifying
this to a single flag allows dc_stream_adjust_vmin_vmax to skip
actual programming when there is no change required.

[how]
Remove wm_optimze_required flag and set only optimize_required in its
place.  Then in dc_stream_adjust_vmin_vmax, check that the stream timing
range matches the requested one and skip programming if they are equal.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 14 +++++---------
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  2 --
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  2 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  8 ++++----
 5 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index aa7c02ba948e..186d54205bcc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -411,9 +411,12 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	 * avoid conflicting with firmware updates.
 	 */
 	if (dc->ctx->dce_version > DCE_VERSION_MAX)
-		if (dc->optimized_required || dc->wm_optimized_required)
+		if (dc->optimized_required)
 			return false;
 
+	if (!memcmp(&stream->adjust, adjust, sizeof(*adjust)))
+		return true;
+
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
@@ -2227,7 +2230,6 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 	}
 
 	dc->optimized_required = false;
-	dc->wm_optimized_required = false;
 }
 
 bool dc_set_generic_gpio_for_stereo(bool enable,
@@ -2650,8 +2652,6 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
 			dc->optimized_required = true;
 		}
-
-		dc->optimized_required |= dc->wm_optimized_required;
 	}
 
 	return type;
@@ -2859,9 +2859,6 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_active_fixed)
 		stream->vrr_active_fixed = *update->vrr_active_fixed;
 
-	if (update->crtc_timing_adjust)
-		stream->adjust = *update->crtc_timing_adjust;
-
 	if (update->dpms_off)
 		stream->dpms_off = *update->dpms_off;
 
@@ -4291,8 +4288,7 @@ static bool full_update_required(struct dc *dc,
 			stream_update->mst_bw_update ||
 			stream_update->func_shaper ||
 			stream_update->lut3d_func ||
-			stream_update->pending_test_pattern ||
-			stream_update->crtc_timing_adjust))
+			stream_update->pending_test_pattern))
 		return true;
 
 	if (stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8ef322b6c724..ee561d941f53 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1038,7 +1038,6 @@ struct dc {
 
 	/* Require to optimize clocks and bandwidth for added/removed planes */
 	bool optimized_required;
-	bool wm_optimized_required;
 	bool idle_optimizations_allowed;
 	bool enable_c20_dtm_b0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index ee10941caa59..a23eebd9933b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -139,7 +139,6 @@ union stream_update_flags {
 		uint32_t wb_update:1;
 		uint32_t dsc_changed : 1;
 		uint32_t mst_bw : 1;
-		uint32_t crtc_timing_adjust : 1;
 		uint32_t fams_changed : 1;
 	} bits;
 
@@ -326,7 +325,6 @@ struct dc_stream_update {
 	struct dc_3dlut *lut3d_func;
 
 	struct test_pattern *pending_test_pattern;
-	struct dc_crtc_timing_adjust *crtc_timing_adjust;
 };
 
 bool dc_is_stream_unchanged(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index d923d8d915f9..e8632a4222a6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3126,7 +3126,7 @@ void dcn10_prepare_bandwidth(
 			context,
 			false);
 
-	dc->wm_optimized_required = hubbub->funcs->program_watermarks(hubbub,
+	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
 			&context->bw_ctx.bw.dcn.watermarks,
 			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 			true);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 6514a51ee7f3..a2a30204f565 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2265,10 +2265,10 @@ void dcn20_prepare_bandwidth(
 	}
 
 	/* program dchubbub watermarks:
-	 * For assigning wm_optimized_required, use |= operator since we don't want
+	 * For assigning optimized_required, use |= operator since we don't want
 	 * to clear the value if the optimize has not happened yet
 	 */
-	dc->wm_optimized_required |= hubbub->funcs->program_watermarks(hubbub,
+	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
@@ -2281,10 +2281,10 @@ void dcn20_prepare_bandwidth(
 	if (hubbub->funcs->program_compbuf_size) {
 		if (context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes) {
 			compbuf_size_kb = context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes;
-			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
+			dc->optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
 		} else {
 			compbuf_size_kb = context->bw_ctx.bw.dcn.compbuf_size_kb;
-			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
+			dc->optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
 		}
 
 		hubbub->funcs->program_compbuf_size(hubbub, compbuf_size_kb, false);
-- 
2.34.1

