Return-Path: <SRS0=njeu=7F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2C5C433DF
	for <amd-gfx@archiver.kernel.org>; Sat, 23 May 2020 11:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19273206DD
	for <amd-gfx@archiver.kernel.org>; Sat, 23 May 2020 11:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="en1QUJ+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19273206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A72026E057;
	Sat, 23 May 2020 11:53:52 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AA96E057
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 May 2020 11:53:50 +0000 (UTC)
Date: Sat, 23 May 2020 11:53:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1590234828;
 bh=zKEAmbr9V1bPLCNBFpsV9zuulffTZwiGATDStCEVeCY=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=en1QUJ+l9hkRjAnagjGy5NPtcJxRdQgCJ1d9+CRZT5v61C1EpYuhIUEPBPhrcKJbR
 +M2/TAZ++HdE7T1gp7aSjLKPbAzqdNeF6x1p8eFl08ee1JDaQGZgr0UFIHM1zpOTjz
 nXhAFzCuKLgJvTpNLF5k7Q5QQxx+z9xbS7/v6h60=
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/amd/display: drop cursor position check in atomic test
Message-ID: <HB1_5z8Vnk8KvqVJezbdCJ0uUkI29R_Q7ksMByqCNQ3DG9HWd_iJP6b0WL1jIIJLBPdN25D8iC4BN-Jbf8NbKSL_Ep6IKVn3DaHpe_h5Ljg=@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

get_cursor_position already handles the case where the cursor has
negative off-screen coordinates by not setting
dc_cursor_position.enabled.

Signed-off-by: Simon Ser <contact@emersion.fr>
Fixes: 626bf90fe03f ("drm/amd/display: add basic atomic check for cursor plane")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 28e651b173ab..7fc15b82fe48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7880,13 +7880,6 @@ static int dm_update_plane_state(struct dc *dc,
 			return -EINVAL;
 		}
 
-		if (new_plane_state->crtc_x <= -new_acrtc->max_cursor_width ||
-			new_plane_state->crtc_y <= -new_acrtc->max_cursor_height) {
-			DRM_DEBUG_ATOMIC("Bad cursor position %d, %d\n",
-							 new_plane_state->crtc_x, new_plane_state->crtc_y);
-			return -EINVAL;
-		}
-
 		return 0;
 	}
 
-- 
2.26.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
