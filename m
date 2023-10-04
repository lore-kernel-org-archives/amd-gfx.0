Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B9BE7B5E5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360CD10E352;
	Wed,  4 Oct 2023 09:24:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE76F10E352
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0pTJ8S4rjtrtEv/iraJOsDblcZSHkuXn3wcLygctb6Z78ANCGOMp9gtVcCmfac2ncoGKJX3nad3Ries+egJkQMbWp0X7Fcg5cl2vzSuimORADyJLcuI5F7nK2Ik//XIaP0FutA+JnfnPt/aqxalDsKzSQl6jOeR6KchMfXECm0UGidmNXlZJte31UlT+Zzmt4IKKnQv5bGIBpou6Lwh7bLnj3wvg2ogs5zRyBeIPjhZhTkZvAD8xKgQPAcQVIE/Fsua6IdBx8T+Rq84d9NNBgrx9FpoFbyTBpmBGfRbkA6apYbZ7j6hs0vBYZqCaTD4Xts7y5XxGCtvaa4fhDYnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9USjXxvU6MyWJrO9j3Av1Uuq4Y+B1S10ljxjYh24t7I=;
 b=IrRrbmXhIb2bkjkVOHZXUIxtJUiQRhQEqiwiCQA7a1bhGIuP5bcgKjSpTGRdDiciNR0LsrzE1JH75KBZCFDBksWzqP5/HETcYdNPa/sCeaYifDq9ERg3+btfQk4UHpRpFkWHSIyySYC2uoW6A8rCyqFYNgqKE7nGmz/09xGGeZlEfWkhv85zhGaraTunamja4LGZDWfb8pUv8HfY+8nexRIwolxiweAqvGOvzFV8+mx7AJNn6dtsGp4QmLSEyTkwUj8F7bjJ29mp4o2hcB1uPN0IZyWIewZ663x7a3Gva7bsAaX5gVkf2i0e0T/oN0KwAmOJFEonO1R+Wep7NjaBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9USjXxvU6MyWJrO9j3Av1Uuq4Y+B1S10ljxjYh24t7I=;
 b=BKB4vgVvHFuGWv8vcNPTt+JybRYSABDh++B3htQq8BscUpKfT7+lpc1OHvtdWJVTiGQYyjoU5UsVudjo13w96K97mtItVms0PcOzWEp/wz/zJhF9HVIJM9WxzvHurM8VG9F1RmLWsaCi5Kj0jy5Gm208wWMsA7giQjDp+lmI+Ew=
Received: from CY5PR19CA0012.namprd19.prod.outlook.com (2603:10b6:930:15::16)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:24:10 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::55) by CY5PR19CA0012.outlook.office365.com
 (2603:10b6:930:15::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Wed, 4 Oct 2023 09:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 4 Oct 2023 09:24:10 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:24:09 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:24:04 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Update cursor limits based on SW
 cursor fallback limits
Date: Wed, 4 Oct 2023 17:22:53 +0800
Message-ID: <20231004092301.2371458-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c1e06c-1d8b-4a27-48b6-08dbc4bbaab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFWwtg7gIGWKVWPKroMBXKd8+yNdB5NA6WSc5Ja6Ol8/kKw7ESL4wgm0UFNS4mLnt7kIQgr63IX3LbP0F90bCsjgWy/fbTSn7Ye6JZIqf2MiTK1F/ftAUlcii5QmqB6dFnOkvniqHs2xd6tUMOwy5iEYWw+b//2bmdAioP8YiF/zSbDAfvMvUBOYYtDVNlk28YtJrfmPsA4vR1iyEGjF9ArnI4/yoFCdlhrQYB1PxiIZmkmiNod3MDGFMipDiu2lm3l+Px4wzUHJgAjwuo4sNb+mRmjJX5jHzgsX4DTdii1yp0FtWPnJjfiShKsXnxgt5QS6EFz+HwigTHYkt2pCPcqd936lWmCSLZq8sLCPq7BQf/jC46/UFIul5f40gZ9f5roAfy+q7IvOXFkhjdVWSUu9htddhgSyL/oYBuYrnRsPtxsU49ypXeGisZOLCbZLWa47rYZfbZ5PonqoEk81Jj3rCUBTZcNBFgjTSpdE+6zp7oAmg6ltEwC5qOr+72o4Dt5MorIpw5vz4fPoW0xmezn4BHUUPNl08T709t98ay7GkahDX1RL+KY11rBppm7MLMW5Zz9H+5KMfWZKhwleLLh0dsw7f48mEZR3BoajU7g1Pag5zpbyByoHSmsidYp6iZMAoqNPN8rumXUd8/71v36oxNy7yjT0Um3d9QjHj83nqgp5CFt+UgznQY46KA551Aacn32l6MDYDv56hBhdyW9SwDfu7lCkLcizFQnfsVe2W18BocTKLyqlf0gtbEN30uC4ErMfCCMcRtCoSs3dZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(1076003)(2616005)(7696005)(70206006)(316002)(54906003)(6916009)(70586007)(8676002)(4326008)(5660300002)(26005)(8936002)(6666004)(478600001)(336012)(426003)(15650500001)(40460700003)(82740400003)(2906002)(83380400001)(47076005)(36756003)(81166007)(356005)(36860700001)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:24:10.3964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c1e06c-1d8b-4a27-48b6-08dbc4bbaab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why&How]
For determining the cursor size limit, use the same checks that
are used for determining SW cursor fallback instead of only
using SubVP

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 ++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 39 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 34 +---------------
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 ++
 4 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 825f275ea9eb..623f4ac0bf42 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5436,15 +5436,15 @@ bool dc_abm_save_restore(
 void dc_query_current_properties(struct dc *dc, struct dc_current_properties *properties)
 {
 	unsigned int i;
-	bool subvp_in_use = false;
+	bool subvp_sw_cursor_req = false;
 
 	for (i = 0; i < dc->current_state->stream_count; i++) {
-		if (dc->current_state->streams[i]->mall_stream_config.type != SUBVP_NONE) {
-			subvp_in_use = true;
+		if (check_subvp_sw_cursor_fallback_req(dc, dc->current_state->streams[i])) {
+			subvp_sw_cursor_req = true;
 			break;
 		}
 	}
-	properties->cursor_size_limit = subvp_in_use ? 64 : dc->caps.max_cursor_size;
+	properties->cursor_size_limit = subvp_sw_cursor_req ? 64 : dc->caps.max_cursor_size;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index aa7b5db83644..3549a9b852a2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1334,6 +1334,32 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 	data->viewport_c.y += src.y / vpc_div;
 }
 
+static bool is_subvp_high_refresh_candidate(struct dc_stream_state *stream)
+{
+	uint32_t refresh_rate;
+	struct dc *dc = stream->ctx->dc;
+
+	refresh_rate = (stream->timing.pix_clk_100hz * (uint64_t)100 +
+		stream->timing.v_total * stream->timing.h_total - (uint64_t)1);
+	refresh_rate = div_u64(refresh_rate, stream->timing.v_total);
+	refresh_rate = div_u64(refresh_rate, stream->timing.h_total);
+
+	/* If there's any stream that fits the SubVP high refresh criteria,
+	 * we must return true. This is because cursor updates are asynchronous
+	 * with full updates, so we could transition into a SubVP config and
+	 * remain in HW cursor mode if there's no cursor update which will
+	 * then cause corruption.
+	 */
+	if ((refresh_rate >= 120 && refresh_rate <= 175 &&
+			stream->timing.v_addressable >= 1080 &&
+			stream->timing.v_addressable <= 2160) &&
+			(dc->current_state->stream_count > 1 ||
+			(dc->current_state->stream_count == 1 && !stream->allow_freesync)))
+		return true;
+
+	return false;
+}
+
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
@@ -5101,3 +5127,16 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 	return DC_OK;
 }
 
+bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream)
+{
+	if (!dc->debug.disable_subvp_high_refresh && is_subvp_high_refresh_candidate(stream))
+		return true;
+	if (dc->current_state->stream_count == 1 && stream->timing.v_addressable >= 2880 &&
+			((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
+		return true;
+	else if (dc->current_state->stream_count > 1 && stream->timing.v_addressable >= 2160 &&
+			((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
+		return true;
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ac493dd7fa68..8a6a2881be41 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -288,32 +288,6 @@ static void program_cursor_attributes(
 	}
 }
 
-static bool is_subvp_high_refresh_candidate(struct dc_stream_state *stream)
-{
-	uint32_t refresh_rate;
-	struct dc *dc = stream->ctx->dc;
-
-	refresh_rate = (stream->timing.pix_clk_100hz * (uint64_t)100 +
-		stream->timing.v_total * stream->timing.h_total - (uint64_t)1);
-	refresh_rate = div_u64(refresh_rate, stream->timing.v_total);
-	refresh_rate = div_u64(refresh_rate, stream->timing.h_total);
-
-	/* If there's any stream that fits the SubVP high refresh criteria,
-	 * we must return true. This is because cursor updates are asynchronous
-	 * with full updates, so we could transition into a SubVP config and
-	 * remain in HW cursor mode if there's no cursor update which will
-	 * then cause corruption.
-	 */
-	if ((refresh_rate >= 120 && refresh_rate <= 175 &&
-			stream->timing.v_addressable >= 1080 &&
-			stream->timing.v_addressable <= 2160) &&
-			(dc->current_state->stream_count > 1 ||
-			(dc->current_state->stream_count == 1 && !stream->allow_freesync)))
-		return true;
-
-	return false;
-}
-
 /*
  * dc_stream_set_cursor_attributes() - Update cursor attributes and set cursor surface address
  */
@@ -347,13 +321,7 @@ bool dc_stream_set_cursor_attributes(
 	 * 3. If not subvp high refresh, for multi display cases, if resolution is >= 4K and refresh rate < 120hz
 	 */
 	if (dc->debug.allow_sw_cursor_fallback && attributes->height * attributes->width * 4 > 16384) {
-		if (!dc->debug.disable_subvp_high_refresh && is_subvp_high_refresh_candidate(stream))
-			return false;
-		if (dc->current_state->stream_count == 1 && stream->timing.v_addressable >= 2880 &&
-				((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
-			return false;
-		else if (dc->current_state->stream_count > 1 && stream->timing.v_addressable >= 2160 &&
-				((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
+		if (check_subvp_sw_cursor_fallback_req(dc, stream))
 			return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 00230a7fbe25..67d1ec0f3c68 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -604,4 +604,7 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 		struct dc_state *context,
 		struct pipe_ctx *pipe_ctx);
+
+bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream);
+
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.25.1

