Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB6CD59D99
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1680710E0DC;
	Mon, 15 Dec 2025 01:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KCZChGQZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112FA10E0BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C45C6013F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AFEC19422;
 Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761156;
 bh=yQ7KrZqwDGh9KatEWtTanZbuesHYOumPisrdVyWmu4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KCZChGQZAOt7QpHMEiqZW0U0fKBSs6O03os67LIUHWGrA8WyZ1EpZPDmiJESeTNbR
 oaEyGVGSHrOem0j5SGLk/jh6A8D+KI4UoZWLVRDVTJvl5DXkTtnvwfDbww7lHyNDCU
 +c7r55ICfml8pWTo1NozPu3T6uFTnmie973zETt2yFPsb3Ca0L9zQvZz5oAtCRSPwo
 sZtJJMmXbGtSbnIT+19JNMCESxC14D1mjfbIfNL+DUVrjeLBR555H1QvJWgrPJssPF
 AMIytlr0kfLuKGYroSf2CEZ4A9/B1uBOgGqy0Nv66RbiIGv+SSQtR354L77QZgkHQ6
 nu9EN35AQM3Dg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 6/9] drm/amd/display: Fix DPMS log printing
Date: Sun, 14 Dec 2025 19:12:24 -0600
Message-ID: <20251215011227.161597-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215011227.161597-1-superm1@kernel.org>
References: <20251215011227.161597-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

[Why]
Spaces before newline are not necessary. Inserting newlines in
multi-line strings are harder to follow when tracing messages.

[How]
Drop extra new lines and split multi-line messages into one print
per line.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 114 +++++-------------
 1 file changed, 29 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 87f9ceebe26a4..595542f0e01bc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1330,6 +1330,28 @@ static void remove_stream_from_alloc_table(
 	}
 }
 
+static void print_mst_streams(struct dc_link *link)
+{
+	int i;
+
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	DC_LOG_MST("%s stream_count: %d:\n",
+		   __func__,
+		   link->mst_stream_alloc_table.stream_count);
+
+	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
+		DC_LOG_MST("stream_enc[%d]: %p\n", i,
+			   (void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc);
+		DC_LOG_MST("stream[%d].hpo_dp_stream_enc: %p\n", i,
+			   (void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc);
+		DC_LOG_MST("stream[%d].vcp_id: %d\n", i,
+			   link->mst_stream_alloc_table.stream_allocations[i].vcp_id);
+		DC_LOG_MST("stream[%d].slot_count: %d\n", i,
+			   link->mst_stream_alloc_table.stream_allocations[i].slot_count);
+	}
+}
+
 static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -1372,9 +1394,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 					pipe_ctx->stream_res.hpo_dp_stream_enc,
 					&proposed_table);
 		else
-			DC_LOG_WARNING("Failed to update"
-					"MST allocation table for"
-					"pipe idx:%d\n",
+			DC_LOG_WARNING("Failed to update MST allocation table for idx %d\n",
 					pipe_ctx->pipe_idx);
 	} else {
 		/* when link is no longer in mst mode (mst hub unplugged),
@@ -1384,25 +1404,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 				pipe_ctx->stream_res.hpo_dp_stream_enc);
 	}
 
-	DC_LOG_MST("%s"
-			"stream_count: %d: ",
-			__func__,
-			link->mst_stream_alloc_table.stream_count);
-
-	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
-		DC_LOG_MST("stream_enc[%d]: %p      "
-		"stream[%d].hpo_dp_stream_enc: %p      "
-		"stream[%d].vcp_id: %d      "
-		"stream[%d].slot_count: %d\n",
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].slot_count);
-	}
+	print_mst_streams(link);
 
 	/* update mst stream allocation table hardware state */
 	if (link_hwss->ext.update_stream_allocation_table == NULL ||
@@ -1459,30 +1461,10 @@ static enum dc_status allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 					pipe_ctx->stream_res.hpo_dp_stream_enc,
 					&proposed_table);
 	else
-		DC_LOG_WARNING("Failed to update"
-				"MST allocation table for"
-				"pipe idx:%d\n",
+		DC_LOG_WARNING("Failed to update MST allocation table for idx %d\n",
 				pipe_ctx->pipe_idx);
 
-	DC_LOG_MST("%s  "
-			"stream_count: %d: \n ",
-			__func__,
-			link->mst_stream_alloc_table.stream_count);
-
-	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
-		DC_LOG_MST("stream_enc[%d]: %p      "
-		"stream[%d].hpo_dp_stream_enc: %p      "
-		"stream[%d].vcp_id: %d      "
-		"stream[%d].slot_count: %d\n",
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].slot_count);
-	}
+	print_mst_streams(link);
 
 	ASSERT(proposed_table.stream_count > 0);
 
@@ -1781,31 +1763,11 @@ enum dc_status link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw_in
 				pipe_ctx->stream_res.hpo_dp_stream_enc,
 				&proposed_table);
 	} else {
-		DC_LOG_WARNING("Failed to update"
-				"MST allocation table for"
-				"pipe idx:%d\n",
+		DC_LOG_WARNING("Failed to update MST allocation table for idx %d\n",
 				pipe_ctx->pipe_idx);
 	}
 
-	DC_LOG_MST("%s  "
-			"stream_count: %d: \n ",
-			__func__,
-			link->mst_stream_alloc_table.stream_count);
-
-	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
-		DC_LOG_MST("stream_enc[%d]: %p      "
-		"stream[%d].hpo_dp_stream_enc: %p      "
-		"stream[%d].vcp_id: %d      "
-		"stream[%d].slot_count: %d\n",
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].slot_count);
-	}
+	print_mst_streams(link);
 
 	ASSERT(proposed_table.stream_count > 0);
 
@@ -1854,25 +1816,7 @@ enum dc_status link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw_
 				&proposed_table);
 	}
 
-	DC_LOG_MST("%s  "
-			"stream_count: %d: \n ",
-			__func__,
-			link->mst_stream_alloc_table.stream_count);
-
-	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
-		DC_LOG_MST("stream_enc[%d]: %p      "
-		"stream[%d].hpo_dp_stream_enc: %p      "
-		"stream[%d].vcp_id: %d      "
-		"stream[%d].slot_count: %d\n",
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].slot_count);
-	}
+	print_mst_streams(link);
 
 	ASSERT(proposed_table.stream_count > 0);
 
-- 
2.43.0

