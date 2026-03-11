Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C49DFD88F4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B9A10E236;
	Wed, 11 Mar 2026 04:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=fatooh.org header.i=@fatooh.org header.b="aEJIw8Iy";
	dkim-atps=neutral
X-Greylist: delayed 450 seconds by postgrey-1.36 at gabe;
 Wed, 11 Mar 2026 04:51:04 UTC
Received: from juniper.fatooh.org (juniper.fatooh.org [173.255.221.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE46210E236
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:51:04 +0000 (UTC)
Received: from juniper.fatooh.org (juniper.fatooh.org [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by juniper.fatooh.org (Postfix) with ESMTPS id 3F740403F3;
 Tue, 10 Mar 2026 21:43:33 -0700 (PDT)
Received: from juniper.fatooh.org (juniper.fatooh.org [127.0.0.1])
 by juniper.fatooh.org (Postfix) with ESMTP id 19F024041D;
 Tue, 10 Mar 2026 21:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=fatooh.org; h=from:to
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; s=dkim; bh=KOmu6YM6Ke0UV2zAfr5XXp/ln
 qY=; b=aEJIw8IyfXSqL8/tZ45pYC6GCLAKXYDBKDqU2eLONVCJeMzvvcpinkRaP
 KFD2oBsiRrW6/v/le/+qps0EogFqUZRXbPnJws+Pb+9aMspxHj+qBRQ8FvsdwtPM
 FkW6N9/qKby7I/8qY1nFfB/kWW5KT7f7in4oaaLLV6EAsKfzKA=
DomainKey-Signature: a=rsa-sha1; c=simple; d=fatooh.org; h=from:to
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; q=dns; s=dkim; b=W7TLWfLbtVqWrUKWXA8
 +B1FznLZZs/k0oQ4xcWpZeS+AIQMX6Gj8Db+79mtLYAYlBrDxXU23qMvWrZhKJyC
 dEQkU6VcIVZrVVAkzyua1RUbe+GsXDpHdRXqubn1LZtt0Hb37pTTr9bKW+vWlFcJ
 hbeFBr3sj+KonZal3daQyfks=
Received: from bugfood.local (unknown
 [IPv6:2600:1700:9750:59ef:62cf:84ff:fe62:f2b2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by juniper.fatooh.org (Postfix) with ESMTPSA id 03798403F3;
 Tue, 10 Mar 2026 21:43:32 -0700 (PDT)
Received: by bugfood.local (Postfix, from userid 1000)
 id C3424C219401; Tue, 10 Mar 2026 21:43:32 -0700 (PDT)
From: Corey Hickey <bugfood-ml@fatooh.org>
To: Corey Hickey <bugfood-ml@fatooh.org>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] Revert "drm/amd/display: use a more lax vblank enable policy
 for older ASICs""
Date: Tue, 10 Mar 2026 21:40:23 -0700
Message-ID: <20260311044311.10941-2-bugfood-ml@fatooh.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311044311.10941-1-bugfood-ml@fatooh.org>
References: <20260311044311.10941-1-bugfood-ml@fatooh.org>
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

From: Corey Hickey <bugfood-c@fatooh.org>

This reverts commit 58a261bfc96763a851cb48b203ed57da37e157b8, largely
done by hand--a 'git revert' no longer cleanly applies, due to
significant changes to the file that happened in the interim.

This revert fixes a reproducible issue on a Radeon RX 6700 XT card: 2D
OpenGL programs often hang.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4663
Fixes: 58a261bfc967 ("drm/amd/display: use a more lax vblank enable policy for older ASICs")
Signed-off-by: Corey Hickey <bugfood-c@fatooh.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 87 ++++++++++---------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6..a8aa610f2c83 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9323,53 +9323,56 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	int offdelay;
 
 	if (acrtc_state) {
-		timing = &acrtc_state->stream->timing;
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+		    IP_VERSION(3, 5, 0)) {
+			drm_crtc_vblank_on(&acrtc->base);
+		} else {
+			timing = &acrtc_state->stream->timing;
 
-		/*
-		 * Depending on when the HW latching event of double-buffered
-		 * registers happen relative to the PSR SDP deadline, and how
-		 * bad the Panel clock has drifted since the last ALPM off
-		 * event, there can be up to 3 frames of delay between sending
-		 * the PSR exit cmd to DMUB fw, and when the panel starts
-		 * displaying live frames.
-		 *
-		 * We can set:
-		 *
-		 * 20/100 * offdelay_ms = 3_frames_ms
-		 * => offdelay_ms = 5 * 3_frames_ms
-		 *
-		 * This ensures that `3_frames_ms` will only be experienced as a
-		 * 20% delay on top how long the display has been static, and
-		 * thus make the delay less perceivable.
-		 */
-		if (acrtc_state->stream->link->psr_settings.psr_version <
-		    DC_PSR_VERSION_UNSUPPORTED) {
-			offdelay = DIV64_U64_ROUND_UP((u64)5 * 3 * 10 *
-						      timing->v_total *
-						      timing->h_total,
-						      timing->pix_clk_100hz);
-			config.offdelay_ms = offdelay ?: 30;
-		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-			   IP_VERSION(3, 5, 0) ||
-			   !(adev->flags & AMD_IS_APU)) {
 			/*
-			 * Older HW and DGPU have issues with instant off;
-			 * use a 2 frame offdelay.
+			 * Depending on when the HW latching event of double-buffered
+			 * registers happen relative to the PSR SDP deadline, and how
+			 * bad the Panel clock has drifted since the last ALPM off
+			 * event, there can be up to 3 frames of delay between sending
+			 * the PSR exit cmd to DMUB fw, and when the panel starts
+			 * displaying live frames.
+			 *
+			 * We can set:
+			 *
+			 * 20/100 * offdelay_ms = 3_frames_ms
+			 * => offdelay_ms = 5 * 3_frames_ms
+			 *
+			 * This ensures that `3_frames_ms` will only be experienced as a
+			 * 20% delay on top how long the display has been static, and
+			 * thus make the delay less perceivable.
 			 */
-			offdelay = DIV64_U64_ROUND_UP((u64)20 *
-						      timing->v_total *
-						      timing->h_total,
-						      timing->pix_clk_100hz);
+			if (acrtc_state->stream->link->psr_settings.psr_version <
+				DC_PSR_VERSION_UNSUPPORTED) {
+				offdelay = DIV64_U64_ROUND_UP((u64)5 * 3 * 10 *
+								  timing->v_total *
+								  timing->h_total,
+								  timing->pix_clk_100hz);
+				config.offdelay_ms = offdelay ?: 30;
+			} else if (!(adev->flags & AMD_IS_APU)) {
+				/*
+				 * DGPU has issues with instant off;
+				 * use a 2 frame offdelay.
+				 */
+				offdelay = DIV64_U64_ROUND_UP((u64)20 *
+								  timing->v_total *
+								  timing->h_total,
+								  timing->pix_clk_100hz);
 
-			config.offdelay_ms = offdelay ?: 30;
-		} else {
-			/* offdelay_ms = 0 will never disable vblank */
-			config.offdelay_ms = 1;
-			config.disable_immediate = true;
-		}
+				config.offdelay_ms = offdelay ?: 30;
+			} else {
+				/* offdelay_ms = 0 will never disable vblank */
+				config.offdelay_ms = 1;
+				config.disable_immediate = true;
+			}
 
-		drm_crtc_vblank_on_config(&acrtc->base,
-					  &config);
+			drm_crtc_vblank_on_config(&acrtc->base,
+						  &config);
+		}
 		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_get.*/
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		case IP_VERSION(3, 0, 0):
-- 
2.51.0

