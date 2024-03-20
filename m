Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FB2C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81B810EC6F;
	Wed, 20 Mar 2024 06:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2boLSzQq";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1516110EC6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0RYG2Nb/NEyHgrAFk1tVvVvXDbK2dK2DOBBQiqP37+4m7mDwMeZ1iSJrIQL6eIiu3b27RhZbiMlnmbaFDyKD/U4vpISDKQVl79SZtDGquRGj1JS+rogKZ6bBzKELjRyWeY4cQdRkdMXNpNxIF2u3VizOqG/fBI9XUtCers1eOdLfTy+IJefoAXCOExQDzidaCZJ8Qb6iKll6Cki7y2GcW9fcfLMoJFApT/5jwUkFmivRFmNz+0dd1Ha7GdUQDx0uEKICah5I19hHtag5gTQYaDWeg5W1b/01ZQDdStty0Da+RrKxvovFvqzCU5at9SyFkBusalHM6+aWVCj2kG/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfMRqxUmVva3xPZAJEqgN/Tp2teAYB9XA9UcjF7NH4Y=;
 b=XFico2BFQBQqcNV9TQMuGYQ7dCbFgeDrzFvxma6XUnZLOVivgH6tONQFedBG3eFCBTK59ArfG7gvH+KQr6Xtn6IXDNP+c7+OIbmmPA0uAPas3AYyCd2PqnS+EAPtwfozJqevxHtkMBuq62WWc4WCSpc3fF+34ql5K9B8nDdQrKjxXUsiRGUOD0dDNqIdsj77xKr6Vh3BnWeq3W/Jn9SPJxlPxwBU5cjdmZdxOZSseBjDlJfC7ABRpR6g404Lq0zxIKi2nj9Rw2nTwvfDPzYHTPutI8CbQPNESDLzudDF/MTgYzRX8+BFqmZj4iGGY3nPCp4TWM15PiBEAP38Jb3YiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfMRqxUmVva3xPZAJEqgN/Tp2teAYB9XA9UcjF7NH4Y=;
 b=2boLSzQqwfftF4JMm2BocQeOyUtGJaGy3lQ2VjusrhX33yBrWQAGW3vQhWscve9wEq3jlsWz++N5hzPQ31b+Ak/t9wtt3BicAkjAcQRdOnvrmm4iVmN7gLFfXYBRSJ0w79zukJLdy7MPnTV76Z8UWgtLJ2fT7WtMb7LT81QeuAE=
Received: from BN0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:e8::19)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Wed, 20 Mar
 2024 06:36:25 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::4c) by BN0PR04CA0044.outlook.office365.com
 (2603:10b6:408:e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:24 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:21 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>
Subject: [PATCH 05/22] drm/amd/display: Expand DML2 callbacks
Date: Wed, 20 Mar 2024 14:35:39 +0800
Message-ID: <20240320063556.1326615-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ee86d1-fca5-44b4-bdb7-08dc48a81100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiuReoDjeg/gHGHCQrJ1x+spOmORD5w+cXNetsTZb+5+7KxMSHOkgaZhE/Uv/hSRcbI9LhWtgegugsR/j/qtboAqdf9YnLW7QZcWif5si0J+CqFsWo4QA62t8wpEYYpeerchKPuz1xBTGXsAq6VOg8T4j9gtxfsb8Ym8HmcLN8aqUat4DyEcnQmSzYINmQSBtf1Uu+SEmR8MfxwnEMksGzr6/W1ICZVtj4zIHFbQD41TITcaJ7HtUQXgswOTTDzBbg9dvO2dLzc2ao3hAnQDSFATp69fqij0TAemNf8I5Uv91pFfQACwNwVATJNgDJWK0cRsipL9BddpNyDPDlvsf2j8UzlB+C7MRjp3hkgTSDG+R7znYc1NkHYqrgwYONjdxuDLOrL/ksEcyBKOjihEJ8lfgtU/co4WmHaV3vIpwVWAwuA+rj5GGm/RmEbTyS40ifB9yWAfp83Q5lX1TVAOsTr+ZuJiamodXXR6AHVTgp/bUk0JSEkhOk39S3gwUtmReeeTCQkHeWohJ/H5lNqzLoAeyYPknQm5i2uM9fnayY1VRMkbVn5adPY3IjBrFsddP9d1YA6nQuCzanjZwZntUH6Rlwn1JWhaktKYzej5KK1+kLNCvJq7qqCuMQm+gO8K454FnufUvbCNulOLTEAmbTuAxhwrbinK7yfGr3ISplNyat7o3T8/s4kOkex+v48Bw4u8sabKYG9QRI2IdTw5wSndDIvxzFlXJlK3aiiFlIjNKdhjavuL3z2FS6hK1nnJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:25.6265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ee86d1-fca5-44b4-bdb7-08dc48a81100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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

From: Dillon Varone <dillon.varone@amd.com>

[Why&How]
These additional callbacks to DC will be required for the DML2 wrapper. Also
consolidate common callbacks for projects to a single location for maintenance.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 33 +++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 17 +++++++-
 drivers/gpu/drm/amd/display/dc/dc_state.h     |  2 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |  2 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 23 ++---------
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    | 24 ++++++++++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  6 +++
 .../dc/resource/dcn32/dcn32_resource.c        | 41 +++++++++----------
 .../dc/resource/dcn32/dcn32_resource.h        |  6 +--
 .../dc/resource/dcn321/dcn321_resource.c      | 25 ++---------
 .../dc/resource/dcn35/dcn35_resource.c        | 10 +----
 .../dc/resource/dcn351/dcn351_resource.c      | 10 +----
 15 files changed, 119 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 96b4f68ec374..ce56e47cfd0a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4993,3 +4993,36 @@ bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_st
 
 	return false;
 }
+
+void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuration_options *dml2_options)
+{
+	dml2_options->callbacks.dc = dc;
+	dml2_options->callbacks.build_scaling_params = &resource_build_scaling_params;
+	dml2_options->callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
+	dml2_options->callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
+	dml2_options->callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
+	dml2_options->callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
+	dml2_options->callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
+	dml2_options->callbacks.get_opp_head = &resource_get_opp_head;
+	dml2_options->callbacks.get_otg_master_for_stream = &resource_get_otg_master_for_stream;
+	dml2_options->callbacks.get_opp_heads_for_otg_master = &resource_get_opp_heads_for_otg_master;
+	dml2_options->callbacks.get_dpp_pipes_for_plane = &resource_get_dpp_pipes_for_plane;
+	dml2_options->callbacks.get_stream_status = &dc_state_get_stream_status;
+	dml2_options->callbacks.get_stream_from_id = &dc_state_get_stream_from_id;
+
+	dml2_options->svp_pstate.callbacks.dc = dc;
+	dml2_options->svp_pstate.callbacks.add_phantom_plane = &dc_state_add_phantom_plane;
+	dml2_options->svp_pstate.callbacks.add_phantom_stream = &dc_state_add_phantom_stream;
+	dml2_options->svp_pstate.callbacks.build_scaling_params = &resource_build_scaling_params;
+	dml2_options->svp_pstate.callbacks.create_phantom_plane = &dc_state_create_phantom_plane;
+	dml2_options->svp_pstate.callbacks.remove_phantom_plane = &dc_state_remove_phantom_plane;
+	dml2_options->svp_pstate.callbacks.remove_phantom_stream = &dc_state_remove_phantom_stream;
+	dml2_options->svp_pstate.callbacks.create_phantom_stream = &dc_state_create_phantom_stream;
+	dml2_options->svp_pstate.callbacks.release_phantom_plane = &dc_state_release_phantom_plane;
+	dml2_options->svp_pstate.callbacks.release_phantom_stream = &dc_state_release_phantom_stream;
+	dml2_options->svp_pstate.callbacks.get_pipe_subvp_type = &dc_state_get_pipe_subvp_type;
+	dml2_options->svp_pstate.callbacks.get_stream_subvp_type = &dc_state_get_stream_subvp_type;
+	dml2_options->svp_pstate.callbacks.get_paired_subvp_stream = &dc_state_get_paired_subvp_stream;
+	dml2_options->svp_pstate.callbacks.remove_phantom_streams_and_planes = &dc_state_remove_phantom_streams_and_planes;
+	dml2_options->svp_pstate.callbacks.release_phantom_streams_and_planes = &dc_state_release_phantom_streams_and_planes;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index cce4e1c465b6..c5c078771b15 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -585,7 +585,7 @@ bool dc_state_add_all_planes_for_stream(
  */
 struct dc_stream_status *dc_state_get_stream_status(
 		struct dc_state *state,
-		struct dc_stream_state *stream)
+		const struct dc_stream_state *stream)
 {
 	uint8_t i;
 
@@ -868,3 +868,18 @@ void dc_state_release_phantom_streams_and_planes(
 	for (i = 0; i < state->phantom_plane_count; i++)
 		dc_state_release_phantom_plane(dc, state, state->phantom_planes[i]);
 }
+
+struct dc_stream_state *dc_state_get_stream_from_id(const struct dc_state *state, unsigned int id)
+{
+	struct dc_stream_state *stream = NULL;
+	int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		if (state->streams[i] && state->streams[i]->stream_id == id) {
+			stream = state->streams[i];
+			break;
+		}
+	}
+
+	return stream;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state.h b/drivers/gpu/drm/amd/display/dc/dc_state.h
index d167fdbfa8a9..631d1a57263c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state.h
@@ -74,5 +74,5 @@ bool dc_state_add_all_planes_for_stream(
 
 struct dc_stream_status *dc_state_get_stream_status(
 	struct dc_state *state,
-	struct dc_stream_state *stream);
+	const struct dc_stream_state *stream);
 #endif /* _DC_STATE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
index c1f44e09a6c1..4da4babf0d18 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
@@ -29,6 +29,8 @@
 #include "dc_state.h"
 #include "dc_stream.h"
 
+struct dc_stream_state *dc_state_get_stream_from_id(const struct dc_state *state, unsigned int id);
+
 /* Get the type of the provided resource (none, phantom, main) based on the provided
  * context. If the context is unavailable, determine only if phantom or not.
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index f98def6c8c2d..c831f6c69a17 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -35,25 +35,6 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
-
-uint32_t dcn32_helper_mall_bytes_to_ways(
-		struct dc *dc,
-		uint32_t total_size_in_mall_bytes)
-{
-	uint32_t cache_lines_used, lines_per_way, total_cache_lines, num_ways;
-
-	/* add 2 lines for worst case alignment */
-	cache_lines_used = total_size_in_mall_bytes / dc->caps.cache_line_size + 2;
-
-	total_cache_lines = dc->caps.max_cab_allocation_bytes / dc->caps.cache_line_size;
-	lines_per_way = total_cache_lines / dc->caps.cache_num_ways;
-	num_ways = cache_lines_used / lines_per_way;
-	if (cache_lines_used % lines_per_way > 0)
-		num_ways++;
-
-	return num_ways;
-}
-
 uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
@@ -112,8 +93,10 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(
 	if (context->bw_ctx.bw.dcn.mall_subvp_size_bytes > 0) {
 		if (dc->debug.force_subvp_num_ways) {
 			return dc->debug.force_subvp_num_ways;
+		} else if (dc->res_pool->funcs->calculate_mall_ways_from_bytes) {
+			return dc->res_pool->funcs->calculate_mall_ways_from_bytes(dc, context->bw_ctx.bw.dcn.mall_subvp_size_bytes);
 		} else {
-			return dcn32_helper_mall_bytes_to_ways(dc, context->bw_ctx.bw.dcn.mall_subvp_size_bytes);
+			return 0;
 		}
 	} else {
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 72cca367062e..018cf97c0251 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -681,7 +681,7 @@ static void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *d
 	}
 }
 
-bool dml2_validate(const struct dc *in_dc, struct dc_state *context, bool fast_validate)
+bool dml2_validate(struct dc *in_dc, struct dc_state *context, bool fast_validate)
 {
 	bool out = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index cc662d682fd4..800d2ce4856c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -88,6 +88,19 @@ struct dml2_dc_callbacks {
 	int (*get_odm_slice_index)(const struct pipe_ctx *opp_head);
 	int (*get_mpc_slice_index)(const struct pipe_ctx *dpp_pipe);
 	struct pipe_ctx *(*get_opp_head)(const struct pipe_ctx *pipe_ctx);
+	struct pipe_ctx *(*get_otg_master_for_stream)(
+		struct resource_context *res_ctx,
+		const struct dc_stream_state *stream);
+	int (*get_opp_heads_for_otg_master)(const struct pipe_ctx *otg_master,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *opp_heads[MAX_PIPES]);
+	int (*get_dpp_pipes_for_plane)(const struct dc_plane_state *plane,
+			struct resource_context *res_ctx,
+			struct pipe_ctx *dpp_pipes[MAX_PIPES]);
+	struct dc_stream_status *(*get_stream_status)(
+		struct dc_state *state,
+		const struct dc_stream_state *stream);
+	struct dc_stream_state *(*get_stream_from_id)(const struct dc_state *state, unsigned int id);
 };
 
 struct dml2_dc_svp_callbacks {
@@ -121,6 +134,15 @@ struct dml2_dc_svp_callbacks {
 	enum mall_stream_type (*get_pipe_subvp_type)(const struct dc_state *state, const struct pipe_ctx *pipe_ctx);
 	enum mall_stream_type (*get_stream_subvp_type)(const struct dc_state *state, const struct dc_stream_state *stream);
 	struct dc_stream_state *(*get_paired_subvp_stream)(const struct dc_state *state, const struct dc_stream_state *stream);
+	bool (*remove_phantom_streams_and_planes)(
+			struct dc *dc,
+			struct dc_state *state);
+	void (*release_phantom_streams_and_planes)(
+			struct dc *dc,
+			struct dc_state *state);
+	unsigned int (*calculate_mall_ways_from_bytes)(
+				const struct dc *dc,
+				unsigned int total_size_in_mall_bytes);
 };
 
 struct dml2_clks_table_entry {
@@ -242,7 +264,7 @@ void dml2_reinit(const struct dc *in_dc,
  *          separate dc_states for validation.
  * Return: True if mode is supported, false otherwise.
  */
-bool dml2_validate(const struct dc *in_dc,
+bool dml2_validate(struct dc *in_dc,
 				   struct dc_state *context,
 				   bool fast_validate);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index a5e92389615f..367dcaeaf186 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -239,8 +239,10 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 	// Convert number of cache lines required to number of ways
 	if (dc->debug.force_mall_ss_num_ways > 0) {
 		num_ways = dc->debug.force_mall_ss_num_ways;
+	} else if (dc->res_pool->funcs->calculate_mall_ways_from_bytes) {
+		num_ways = dc->res_pool->funcs->calculate_mall_ways_from_bytes(dc, mall_ss_size_bytes);
 	} else {
-		num_ways = dcn32_helper_mall_bytes_to_ways(dc, mall_ss_size_bytes);
+		num_ways = 0;
 	}
 
 	return num_ways;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 34764094f546..a66676c00c6c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -90,6 +90,9 @@ struct resource_funcs {
 	void (*update_soc_for_wm_a)(
 				struct dc *dc, struct dc_state *context);
 
+	unsigned int (*calculate_mall_ways_from_bytes)(
+				const struct dc *dc,
+				unsigned int total_size_in_mall_bytes);
 	/**
 	 * @populate_dml_pipes - Populate pipe data struct
 	 *
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 77a60aa9f27b..d17fa73d72a3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -615,4 +615,10 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
 
 bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream);
+
+/* Setup dc callbacks for dml2
+ * @dc: the display core structure
+ * @dml2_options: struct to hold callbacks
+ */
+void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuration_options *dml2_options);
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 1c657fe4a9bb..da15ad845147 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1912,6 +1912,22 @@ int dcn32_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
+unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned int total_size_in_mall_bytes)
+{
+	uint32_t cache_lines_used, lines_per_way, total_cache_lines, num_ways;
+
+	/* add 2 lines for worst case alignment */
+	cache_lines_used = total_size_in_mall_bytes / dc->caps.cache_line_size + 2;
+
+	total_cache_lines = dc->caps.max_cab_allocation_bytes / dc->caps.cache_line_size;
+	lines_per_way = total_cache_lines / dc->caps.cache_num_ways;
+	num_ways = cache_lines_used / lines_per_way;
+	if (cache_lines_used % lines_per_way > 0)
+		num_ways++;
+
+	return num_ways;
+}
+
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
 	.get_subvp_en = dcn32_subvp_in_use,
@@ -1960,6 +1976,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
+	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
@@ -2363,30 +2380,10 @@ static bool dcn32_resource_construct(
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = true;
 
-	dc->dml2_options.callbacks.dc = dc;
-	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
+	resource_init_common_dml2_callbacks(dc, &dc->dml2_options);
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
-	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
-	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
-	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
-	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
-	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
-	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
-
-	dc->dml2_options.svp_pstate.callbacks.dc = dc;
-	dc->dml2_options.svp_pstate.callbacks.add_phantom_plane = &dc_state_add_phantom_plane;
-	dc->dml2_options.svp_pstate.callbacks.add_phantom_stream = &dc_state_add_phantom_stream;
-	dc->dml2_options.svp_pstate.callbacks.build_scaling_params = &resource_build_scaling_params;
-	dc->dml2_options.svp_pstate.callbacks.create_phantom_plane = &dc_state_create_phantom_plane;
-	dc->dml2_options.svp_pstate.callbacks.remove_phantom_plane = &dc_state_remove_phantom_plane;
-	dc->dml2_options.svp_pstate.callbacks.remove_phantom_stream = &dc_state_remove_phantom_stream;
-	dc->dml2_options.svp_pstate.callbacks.create_phantom_stream = &dc_state_create_phantom_stream;
-	dc->dml2_options.svp_pstate.callbacks.release_phantom_plane = &dc_state_release_phantom_plane;
-	dc->dml2_options.svp_pstate.callbacks.release_phantom_stream = &dc_state_release_phantom_stream;
 	dc->dml2_options.svp_pstate.callbacks.release_dsc = &dcn20_release_dsc;
-	dc->dml2_options.svp_pstate.callbacks.get_pipe_subvp_type = &dc_state_get_pipe_subvp_type;
-	dc->dml2_options.svp_pstate.callbacks.get_stream_subvp_type = &dc_state_get_stream_subvp_type;
-	dc->dml2_options.svp_pstate.callbacks.get_paired_subvp_stream = &dc_state_get_paired_subvp_stream;
+	dc->dml2_options.svp_pstate.callbacks.calculate_mall_ways_from_bytes = pool->base.funcs->calculate_mall_ways_from_bytes;
 
 	dc->dml2_options.svp_pstate.subvp_fw_processing_delay_us = dc->caps.subvp_fw_processing_delay_us;
 	dc->dml2_options.svp_pstate.subvp_prefetch_end_to_mall_start_us = dc->caps.subvp_prefetch_end_to_mall_start_us;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 2258c5c7212d..286e20ad46ed 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -113,10 +113,6 @@ void dcn32_calculate_wm_and_dlg(
 		int pipe_cnt,
 		int vlevel);
 
-uint32_t dcn32_helper_mall_bytes_to_ways(
-		struct dc *dc,
-		uint32_t total_size_in_mall_bytes);
-
 uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
@@ -184,6 +180,8 @@ void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc
 
 void dcn32_override_min_req_dcfclk(struct dc *dc, struct dc_state *context);
 
+unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned int total_size_in_mall_bytes);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 6c8129734163..f7339b141939 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1610,6 +1610,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
+	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
@@ -2000,30 +2001,10 @@ static bool dcn321_resource_construct(
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = true;
 
-	dc->dml2_options.callbacks.dc = dc;
-	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
+	resource_init_common_dml2_callbacks(dc, &dc->dml2_options);
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
-	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
-	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
-	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
-	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
-	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
-	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
-
-	dc->dml2_options.svp_pstate.callbacks.dc = dc;
-	dc->dml2_options.svp_pstate.callbacks.add_phantom_plane = &dc_state_add_phantom_plane;
-	dc->dml2_options.svp_pstate.callbacks.add_phantom_stream = &dc_state_add_phantom_stream;
-	dc->dml2_options.svp_pstate.callbacks.build_scaling_params = &resource_build_scaling_params;
-	dc->dml2_options.svp_pstate.callbacks.create_phantom_plane = &dc_state_create_phantom_plane;
-	dc->dml2_options.svp_pstate.callbacks.remove_phantom_plane = &dc_state_remove_phantom_plane;
-	dc->dml2_options.svp_pstate.callbacks.remove_phantom_stream = &dc_state_remove_phantom_stream;
-	dc->dml2_options.svp_pstate.callbacks.create_phantom_stream = &dc_state_create_phantom_stream;
-	dc->dml2_options.svp_pstate.callbacks.release_phantom_plane = &dc_state_release_phantom_plane;
-	dc->dml2_options.svp_pstate.callbacks.release_phantom_stream = &dc_state_release_phantom_stream;
 	dc->dml2_options.svp_pstate.callbacks.release_dsc = &dcn20_release_dsc;
-	dc->dml2_options.svp_pstate.callbacks.get_pipe_subvp_type = &dc_state_get_pipe_subvp_type;
-	dc->dml2_options.svp_pstate.callbacks.get_stream_subvp_type = &dc_state_get_stream_subvp_type;
-	dc->dml2_options.svp_pstate.callbacks.get_paired_subvp_stream = &dc_state_get_paired_subvp_stream;
+	dc->dml2_options.svp_pstate.callbacks.calculate_mall_ways_from_bytes = pool->base.funcs->calculate_mall_ways_from_bytes;
 
 	dc->dml2_options.svp_pstate.subvp_fw_processing_delay_us = dc->caps.subvp_fw_processing_delay_us;
 	dc->dml2_options.svp_pstate.subvp_prefetch_end_to_mall_start_us = dc->caps.subvp_prefetch_end_to_mall_start_us;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 49cccf3c0f9c..91c6eff79282 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2138,15 +2138,9 @@ static bool dcn35_resource_construct(
 		dc->dml2_options.minimize_dispclk_using_odm = true;
 	dc->dml2_options.enable_windowed_mpo_odm = dc->config.enable_windowed_mpo_odm;
 
-	dc->dml2_options.callbacks.dc = dc;
-	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
+	resource_init_common_dml2_callbacks(dc, &dc->dml2_options);
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
-	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
-	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
-	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
-	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
-	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
-	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
+
 	dc->dml2_options.max_segments_per_hubp = 24;
 
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 2dfd73d5f767..a5ebfde56730 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -2116,15 +2116,9 @@ static bool dcn351_resource_construct(
 		dc->dml2_options.minimize_dispclk_using_odm = true;
 	dc->dml2_options.enable_windowed_mpo_odm = dc->config.enable_windowed_mpo_odm;
 
-	dc->dml2_options.callbacks.dc = dc;
-	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
+	resource_init_common_dml2_callbacks(dc, &dc->dml2_options);
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
-	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
-	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
-	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
-	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
-	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
-	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
+
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
 
-- 
2.34.1

