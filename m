Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF93C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02C110EBB7;
	Wed, 20 Mar 2024 06:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IBbc1NpU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF4F10EBB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6maijHbQHbsNY7nLhftn0pA6bwfFKzFGp4rLmAC7nkQzgUeufmEA0+SbJnAYlM+WwI2+yr0gRfqS7RSmm6DSVQUfxpsTuUTuzEI++PJ819ULRKFsTAfuUsSUtNxGDJjAbN9cKeAWF34gxgi+jsTP7qUd+WqeDmDhF8R3ytXnl73SzBo084SGLIo+TE8yxGKcgtTGUcx5pTX94YV94zg6hPjB+fmFj9y4IBiVvpsCC35dONc9K6XJ4jYl5t61Ob008BpgDEFNgG4MgyJfsEHg2HvBxuZCgMfduS8UsH7cCvr8zYGfgWOi7OBXT/TPmm8R6P8r+bTFnhxvT+R/a7syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rHjSNr/bd5NYLZaACLe6iGlTN3yihHooT4UiDQH6uQ=;
 b=oTgTraX3qqAiiy76bGDupD/ViSf0epXQ+8mp1OJph5ZbJ04E3MPFOzRCHvYXV7x14s5lhkwahMkeyFNxDwpLE9aKXXit5BNIwMwYCDZYnpYG2jXWrtKCK1XNiPENDRrvsFya19fbEFfBjGAc7sQt+BA+kwX1ozYxoC3yYUfFFzRfsQQqUvdfJwhQ9T/2psgT133DKyM994Hk+cH4t7VLzyEVoZLs4dh7GYnm5pB+CipoQsMCqfkF4aS+d5scA96aEpEZl90tgd38NwJTq/rLIZ0cM2adbok4RD4uLaUF1xVXEqQQrqlzhcJ5e60TnudqGPEW+X4VzeWZhZKoSbsERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rHjSNr/bd5NYLZaACLe6iGlTN3yihHooT4UiDQH6uQ=;
 b=IBbc1NpUhgZ2EQSL1oXOX3EtxXEUBcHmP3Nw5Esgf3h7cFlO+dyWucj0blGpGYGv927lAe2PgUtou1scmLZHzhEeeqxuT4S4dOKKAuB3txVwNUt6w+/2t+IKHAx2oX4SmRQo78WVqjXcQBcwrckAWIZjrVpyExfYa800LfsZxeo=
Received: from BN9PR03CA0536.namprd03.prod.outlook.com (2603:10b6:408:131::31)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 06:36:29 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::49) by BN9PR03CA0536.outlook.office365.com
 (2603:10b6:408:131::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:28 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:25 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>
Subject: [PATCH 06/22] drm/amd/display: Refactor DML2 interfaces
Date: Wed, 20 Mar 2024 14:35:40 +0800
Message-ID: <20240320063556.1326615-7-chiahsuan.chung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b591fe-4806-4e47-6c74-08dc48a81312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Pw+SS0MPQVGoRYQX9xw7KWcIJz4iKhXSfvI5CKCQ0ArVCOrob4lf9iTBqjI6iNW2JEDSYxpkXWq/tvThQN2HXqNObTUoQwtQbKK5MO20VopcnSJZ9QwPtgHdcuQ3np7B4+LpxXq0AA6NIklO7MxJ78PeaHQVGVqndexdiuY6uQJXtKdGkVT3VGmXtzruBl5mwBBn4PooP4GTJ0M06ZvBuWg2L8Yh7/Aq2nRGK9707SFL//xmPhD8TvrFpF+tYx85zijA1dKKMNWEgQw0DYRH7Y1yrJPgeQzRCCEjBLE/f+s/O/ngqJS3fF6iGxdyq/4EvfAk0+lKGyUUEX1EREQZpSbUhfWLUFD1w0+gZgoEuDdu70ZvEZOkZi2RW9NCEj8WPKxCKVWKZw3HvbwM5j+eMK1/5Z0/mwzHiMg1Xl9mFlg9a6I8WJJxD5ZXw1PrOs7yz78Zv1vX9tBjXlyWx1eFwV2qL3U5j8vr/W/VX1Y18Q/qRv72k1Gi8VzywlMlHA+5phlqpCu8w/bFhtiYTderhDgRqOLS0IOw/AFMW16EPpUP4EVNxLphGNBOxKSt9AJihx0R4d/qGewcRKIK8ixheVZ2YVA0DeKp7s27HUEyRcMJbXwNidWhrGy/yiTTKU6Fyl0t0KvHL18RN0HkgJwMKHpSBJbSEDR5upEdKJzQUAxIHIQjjd9KFwbg4zbPl8b67gSVedhLS9YeGP00dbx4U4IW6E1fONdzX3IrG4y/fmD+sBdSLsjvIzUA/sQRqWY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:29.0979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b591fe-4806-4e47-6c74-08dc48a81312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
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

[Why&How}
Some interfaces needed changes to support future architectures.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 14 +++++------
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_state.h     |  4 ++--
 .../gpu/drm/amd/display/dc/dc_state_priv.h    | 10 ++++----
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 23 +++++++++++--------
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    | 12 +++++-----
 9 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index c5c078771b15..d546ea71026d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -340,7 +340,7 @@ void dc_state_release(struct dc_state *state)
  * dc_state_add_stream() - Add a new dc_stream_state to a dc_state.
  */
 enum dc_status dc_state_add_stream(
-		struct dc *dc,
+		const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *stream)
 {
@@ -369,7 +369,7 @@ enum dc_status dc_state_add_stream(
  * dc_state_remove_stream() - Remove a stream from a dc_state.
  */
 enum dc_status dc_state_remove_stream(
-		struct dc *dc,
+		const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *stream)
 {
@@ -679,7 +679,7 @@ void dc_state_release_phantom_stream(const struct dc *dc,
 	dc_stream_release(phantom_stream);
 }
 
-struct dc_plane_state *dc_state_create_phantom_plane(struct dc *dc,
+struct dc_plane_state *dc_state_create_phantom_plane(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_plane_state *main_plane)
 {
@@ -715,7 +715,7 @@ void dc_state_release_phantom_plane(const struct dc *dc,
 }
 
 /* add phantom streams to context and generate correct meta inside dc_state */
-enum dc_status dc_state_add_phantom_stream(struct dc *dc,
+enum dc_status dc_state_add_phantom_stream(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *phantom_stream,
 		struct dc_stream_state *main_stream)
@@ -741,7 +741,7 @@ enum dc_status dc_state_add_phantom_stream(struct dc *dc,
 	return res;
 }
 
-enum dc_status dc_state_remove_phantom_stream(struct dc *dc,
+enum dc_status dc_state_remove_phantom_stream(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *phantom_stream)
 {
@@ -835,7 +835,7 @@ bool dc_state_add_all_phantom_planes_for_stream(
 }
 
 bool dc_state_remove_phantom_streams_and_planes(
-	struct dc *dc,
+	const struct dc *dc,
 	struct dc_state *state)
 {
 	int i;
@@ -857,7 +857,7 @@ bool dc_state_remove_phantom_streams_and_planes(
 }
 
 void dc_state_release_phantom_streams_and_planes(
-		struct dc *dc,
+		const struct dc *dc,
 		struct dc_state *state)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 19140fb65787..acc7a8baa169 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -103,7 +103,7 @@ void enable_surface_flip_reporting(struct dc_plane_state *plane_state,
 	/*register_flip_interrupt(surface);*/
 }
 
-struct dc_plane_state *dc_create_plane_state(struct dc *dc)
+struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
 {
 	struct dc_plane_state *plane_state = kvzalloc(sizeof(*plane_state),
 							GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e0b44c43e959..52fd2ebdcdbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -996,6 +996,7 @@ struct dc_debug_options {
 	bool enable_idle_reg_checks;
 	unsigned int static_screen_wait_frames;
 	bool force_chroma_subsampling_1tap;
+	bool disable_422_left_edge_pixel;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_plane.h b/drivers/gpu/drm/amd/display/dc/dc_plane.h
index ef380cae816a..44afcd989224 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_plane.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_plane.h
@@ -29,7 +29,7 @@
 #include "dc.h"
 #include "dc_hw_types.h"
 
-struct dc_plane_state *dc_create_plane_state(struct dc *dc);
+struct dc_plane_state *dc_create_plane_state(const struct dc *dc);
 const struct dc_plane_status *dc_plane_get_status(
 		const struct dc_plane_state *plane_state);
 void dc_plane_state_retain(struct dc_plane_state *plane_state);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state.h b/drivers/gpu/drm/amd/display/dc/dc_state.h
index 631d1a57263c..a8979c9defe4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state.h
@@ -39,12 +39,12 @@ void dc_state_destruct(struct dc_state *state);
 void dc_state_retain(struct dc_state *state);
 void dc_state_release(struct dc_state *state);
 
-enum dc_status dc_state_add_stream(struct dc *dc,
+enum dc_status dc_state_add_stream(const struct dc *dc,
 				    struct dc_state *state,
 				    struct dc_stream_state *stream);
 
 enum dc_status dc_state_remove_stream(
-		struct dc *dc,
+		const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *stream);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
index 4da4babf0d18..615086d74d32 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
@@ -47,7 +47,7 @@ struct dc_stream_state *dc_state_get_paired_subvp_stream(const struct dc_state *
 struct dc_stream_state *dc_state_create_phantom_stream(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *main_stream);
-struct dc_plane_state *dc_state_create_phantom_plane(struct dc *dc,
+struct dc_plane_state *dc_state_create_phantom_plane(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_plane_state *main_plane);
 
@@ -60,11 +60,11 @@ void dc_state_release_phantom_plane(const struct dc *dc,
 		struct dc_plane_state *phantom_plane);
 
 /* add/remove phantom stream to context and generate subvp meta data */
-enum dc_status dc_state_add_phantom_stream(struct dc *dc,
+enum dc_status dc_state_add_phantom_stream(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *phantom_stream,
 		struct dc_stream_state *main_stream);
-enum dc_status dc_state_remove_phantom_stream(struct dc *dc,
+enum dc_status dc_state_remove_phantom_stream(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *phantom_stream);
 
@@ -94,11 +94,11 @@ bool dc_state_add_all_phantom_planes_for_stream(
 		struct dc_state *state);
 
 bool dc_state_remove_phantom_streams_and_planes(
-		struct dc *dc,
+		const struct dc *dc,
 		struct dc_state *state);
 
 void dc_state_release_phantom_streams_and_planes(
-		struct dc *dc,
+		const struct dc *dc,
 		struct dc_state *state);
 
 #endif /* _DC_STATE_PRIV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index a52c594e1ba4..b64e0160d482 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -794,7 +794,7 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 }
 
 static unsigned int get_mpc_factor(struct dml2_context *ctx,
-		const struct dc_state *state,
+		struct dc_state *state,
 		const struct dml_display_cfg_st *disp_cfg,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
 		const struct dc_stream_status *status,
@@ -805,10 +805,10 @@ static unsigned int get_mpc_factor(struct dml2_context *ctx,
 	unsigned int cfg_idx;
 	unsigned int mpc_factor;
 
-	get_plane_id(ctx, state, status->plane_states[plane_idx],
-			stream->stream_id, plane_idx, &plane_id);
-	cfg_idx = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
 	if (ctx->architecture == dml2_architecture_20) {
+		get_plane_id(ctx, state, status->plane_states[plane_idx],
+				stream->stream_id, plane_idx, &plane_id);
+		cfg_idx = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
 		mpc_factor = (unsigned int)disp_cfg->hw.DPPPerSurface[cfg_idx];
 	} else {
 		mpc_factor = 1;
@@ -824,14 +824,16 @@ static unsigned int get_mpc_factor(struct dml2_context *ctx,
 
 static unsigned int get_odm_factor(
 		const struct dml2_context *ctx,
+		struct dc_state *state,
 		const struct dml_display_cfg_st *disp_cfg,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
 		const struct dc_stream_state *stream)
 {
-	unsigned int cfg_idx = find_disp_cfg_idx_by_stream_id(
-			mapping, stream->stream_id);
+	unsigned int cfg_idx;
 
-	if (ctx->architecture == dml2_architecture_20)
+	if (ctx->architecture == dml2_architecture_20) {
+		cfg_idx = find_disp_cfg_idx_by_stream_id(
+				mapping, stream->stream_id);
 		switch (disp_cfg->hw.ODMMode[cfg_idx]) {
 		case dml_odm_mode_bypass:
 			return 1;
@@ -842,6 +844,7 @@ static unsigned int get_odm_factor(
 		default:
 			break;
 		}
+	}
 	ASSERT(false);
 	return 1;
 }
@@ -850,7 +853,7 @@ static void populate_mpc_factors_for_stream(
 		struct dml2_context *ctx,
 		const struct dml_display_cfg_st *disp_cfg,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
-		const struct dc_state *state,
+		struct dc_state *state,
 		unsigned int stream_idx,
 		unsigned int odm_factor,
 		unsigned int mpc_factors[MAX_PIPES])
@@ -870,14 +873,14 @@ static void populate_mpc_factors_for_stream(
 static void populate_odm_factors(const struct dml2_context *ctx,
 		const struct dml_display_cfg_st *disp_cfg,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
-		const struct dc_state *state,
+		struct dc_state *state,
 		unsigned int odm_factors[MAX_PIPES])
 {
 	int i;
 
 	for (i = 0; i < state->stream_count; i++)
 		odm_factors[i] = get_odm_factor(
-				ctx, disp_cfg, mapping, state->streams[i]);
+				ctx, state, disp_cfg, mapping, state->streams[i]);
 }
 
 static bool map_dc_pipes_for_stream(struct dml2_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 018cf97c0251..72cca367062e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -681,7 +681,7 @@ static void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *d
 	}
 }
 
-bool dml2_validate(struct dc *in_dc, struct dc_state *context, bool fast_validate)
+bool dml2_validate(const struct dc *in_dc, struct dc_state *context, bool fast_validate)
 {
 	bool out = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 800d2ce4856c..6e97337863e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -109,10 +109,10 @@ struct dml2_dc_svp_callbacks {
 	struct dc_stream_state* (*create_phantom_stream)(const struct dc *dc,
 			struct dc_state *state,
 			struct dc_stream_state *main_stream);
-	struct dc_plane_state* (*create_phantom_plane)(struct dc *dc,
+	struct dc_plane_state* (*create_phantom_plane)(const struct dc *dc,
 			struct dc_state *state,
 			struct dc_plane_state *main_plane);
-	enum dc_status (*add_phantom_stream)(struct dc *dc,
+	enum dc_status (*add_phantom_stream)(const struct dc *dc,
 			struct dc_state *state,
 			struct dc_stream_state *phantom_stream,
 			struct dc_stream_state *main_stream);
@@ -121,7 +121,7 @@ struct dml2_dc_svp_callbacks {
 			struct dc_stream_state *stream,
 			struct dc_plane_state *plane_state,
 			struct dc_state *context);
-	enum dc_status (*remove_phantom_stream)(struct dc *dc,
+	enum dc_status (*remove_phantom_stream)(const struct dc *dc,
 			struct dc_state *state,
 			struct dc_stream_state *stream);
 	void (*release_phantom_plane)(const struct dc *dc,
@@ -135,10 +135,10 @@ struct dml2_dc_svp_callbacks {
 	enum mall_stream_type (*get_stream_subvp_type)(const struct dc_state *state, const struct dc_stream_state *stream);
 	struct dc_stream_state *(*get_paired_subvp_stream)(const struct dc_state *state, const struct dc_stream_state *stream);
 	bool (*remove_phantom_streams_and_planes)(
-			struct dc *dc,
+			const struct dc *dc,
 			struct dc_state *state);
 	void (*release_phantom_streams_and_planes)(
-			struct dc *dc,
+			const struct dc *dc,
 			struct dc_state *state);
 	unsigned int (*calculate_mall_ways_from_bytes)(
 				const struct dc *dc,
@@ -264,7 +264,7 @@ void dml2_reinit(const struct dc *in_dc,
  *          separate dc_states for validation.
  * Return: True if mode is supported, false otherwise.
  */
-bool dml2_validate(struct dc *in_dc,
+bool dml2_validate(const struct dc *in_dc,
 				   struct dc_state *context,
 				   bool fast_validate);
 
-- 
2.34.1

