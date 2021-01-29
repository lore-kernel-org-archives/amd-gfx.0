Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DA0C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44AF64E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44AF64E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F276EC24;
	Fri, 29 Jan 2021 21:28:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0596EC21
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKDBe8PJthrA0gpSTJZ2/Ww0O62rqnOPNAnWEI3ZEH9kEfv3mT1fJN8Q6IGwRXz7BWL/YeLvvT/sRsV+V+D23lZaiNlnwBE+fES/P4fUajKFPMcpkPY0h19jMOY+K9uYowiL7dCCmapXcAYuB5Wh0ioe9cIFnqaEGmCWmt//1KXJehkeItByNTeJFCH3M4YTkQjMWS/yCwKE1KSG8BB83MYxt1xhwf4REfR6RpeoV+yiD1gGtKrA5CF0nmASf7vhGiHL64pvpA6NkwUm4FI8w2Osew0DhYb/KSN2+duH2PX4bAv+b5gTVUftb9uV8GXH6Xj7E8K3ZgWH4i93/njQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDpVrGFVyX7F6O9UjUyPevQiJjMvVFBXfgd78Zkp+OQ=;
 b=OBSVT7Mhh85Z5XF/NSsIETURNcb+jxeqRvQC1KOuggtu1DVi30VsxPDB8L/wNlyeo2bzuAyTJ+RfGvU4oqabwiDFRCr47rFN2ZJEn12R8MoGX/pV4v3NeKwfC2WE07nNIaE5plsnq/J6Z8TgDQ98l1AsIy/i+9mAAIW2EuH2U2aVYuvrPqzcp4Y9hNxK8PqMdj3LsScvuvbc7rYjRv1mm6mC9UUiPlmARnemWRvXIXYukiKk5wWaCQdSytU3tEtxpXgCYLyxCRG7ZCoo71k/gmS3wr59LA7IhGuFGdNsNd9R6EUDe5U4PyTr+ydlOKDJa1TnKuKXGc/gS5QILBNH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDpVrGFVyX7F6O9UjUyPevQiJjMvVFBXfgd78Zkp+OQ=;
 b=aV//enVq2owQd40AGDM/AxoiLhe9lOlMjsMGfGh5TfUBqIs1UJqPbprN9ZKqEuqcNbaGbvlM8XQcjJgqCCE7ryRLT8p6ggZXDYk2AbF524hNgmffReXM36AeUXqZ6CBpu8eZeSXdlXOhWnsH7qV4ND2MEZ3TenKNbg7vysCfgLg=
Received: from MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40) by
 MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Fri, 29 Jan 2021 21:28:07 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::d6) by MW2PR16CA0027.outlook.office365.com
 (2603:10b6:907::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:04 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:04 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:03 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/27] drm/amd/display: reuse current context instead of
 recreating one
Date: Fri, 29 Jan 2021 16:27:30 -0500
Message-ID: <20210129212752.38865-6-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ff50a9-4b10-49cc-e6c2-08d8c49cc449
X-MS-TrafficTypeDiagnostic: MW2PR12MB2361:
X-Microsoft-Antispam-PRVS: <MW2PR12MB23610667D13730B8D964EBF6EBB99@MW2PR12MB2361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vU6Msydm+DDmNjttuSA5/cSg4xFdRUicc6EOeYcbMR/ZvvSRX3J4h835MpECnCL3kDKXqyfiJLpsUpbYs5HfcVoT5P7r+c937GUyAxPA7bWDkXY4LC+kp4dRB/kJone21SDGJ0v/b3qCgzyOJvmBHPTqhLhsRlZkG/6chtD/m+4zXdUW+76j8V2keYqtyXEKTXUm+whzU2FTI6RBBnMHfUGVJqvWsfJB+l8sMxJwIRtfbQSvxppngOZOIOn3vf9IEDJ5IBzA+eOl/jHUrbfKonCvZueq10Tn/9NrmLUEUV3cGry0JSIyVstNmcPYG8kWfDeFZ1EC2LQ43qTlcPlLzBlZ3cfYsfrAr9nZ5Xkw5zvHk/4Aa24FQbzNlMv1LmeI/z4PeOhF4fSySYK3ztzuzWHBKYrDoGt/UNT9CpRcglx7RKYiMw9wq1zaAk0UZ4IScfr9tcgFYWnQAtDBGf5d1XXt9xjo/bxSiHetsoBRVGUTSRCcK5CFRdbDa2oNyerocL3mUnLh2oOwTc5uq4AUMYlgWbYlj+9OhMrcLfUgxpks0FGJVSs7orrabj4HUaaxYx4xbnFkTlgNMLcuWC11XM3XHCLD8zbz5HYoDfS1aE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(83380400001)(8936002)(8676002)(81166007)(6666004)(4326008)(2906002)(82310400003)(7696005)(356005)(82740400003)(70586007)(1076003)(70206006)(86362001)(186003)(426003)(26005)(5660300002)(47076005)(36756003)(478600001)(6916009)(54906003)(336012)(316002)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:05.8355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ff50a9-4b10-49cc-e6c2-08d8c49cc449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2361
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
Currently we discard the current context and recreate it. The current
context is what is applied to the HW so we should be re-using this
rather than creating a new context.

Recreating the context can lead to mismatch between new context and the
current context

For example: gsl groups get changed when we create a new context this
can cause issues in a multi display config (with flip immediate) because
we don't align the existing gsl groups in the new and current context.
If we reuse the current context the gsl group assignment stays the same.

[How]
Instead of discarding the current context, we instead just copy the
current state and add/remove planes and streams.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 27 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 +--
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a63aec164628..68209d0a420a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1936,7 +1936,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 		dc_commit_updates_for_stream(
 			dm->dc, bundle->surface_updates,
 			dc_state->stream_status->plane_count,
-			dc_state->streams[k], &bundle->stream_update, dc_state);
+			dc_state->streams[k], &bundle->stream_update);
 	}
 
 cleanup:
@@ -1967,8 +1967,7 @@ static void dm_set_dpms_off(struct dc_link *link)
 
 	stream_update.stream = stream_state;
 	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
-				     stream_state, &stream_update,
-				     stream_state->ctx->dc->current_state);
+				     stream_state, &stream_update);
 	mutex_unlock(&adev->dm.dc_lock);
 }
 
@@ -7730,7 +7729,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_crtc *pcrtc,
 				    bool wait_for_vblank)
 {
-	uint32_t i;
+	int i;
 	uint64_t timestamp_ns;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
@@ -7771,7 +7770,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		amdgpu_dm_commit_cursors(state);
 
 	/* update planes when needed */
-	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
+	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
 		struct drm_crtc *crtc = new_plane_state->crtc;
 		struct drm_crtc_state *new_crtc_state;
 		struct drm_framebuffer *fb = new_plane_state->fb;
@@ -7994,8 +7993,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 						     bundle->surface_updates,
 						     planes_count,
 						     acrtc_state->stream,
-						     &bundle->stream_update,
-						     dc_state);
+						     &bundle->stream_update);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
@@ -8331,13 +8329,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
-		struct dc_surface_update dummy_updates[MAX_SURFACES];
+		struct dc_surface_update surface_updates[MAX_SURFACES];
 		struct dc_stream_update stream_update;
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
 		bool abm_changed, hdr_changed, scaling_changed;
 
-		memset(&dummy_updates, 0, sizeof(dummy_updates));
+		memset(&surface_updates, 0, sizeof(surface_updates));
 		memset(&stream_update, 0, sizeof(stream_update));
 
 		if (acrtc) {
@@ -8394,16 +8392,15 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		 * To fix this, DC should permit updating only stream properties.
 		 */
 		for (j = 0; j < status->plane_count; j++)
-			dummy_updates[j].surface = status->plane_states[0];
+			surface_updates[j].surface = status->plane_states[j];
 
 
 		mutex_lock(&dm->dc_lock);
 		dc_commit_updates_for_stream(dm->dc,
-						     dummy_updates,
+						surface_updates,
 						     status->plane_count,
 						     dm_new_crtc_state->stream,
-						     &stream_update,
-						     dc_state);
+						     &stream_update);
 		mutex_unlock(&dm->dc_lock);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8fa179cbed32..e3a65d1714ca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2695,8 +2695,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_state *stream,
-		struct dc_stream_update *stream_update,
-		struct dc_state *state)
+		struct dc_stream_update *stream_update)
 {
 	const struct dc_stream_status *stream_status;
 	enum surface_update_type update_type;
@@ -2715,6 +2714,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 
 	if (update_type >= UPDATE_TYPE_FULL) {
+		struct dc_plane_state *new_planes[MAX_SURFACES];
+
+		memset(new_planes, 0, sizeof(new_planes));
+
+		for (i = 0; i < surface_count; i++)
+			new_planes[i] = srf_updates[i].surface;
 
 		/* initialize scratch memory for building context */
 		context = dc_create_state(dc);
@@ -2723,15 +2728,21 @@ void dc_commit_updates_for_stream(struct dc *dc,
 			return;
 		}
 
-		dc_resource_state_copy_construct(state, context);
+		dc_resource_state_copy_construct(
+				dc->current_state, context);
 
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
-			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		/*remove old surfaces from context */
+		if (!dc_rem_all_planes_for_stream(dc, stream, context)) {
+			DC_ERROR("Failed to remove streams for new validate context!\n");
+			return;
+		}
 
-			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
-				new_pipe->plane_state->force_full_update = true;
+		/* add surface to context */
+		if (!dc_add_all_planes_for_stream(dc, stream, new_planes, surface_count, context)) {
+			DC_ERROR("Failed to add streams for new validate context!\n");
+			return;
 		}
+
 	}
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 80b67b860091..a4f7ec888c67 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -294,8 +294,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_state *stream,
-		struct dc_stream_update *stream_update,
-		struct dc_state *state);
+		struct dc_stream_update *stream_update);
 /*
  * Log the current stream state.
  */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
