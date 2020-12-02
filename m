Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28A3C64E7B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 21:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4228F206CA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 21:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4228F206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615466EAE1;
	Wed,  2 Dec 2020 21:06:15 +0000 (UTC)
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2B86EAF0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 21:06:13 +0000 (UTC)
Date: Wed, 02 Dec 2020 21:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1606943170;
 bh=GLsJiGo0zjMOq1Ubm0rxKqUSyyap+dBTq9gn/SbzHCs=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=BuYTHCWOF7IfFpkYKPLdzzDfuMR8/j7v0+tG1ZXSefFnt4MC4t7A75lZ6Ggyavfub
 t2VP11oHLFZWB+wbxRjaUhcqrL4goct1d/00lhmo4oDa3Z1ByM3OSUSyFvSJFyZwCs
 hQ6NYrtktFnEQhpL7hZqAOzI5H8osFVW72+PaeFS8udJ4dZBWxsIP/wI5ztrIYZu1Y
 ZNwJneqGAlmJ9LyiM/mqfTmT8i+nDlm7zNRLyvwt1uC0ZjFXRLZJAZXUkOoExJVTON
 XL6zA+AsDhv9/9r1+r6D3afYLnBYEHtIFRGUfHCzvF/HGrJe//3uK0ACqVl9Rq4HS6
 YAq6a3UugfcTw==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/amd/display: add debug logs for
 dm_crtc_helper_atomic_check
Message-ID: <VGhcmyoWBxsf46kzlRFgLgfPcSdrSwiANl9PJpNE2o@cp4-web-038.plabs.ch>
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

Instead of silently failing the atomic check, explain what happened via
a debug log. This makes it easier for user-space to figure out why
something failed.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 862a59703060..313501cc39fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6068,8 +6068,10 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	 * userspace which stops using the HW cursor altogether in response to the resulting EINVAL.
 	 */
 	if (crtc_state->enable &&
-	    !(crtc_state->plane_mask & drm_plane_mask(crtc->primary)))
+	    !(crtc_state->plane_mask & drm_plane_mask(crtc->primary))) {
+		DRM_DEBUG_ATOMIC("Can't enable a CRTC without enabling the primary plane\n");
 		return -EINVAL;
+	}
 
 	/* In some use cases, like reset, no stream is attached */
 	if (!dm_crtc_state->stream)
@@ -6078,6 +6080,7 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	if (dc_validate_stream(dc, dm_crtc_state->stream) == DC_OK)
 		return 0;
 
+	DRM_DEBUG_ATOMIC("Failed DC stream validation\n");
 	return ret;
 }
 
-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
