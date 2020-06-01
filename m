Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3E12074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc1Oa4LH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3E12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EB26E9F0;
	Mon,  1 Jun 2020 18:30:22 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088A46E9EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:21 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id c12so9989460qkk.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iR080AMs0PSpjIjFpVP92THeK8RIY/ttzio5SY9zsPE=;
 b=qc1Oa4LH2kFOSgvh6AdLCUBpW1Ygg388W5DIad8aGDL6oIv0sKzmKW4lY0YAa6kX5Y
 VObkRslNAVmi06svPNV5Hhj6ps8HHGq7Pq3Lk8bIWLrDvgzOfjd9nWC7MZRjMV+5xgP3
 OXn/4yBvLnQYlqxfPvkOFUBwDg4LzJ7QAwT4XJNb3o2Ycb2O44MxMS0qg0wuAL1BoZn5
 Fs1oP2sb/6CULQbZs5snHJTZd6t4LkauRLfQp+5NHm7K4y0SaNsUisdw3vryPTiCJRok
 /D+6sBFEzZwQPj558de+WiqQqq2SIQh49aGNYl1PpiZnQmEzJaCPT4PhKIr446CO8/yX
 ra/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iR080AMs0PSpjIjFpVP92THeK8RIY/ttzio5SY9zsPE=;
 b=feTo8NLx2U8njFTS/ty7mZGIh58VSh0Gao69lVvtYQOrFR/qQpNIlUN/i7C91onD+7
 9FZ9bHiOjfRUBHAyUVpzxvzhSFnaKLwU6KrEBplkaMDMSrjAsJs0FFhfn4kLYqArh5ah
 8mfzfJvOLOoClidD0V/v1dNbeS8DoOvgMbjSLBYUvGXwW4JRTLLYIPBcsSL4wUOBQY5X
 3+gmaWgNRKr6IId6sIgkjvopcgkYHaxzvAkF5xRjtbXeurMP0vPrXXJqUVH63LZKkbn3
 3wErP4CZq3R98501BTFgBrko2yq8M+wRDJsv4+8P/s93+/ImAgI9npkoJ2Nmz+9qPt0D
 LOGg==
X-Gm-Message-State: AOAM533Ur16weBdokTLRspY8NwfPQtqpsNWHvVlkLd+GXu+OpwlDWRwO
 XAbfe9rBBqfRpIj20Vbdfkm95KuO
X-Google-Smtp-Source: ABdhPJzCkcN1ursJhhT3QsBpmQ+/Bxb7cRISTpOyi6KnfDsS7fQyLUgqadukAK6wZBoX4Mn5uqsQZA==
X-Received: by 2002:a05:620a:995:: with SMTP id
 x21mr20870212qkx.418.1591036219631; 
 Mon, 01 Jun 2020 11:30:19 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:19 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 205/207] drm/amd/display: fix and simplify pipe split logic
 for DCN3
Date: Mon,  1 Jun 2020 14:29:24 -0400
Message-Id: <20200601182926.1267958-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This was done already done for DCN

From:
f7a695da88cf ("drm/amd/display: fix and simplify pipe split logic")

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 213 ++++++++----------
 1 file changed, 93 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 9ae0f4399e5a..bddd671fb196 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1875,19 +1875,57 @@ static bool init_soc_bounding_box(struct dc *dc,
 	return true;
 }
 
-bool dcn30_build_params_mpc_split(struct pipe_ctx *primary_pipe)
+static bool dcn30_split_stream_for_mpc_or_odm(
+		const struct dc *dc,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *pri_pipe,
+		struct pipe_ctx *sec_pipe,
+		bool odm)
 {
-	struct pipe_ctx *current_pipe = primary_pipe;
+	int pipe_idx = sec_pipe->pipe_idx;
+	const struct resource_pool *pool = dc->res_pool;
+
+	*sec_pipe = *pri_pipe;
+
+	sec_pipe->pipe_idx = pipe_idx;
+	sec_pipe->plane_res.mi = pool->mis[pipe_idx];
+	sec_pipe->plane_res.hubp = pool->hubps[pipe_idx];
+	sec_pipe->plane_res.ipp = pool->ipps[pipe_idx];
+	sec_pipe->plane_res.xfm = pool->transforms[pipe_idx];
+	sec_pipe->plane_res.dpp = pool->dpps[pipe_idx];
+	sec_pipe->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+	sec_pipe->stream_res.dsc = NULL;
+	if (odm) {
+		if (pri_pipe->next_odm_pipe) {
+			ASSERT(pri_pipe->next_odm_pipe != sec_pipe);
+			sec_pipe->next_odm_pipe = pri_pipe->next_odm_pipe;
+			sec_pipe->next_odm_pipe->prev_odm_pipe = sec_pipe;
+		}
+		pri_pipe->next_odm_pipe = sec_pipe;
+		sec_pipe->prev_odm_pipe = pri_pipe;
+		ASSERT(sec_pipe->top_pipe == NULL);
+
+		sec_pipe->stream_res.opp = pool->opps[pipe_idx];
+		if (sec_pipe->stream->timing.flags.DSC == 1) {
+			dcn20_acquire_dsc(dc, res_ctx, &sec_pipe->stream_res.dsc, pipe_idx);
+			ASSERT(sec_pipe->stream_res.dsc);
+			if (sec_pipe->stream_res.dsc == NULL)
+				return false;
+		}
+	} else {
+		if (pri_pipe->bottom_pipe) {
+			ASSERT(pri_pipe->bottom_pipe != sec_pipe);
+			sec_pipe->bottom_pipe = pri_pipe->bottom_pipe;
+			sec_pipe->bottom_pipe->top_pipe = sec_pipe;
+		}
+		pri_pipe->bottom_pipe = sec_pipe;
+		sec_pipe->top_pipe = pri_pipe;
 
-	while (current_pipe) {
-		if (!resource_build_scaling_params(current_pipe))
-			return false;
-		current_pipe = current_pipe->bottom_pipe;
+		ASSERT(pri_pipe->plane_state);
 	}
 
 	return true;
 }
-
 static bool dcn30_fast_validate_bw(
 		struct dc *dc,
 		struct dc_state *context,
@@ -1945,7 +1983,7 @@ static bool dcn30_fast_validate_bw(
 			continue;
 
 		/* We only support full screen mpo with ODM */
-		if (vba->ODMCombineEnabled[pipe_idx] != dm_odm_combine_mode_disabled
+		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
 				&& pipe->plane_state && mpo_pipe
 				&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
 						&pipe->plane_res.scl_data.recout,
@@ -1966,10 +2004,13 @@ static bool dcn30_fast_validate_bw(
 		if (!merge[i])
 			continue;
 
-		/* if ODM merge we ignore mpc tree, mpo pipes will have their own flags
-		 */
+		/* if ODM merge we ignore mpc tree, mpo pipes will have their own flags */
 		if (pipe->prev_odm_pipe) {
 			/*split off odm pipe*/
+			pipe->prev_odm_pipe->next_odm_pipe = pipe->next_odm_pipe;
+			if (pipe->next_odm_pipe)
+				pipe->next_odm_pipe->prev_odm_pipe = pipe->prev_odm_pipe;
+
 			pipe->bottom_pipe = NULL;
 			pipe->next_odm_pipe = NULL;
 			pipe->plane_state = NULL;
@@ -1980,15 +2021,11 @@ static bool dcn30_fast_validate_bw(
 				dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res.dsc);
 			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
 			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
-		} else if (pipe->next_odm_pipe) {
-			/*initial odm pipe*/
-			pipe->next_odm_pipe = NULL;
-		} else {
+		} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
 			struct pipe_ctx *top_pipe = pipe->top_pipe;
 			struct pipe_ctx *bottom_pipe = pipe->bottom_pipe;
 
-			if (top_pipe)
-				top_pipe->bottom_pipe = bottom_pipe;
+			top_pipe->bottom_pipe = bottom_pipe;
 			if (bottom_pipe)
 				bottom_pipe->top_pipe = top_pipe;
 
@@ -1998,141 +2035,77 @@ static bool dcn30_fast_validate_bw(
 			pipe->stream = NULL;
 			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
 			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
-		}
+		} else
+			ASSERT(0); /* Should never try to merge master pipe */
 
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (pipe->plane_state) {
-			if (!resource_build_scaling_params(pipe))
-				goto validate_fail;
-		}
-	}
-
 	for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *hsplit_pipe = NULL;
+		bool odm;
 
 		if (!pipe->stream || newly_split[i])
 			continue;
 
 		pipe_idx++;
+		odm = vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled;
 
-		if (!pipe->top_pipe && !pipe->plane_state && split[i] != 0
-				&& vba->ODMCombineEnabled[pipe_idx] != dm_odm_combine_mode_disabled) {
+		if (!pipe->plane_state && !odm)
+			continue;
+
+		if (split[i]) {
 			hsplit_pipe = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
 			ASSERT(hsplit_pipe);
 			if (!hsplit_pipe)
 				goto validate_fail;
-			if (!dcn20_split_stream_for_odm(
+
+			if (!dcn30_split_stream_for_mpc_or_odm(
 					dc, &context->res_ctx,
-					pipe, hsplit_pipe))
+					pipe, hsplit_pipe, odm))
 				goto validate_fail;
+
 			newly_split[hsplit_pipe->pipe_idx] = true;
-			if (vba->ODMCombineEnabled[pipe_idx] == dm_odm_combine_mode_4to1) {
-				struct pipe_ctx *pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
-
-				ASSERT(pipe_4to1);
-				if (!dcn20_split_stream_for_odm(
-						dc, &context->res_ctx,
-						pipe, pipe_4to1))
-					goto validate_fail;
-				newly_split[pipe_4to1->pipe_idx] = true;
-
-				pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
-				ASSERT(pipe_4to1);
-				if (!dcn20_split_stream_for_odm(
-						dc, &context->res_ctx,
-						hsplit_pipe, pipe_4to1))
-					goto validate_fail;
-				newly_split[pipe_4to1->pipe_idx] = true;
-			}
-			dcn20_build_mapped_resource(dc, context, pipe->stream);
 			repopulate_pipes = true;
 		}
+		if (split[i] == 4) {
+			struct pipe_ctx *pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
 
-		if (!pipe->plane_state)
-			continue;
-
-		if (split[i] == 2) {
-			hsplit_pipe = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
-			ASSERT(hsplit_pipe);
-			if (!hsplit_pipe)
+			ASSERT(pipe_4to1);
+			if (!pipe_4to1)
 				goto validate_fail;
+			if (!dcn30_split_stream_for_mpc_or_odm(
+					dc, &context->res_ctx,
+					pipe, pipe_4to1, odm))
+				goto validate_fail;
+			newly_split[pipe_4to1->pipe_idx] = true;
 
-			if (vba->ODMCombineEnabled[pipe_idx] != dm_odm_combine_mode_disabled) {
-				if (!dcn20_split_stream_for_odm(
-						dc, &context->res_ctx,
-						pipe, hsplit_pipe))
-					goto validate_fail;
-				if (vba->ODMCombineEnabled[pipe_idx] == dm_odm_combine_mode_4to1) {
-					struct pipe_ctx *pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
-
-					ASSERT(pipe_4to1);
-					if (!pipe_4to1)
-						goto validate_fail;
-					if (!dcn20_split_stream_for_odm(
-							dc, &context->res_ctx,
-							pipe, pipe_4to1))
-						goto validate_fail;
-					newly_split[pipe_4to1->pipe_idx] = true;
-
-					pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
-					ASSERT(pipe_4to1);
-					if (!pipe_4to1)
-						goto validate_fail;
-					if (!dcn20_split_stream_for_odm(
-							dc, &context->res_ctx,
-							hsplit_pipe, pipe_4to1))
-						goto validate_fail;
-					newly_split[pipe_4to1->pipe_idx] = true;
-				}
-				dcn20_build_mapped_resource(dc, context, pipe->stream);
-			} else {
-				/* Going from 2 pipe split to 4 pipe split case */
-				if (dcn20_find_previous_split_count(pipe) == 2) {
-					dcn20_split_stream_for_mpc(
-						&context->res_ctx, dc->res_pool,
-						pipe, hsplit_pipe);
-					newly_split[hsplit_pipe->pipe_idx] = true;
-					hsplit_pipe = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
-					dcn20_split_stream_for_mpc(
-						&context->res_ctx, dc->res_pool,
-						pipe, hsplit_pipe);
-					if (!dcn30_build_params_mpc_split(pipe))
-						goto validate_fail;
-				} else {
-					dcn20_split_stream_for_mpc(
-						&context->res_ctx, dc->res_pool,
-						pipe, hsplit_pipe);
-					if (!resource_build_scaling_params(pipe) || !resource_build_scaling_params(hsplit_pipe))
-						goto validate_fail;
-				}
-			}
-			newly_split[hsplit_pipe->pipe_idx] = true;
-			repopulate_pipes = true;
+			pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
+			ASSERT(pipe_4to1);
+			if (!pipe_4to1)
+				goto validate_fail;
+			if (!dcn30_split_stream_for_mpc_or_odm(
+					dc, &context->res_ctx,
+					hsplit_pipe, pipe_4to1, odm))
+				goto validate_fail;
+			newly_split[pipe_4to1->pipe_idx] = true;
 		}
-		if (split[i] == 4) {
-			struct pipe_ctx *pipe_4to1;
+		if (odm)
+			dcn20_build_mapped_resource(dc, context, pipe->stream);
+	}
 
-			hsplit_pipe = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
-			for (i = 0; i < 3; i++) {
-				pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
-				ASSERT(pipe_4to1);
-				dcn20_split_stream_for_mpc(&context->res_ctx, dc->res_pool, pipe, pipe_4to1);
-				newly_split[pipe_4to1->pipe_idx] = true;
-			}
-			if (!dcn30_build_params_mpc_split(pipe))
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->plane_state) {
+			if (!resource_build_scaling_params(pipe))
 				goto validate_fail;
-			repopulate_pipes = true;
 		}
 	}
+
 	/* Actual dsc count per stream dsc validation*/
 	if (!dcn20_validate_dsc(dc, context)) {
-		context->bw_ctx.dml.vba.ValidationStatus[context->bw_ctx.dml.vba.soc.num_states] =
-				DML_FAIL_DSC_VALIDATION_FAILURE;
+		vba->ValidationStatus[vba->soc.num_states] = DML_FAIL_DSC_VALIDATION_FAILURE;
 		goto validate_fail;
 	}
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
