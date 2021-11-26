Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FDDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594636E871;
	Fri, 26 Nov 2021 19:49:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106E56E857
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N38NlVOQKWjlzXNBu4bWH3yUfz5tlCAGjB8yhDSv+57jtcK5zbv5wvEFq7cpGLcFlakvRiFabZ2ZE5zizzRpsERJPHMWOaARvEtv6aYElLuczyr/5+UscB2duNoBgfwqGpsKazo2OeDTa20NzootyGr3nAwUN0RdKLrV7uqE747sIq23YX8+HxiecXuDSUHai3dAGFAQ+6Z8eNigIof3iVZN5mfWRmTAM8N6qN1DGFf4LmLoXWtJCfFwksR1qYsLZKXrTD5K9uyObD5b4iqCtrbrBQF9/4wOuY6aMUrxDP8+Hfv8g0Rp1Nx4NwuPQqPsb8jOEuaixIGPLMTVoIWvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CI1KLzEyV7dUunadQjgMqfKqOdCzrCNQJvl0gMDczI=;
 b=jGrt/b0RnTOwaL3vw3V0WaQqvikEhPXIUrzC47IscdlimsPAFJpWN/TFch83jjEzI8RJbgbFkLhI5SSHp4c0GVlJNu76VocVUcYOOhfZADKFUwgw1AY6KEMORzC9b/IVoccu/A28gCinn6kCLPipnzO9xWnZGPDFPm787J6KWf3C8uVx0+xNSunkFJyV8Oe/UCPyni8QURVrRDrTsZq9mv/YffpquGSFBsSeCivTd4fVvYP39/fz9Rg/VPINIKpjTzMCBjYKXClX6UY7WMFYgMX3CgPtg8R1bn8rJl+Jn1/Ziq0TpfhI4n1AIkjXBIko+bqiOvrOyhDbo6cuXk2Pnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CI1KLzEyV7dUunadQjgMqfKqOdCzrCNQJvl0gMDczI=;
 b=VHUOpid02shB63WvHKMQV8uNH1TJXJIutmSykcjt8Yqi7tecfzHer0KPICfM9rKAotd3ofL2s1Gtv6pn8kpPdmPrKnsIuVKBjv0KXjS029Su/vGQnlkFrOxDFJGuQK2wakQeuP2ws37VTn4yICM87EBQ27yK2ZxWm+PG2WCp/mQ=
Received: from MWHPR17CA0095.namprd17.prod.outlook.com (2603:10b6:300:c2::33)
 by SJ0PR12MB5578.namprd12.prod.outlook.com (2603:10b6:a03:424::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 26 Nov
 2021 19:49:35 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::1f) by MWHPR17CA0095.outlook.office365.com
 (2603:10b6:300:c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:31 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:30 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Fix for otg synchronization logic
Date: Fri, 26 Nov 2021 14:49:11 -0500
Message-ID: <20211126194922.816835-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ee6e16e-c90b-4cc0-a08c-08d9b115df41
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5578:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5578434883AFA8CEE0880EF9F9639@SJ0PR12MB5578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63AUF7V/KiSYGqQymT8ya/rTrP2bQeuBnPKwEP/TprzLt9PBmywUUVp+ZSNUWCkfX9yuZR7280gpRFqcOyytdJpPmE1ypD/mT5IiD7EPpOQF+2z/i6Y4ebJ7MlGx7aCjNn5mKaItq3YfiSxYDHifSCxtHOM4z2xgvuCOqP4BBlWytP54ooBI5T1eajxLX1hivPP1oe57O8xHP7HdumIkHrhv37hq/VugeT8GG/sRGqrs9y8l2+6HEodWKIWVb2+/9YUwLRqxB/0mVR44VfAu9oUb2mbtfSCL8QlveHPaa21HYzINp3RMqSZVCaQ0BJTXVgb6meq28+o54wCFcXG2dmsWZodNtyn1Dcr2km6yKUdmpCYdMkgv6Bh1kHBJq/r5iFDymNlnFzCibhiXn+Ji7/RLDyFTkdXlLfKte3AoboX5GFEFY78ErhKY3Pn+jnaD4gHiALTfYo1KGMe6jMXo0qBLhjLfJ6Nmwbx2XbQZo/kEm+DMXTAwEH6kME1sotby3vuxnDRG/qfES9GZIeNiENxpFRjRdGfgLymDUqXdn1K778PMORwn6azWCJRHE4QDv3giUqChLsbal08Aiktl7FBihaT2rQHdtxDOTaInWjcKLgSbf9LEKNd3tQeYls0mBRrVRRQ62jm+z3nEDIsgUvnv9fxsyUNAja78WXHg/5+5r1ZXYtx+k3Psn3gcrDiElyglYwqetqDGs8BCedaJrk3j3fa2rIHLhn+kjNyYYm0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(54906003)(26005)(82310400004)(36756003)(6666004)(508600001)(70586007)(70206006)(47076005)(1076003)(2906002)(426003)(356005)(186003)(8936002)(336012)(36860700001)(8676002)(6916009)(81166007)(4326008)(83380400001)(5660300002)(316002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:34.6096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee6e16e-c90b-4cc0-a08c-08d9b115df41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5578
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
Cc: stylon.wang@amd.com, Mustapha
 Ghaddar <mustapha.ghaddar@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
During otg sync trigger, plane states are used to decide whether the otg
is already synchronized or not. There are scenarions when otgs are
disabled without plane state getting disabled and in such case the otg is
excluded from synchronization.

[How]
Introduced pipe_idx_syncd in pipe_ctx that tracks each otgs master pipe.
When a otg is disabled/enabled, pipe_idx_syncd is reset to itself.
On sync trigger, pipe_idx_syncd is checked to decide whether a otg is
already synchronized and the otg is further included or excluded from
synchronization.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 35 +++++++-----
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 54 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  8 +++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 11 ++++
 7 files changed, 99 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 17b7408d84b7..bd6541f1c8bb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1422,22 +1422,29 @@ static void program_timing_sync(
 				status->timing_sync_info.master = false;
 
 		}
-		/* remove any other unblanked pipes as they have already been synced */
-		for (j = j + 1; j < group_size; j++) {
-			bool is_blanked;
 
-			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
-				is_blanked =
-					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
-			else
-				is_blanked =
-					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
-			if (!is_blanked) {
-				group_size--;
-				pipe_set[j] = pipe_set[group_size];
-				j--;
+		/* remove any other pipes that are already been synced */
+		if (dc->config.use_pipe_ctx_sync_logic) {
+			/* check pipe's syncd to decide which pipe to be removed */
+			for (j = 1; j < group_size; j++) {
+				if (pipe_set[j]->pipe_idx_syncd == pipe_set[0]->pipe_idx_syncd) {
+					group_size--;
+					pipe_set[j] = pipe_set[group_size];
+					j--;
+				} else
+					/* link slave pipe's syncd with master pipe */
+					pipe_set[j]->pipe_idx_syncd = pipe_set[0]->pipe_idx_syncd;
 			}
-		}
+		} else {
+			/* remove any other pipes by checking valid plane */
+			for (j = j + 1; j < group_size; j++) {
+				if (pipe_set[j]->plane_state) {
+					group_size--;
+					pipe_set[j] = pipe_set[group_size];
+					j--;
+				}
+ 			}
+ 		}
 
 		if (group_size > 1) {
 			if (sync_type == TIMING_SYNCHRONIZABLE) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1da91f250afa..51e22b965ed6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3118,3 +3118,57 @@ struct hpo_dp_link_encoder *resource_get_unused_hpo_dp_link_encoder(
 	return enc;
 }
 #endif
+
+void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
+		struct dc_state *context)
+{
+	int i, j;
+	struct pipe_ctx *pipe_ctx_old, *pipe_ctx, *pipe_ctx_syncd;
+
+	/* If pipe backend is reset, need to reset pipe syncd status */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx_old =	&dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx_old->stream)
+			continue;
+
+		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+			continue;
+
+		if (!pipe_ctx->stream ||
+				pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
+
+			/* Reset all the syncd pipes from the disabled pipe */
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				pipe_ctx_syncd = &context->res_ctx.pipe_ctx[j];
+				if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_syncd) == pipe_ctx_old->pipe_idx) ||
+					!IS_PIPE_SYNCD_VALID(pipe_ctx_syncd))
+					SET_PIPE_SYNCD_TO_PIPE(pipe_ctx_syncd, j);
+			}
+		}
+	}
+}
+
+void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
+	struct dc_state *context,
+	uint8_t disabled_master_pipe_idx)
+{
+	int i;
+	struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
+
+	pipe_ctx = &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
+	if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx) != disabled_master_pipe_idx) ||
+		!IS_PIPE_SYNCD_VALID(pipe_ctx))
+		SET_PIPE_SYNCD_TO_PIPE(pipe_ctx, disabled_master_pipe_idx);
+
+	/* for the pipe disabled, check if any slave pipe exists and assert */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx_check = &context->res_ctx.pipe_ctx[i];
+
+		if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) == disabled_master_pipe_idx) &&
+			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx))
+			DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
+				i, disabled_master_pipe_idx);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c14e7db3f69d..90baef199c12 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -333,6 +333,7 @@ struct dc_config {
 	uint8_t  vblank_alignment_max_frame_time_diff;
 	bool is_asymmetric_memory;
 	bool is_single_rank_dimm;
+	bool use_pipe_ctx_sync_logic;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 3d421583e9ca..67298aa890c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1564,6 +1564,10 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 				&pipe_ctx->stream->audio_info);
 	}
 
+	/* make sure no pipes syncd to the pipe being enabled */
+	if (!pipe_ctx->stream->apply_seamless_boot_optimization && dc->config.use_pipe_ctx_sync_logic)
+		check_syncd_pipes_for_disabled_master_pipe(dc, context, pipe_ctx->pipe_idx);
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* DCN3.1 FPGA Workaround
 	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
@@ -2294,6 +2298,10 @@ enum dc_status dce110_apply_ctx_to_hw(
 	enum dc_status status;
 	int i;
 
+	/* reset syncd pipes from disabled pipes */
+	if (dc->config.use_pipe_ctx_sync_logic)
+		reset_syncd_pipes_from_disabled_pipes(dc, context);
+
 	/* Reset old context */
 	/* look up the targets that have been removed since last commit */
 	hws->funcs.reset_hw_ctx_wrap(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index f5d702148e0e..70cbd89bdcb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2232,6 +2232,9 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* Use pipe context based otg sync logic */
+	dc->config.use_pipe_ctx_sync_logic = true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 6fc6488c54c0..f3c0e70073da 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -367,6 +367,7 @@ struct pipe_ctx {
 	struct pll_settings pll_settings;
 
 	uint8_t pipe_idx;
+	uint8_t pipe_idx_syncd;
 
 	struct pipe_ctx *top_pipe;
 	struct pipe_ctx *bottom_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 372c0898facd..c208925f8247 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -34,6 +34,10 @@
 #define MEMORY_TYPE_HBM 2
 
 
+#define IS_PIPE_SYNCD_VALID(pipe) ((((pipe)->pipe_idx_syncd) & 0x80)?1:0)
+#define GET_PIPE_SYNCD_FROM_PIPE(pipe) ((pipe)->pipe_idx_syncd & 0x7F)
+#define SET_PIPE_SYNCD_TO_PIPE(pipe, pipe_syncd) ((pipe)->pipe_idx_syncd = (0x80 | pipe_syncd))
+
 enum dce_version resource_parse_asic_id(
 		struct hw_asic_id asic_id);
 
@@ -206,4 +210,11 @@ struct hpo_dp_link_encoder *resource_get_unused_hpo_dp_link_encoder(
 		const struct resource_pool *pool);
 #endif
 
+void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
+	struct dc_state *context);
+
+void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
+	struct dc_state *context,
+	uint8_t disabled_master_pipe_idx);
+
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.25.1

