Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416CECC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4C410F77C;
	Tue, 13 Oct 2026 11:18:54 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C120210F77C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie8pbeQgD6iQydh/px1tHQoxgKQHuCwcT19Ko0bFVb02VbIx9o8qOafoLZryOLHq+wvmWUdfeO7nZWZrVNty7qhgsgWaMQrbNe32i8xF1udl08PdHIjorSUogxh4R/3PMd1EKzC5KSjgI6nwkm70SGbP84y6mludF0lDya91tkeu3gq/tg6pxTw96T88/RAkQDh7PzPzUoVnMrYyrJ/GCdEIadLJur7xtLww2gfoeYoaZvx3Gz2PqdTj39fUhm3UVsztLzqy7Wh6DdJoQnx3r0PC6a0vQ+dJftHSMrbrSyHGdS86NIxfchMKDOYisWbnvsJcgPI3dzKXmqDTbS7p+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c54mFxGt7B/nUy6RqV8Y5EXb0MmtPJkRg29B9yfsWfk=;
 b=ItZh5nOCeYlugfr7oUMMz3ZT4WkbfqC+uzvzB5TDYIzEfR0+bCRXnNx+gJcAk4M/qWpFyg8O5SD/e5BseB0+M0j2BViDDQmtLsjEzFJmK/1dhA2lZrHP8qWxKfwmuD6UoC8n7wlNRXXs1Kw2mDklsIfNSekrWH49OibPRu6m82NXqKoHPpzt4YsuyEmxaMYFxjIAG9uraj6dCTvCgbVVazCitT9hqgzXgq+ANCkDiJ4Uj1aki900Cz2JK/MqUE/DUf9Boo5FAXcLjiJhaRJ0HSc0Bh2JFrlRhV32PA0kwfvGXF/P3d5VuczU/KtkpOy6y0nHM4tzVMxbxZmJHZHuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c54mFxGt7B/nUy6RqV8Y5EXb0MmtPJkRg29B9yfsWfk=;
 b=GDVTggMbOQz3Zy1GaLwu8prC5KG+knEJvgGe0nrdfmPnxMeEOX35had0YN+jnp4jY2/ksXyh5+vnSEQ3TsTRxYEOVX0GZYcDvhJASS0TxPvr4H75F/PkRM9Ge2KJA24SJzZHBqM8SshY1KJURFF1jpTnOEvgbjck3qkagqXbyD0=
Received: from SJ0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:33a::29)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:18:42 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::31) by SJ0PR03CA0024.outlook.office365.com
 (2603:10b6:a03:33a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:18:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:18:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:32 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:18:24 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Josip Pavic
 <josip.pavic@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 18/30] drm/amd/display: move timing_adjust_pending into
 dc_stream_state
Date: Tue, 13 Oct 2026 19:08:05 +0800
Message-ID: <20261013111616.2267344-19-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 362aa83e-a73a-4501-d4e6-08df291bbd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|5023799004|11063799006|56012099006|22082099003|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: TwgoIS3czsVAj7IbZBRw3/hCwQ4DA1A1hv83PV+zdyHkLgeM+QZLcZ7D1w2slWPCCKRNJhBxC+d7DK8fjgdgsmIld5L0/oHt9wp5AJD5Y3tuWarYs7b/h/7fLJF8Fjty/PSr7V+mdnXJZmYnYOKNqGWHa/gGvGrdgRxhKLIEg7n+fL0AnZTfkJE/tlAmgqefS1EYzLrv79zyH5sl95Y4N4rWVKvb6DcFsz6/Pg9dUNGG0OJkBMe5WC9E7ZLV4ot6xj+oZnFVA5FbZdhTq28p3ASa9h1SUbu+SgjxJiTOYNgm+hK9NUHQA7Y4Prhyxj4680PAZ2xNtbngTDOxZ3ZHTywIJIg9bwmNP8eZhljMw0EGH1OaSjdjKIEf4y2+QbrAMRdxqbI2M4DV5pnkWKIsax0CPpCDAvtBpbrFyBgEX5OZsix9hP+sAlAos0oIFpl0+em+Mt9lSPBCEI8kkliPiUyUXG44b7ltsJX/GpfP8invn1ssjZD58Jayk5Js7cP6ZTgxFJOyqzFf9JNjpydREedHFiN6zxz7Hg998sYVRMqApqdP8/m7WatZN1buJJEOw4uBCm2RRl7a40Y8vdGVFmj1LNwIthd4NcX2A15fqTpr3SklFEOO20Qt1LnpN9pWdPXXGU3noa6h0bqhS52LdFrUklFQ9l5URTD2SowM5TpGOSp+RNY2fVZxAPPmokWL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wgm6OoJQMgGlnMDl+pjLVXVDc593ERB1NjqSANyQLWWQdXgc8gV0Lnrx7ararx3iSMFGAYdaPYo3nqXWW3dfb+tWzNnA3eJGdksUTXcUxydSH12EFVD0z1aRG8mcJP0evSuk88Qm337vtBITXzWZZmegQF3ZEkXEuE9NLv1yYwiFTqaTgD/aA3AWP+Z19TPzK/VhUaBQbPkT0jGN3ZKGX0n1sIMfCbM2Pj5BAtI9D7aM9zPmO9dhSL1xwa6E6ny28LP77q29LlqgVd64u5vXBmFXUz+Hu6xTqO/ucToxLe7/LAIezhlf7YEivkNp5/iCVlu9XyRydnw4ecn6fEXvi/lfbR6h84ImuLJWQOS0P+BBBgmvjB/2MsZAF1CkWFPjqRgUUSWb1eTBvX3DA0PnFOPS+ULRuy+/qs41/S467QgaWlU1Ny8uxHuKkdIF0AUj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:18:42.1553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362aa83e-a73a-4501-d4e6-08df291bbd11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <Aric.Cyr@amd.com>

[Why]
dc_stream_adjust_vmin_vmax() short circuits when the requested v_totals
match stream->adjust and nothing is pending. A display that is not
driving DRR requests a constant v_total, so that short circuit is
permanent once hardware stops matching - and init_hw() resets the OTG
DRR registers and the static screen trigger mask. The commit that
follows need not restore them either: apply_ctx_to_hw() skips
enable_stream_timing() when pipe_need_reprogram() considers the pipe
unchanged, and dc_commit_streams() can skip the commit entirely on
!streams_changed(). Panel replay never sees a static screen trigger
again.

timing_adjust_pending should cover this, but it lives inside struct
dc_crtc_timing_adjust, which is copied and compared by value.
hwss.set_drr() takes it by value, and copy_stream_update_to_stream()
wrote the flag back into the caller's struct.

[How]
Move timing_adjust_pending into struct dc_stream_state so a
dc_crtc_timing_adjust is pure request data, safe to copy and compare.

Add program_pending_drr_adjust() to settle any stream still carrying a
pending adjustment at the end of a commit, so a commit always leaves
stream->adjust describing the OTG. It is a no-op when nothing is
pending.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 51 +++++++++++++++----
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  1 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 ++
 6 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index b65af2cc1fb7..49c6048d0cc9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -42,7 +42,7 @@
 bool amdgpu_dm_is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 					  struct dm_crtc_state *new_state)
 {
-	if (new_state->stream->adjust.timing_adjust_pending)
+	if (new_state->stream->timing_adjust_pending)
 		return true;
 	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
 		return true;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 547a543b9f5d..85670e1cbb05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -173,7 +173,7 @@ static void dm_test_dc_timing_adjust_pending(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
 	new_state->stream = stream;
-	stream->adjust.timing_adjust_pending = 1;
+	stream->timing_adjust_pending = 1;
 
 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_dc_timing_adjust_needed(old_state, new_state));
 }
@@ -592,7 +592,7 @@ static void dm_test_update_freesync_state_pre_ai_active(struct kunit *test)
 
 	amdgpu_dm_update_freesync_state_on_stream(&adev->dm, &crtc_state, stream, surface, 0);
 
-	KUNIT_EXPECT_FALSE(test, stream->adjust.timing_adjust_pending);
+	KUNIT_EXPECT_FALSE(test, stream->timing_adjust_pending);
 }
 
 static void dm_test_update_freesync_state_pcon_version(struct kunit *test, u8 version)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8cf6edbd39c9..f84f659c101b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -458,7 +458,34 @@ static void invalidate_drr_adjust(struct dc *dc)
 
 	for (i = 0; i < dc->current_state->stream_count; i++)
 		if (dc->current_state->streams[i])
-			dc->current_state->streams[i]->adjust.timing_adjust_pending = true;
+			dc->current_state->streams[i]->timing_adjust_pending = true;
+}
+
+/* apply_ctx_to_hw() skips controller programming for a pipe it considers unchanged, so a
+ * commit on its own does not guarantee the OTG matches stream->adjust. Settle anything
+ * still outstanding here - dc_stream_adjust_vmin_vmax() cannot, because it short circuits
+ * when the requested v_totals are unchanged, which is permanent for a stream that is not
+ * driving DRR.
+ */
+static void program_pending_drr_adjust(struct dc *dc, struct dc_state *context)
+{
+	int i;
+
+	if (!dc->hwss.set_drr)
+		return;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) || !pipe->stream_res.tg)
+			continue;
+
+		if (!pipe->stream->timing_adjust_pending)
+			continue;
+
+		dc_exit_ips_for_hw_access(dc);
+		dc->hwss.set_drr(&pipe, 1, pipe->stream->adjust);
+	}
 }
 
 /**
@@ -1370,7 +1397,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		if (dc->optimized_required &&
 			(stream->adjust.v_total_max != adjust->v_total_max ||
 			stream->adjust.v_total_min != adjust->v_total_min)) {
-			stream->adjust.timing_adjust_pending = true;
+			stream->timing_adjust_pending = true;
 			return false;
 		}
 	}
@@ -1378,7 +1405,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	/* timing_adjust_pending tracks whether stream->adjust still describes the
 	 * OTG, so a cleared flag plus matching values means hw is already current.
 	 */
-	drr_unchanged = !stream->adjust.timing_adjust_pending &&
+	drr_unchanged = !stream->timing_adjust_pending &&
 			stream->adjust.v_total_min == adjust->v_total_min &&
 			stream->adjust.v_total_max == adjust->v_total_max &&
 			stream->adjust.v_total_mid == adjust->v_total_mid &&
@@ -1402,13 +1429,13 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	stream->adjust.v_total_min = adjust->v_total_min;
 	stream->adjust.allow_otg_v_count_halt = adjust->allow_otg_v_count_halt;
 	/* Only cleared once the new values have actually reached an OTG. */
-	stream->adjust.timing_adjust_pending = true;
+	stream->timing_adjust_pending = true;
 
 	if (exceeds_max_v_total) {
 		if (!set_long_vtotal(dc, stream, adjust))
 			return false;
 
-		stream->adjust.timing_adjust_pending = false;
+		stream->timing_adjust_pending = false;
 		return true;
 	}
 
@@ -1419,7 +1446,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 			dc->hwss.set_drr(&pipe,
 					1,
 					*adjust);
-			stream->adjust.timing_adjust_pending = false;
+			stream->timing_adjust_pending = false;
 
 			if (dc->debug.visual_confirm == VISUAL_CONFIRM_BOOSTED_REFRESH_RATE) {
 				if (pipe->stream && pipe->plane_state) {
@@ -2422,6 +2449,8 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		return result;
 	}
 
+	program_pending_drr_adjust(dc, context);
+
 	dc_trigger_sync(dc, context);
 
 	/* Full update should unconditionally be triggered when dc_commit_state_no_check is called */
@@ -2578,8 +2607,10 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 		return res;
 
 	if (!streams_changed(dc, params->streams, params->stream_count) &&
-			dc->current_state->power_source == params->power_source)
+			dc->current_state->power_source == params->power_source) {
+		program_pending_drr_adjust(dc, dc->current_state);
 		return res;
+	}
 
 	dc_exit_ips_for_hw_access(dc);
 
@@ -3604,11 +3635,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 
 	if (update->crtc_timing_adjust) {
 		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
-			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max ||
-			stream->adjust.timing_adjust_pending)
-			update->crtc_timing_adjust->timing_adjust_pending = true;
+			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max)
+			stream->timing_adjust_pending = true;
 		stream->adjust = *update->crtc_timing_adjust;
-		update->crtc_timing_adjust->timing_adjust_pending = false;
 	}
 
 	if (update->dpms_off)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 86957b4d182a..415ad6ddb740 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -756,7 +756,7 @@ void set_drr_and_clear_adjust_pending(
 
 	if (stream)
 		/* A null params resets DRR in hw, leaving stream->adjust stale. */
-		stream->adjust.timing_adjust_pending = (params == NULL);
+		stream->timing_adjust_pending = (params == NULL);
 }
 
 void get_fams2_visual_confirm_color(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index baf6091bb52d..eb9effb22658 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -1083,7 +1083,6 @@ struct dc_crtc_timing_adjust {
 	uint32_t v_total_mid;
 	uint32_t v_total_mid_frame_num;
 	uint32_t allow_otg_v_count_halt;
-	uint8_t timing_adjust_pending;
 };
 
 struct dtbclk_dto_params {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index fec5e7a84bb9..7999a7d84a77 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -336,6 +336,9 @@ struct dc_stream_state {
 	enum dc_blending_linearity blending_linearity;
 	struct dc_update_scratch_space *update_scratch;
 	bool firmware_controlled_hdr_info_packet;
+
+	/* timing adjust has not been propagated to hardware yet. */
+	bool timing_adjust_pending;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
-- 
2.43.0

