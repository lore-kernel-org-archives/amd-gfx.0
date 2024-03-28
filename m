Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF721CD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB47112531;
	Thu, 28 Mar 2024 19:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HpONHirk";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEDF611252C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyBK5PvhvYXVCW2ShRh1Kcj5RxmPmEF1++tc8XW5T1bCCtYZrNfAW6nKCw/WJe7SbIfihEU4jvBx//AZzzzO5YtWkhds0FH3mVoeDIB7UPA8c0m6Eh3pIkS1QNZvXYgootyiYodQaUW6coRZPIDSopakwMlgLAGwnXxQNjh46IM4HDnbUVgGayNq4TXQ5YgEuJAiND9IoSofB/TG6JPsoCja/gWuujkIy764ib6zCoLtiy++Hn9SFeNGpZB+e8ys5zgeu5LX+jLnx8wBr+FqcsgOokapoFoTniE4GggVpPP3KSmg6j2/gIeu128dYfAkuwUeZpz/5Ma4onEKZCsUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93ZQQsJ5nw7oFafejThGHYu04wYdZKYhUKht99kZ6w0=;
 b=mLD/jLDcNtaXEUBJmHRtdn3g29TR2fBGIk9zk4NJV0WaXDYXObR7YsmKEd+bKhQPq1NC3Ls/w3z0P/GfQsFGgIy+lI0x+6J+bgzMTw6nF1tbZT3CDavyC3HAgmo+2EMIL8dd31WrgOJaKT905u13w0t8iU/9rR/f+sMqDv86TIac7LuoK88P5VLH5xoNfMygVEdRW7BnjQkJu7TU1wpxI8PvnpTR5P0clJtXYI4bUEwhcOJziCqqedq1aL4mET/Qgxzyq9qXPtQUnrINgn+yeZscJuxTlkA3bjERHTGAhxqY/e3jF/d26NyVmauIwHhpOVsaDSjos/VUA3PUO57Rwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93ZQQsJ5nw7oFafejThGHYu04wYdZKYhUKht99kZ6w0=;
 b=HpONHirkx1JZpwsMN4pslnRiBjXHC4zEfGH8ViPwhRDPbCfELst5nuJedhquSVO4VdKaUHn/E/09aeUGlxjaB6JnNV0suVV99qoVydzaFLWFkgcI+D1xsRBclDCEP9VQ5kBOjzvQS/iaMqj1xP3ryy7/PU5zy6L+ZHnIHEOPUB8=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:52:00 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f5) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:55 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:54 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Jun Lei <jun.lei@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 23/43] drm/amd/display: Add handling for DC power mode
Date: Thu, 28 Mar 2024 15:50:27 -0400
Message-ID: <20240328195047.2843715-24-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: ab08024b-9b99-4b88-fdc2-08dc4f6087b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwH2iCIlFO0T7iVgP2w3Zxq7Wlip+xtgl4KN3TqrO/8LumKnFPDBu+sxBgw54y/X+6Q78zhsXXuHhxGWb9IMbyGENqCKxS/MIw2eeZXYdtOQR+0fCxL+Ovs7XxKmMROLUtfoYiMRt+4eetvtcafG3aEnJp6NZRiPBTIp+2/x7f62+hRpMWxNWKVp9ASkxBfRv2KA4Xboid562uGElpocknTF8ohsl34nsSaEAiKONS1RWofLjxml+SCNKxDHftMMuC/WFcZI9dUXwD0s8GBn3mq9nJfzzpIPve63P5+HzjSTX7TGzYXbk9SvBilwFjh1XxNEYW4795Tsss38GZ96jtlZ+0qjAY87aEmg8txPOhv7BqlKoyv05EIxnWOVVIziwcAUZm5WModY+ZP6H2U76suPps9z8L63v16ay0qZPQRciT1BmA2KBG9nr4UrvvaDuWKcg0KWgrlPkpbXjIgwoHijshTlxIpjCptExyi4ZUdiXaSB48UnJv2VDV94X3X4RxrzGlqBwB78Jj3dTl74LqXNt3JrO4H/4tq9BIJ7KP0BExqENkEseZWx2Zd2IQ11wlgKBZbwP524kr0AyKwJxAx8pmdWNY6FJRcl/9WBmZdTQuRq2dQXzLfVDKWapW4WkA+xYXhKKOxTaU5yeC0G1WhGJ+BjyAboCbPmDWw1eKBLu1f89IqBDfbt8m4rWqEwT3cBltNR/XnDHpptobrDBVcEVJA7nMy1bxvEg9l1Gi+LABnu0YUqmWnzIOzGlATQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:59.0148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab08024b-9b99-4b88-fdc2-08dc4f6087b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Future implementations will require a distinction between AC power and
DC power (wall power and battery power, respectively). To accomplish this,
adding a power mode parameter to certain dc interfaces, and adding a
separate DML2 instance for DC mode validation. Default behaviour unchanged.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 ++++++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 37 ++++++++++---------
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 29 +++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 13 +++++--
 drivers/gpu/drm/amd/display/dc/dc_state.h     |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  8 ----
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 16 ++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 ++
 .../dc/resource/dcn32/dcn32_resource.c        | 16 +++++++-
 .../dc/resource/dcn321/dcn321_resource.c      | 12 +++++-
 .../dc/resource/dcn35/dcn35_resource.c        |  4 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  4 +-
 13 files changed, 120 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08ca842af727..e9044415bf1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2629,6 +2629,7 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 	int i;
 	struct dc_stream_state *del_streams[MAX_PIPES];
 	int del_streams_count = 0;
+	struct dc_commit_streams_params params = {};
 
 	memset(del_streams, 0, sizeof(del_streams));
 
@@ -2655,7 +2656,9 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 			goto fail;
 	}
 
-	res = dc_commit_streams(dc, context->streams, context->stream_count);
+	params.streams = context->streams;
+	params.stream_count = context->stream_count;
+	res = dc_commit_streams(dc, &params);
 
 fail:
 	dc_state_release(context);
@@ -2877,6 +2880,7 @@ static int dm_resume(void *handle)
 	struct dc_state *dc_state;
 	int i, r, j, ret;
 	bool need_hotplug = false;
+	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
 		dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
@@ -2926,7 +2930,9 @@ static int dm_resume(void *handle)
 			dc_enable_dmub_outbox(adev->dm.dc);
 		}
 
-		WARN_ON(!dc_commit_streams(dm->dc, dc_state->streams, dc_state->stream_count));
+		commit_params.streams = dc_state->streams;
+		commit_params.stream_count = dc_state->stream_count;
+		WARN_ON(!dc_commit_streams(dm->dc, &commit_params));
 
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
 
@@ -2943,7 +2949,7 @@ static int dm_resume(void *handle)
 	}
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_state_release(dm_state->context);
-	dm_state->context = dc_state_create(dm->dc);
+	dm_state->context = dc_state_create(dm->dc, NULL);
 	/* TODO: Remove dc_state->dccg, use dc->dccg directly. */
 
 	/* Before powering on DC we need to re-initialize DMUB. */
@@ -6802,7 +6808,7 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
 	if (!dc_plane_state)
 		goto cleanup;
 
-	dc_state = dc_state_create(dc);
+	dc_state = dc_state_create(dc, NULL);
 	if (!dc_state)
 		goto cleanup;
 
@@ -8858,6 +8864,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	struct drm_connector *connector;
 	bool mode_set_reset_required = false;
 	u32 i;
+	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
 
 	/* Disable writeback */
 	for_each_old_connector_in_state(state, connector, old_con_state, i) {
@@ -8994,7 +9001,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 	dm_enable_per_frame_crtc_master_sync(dc_state);
 	mutex_lock(&dm->dc_lock);
-	WARN_ON(!dc_commit_streams(dm->dc, dc_state->streams, dc_state->stream_count));
+	WARN_ON(!dc_commit_streams(dm->dc, &params));
 
 	/* Allow idle optimization when vblank count is 0 for display off */
 	if (dm->active_vblank_irq_count == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c3510cdd0ec8..f44025eacc0a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1089,8 +1089,7 @@ static bool dc_construct(struct dc *dc,
 	 * is initialized in dc_create_resource_pool because
 	 * on creation it copies the contents of dc->dml
 	 */
-
-	dc->current_state = dc_state_create(dc);
+	dc->current_state = dc_state_create(dc, NULL);
 
 	if (!dc->current_state) {
 		dm_error("%s: failed to create validate ctx\n", __func__);
@@ -2135,9 +2134,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
  * Return DC_OK if everything work as expected, otherwise, return a dc_status
  * code.
  */
-enum dc_status dc_commit_streams(struct dc *dc,
-				 struct dc_stream_state *streams[],
-				 uint8_t stream_count)
+enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params *params)
 {
 	int i, j;
 	struct dc_state *context;
@@ -2146,18 +2143,22 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	struct pipe_ctx *pipe;
 	bool handle_exit_odm2to1 = false;
 
+	if (!params)
+		return DC_ERROR_UNEXPECTED;
+
 	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
 		return res;
 
-	if (!streams_changed(dc, streams, stream_count))
+	if (!streams_changed(dc, params->streams, params->stream_count) &&
+			dc->current_state->power_source == params->power_source)
 		return res;
 
 	dc_exit_ips_for_hw_access(dc);
 
-	DC_LOG_DC("%s: %d streams\n", __func__, stream_count);
+	DC_LOG_DC("%s: %d streams\n", __func__, params->stream_count);
 
-	for (i = 0; i < stream_count; i++) {
-		struct dc_stream_state *stream = streams[i];
+	for (i = 0; i < params->stream_count; i++) {
+		struct dc_stream_state *stream = params->streams[i];
 		struct dc_stream_status *status = dc_stream_get_status(stream);
 
 		dc_stream_log(dc, stream);
@@ -2175,7 +2176,7 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	 * scenario, it uses extra pipes than needed to reduce power consumption
 	 * We need to switch off this feature to make room for new streams.
 	 */
-	if (stream_count > dc->current_state->stream_count &&
+	if (params->stream_count > dc->current_state->stream_count &&
 			dc->current_state->stream_count == 1) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -2191,7 +2192,9 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	if (!context)
 		goto context_alloc_fail;
 
-	res = dc_validate_with_context(dc, set, stream_count, context, false);
+	context->power_source = params->power_source;
+
+	res = dc_validate_with_context(dc, set, params->stream_count, context, false);
 	if (res != DC_OK) {
 		BREAK_TO_DEBUGGER();
 		goto fail;
@@ -2199,16 +2202,16 @@ enum dc_status dc_commit_streams(struct dc *dc,
 
 	res = dc_commit_state_no_check(dc, context);
 
-	for (i = 0; i < stream_count; i++) {
+	for (i = 0; i < params->stream_count; i++) {
 		for (j = 0; j < context->stream_count; j++) {
-			if (streams[i]->stream_id == context->streams[j]->stream_id)
-				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+			if (params->streams[i]->stream_id == context->streams[j]->stream_id)
+				params->streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
 
-			if (dc_is_embedded_signal(streams[i]->signal)) {
-				struct dc_stream_status *status = dc_state_get_stream_status(context, streams[i]);
+			if (dc_is_embedded_signal(params->streams[i]->signal)) {
+				struct dc_stream_status *status = dc_state_get_stream_status(context, params->streams[i]);
 
 				if (dc->hwss.is_abm_supported)
-					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, streams[i]);
+					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, params->streams[i]);
 				else
 					status->is_abm_supported = true;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index d546ea71026d..d1d326e9b9b6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -188,8 +188,11 @@ static void init_state(struct dc *dc, struct dc_state *state)
 }
 
 /* Public dc_state functions */
-struct dc_state *dc_state_create(struct dc *dc)
+struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
 {
+#ifdef CONFIG_DRM_AMD_DC_FP
+	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+#endif
 	struct dc_state *state = kvzalloc(sizeof(struct dc_state),
 			GFP_KERNEL);
 
@@ -198,10 +201,16 @@ struct dc_state *dc_state_create(struct dc *dc)
 
 	init_state(dc, state);
 	dc_state_construct(dc, state);
+	state->power_source = params ? params->power_source : DC_POWER_SOURCE_AC;
 
 #ifdef CONFIG_DRM_AMD_DC_FP
-	if (dc->debug.using_dml2)
-		dml2_create(dc, &dc->dml2_options, &state->bw_ctx.dml2);
+	if (dc->debug.using_dml2) {
+		dml2_opt.use_clock_dc_limits = false;
+		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2);
+
+		dml2_opt.use_clock_dc_limits = true;
+		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2_dc_power_source);
+	}
 #endif
 
 	kref_init(&state->refcount);
@@ -214,6 +223,7 @@ void dc_state_copy(struct dc_state *dst_state, struct dc_state *src_state)
 	struct kref refcount = dst_state->refcount;
 #ifdef CONFIG_DRM_AMD_DC_FP
 	struct dml2_context *dst_dml2 = dst_state->bw_ctx.dml2;
+	struct dml2_context *dst_dml2_dc_power_source = dst_state->bw_ctx.dml2_dc_power_source;
 #endif
 
 	dc_state_copy_internal(dst_state, src_state);
@@ -222,6 +232,10 @@ void dc_state_copy(struct dc_state *dst_state, struct dc_state *src_state)
 	dst_state->bw_ctx.dml2 = dst_dml2;
 	if (src_state->bw_ctx.dml2)
 		dml2_copy(dst_state->bw_ctx.dml2, src_state->bw_ctx.dml2);
+
+	dst_state->bw_ctx.dml2_dc_power_source = dst_dml2_dc_power_source;
+	if (src_state->bw_ctx.dml2_dc_power_source)
+		dml2_copy(dst_state->bw_ctx.dml2_dc_power_source, src_state->bw_ctx.dml2_dc_power_source);
 #endif
 
 	/* context refcount should not be overridden */
@@ -245,6 +259,12 @@ struct dc_state *dc_state_create_copy(struct dc_state *src_state)
 		dc_state_release(new_state);
 		return NULL;
 	}
+
+	if (src_state->bw_ctx.dml2_dc_power_source &&
+			!dml2_create_copy(&new_state->bw_ctx.dml2_dc_power_source, src_state->bw_ctx.dml2_dc_power_source)) {
+		dc_state_release(new_state);
+		return NULL;
+	}
 #endif
 
 	kref_init(&new_state->refcount);
@@ -326,6 +346,9 @@ static void dc_state_free(struct kref *kref)
 #ifdef CONFIG_DRM_AMD_DC_FP
 	dml2_destroy(state->bw_ctx.dml2);
 	state->bw_ctx.dml2 = 0;
+
+	dml2_destroy(state->bw_ctx.dml2_dc_power_source);
+	state->bw_ctx.dml2_dc_power_source = 0;
 #endif
 
 	kvfree(state);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b026004b713a..4d087137de3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1504,10 +1504,15 @@ bool dc_acquire_release_mpc_3dlut(
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
-
-enum dc_status dc_commit_streams(struct dc *dc,
-				 struct dc_stream_state *streams[],
-				 uint8_t stream_count);
+/*
+ * Set up streams and links associated to drive sinks
+ * The streams parameter is an absolute set of all active streams.
+ *
+ * After this call:
+ *   Phy, Encoder, Timing Generator are programmed and enabled.
+ *   New streams are enabled with blank stream; no memory read.
+ */
+enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params *params);
 
 
 struct dc_plane_state *dc_get_surface_for_mpcc(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state.h b/drivers/gpu/drm/amd/display/dc/dc_state.h
index a8979c9defe4..caa45db50232 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state.h
@@ -29,7 +29,7 @@
 #include "dc.h"
 #include "inc/core_status.h"
 
-struct dc_state *dc_state_create(struct dc *dc);
+struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params);
 void dc_state_copy(struct dc_state *dst_state, struct dc_state *src_state);
 struct dc_state *dc_state_create_copy(struct dc_state *src_state);
 void dc_state_copy_current(struct dc *dc, struct dc_state *dst_state);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 68dc668f3e14..e5dbbc6089a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -427,14 +427,6 @@ bool dc_stream_set_dynamic_metadata(struct dc *dc,
 
 enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream);
 
-/*
- * Set up streams and links associated to drive sinks
- * The streams parameter is an absolute set of all active streams.
- *
- * After this call:
- *   Phy, Encoder, Timing Generator are programmed and enabled.
- *   New streams are enabled with blank stream; no memory read.
- */
 /*
  * Enable stereo when commit_streams is not required,
  * for example, frame alternate.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index e219a1812360..614d7c27c759 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1175,4 +1175,20 @@ enum mall_stream_type {
 	SUBVP_MAIN, // subvp in use, this stream is main stream
 	SUBVP_PHANTOM, // subvp in use, this stream is a phantom stream
 };
+
+enum dc_power_source_type {
+	DC_POWER_SOURCE_AC, // wall power
+	DC_POWER_SOURCE_DC, // battery power
+};
+
+struct dc_state_create_params {
+	enum dc_power_source_type power_source;
+};
+
+struct dc_commit_streams_params {
+	struct dc_stream_state **streams;
+	uint8_t stream_count;
+	enum dc_power_source_type power_source;
+};
+
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 20fd5b8e5117..3760d67af7d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -215,6 +215,8 @@ struct dml2_configuration_options {
 	unsigned int max_segments_per_hubp;
 	unsigned int det_segment_size;
 	bool map_dc_pipes_with_callbacks;
+
+	bool use_clock_dc_limits;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 3f6876aafee0..3fab7c5bf093 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -518,6 +518,7 @@ struct bw_context {
 	union bw_output bw;
 	struct display_mode_lib dml;
 	struct dml2_context *dml2;
+	struct dml2_context *dml2_dc_power_source;
 };
 
 struct dc_dmub_cmd {
@@ -606,6 +607,8 @@ struct dc_state {
 	struct {
 		unsigned int stutter_period_us;
 	} perf_params;
+
+	enum dc_power_source_type power_source;
 };
 
 struct replay_context {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 61fd0f2e69fe..e2bff9b9d55a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1799,7 +1799,9 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 	bool out = false;
 
 	if (dc->debug.using_dml2)
-		out = dml2_validate(dc, context, context->bw_ctx.dml2, fast_validate);
+		out = dml2_validate(dc, context,
+				context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
+				fast_validate);
 	else
 		out = dml1_validate(dc, context, fast_validate);
 	return out;
@@ -1997,10 +1999,20 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 
 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
+	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+
 	DC_FP_START();
+
 	dcn32_update_bw_bounding_box_fpu(dc, bw_params);
+
+	dml2_opt.use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2);
+
+	dml2_opt.use_clock_dc_limits = true;
+	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
+		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+
 	DC_FP_END();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index f7339b141939..3816678b044f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1579,10 +1579,20 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
+	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+
 	DC_FP_START();
+
 	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
+
+	dml2_opt.use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2);
+
+	dml2_opt.use_clock_dc_limits = true;
+	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
+		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+
 	DC_FP_END();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index e0544484e8c0..25ac450944e7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1734,7 +1734,9 @@ static bool dcn35_validate_bandwidth(struct dc *dc,
 {
 	bool out = false;
 
-	out = dml2_validate(dc, context, context->bw_ctx.dml2, fast_validate);
+	out = dml2_validate(dc, context,
+			context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
+			fast_validate);
 
 	if (fast_validate)
 		return out;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 690e1ade361e..66ab6aba26aa 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1714,7 +1714,9 @@ static bool dcn351_validate_bandwidth(struct dc *dc,
 {
 	bool out = false;
 
-	out = dml2_validate(dc, context, context->bw_ctx.dml2, fast_validate);
+	out = dml2_validate(dc, context,
+			context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
+			fast_validate);
 
 	if (fast_validate)
 		return out;
-- 
2.34.1

