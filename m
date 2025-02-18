Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A756C021AE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EAB710E60A;
	Tue, 18 Feb 2025 04:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mYVDMWwL";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3BA10E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:58:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0DED1A41C0F;
 Tue, 18 Feb 2025 04:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB33C4CEE2;
 Tue, 18 Feb 2025 04:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854738;
 bh=1HRAw/eb/4pFujF4kDd61bCpBjQZ2gsY/Qbe0hNmoBc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mYVDMWwLLGLDBcGFT8SWM8pzrNU1g5i/apTYxpQaS+jPm+aol7FjtiB0Z6QzlHaaN
 Ye2dCapoVlftu+gN0x5Xucz5qs+FbNeMESJZonNsaPuG+PJtHrxS4b2DuJ2Da4OC79
 cGISwdn41mPn0jDuQgqE4SX+zchsnZHenfT05GkxWQK8/vLkf9dhNEExJUNNwfn5O5
 LooYbseosxzFBjfK+dz3xleGtBHFWAtG6rxHTGMkMbuqpg058LC6T23Y5pAvmB3vWe
 /dqd3hB/onG93Lj+o1CybihiiiUvRVYkJ5jpDn74qWf2Tepn7izSjDv3nElyhf9i/O
 MDRJLckmNuaeQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 04/13] drm/amd/display: Use a _free() macro for
 amdgpu_dm_commit_zero_streams()
Date: Mon, 17 Feb 2025 22:58:31 -0600
Message-ID: <20250218045840.2469890-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218045840.2469890-1-superm1@kernel.org>
References: <20250218045840.2469890-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

All cases except a failure to create a copy of the current context will
call dc_state_release() on the copied context.

Use a _free() macro to free the context and then adjust the error handling
flow to drop the unnecessary use of goto statements.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index afd2cd71c373e..be162a0cdc7d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3028,10 +3028,11 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 
 }
 
+DEFINE_FREE(state_release, struct dc_state *, if (_T) dc_state_release(_T))
+
 static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 {
-	struct dc_state *context = NULL;
-	enum dc_status res = DC_ERROR_UNEXPECTED;
+	struct dc_state *context __free(state_release) = NULL;
 	int i;
 	struct dc_stream_state *del_streams[MAX_PIPES];
 	int del_streams_count = 0;
@@ -3041,7 +3042,7 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 
 	context = dc_state_create_current_copy(dc);
 	if (context == NULL)
-		goto context_alloc_fail;
+		return DC_ERROR_UNEXPECTED;
 
 	/* First remove from context all streams */
 	for (i = 0; i < context->stream_count; i++) {
@@ -3052,25 +3053,20 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 
 	/* Remove all planes for removed streams and then remove the streams */
 	for (i = 0; i < del_streams_count; i++) {
-		if (!dc_state_rem_all_planes_for_stream(dc, del_streams[i], context)) {
-			res = DC_FAIL_DETACH_SURFACES;
-			goto fail;
-		}
+		enum dc_status res;
+
+		if (!dc_state_rem_all_planes_for_stream(dc, del_streams[i], context))
+			return DC_FAIL_DETACH_SURFACES;
 
 		res = dc_state_remove_stream(dc, context, del_streams[i]);
 		if (res != DC_OK)
-			goto fail;
+			return res;
 	}
 
 	params.streams = context->streams;
 	params.stream_count = context->stream_count;
-	res = dc_commit_streams(dc, &params);
-
-fail:
-	dc_state_release(context);
 
-context_alloc_fail:
-	return res;
+	return dc_commit_streams(dc, &params);
 }
 
 static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
-- 
2.43.0

