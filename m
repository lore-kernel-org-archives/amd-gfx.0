Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8668DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B8710E245;
	Wed, 13 Dec 2023 06:13:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6514010E245
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7dfo8DAeyeJx8Tc8WU3mF5jbOZPStbamcCwWg/P46t+/pojohiWVYgE90LwaXHb7L5/PXnL6BnSbAqSrIZXffe9BopxVOhll3mMWL7R92tSC/GW2bB800U6vGYBzQt9fYE9EGpapZf+1HME1Nuu3U68Bef5INkdb2pINm7/dINPkkZSuaPt4ckSVIovTKu2tzSvW8GgCk+CSwY153li9b6aQPU1Mqd9wYGfhFTfaeBIk2ilwm3grncg6bgDa7xZNZOokRcifRTVtfYDema6j6hzAXS+e/wdaudjYv/4N0A4wXzJ4T6vGQ0y8vwfIH291sy2QAK4TaVdKhnIfgr+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQQRNq4/kR8noXLOGg0cJXT+qj4HagJ8gaV9WeAQi3U=;
 b=hAtVctLtSOmk80olc3roArDZNZO5XSOTWB817MJUgZ/e5gXR2q/6KCxG8suN3+4NS/ES3JYofX9F5HxlwKwvTLiLhG1qvhN/S4nmYB4iOjFoI05AhKQh8a1Cg89Ta72AK/M0epiaAUmPRvHiN/kPjeY03fvqr2yzzhj12JDFhYSoOF6bBciIc3dWtPDn41kQX9yH7wKg7JcjhKzDuJMxepjN8rBimxkbr/+yWxAj+ZBbiTsAjNtI3n9Z/hiAae/HoSRWj/EPZi7cltAdBhgCIlcvefE8yEbcDcjFkBLbAhjQraDfReNYEWhdxj22+x9zBiem9xe4BGcTocs5ZKU6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQQRNq4/kR8noXLOGg0cJXT+qj4HagJ8gaV9WeAQi3U=;
 b=4pmFK3xc5W4ha1bAdgajZHfkXkx+UiZXlOdGc3cGJz1lvN7iZqiCFOoeXGUIHYj2aVqMj+kly4kSI02Nq7GIboeTki1MI3XkXZ36bvLdd/A04pLObuWlOkZicOwadO0fwNZ/8xWRWepD8FGPCXLZW8AKX1RVjT2AECwZc9548y4=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:13:17 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::25) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Wed, 13 Dec 2023 06:13:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:15 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:10 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/25] drm/amd/display: Unify optimize_required flags and VRR
 adjustments
Date: Wed, 13 Dec 2023 14:12:06 +0800
Message-ID: <20231213061227.1750663-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: c6184527-73d0-472b-c8ac-08dbfba298d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRoUPzDr3vnwDWu5otvbLP9r/4tTKdtrS/2cKbuCrusqyf2p9Vc0wjGjDPD5EkjeghmmSIvKmNQFAr8QuFsoIFX0HK7HFtUAkrcDafb7W5U8faUZp97C5azzvBU/DgmBLLa1a0W5+1k3iATklCJZaQLoyeWDlhPQ2o1rF1VnPOMNpTTCwqRYix32lQ1wqiogaqBu7GcBN+b9j5R/IuaQ2TIRlf+3DxqJyu7PMOyIxhv4HbcQWrRrn2FKH4306mJ+b7kGw1AdVKGVv2nNSLipjJ3ARjbAMpvtYaXtxM8HkyJfFYf7BMIEx6WDfAZGyq2EDAgdIjMu8Ny/TFjH73snHWgxg/SZg7vqu53PrlERk07PBp3WGIYX5ChVXhkISCad+uF+HQTm3GVmQKsAHlG5LNCgU6/0SDaWuPnVaNiXY2iN3C9x9BNOUyK0M9FhRYgczz23Ll3K/2ARf0iCN6b9yh+KWECq56kHPGuy+PxdpuiDW5KrRDV8sP3AW/4vpLFees9syzDQ1XDTwzeQLwB26lhZ9GWi3EwloherdbuXjOjHV39RLZ+6lOxftk4nrJnw5RnbF6+tiGbyMU3e2ZIShmGMc/lsubgqkIjv8VbY9R1YPOGi5H35hGsfs70kv5YydryNucU9olQgJR1LA57U85fD5LFEJKRBO7o73VutswNvZNWu8W1Tf9z2mMXRL/KeiwANw3nTg1Zb3HhN9zOTRgG5g8xrlmFNISU2q/C0xpU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(1076003)(2616005)(426003)(336012)(26005)(7696005)(6666004)(40460700003)(86362001)(82740400003)(81166007)(356005)(36756003)(5660300002)(8676002)(8936002)(4326008)(36860700001)(83380400001)(47076005)(54906003)(6916009)(70206006)(70586007)(41300700001)(2906002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:16.7716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6184527-73d0-472b-c8ac-08dbfba298d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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
Cc: stylon.wang@amd.com, Aric
 Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why]
There is only a single call to dc_post_update_surfaces_to_stream so
there is no need to have two flags to control it. Unifying this to a
single flag allows dc_stream_adjust_vmin_vmax to skip actual
programming when there is no change required.

[how]
Remove wm_optimze_required flag and set only optimize_required in its
place.  Then in dc_stream_adjust_vmin_vmax, check that the stream timing
range matches the requested one and skip programming if they are equal.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 14 +++++---------
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  2 --
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  2 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  8 ++++----
 5 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9d3925603979..0d42074f33a6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -409,9 +409,12 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
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
@@ -2223,7 +2226,6 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 	}
 
 	dc->optimized_required = false;
-	dc->wm_optimized_required = false;
 }
 
 static void init_state(struct dc *dc, struct dc_state *context)
@@ -2743,8 +2745,6 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
 			dc->optimized_required = true;
 		}
-
-		dc->optimized_required |= dc->wm_optimized_required;
 	}
 
 	return type;
@@ -2952,9 +2952,6 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_active_fixed)
 		stream->vrr_active_fixed = *update->vrr_active_fixed;
 
-	if (update->crtc_timing_adjust)
-		stream->adjust = *update->crtc_timing_adjust;
-
 	if (update->dpms_off)
 		stream->dpms_off = *update->dpms_off;
 
@@ -4401,8 +4398,7 @@ static bool full_update_required(struct dc *dc,
 			stream_update->mst_bw_update ||
 			stream_update->func_shaper ||
 			stream_update->lut3d_func ||
-			stream_update->pending_test_pattern ||
-			stream_update->crtc_timing_adjust))
+			stream_update->pending_test_pattern))
 		return true;
 
 	if (stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2c85f8ee682f..c87ec3e0a8cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1026,7 +1026,6 @@ struct dc {
 
 	/* Require to optimize clocks and bandwidth for added/removed planes */
 	bool optimized_required;
-	bool wm_optimized_required;
 	bool idle_optimizations_allowed;
 	bool enable_c20_dtm_b0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 4ac48c346a33..27118e672754 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -130,7 +130,6 @@ union stream_update_flags {
 		uint32_t wb_update:1;
 		uint32_t dsc_changed : 1;
 		uint32_t mst_bw : 1;
-		uint32_t crtc_timing_adjust : 1;
 		uint32_t fams_changed : 1;
 	} bits;
 
@@ -342,7 +341,6 @@ struct dc_stream_update {
 	struct dc_3dlut *lut3d_func;
 
 	struct test_pattern *pending_test_pattern;
-	struct dc_crtc_timing_adjust *crtc_timing_adjust;
 };
 
 bool dc_is_stream_unchanged(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index cdb903116eb7..0d9e41315f84 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3068,7 +3068,7 @@ void dcn10_prepare_bandwidth(
 			context,
 			false);
 
-	dc->wm_optimized_required = hubbub->funcs->program_watermarks(hubbub,
+	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
 			&context->bw_ctx.bw.dcn.watermarks,
 			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 			true);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c3c83178eb1e..5bb5e2960276 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2146,10 +2146,10 @@ void dcn20_prepare_bandwidth(
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
@@ -2162,10 +2162,10 @@ void dcn20_prepare_bandwidth(
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
2.37.3

