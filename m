Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E7AC64E7B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 21:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3983C21D91
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 21:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3983C21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD956EADB;
	Wed,  2 Dec 2020 21:09:23 +0000 (UTC)
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A312F6EADB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 21:09:22 +0000 (UTC)
Date: Wed, 02 Dec 2020 21:09:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1606943360;
 bh=YOtYhcoFH/fl14SEmnn20mAGB6zjgA6t7LTkWsRxqQI=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=UVqdT8wuzPt2MIybXpbgwTblMbkh2o5T0XJd1Ka7GsLIr4A5pk8mZAoGsNzRFeyKH
 kaXhMHduh1huI1JrMLbW731Sm1S11HyBVtl3OmflWdAMILNYWhDPobFtXKo2QTyhp1
 XnaaUPCcGyRi0LTmKA/QytP3eX8lW12jzo2SJOdzVYAx/PzM+wjp0lObSLY6C1HCZI
 gqH0FYnz+s7NMNHkwu9y7mnvRuEuMrpUDAeBeAcJ0Se4l0dvthRA7kvchwsQDWfWEj
 49l8Kmp6e9QXlUi88kxlBTQm5BCmvDs2q754AItqHiU/7CE8UndfMzHQt5aKYb/4Jc
 La6E2SYGKhUdg==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 2/2] drm/amd/display: add cursor pitch check
Message-ID: <7UvPE5okTSEaIRnrg3TJcnkyIBhPPRXCCuMa5wwC18@cp3-web-029.plabs.ch>
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the width check with a pitch check, which matches DM internals.
Add a new check to make sure the pitch (in pixels) matches the width.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9e328101187e..862a59703060 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8988,6 +8988,7 @@ static int dm_update_plane_state(struct dc *dc,
 	struct amdgpu_crtc *new_acrtc;
 	bool needs_reset;
 	int ret = 0;
+	unsigned int pitch;
 
 
 	new_plane_crtc = new_plane_state->crtc;
@@ -9021,15 +9022,25 @@ static int dm_update_plane_state(struct dc *dc,
 				return -EINVAL;
 			}
 
-			switch (new_plane_state->fb->width) {
+			/* Pitch in pixels */
+			pitch = new_plane_state->fb->pitches[0] / new_plane_state->fb->format->cpp[0];
+
+			if (new_plane_state->fb->width != pitch) {
+				DRM_DEBUG_ATOMIC("Cursor FB width %d doesn't match pitch %d",
+						 new_plane_state->fb->width,
+						 pitch);
+				return -EINVAL;
+			}
+
+			switch (pitch) {
 			case 64:
 			case 128:
 			case 256:
-				/* FB width is supported by cursor plane */
+				/* FB pitch is supported by cursor plane */
 				break;
 			default:
-				DRM_DEBUG_ATOMIC("Bad cursor FB width %d\n",
-						 new_plane_state->fb->width);
+				DRM_DEBUG_ATOMIC("Bad cursor FB pitch %d px\n",
+						 pitch);
 				return -EINVAL;
 			}
 		}
-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
