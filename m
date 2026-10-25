Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AD606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P2yxUEzu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4160110ECBD;
	Mon, 26 Oct 2026 08:43:57 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A160610E231
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 08:45:14 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so3443835e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792917913; x=1793522713; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1d5mUWdvk774lKl2QnImU1luPbD//SI7ZRpbSPmcqww=;
 b=P2yxUEzufW0+S0phYIoUMOk5kuVsTB+XyGE8WHDqnV5ONql+vev4Zmp1oXJMTxIQPi
 HbGxoSu3+nuKSASkTN56iI5v8+CWlUeIqXYDPD6RhPVk2L46BynITHbr+oZTPU2QeTZI
 4ISLNyhKMdGBPZGPggUE4FJeGzs0wyCiEe8mceE1kfjRaC64Cgc8nTZpTQzOFTIa8o9I
 1fyrxowlWBVbb+C7R+raaBxsJncjrs3O4PasbPK/gPU6vQmD0XS3F03rtL8GpvKyokfA
 UAcmVafinVucp687cbNZbH7IQudVIa8mPM+XPWFjpip7AH+wRk6Yb02djS1fMlkCsuKY
 gSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792917913; x=1793522713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1d5mUWdvk774lKl2QnImU1luPbD//SI7ZRpbSPmcqww=;
 b=C+0gEz78XIwfcCz8/sDYl4P7AQTdrbA3ON0/rRwv+Gc8w0JySyD5fCkqZt01hjKDcU
 /bgDlUQ91PqElbfVddbB6gw5I7lPvUFp9pXBpnRYg/+yet/dJNvflEs+3xy1q4GQhetJ
 Dwfdq7DAX0RYLfykXOGDOVlu8AwEI/Abxt9/L91c6UpfFoc7L1ACQsc+EIYnfqB4ct0L
 Zxqmn5Swa3AC0jqaXS4u8oGK9nso7xB4nXsnosgIpUzuPuHJRm5vjkzffNNMsICpr+S8
 Y9zTR2rMbfB/ODAPlTutrloWM81RbQgS0+Rf5l//ZxeOEPvi4SeksHpCLwEOmqtl6tZH
 M7rA==
X-Gm-Message-State: AFq9FYJTHY/2/+49gyPPwxg11ymTzHRMditaxCnrsFbK/LwY4wVxpEGI
 rFxZiwAzv9jcG2vBGWjap2Pn7H6s8TMChITaqnSovuA7bshCA6A7B5GpYg4w8I0J
X-Gm-Gg: AYBFou2Z108lg1cQvVBZiOcgVCJ1Emt3bbQ2p17RD7fP7vK3WLWbXCbBtJcfQ1Obdr9
 mnGBb5L50iinUYdtVjMj4iMn44s8Yk7xvh9Ve1FnVj/qEjRCDpWY+8XGoy3mJWtWsOhj6OcvgD+
 w4Gy6KoMLmzM9A+oPqWtWl4jJ/oaHSceJqgb7iBdFrkarTg9GRj4+6aosQmgF7lY18LG7l2O6eA
 GcnbLldtUNbACAhJtdyf1cYX32+MH8IRo9qWaik5vAJpXr8eIHYVC29Zp57xWklmdRh+U89Bqc6
 Tdq2/iKyCqADZQLg0ihgxb+jUOBjPJYuUyqvt1lljb8gqXU7GNfJUdvlc0gxhNzEnI8acJZOzRd
 Swkljr1yqB0yXtkhZV8KQbUVrgHJKbdJgFAYe37SBVMohS4MuH0tA8+4TvnyvnyinxwrXRpBGM9
 8jE+s2n6ACcAjnSwISmzw5aPwu0Nm6OARm9U4Fmfy3/+Rglmu27hiIy2OCIpcaEiqnV98+RP/Qk
 p+ccfJmXqNXJ48cjChND/XU+jSxxNshBpVa237b660ADGaY2NjhV0P0g1yVEym0WBI2g988/WoU
 yPaN6OKEc3bBhomZfWs2AAlVztoognfIpDjoOyREo1IFu9f5hwuoCcZ4ScgYTdf7mgdjeWc4VYn
 3aBk+RHS0w+erAF2mffanAaaH1m8yQcF3wRLGSs/eED8LDEoWZJ9JHHUqUjLI8GJIBD7XtyvY3+
 BrPwNOV+n+8JKmi7i1O8dhDBLlZH8vMKVUlRe7nRWj6NIaCqwpxohhiMHngmkjWlBSTtW2S30D/
 TVj/G+lVMzbrD/HMrfjx4lAVi0IlTCwCl6edHaoHeinO3rU7VmDfLYz0u32fVu2KSq6hRxPqcsw
 d5k+XNlV/8w=
X-Received: by 2002:a05:600c:4e87:b0:4a2:994:5750 with SMTP id
 5b1f17b1804b1-4a35acbbbdamr59352085e9.32.1792917912666; 
 Sun, 25 Oct 2026 01:45:12 -0700 (PDT)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de.
 [91.65.217.39]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ae28sm111484945e9.2.2026.10.25.01.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 01:45:12 -0700 (PDT)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jack.Xiao@amd.com,
 Erhan Bilgili <erhan.bilgili@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix DC scanout position handling
Date: Sun, 25 Oct 2026 09:45:06 +0100
Message-ID: <20261025084506.62881-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dm_crtc_get_scanoutpos() packs decoded DC positions and blanking
boundaries into u32 words, shifting the second value by 16 bits.

VRR extends vertical blanking without changing the line clock. For
example, a 4K240 mode with vtotal=2250 spans about 9000 lines per
refresh at 60 Hz, exceeding the 13 bit range within a 48-240 Hz VRR
range.

The 13 bit mask truncates positions above 8191, causing early VRR
timestamps and missed vblank count adjustments.

Fixes: e806208dc1da ("drm/amd/display: Fix slow FPS.")
Cc: stable@vger.kernel.org
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0a8dd7241750..f78c82ba7f70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1767,6 +1767,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	bool in_vbl = true;
 
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	/* DC packs decoded values into 16 bit fields. */
+	const u32 scanout_mask = adev->dc_enabled ? 0xffff : 0x1fff;
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
 
@@ -1784,15 +1786,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
 
 	/* Decode into vertical and horizontal scanout position. */
-	*vpos = position & 0x1fff;
-	*hpos = (position >> 16) & 0x1fff;
+	*vpos = position & scanout_mask;
+	*hpos = (position >> 16) & scanout_mask;
 
 	/* Valid vblank area boundaries from gpu retrieved? */
 	if (vbl > 0) {
 		/* Yes: Decode. */
 		ret |= DRM_SCANOUTPOS_ACCURATE;
-		vbl_start = vbl & 0x1fff;
-		vbl_end = (vbl >> 16) & 0x1fff;
+		vbl_start = vbl & scanout_mask;
+		vbl_end = (vbl >> 16) & scanout_mask;
 	} else {
 		/* No: Fake something reasonable which gives at least ok results. */
 		vbl_start = mode->crtc_vdisplay;
-- 
2.56.0

