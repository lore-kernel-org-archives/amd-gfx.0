Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EEEC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEFE60C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEFE60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040E16EC65;
	Fri, 19 Feb 2021 22:16:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE2A6EC63
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E45zr4ORq+bMko8yLqlSSfTBI+lEqTOm+DIrO7TtqgLiFVq1CxdgKtUCEnji6aopogKCzf9wKffjIS0Kh/0pvz15rnEEUnzw6X/U0nJdKAk082nyAY1er6ogbVrEtir4YgUV2j4gcro61QSZgid3kUP64ozqOSR3em7g1pg+GEbz6iaN44E96/R2kGgkHi4IXlZ9XKdj+iJGLkeFiy4VXlOm9H4PRLDPO5Nmxg0pdmoBlURqlnoWCuc/FI6pzHZcgPoGlHlzKFR+UX8tF13G7L83j1PNBUwoDCR+y3PvGNadIxKZJuCUnqFMsITJICbfab7xvLsO6JX6PVyG7C+KsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV1HuNhUQQxHWOx5FOYL2AnuN6EUJPt262jFCKQ2+Jc=;
 b=UgG5xmrj7BBmCoQL1gh+PyCk0Ccrg3lg17hBFkZSjKYf/47cWu2oiPQU/HLWhvbmju59Ojux5Pi9hzst9d0L7h1AeL+bRaM2gUJuhQQtXeRPyRGwA38HumzzxsOSqG03WZhFXH90+i7rNJ2TM5G2txmNrjwWQghyoeQfT3PMPpXKz2xN4+0t8zqeEmnc5LH/zzcmyf0nHvwnNXWRxJKu+JxVpAhRGs7y0sCpvC4/LLVttk60y/7kstKnWGcb6J1ir1GGfAV0XIP6TxxtbHe0ogo/8kVHfXNt9pWnxR/JvG8QcMyduXpuTwzCi3vKxih2HbL54TG6IZzFJGZeDpGdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV1HuNhUQQxHWOx5FOYL2AnuN6EUJPt262jFCKQ2+Jc=;
 b=4egZxgIsmBzEKisnVFqcPaFMniF0afgZw8CLWnBtwhUvsDliTNKK4tqkZP53yNuxznC9AHlxoYXO2m0B38I3pf0+7xAr9rbzWLh8f/Vp5N0PL0HizD4niOVNeZMr/VAbjTsCj5zgsb8XkTWbPZCM/7avoxkPW6y6FWap8+pH258=
Received: from BN6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:404:f7::25)
 by DM5PR1201MB0124.namprd12.prod.outlook.com (2603:10b6:4:58::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 22:16:52 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::34) by BN6PR11CA0063.outlook.office365.com
 (2603:10b6:404:f7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:50 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:49 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:49 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amd/display: Synchronize displays with different
 timings
Date: Fri, 19 Feb 2021 17:16:07 -0500
Message-ID: <20210219221612.1713328-9-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce0cea3-c36b-41ba-5a44-08d8d5240e47
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0124:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0124A3BBB45DC78CD65124C6F5849@DM5PR1201MB0124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rI0Cdmr428Eg/Hl2dGZtws9rP/sQDHsfvUbxQ5huHhdOLX96M/SN2F5RuJzIDTVjzRjuxEym9D96haHaqQcK6dIYm+cNAx28oxNPvFChrPqO2qyXtpw+zi1f+A283+wr/q3lcri0obez3PAAl8qB955CA8dv9kju9BnLXkdsxNginc++F9ePD4hNZnabV6kqdmGo3SiD0VtjSpEf/+BKGCYwGG/a6qcyTaVUEH99J0PfX3q7xwKZkWgvJdU0jnsylM3u8FuhlVA7llz8Ao0BUi7XVPRTvDCYZnNUCE6L89XOm6y+4m1HSBTlXg2qQqOoQpwv+PUUEvhLWKtTT1EHpEMez/Jg6mhyFUNRJE0Aaq7oCDW8Qp2t77cuLlE7npH3hFeBDvv8Kbc130HN/tK5zml3xH323Q5Xs/FyJARXc1NqI1cM+UwnUUfPn9NhWpwHyt+PXdjhJYZV3QaU9ez7U1WPnJVMtiFGE5hmsvsxv5a4z/XgGDJJV36y0xuzlaMjie9urT+uEF2Gc3fQ+N3cfu7ScPC4gvWmHFjwtAaTWRMiGtv85WlcpZjoaJX3CRFn0ZYj7hskh2e83xnT9Gen5sIBnDBGlfyRpFKw4+hOtedNmd8aonbRxirOerBA/O1WIWtjXFCKTwNlGcG9+G5hK+ptUviNjlKoWoNBFSRQtIlJRxw3l5HT8UZoGirqk9zq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(82310400003)(54906003)(7696005)(47076005)(4326008)(478600001)(30864003)(8936002)(70586007)(356005)(36860700001)(19627235002)(316002)(1076003)(2906002)(81166007)(86362001)(336012)(6916009)(2616005)(426003)(6666004)(70206006)(82740400003)(36756003)(5660300002)(26005)(8676002)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:50.7591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce0cea3-c36b-41ba-5a44-08d8d5240e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0124
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
Cc: Vladimir Stempen <vladimir.stempen@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[why]
 Vendor based fan noise improvement

[how]
Report timing synchronizable when DP streams time frame
difference is less than 0.05 percent. Adjust DP  DTOs and
sync displays using  MASTER_UPDATE_LOCK_DB_X_Y

Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  28 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  43 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  52 +++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 225 ++++++++++++++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   2 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 123 ++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   8 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 -
 .../gpu/drm/amd/display/dc/inc/clock_source.h |   5 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  12 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
 18 files changed, 505 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2f56fa2c0bf4..39df5d2c0108 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1102,6 +1102,7 @@ static void program_timing_sync(
 
 	for (i = 0; i < pipe_count; i++) {
 		int group_size = 1;
+		enum timing_synchronization_type sync_type = NOT_SYNCHRONIZABLE;
 		struct pipe_ctx *pipe_set[MAX_PIPES];
 
 		if (!unsynced_pipes[i])
@@ -1116,10 +1117,22 @@ static void program_timing_sync(
 		for (j = i + 1; j < pipe_count; j++) {
 			if (!unsynced_pipes[j])
 				continue;
-
-			if (resource_are_streams_timing_synchronizable(
+			if (sync_type != TIMING_SYNCHRONIZABLE &&
+				dc->hwss.enable_vblanks_synchronization &&
+				unsynced_pipes[j]->stream_res.tg->funcs->align_vblanks &&
+				resource_are_vblanks_synchronizable(
+					unsynced_pipes[j]->stream,
+					pipe_set[0]->stream)) {
+				sync_type = VBLANK_SYNCHRONIZABLE;
+				pipe_set[group_size] = unsynced_pipes[j];
+				unsynced_pipes[j] = NULL;
+				group_size++;
+			} else
+			if (sync_type != VBLANK_SYNCHRONIZABLE &&
+				resource_are_streams_timing_synchronizable(
 					unsynced_pipes[j]->stream,
 					pipe_set[0]->stream)) {
+				sync_type = TIMING_SYNCHRONIZABLE;
 				pipe_set[group_size] = unsynced_pipes[j];
 				unsynced_pipes[j] = NULL;
 				group_size++;
@@ -1145,7 +1158,6 @@ static void program_timing_sync(
 			}
 		}
 
-
 		for (k = 0; k < group_size; k++) {
 			struct dc_stream_status *status = dc_stream_get_status_from_state(ctx, pipe_set[k]->stream);
 
@@ -1175,8 +1187,14 @@ static void program_timing_sync(
 		}
 
 		if (group_size > 1) {
-			dc->hwss.enable_timing_synchronization(
-				dc, group_index, group_size, pipe_set);
+			if (sync_type == TIMING_SYNCHRONIZABLE) {
+				dc->hwss.enable_timing_synchronization(
+					dc, group_index, group_size, pipe_set);
+			} else
+				if (sync_type == VBLANK_SYNCHRONIZABLE) {
+				dc->hwss.enable_vblanks_synchronization(
+					dc, group_index, group_size, pipe_set);
+				}
 			group_index++;
 		}
 		num_group++;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 0c26c2ade782..0241c9d96d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -417,6 +417,49 @@ int resource_get_clock_source_reference(
 	return -1;
 }
 
+bool resource_are_vblanks_synchronizable(
+	struct dc_stream_state *stream1,
+	struct dc_stream_state *stream2)
+{
+	uint32_t base60_refresh_rates[] = {10, 20, 5};
+	uint8_t i;
+	uint8_t rr_count = sizeof(base60_refresh_rates)/sizeof(base60_refresh_rates[0]);
+	int64_t frame_time_diff;
+
+	if (stream1->ctx->dc->config.vblank_alignment_dto_params &&
+		stream1->ctx->dc->config.vblank_alignment_max_frame_time_diff > 0 &&
+		dc_is_dp_signal(stream1->signal) &&
+		dc_is_dp_signal(stream2->signal) &&
+		false == stream1->has_non_synchronizable_pclk &&
+		false == stream2->has_non_synchronizable_pclk &&
+		stream1->timing.flags.VBLANK_SYNCHRONIZABLE &&
+		stream2->timing.flags.VBLANK_SYNCHRONIZABLE) {
+		/* disable refresh rates higher than 60Hz for now */
+		if (stream1->timing.pix_clk_100hz*100/stream1->timing.h_total/
+				stream1->timing.v_total > 60)
+			return false;
+		if (stream2->timing.pix_clk_100hz*100/stream2->timing.h_total/
+				stream2->timing.v_total > 60)
+			return false;
+		frame_time_diff = (int64_t)10000 *
+			stream1->timing.h_total *
+			stream1->timing.v_total *
+			stream2->timing.pix_clk_100hz /
+			stream1->timing.pix_clk_100hz /
+			stream2->timing.h_total /
+			stream2->timing.v_total;
+		for (i = 0; i < rr_count; i++) {
+			int64_t diff = (frame_time_diff * base60_refresh_rates[i]) / 10 - 10000;
+
+			if (diff < 0)
+				diff = -diff;
+			if (diff < stream1->ctx->dc->config.vblank_alignment_max_frame_time_diff)
+				return true;
+		}
+	}
+	return false;
+}
+
 bool resource_are_streams_timing_synchronizable(
 	struct dc_stream_state *stream1,
 	struct dc_stream_state *stream2)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a10daf6655f9..9e631980fa1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -301,6 +301,8 @@ struct dc_config {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool clamp_min_dcfclk;
 #endif
+	uint64_t vblank_alignment_dto_params;
+	uint8_t  vblank_alignment_max_frame_time_diff;
 };
 
 enum visual_confirm {
@@ -528,6 +530,7 @@ struct dc_debug_options {
 	bool disable_dsc;
 	bool enable_dram_clock_change_one_display_vactive;
 	union mem_low_power_enable_options enable_mem_low_power;
+	bool force_vblank_alignment;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index b41e6367b15e..48d3ed97ead9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -705,6 +705,7 @@ struct dc_crtc_timing_flags {
 #ifndef TRIM_FSFT
 	uint32_t FAST_TRANSPORT: 1;
 #endif
+	uint32_t VBLANK_SYNCHRONIZABLE: 1;
 };
 
 enum dc_timing_3d_format {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e243c01b9672..7fa998f97e7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -228,6 +228,9 @@ struct dc_stream_state {
 	uint32_t stream_id;
 	bool is_dsc_enabled;
 	union stream_update_flags update_flags;
+
+	bool has_non_synchronizable_pclk;
+	bool vblank_synchronized;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index dec58b3c42e4..6f47f9bab5ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1002,15 +1002,27 @@ static bool get_pixel_clk_frequency_100hz(
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	unsigned int clock_hz = 0;
+	unsigned int modulo_hz = 0;
 
 	if (clock_source->id == CLOCK_SOURCE_ID_DP_DTO) {
 		clock_hz = REG_READ(PHASE[inst]);
 
-		/* NOTE: There is agreement with VBIOS here that MODULO is
-		 * programmed equal to DPREFCLK, in which case PHASE will be
-		 * equivalent to pixel clock.
-		 */
-		*pixel_clk_khz = clock_hz / 100;
+		if (clock_source->ctx->dc->hwss.enable_vblanks_synchronization &&
+			clock_source->ctx->dc->config.vblank_alignment_max_frame_time_diff > 0) {
+			/* NOTE: In case VBLANK syncronization is enabled, MODULO may
+			 * not be programmed equal to DPREFCLK
+			 */
+			modulo_hz = REG_READ(MODULO[inst]);
+			*pixel_clk_khz = ((uint64_t)clock_hz*
+				clock_source->ctx->dc->clk_mgr->dprefclk_khz*10)/
+				modulo_hz;
+		} else {
+			/* NOTE: There is agreement with VBIOS here that MODULO is
+			 * programmed equal to DPREFCLK, in which case PHASE will be
+			 * equivalent to pixel clock.
+			 */
+			*pixel_clk_khz = clock_hz / 100;
+		}
 		return true;
 	}
 
@@ -1074,8 +1086,35 @@ static bool dcn20_program_pix_clk(
 		struct pixel_clk_params *pix_clk_params,
 		struct pll_settings *pll_settings)
 {
+	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
+	unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
+
 	dce112_program_pix_clk(clock_source, pix_clk_params, pll_settings);
 
+	if (clock_source->ctx->dc->hwss.enable_vblanks_synchronization &&
+			clock_source->ctx->dc->config.vblank_alignment_max_frame_time_diff > 0) {
+		/* NOTE: In case VBLANK syncronization is enabled,
+		 * we need to set modulo to default DPREFCLK first
+		 * dce112_program_pix_clk does not set default DPREFCLK
+		 */
+		REG_WRITE(MODULO[inst],
+			clock_source->ctx->dc->clk_mgr->dprefclk_khz*1000);
+	}
+	return true;
+}
+
+static bool dcn20_override_dp_pix_clk(
+		struct clock_source *clock_source,
+		unsigned int inst,
+		unsigned int pixel_clk,
+		unsigned int ref_clk)
+{
+	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
+
+	REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 0);
+	REG_WRITE(PHASE[inst], pixel_clk);
+	REG_WRITE(MODULO[inst], ref_clk);
+	REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
 	return true;
 }
 
@@ -1083,7 +1122,8 @@ static const struct clock_source_funcs dcn20_clk_src_funcs = {
 	.cs_power_down = dce110_clock_source_power_down,
 	.program_pix_clk = dcn20_program_pix_clk,
 	.get_pix_clk_dividers = dce112_get_pix_clk_dividers,
-	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
+	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz,
+	.override_dp_pix_clk = dcn20_override_dp_pix_clk
 };
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 89912bb5014f..669cee48b0b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1851,6 +1851,225 @@ static bool wait_for_reset_trigger_to_occur(
 	return rc;
 }
 
+uint64_t reduceSizeAndFraction(
+	uint64_t *numerator,
+	uint64_t *denominator,
+	bool checkUint32Bounary)
+{
+	int i;
+	bool ret = checkUint32Bounary == false;
+	uint64_t max_int32 = 0xffffffff;
+	uint64_t num, denom;
+	uint16_t prime_numbers[] = {
+		2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43,
+		47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103,
+		107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163,
+		167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227,
+		229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281,
+		283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353,
+		359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421,
+		431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487,
+		491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569,
+		571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631,
+		641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701,
+		709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773,
+		787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857,
+		859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937,
+		941, 947, 953, 967, 971, 977, 983, 991, 997};
+	int count = ARRAY_SIZE(prime_numbers)/sizeof(prime_numbers[0]);
+
+	num = *numerator;
+	denom = *denominator;
+	for (i = 0; i < count; i++) {
+		if (checkUint32Bounary &&
+			num <= max_int32 && denom <= max_int32) {
+			ret = true;
+			break;
+		}
+		while (num % prime_numbers[i] == 0 &&
+			   denom % prime_numbers[i] == 0) {
+			num /= prime_numbers[i];
+			denom /= prime_numbers[i];
+		}
+	}
+	*numerator = num;
+	*denominator = denom;
+	return ret;
+}
+
+bool is_low_refresh_rate(struct pipe_ctx *pipe)
+{
+	uint32_t master_pipe_refresh_rate =
+		pipe->stream->timing.pix_clk_100hz * 100 /
+		pipe->stream->timing.h_total /
+		pipe->stream->timing.v_total;
+	return master_pipe_refresh_rate <= 30;
+}
+
+uint8_t get_clock_divider(struct pipe_ctx *pipe, bool account_low_refresh_rate)
+{
+	uint32_t clock_divider = 1;
+	uint32_t numpipes = 1;
+
+	if (account_low_refresh_rate && is_low_refresh_rate(pipe))
+		clock_divider *= 2;
+
+	if (pipe->stream_res.pix_clk_params.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		clock_divider *= 2;
+
+	while (pipe->next_odm_pipe) {
+		pipe = pipe->next_odm_pipe;
+		numpipes++;
+	}
+	clock_divider *= numpipes;
+
+	return clock_divider;
+}
+
+int dcn10_align_pixel_clocks(
+	struct dc *dc,
+	int group_size,
+	struct pipe_ctx *grouped_pipes[])
+{
+	struct dc_context *dc_ctx = dc->ctx;
+	int i, master = -1, embedded = -1;
+	struct dc_crtc_timing hw_crtc_timing[MAX_PIPES] = {0};
+	uint64_t phase[MAX_PIPES];
+	uint64_t modulo[MAX_PIPES];
+	unsigned int pclk;
+
+	uint32_t embedded_pix_clk_100hz;
+	uint16_t embedded_h_total;
+	uint16_t embedded_v_total;
+	bool clamshell_closed = false;
+	uint32_t dp_ref_clk_100hz =
+		dc->res_pool->dp_clock_source->ctx->dc->clk_mgr->dprefclk_khz*10;
+
+	if (dc->config.vblank_alignment_dto_params &&
+		dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk) {
+		clamshell_closed =
+			(dc->config.vblank_alignment_dto_params >> 63);
+		embedded_h_total =
+			(dc->config.vblank_alignment_dto_params >> 32) & 0x7FFF;
+		embedded_v_total =
+			(dc->config.vblank_alignment_dto_params >> 48) & 0x7FFF;
+		embedded_pix_clk_100hz =
+			dc->config.vblank_alignment_dto_params & 0xFFFFFFFF;
+
+		for (i = 0; i < group_size; i++) {
+			grouped_pipes[i]->stream_res.tg->funcs->get_hw_timing(
+					grouped_pipes[i]->stream_res.tg,
+					&hw_crtc_timing[i]);
+			dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
+				dc->res_pool->dp_clock_source,
+				grouped_pipes[i]->stream_res.tg->inst,
+				&pclk);
+			hw_crtc_timing[i].pix_clk_100hz = pclk;
+			if (dc_is_embedded_signal(
+					grouped_pipes[i]->stream->signal)) {
+				embedded = i;
+				master = i;
+				phase[i] = embedded_pix_clk_100hz*100;
+				modulo[i] = dp_ref_clk_100hz*100;
+			} else {
+
+				phase[i] = (uint64_t)embedded_pix_clk_100hz*
+					hw_crtc_timing[i].h_total*
+					hw_crtc_timing[i].v_total/
+					get_clock_divider(grouped_pipes[i], true);
+				modulo[i] = (uint64_t)dp_ref_clk_100hz*
+					embedded_h_total*
+					embedded_v_total;
+
+				if (reduceSizeAndFraction(&phase[i],
+						&modulo[i], true) == false) {
+					/*
+					 * this will help to stop reporting
+					 * this timing synchronizable
+					 */
+					DC_SYNC_INFO("Failed to reduce DTO parameters\n");
+					grouped_pipes[i]->stream->has_non_synchronizable_pclk = true;
+				}
+			}
+		}
+
+		for (i = 0; i < group_size; i++) {
+			if (i != embedded && !grouped_pipes[i]->stream->has_non_synchronizable_pclk) {
+				dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk(
+					dc->res_pool->dp_clock_source,
+					grouped_pipes[i]->stream_res.tg->inst,
+					phase[i], modulo[i]);
+				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
+					dc->res_pool->dp_clock_source,
+					grouped_pipes[i]->stream_res.tg->inst, &pclk);
+					grouped_pipes[i]->stream->timing.pix_clk_100hz =
+						pclk*get_clock_divider(grouped_pipes[i], false);
+				if (master == -1)
+					master = i;
+			}
+		}
+
+	}
+	return master;
+}
+
+void dcn10_enable_vblanks_synchronization(
+	struct dc *dc,
+	int group_index,
+	int group_size,
+	struct pipe_ctx *grouped_pipes[])
+{
+	struct dc_context *dc_ctx = dc->ctx;
+	struct output_pixel_processor *opp;
+	struct timing_generator *tg;
+	int i, width, height, master;
+
+	for (i = 1; i < group_size; i++) {
+		opp = grouped_pipes[i]->stream_res.opp;
+		tg = grouped_pipes[i]->stream_res.tg;
+		tg->funcs->get_otg_active_size(tg, &width, &height);
+		if (opp->funcs->opp_program_dpg_dimensions)
+			opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
+	}
+
+	for (i = 0; i < group_size; i++) {
+		if (grouped_pipes[i]->stream == NULL)
+			continue;
+		grouped_pipes[i]->stream->vblank_synchronized = false;
+		grouped_pipes[i]->stream->has_non_synchronizable_pclk = false;
+	}
+
+	DC_SYNC_INFO("Aligning DP DTOs\n");
+
+	master = dcn10_align_pixel_clocks(dc, group_size, grouped_pipes);
+
+	DC_SYNC_INFO("Synchronizing VBlanks\n");
+
+	if (master >= 0) {
+		for (i = 0; i < group_size; i++) {
+			if (i != master && !grouped_pipes[i]->stream->has_non_synchronizable_pclk)
+			grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
+				grouped_pipes[master]->stream_res.tg,
+				grouped_pipes[i]->stream_res.tg,
+				grouped_pipes[master]->stream->timing.pix_clk_100hz,
+				grouped_pipes[i]->stream->timing.pix_clk_100hz,
+				get_clock_divider(grouped_pipes[master], false),
+				get_clock_divider(grouped_pipes[i], false));
+				grouped_pipes[i]->stream->vblank_synchronized = true;
+		}
+		grouped_pipes[master]->stream->vblank_synchronized = true;
+		DC_SYNC_INFO("Sync complete\n");
+	}
+
+	for (i = 1; i < group_size; i++) {
+		opp = grouped_pipes[i]->stream_res.opp;
+		tg = grouped_pipes[i]->stream_res.tg;
+		tg->funcs->get_otg_active_size(tg, &width, &height);
+		if (opp->funcs->opp_program_dpg_dimensions)
+			opp->funcs->opp_program_dpg_dimensions(opp, width, height);
+	}
+}
+
 void dcn10_enable_timing_synchronization(
 	struct dc *dc,
 	int group_index,
@@ -1872,6 +2091,12 @@ void dcn10_enable_timing_synchronization(
 			opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
 	}
 
+	for (i = 0; i < group_size; i++) {
+		if (grouped_pipes[i]->stream == NULL)
+			continue;
+		grouped_pipes[i]->stream->vblank_synchronized = false;
+	}
+
 	for (i = 1; i < group_size; i++)
 		grouped_pipes[i]->stream_res.tg->funcs->enable_reset_trigger(
 				grouped_pipes[i]->stream_res.tg,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 89e6dfb63da0..a30f74cfd11a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -123,6 +123,11 @@ void dcn10_enable_timing_synchronization(
 		int group_index,
 		int group_size,
 		struct pipe_ctx *grouped_pipes[]);
+void dcn10_enable_vblanks_synchronization(
+		struct dc *dc,
+		int group_index,
+		int group_size,
+		struct pipe_ctx *grouped_pipes[]);
 void dcn10_enable_per_frame_crtc_position_reset(
 		struct dc *dc,
 		int group_size,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index b222c67973d4..2529723beeb1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -212,6 +212,7 @@ struct dcn_optc_registers {
 	SF(OTG0_OTG_CONTROL, OTG_START_POINT_CNTL, mask_sh),\
 	SF(OTG0_OTG_CONTROL, OTG_DISABLE_POINT_CNTL, mask_sh),\
 	SF(OTG0_OTG_CONTROL, OTG_FIELD_NUMBER_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_CURRENT_MASTER_EN_STATE, mask_sh),\
 	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EN, mask_sh),\
 	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_LINE_NUM, mask_sh),\
 	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_POLARITY, mask_sh),\
@@ -352,6 +353,7 @@ struct dcn_optc_registers {
 	type OTG_START_POINT_CNTL;\
 	type OTG_DISABLE_POINT_CNTL;\
 	type OTG_FIELD_NUMBER_CNTL;\
+	type OTG_CURRENT_MASTER_EN_STATE;\
 	type OTG_STEREO_EN;\
 	type OTG_STEREO_SYNC_OUTPUT_LINE_NUM;\
 	type OTG_STEREO_SYNC_OUTPUT_POLARITY;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 73ac78b16bd4..f1a08a7736ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -738,7 +738,6 @@ void enc1_stream_encoder_update_dp_info_packets(
 	REG_UPDATE(DP_SEC_CNTL, DP_SEC_GSP2_ENABLE, info_frame->spd.valid);
 	REG_UPDATE(DP_SEC_CNTL, DP_SEC_GSP3_ENABLE, info_frame->hdrsmd.valid);
 
-
 	/* This bit is the master enable bit.
 	 * When enabling secondary stream engine,
 	 * this master bit must also be set.
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 51a4166e9750..5b74605d0abe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -42,6 +42,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.program_output_csc = dcn20_program_output_csc,
 	.enable_accelerated_mode = dce110_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
+	.enable_vblanks_synchronization = dcn10_enable_vblanks_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dce110_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index d8b18c515d06..ef6ee03175e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -309,6 +309,128 @@ void optc2_set_dwb_source(struct timing_generator *optc,
 				OPTC_DWB1_SOURCE_SELECT, optc->inst);
 }
 
+void optc2_align_vblanks(
+	struct timing_generator *optc_master,
+	struct timing_generator *optc_slave,
+	uint32_t master_pixel_clock_100Hz,
+	uint32_t slave_pixel_clock_100Hz,
+	uint8_t master_clock_divider,
+	uint8_t slave_clock_divider)
+{
+	/* accessing slave OTG registers */
+	struct optc *optc1 = DCN10TG_FROM_TG(optc_slave);
+
+	uint32_t master_v_active = 0;
+	uint32_t master_h_total = 0;
+	uint32_t slave_h_total = 0;
+	uint64_t L, XY, p = 10000;
+	uint32_t X, Y;
+	uint32_t master_update_lock;
+
+	/* disable slave OTG */
+	REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0);
+	/* wait until disabled */
+	REG_WAIT(OTG_CONTROL,
+			 OTG_CURRENT_MASTER_EN_STATE,
+			 0, 10, 5000);
+
+	REG_GET(OTG_H_TOTAL, OTG_H_TOTAL, &slave_h_total);
+
+	/* assign slave OTG to be controlled by master update lock */
+	REG_SET(OTG_GLOBAL_CONTROL0, 0,
+			OTG_MASTER_UPDATE_LOCK_SEL, optc_master->inst);
+
+	/* accessing master OTG registers */
+	optc1 = DCN10TG_FROM_TG(optc_master);
+
+	/* saving update lock state, not sure if it's needed */
+	REG_GET(OTG_MASTER_UPDATE_LOCK,
+			OTG_MASTER_UPDATE_LOCK, &master_update_lock);
+	/* unlocking master OTG */
+	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
+			OTG_MASTER_UPDATE_LOCK, 0);
+
+	REG_GET(OTG_V_BLANK_START_END,
+			OTG_V_BLANK_START, &master_v_active);
+	REG_GET(OTG_H_TOTAL, OTG_H_TOTAL, &master_h_total);
+
+	/* calculate when to enable slave OTG */
+	L = p * slave_h_total * master_pixel_clock_100Hz /
+		master_h_total / slave_pixel_clock_100Hz;
+	XY = L / p;
+	Y = master_v_active - XY - 1;
+	X = ((XY + 1) * p - L) * master_h_total / master_clock_divider / p;
+
+	/*
+	 * set master OTG to unlock when V/H
+	 * counters reach calculated values
+	 */
+	REG_UPDATE(OTG_GLOBAL_CONTROL1,
+			   MASTER_UPDATE_LOCK_DB_EN, 1);
+	REG_UPDATE_2(OTG_GLOBAL_CONTROL1,
+				 MASTER_UPDATE_LOCK_DB_X,
+				 X,
+				 MASTER_UPDATE_LOCK_DB_Y,
+				 Y);
+
+	/* lock master OTG */
+	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
+			OTG_MASTER_UPDATE_LOCK, 1);
+	REG_WAIT(OTG_MASTER_UPDATE_LOCK,
+			 UPDATE_LOCK_STATUS, 1, 1, 10);
+
+	/* accessing slave OTG registers */
+	optc1 = DCN10TG_FROM_TG(optc_slave);
+
+	/*
+	 * enable slave OTG, the OTG is locked with
+	 * master's update lock, so it will not run
+	 */
+	REG_UPDATE(OTG_CONTROL,
+			   OTG_MASTER_EN, 1);
+
+	/* accessing master OTG registers */
+	optc1 = DCN10TG_FROM_TG(optc_master);
+
+	/*
+	 * unlock master OTG. When master H/V counters reach
+	 * DB_XY point, slave OTG will start
+	 */
+	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
+			OTG_MASTER_UPDATE_LOCK, 0);
+
+	/* accessing slave OTG registers */
+	optc1 = DCN10TG_FROM_TG(optc_slave);
+
+	/* wait for slave OTG to start running*/
+	REG_WAIT(OTG_CONTROL,
+			 OTG_CURRENT_MASTER_EN_STATE,
+			 1, 10, 5000);
+
+	/* accessing master OTG registers */
+	optc1 = DCN10TG_FROM_TG(optc_master);
+
+	/* disable the XY point*/
+	REG_UPDATE(OTG_GLOBAL_CONTROL1,
+			   MASTER_UPDATE_LOCK_DB_EN, 0);
+	REG_UPDATE_2(OTG_GLOBAL_CONTROL1,
+				 MASTER_UPDATE_LOCK_DB_X,
+				 0,
+				 MASTER_UPDATE_LOCK_DB_Y,
+				 0);
+
+	/*restore master update lock*/
+	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
+			OTG_MASTER_UPDATE_LOCK, master_update_lock);
+
+	/* accessing slave OTG registers */
+	optc1 = DCN10TG_FROM_TG(optc_slave);
+	/* restore slave to be controlled by it's own */
+	REG_SET(OTG_GLOBAL_CONTROL0, 0,
+			OTG_MASTER_UPDATE_LOCK_SEL, optc_slave->inst);
+
+}
+
 void optc2_triplebuffer_lock(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -468,6 +590,7 @@ static struct timing_generator_funcs dcn20_tg_funcs = {
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
+		.align_vblanks = optc2_align_vblanks,
 };
 
 void dcn20_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2c2dbfcd8957..a65efed63fbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2033,9 +2033,13 @@ int dcn20_populate_dml_pipes_from_context(
 		if (res_ctx->pipe_ctx[pipe_cnt].stream == res_ctx->pipe_ctx[i].stream)
 			continue;
 
-		if (dc->debug.disable_timing_sync || !resource_are_streams_timing_synchronizable(
+		if (dc->debug.disable_timing_sync ||
+			(!resource_are_streams_timing_synchronizable(
 				res_ctx->pipe_ctx[pipe_cnt].stream,
-				res_ctx->pipe_ctx[i].stream)) {
+				res_ctx->pipe_ctx[i].stream) &&
+			!resource_are_vblanks_synchronizable(
+				res_ctx->pipe_ctx[pipe_cnt].stream,
+				res_ctx->pipe_ctx[i].stream))) {
 			synchronized_vblank = false;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 6c0f7ef0a3df..72bee637c1e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -454,7 +454,6 @@ static void enc3_stream_encoder_update_dp_info_packets(
 	REG_UPDATE(DP_SEC_CNTL, DP_SEC_GSP2_ENABLE, info_frame->spd.valid);
 	REG_UPDATE(DP_SEC_CNTL, DP_SEC_GSP3_ENABLE, info_frame->hdrsmd.valid);
 
-
 	/* This bit is the master enable bit.
 	 * When enabling secondary stream engine,
 	 * this master bit must also be set.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
index 1b01a9a58d14..e2b3a2c7a927 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
@@ -170,6 +170,11 @@ struct clock_source_funcs {
 			const struct clock_source *clock_source,
 			unsigned int inst,
 			unsigned int *pixel_clk_khz);
+	bool (*override_dp_pix_clk)(
+			struct clock_source *clock_source,
+			unsigned int inst,
+			unsigned int pixel_clk,
+			unsigned int ref_clk);
 };
 
 struct clock_source {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 754832d216fd..9ff68b67780c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -109,6 +109,12 @@ enum h_timing_div_mode {
 	H_TIMING_DIV_BY4,
 };
 
+enum timing_synchronization_type {
+	NOT_SYNCHRONIZABLE,
+	TIMING_SYNCHRONIZABLE,
+	VBLANK_SYNCHRONIZABLE
+};
+
 struct crc_params {
 	/* Regions used to calculate CRC*/
 	uint16_t windowa_x_start;
@@ -292,6 +298,12 @@ struct timing_generator_funcs {
 			uint32_t window_start, uint32_t window_end);
 	void (*set_vtotal_change_limit)(struct timing_generator *optc,
 			uint32_t limit);
+	void (*align_vblanks)(struct timing_generator *master_optc,
+			struct timing_generator *slave_optc,
+			uint32_t master_pixel_clock_100Hz,
+			uint32_t slave_pixel_clock_100Hz,
+			uint8_t master_clock_divider,
+			uint8_t slave_clock_divider);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 0586ab2ffd6a..714a5ace2298 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -111,6 +111,9 @@ struct hw_sequencer_funcs {
 	void (*enable_timing_synchronization)(struct dc *dc,
 			int group_index, int group_size,
 			struct pipe_ctx *grouped_pipes[]);
+	void (*enable_vblanks_synchronization)(struct dc *dc,
+			int group_index, int group_size,
+			struct pipe_ctx *grouped_pipes[]);
 	void (*setup_periodic_interrupt)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			enum vline_select vline);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index d89815a46190..3d97078d52a9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -115,6 +115,10 @@ bool resource_are_streams_timing_synchronizable(
 		struct dc_stream_state *stream1,
 		struct dc_stream_state *stream2);
 
+bool resource_are_vblanks_synchronizable(
+		struct dc_stream_state *stream1,
+		struct dc_stream_state *stream2);
+
 struct clock_source *resource_find_used_clk_src_for_sharing(
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
