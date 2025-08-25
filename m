Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24E8CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9405210E592;
	Mon, 25 Aug 2025 21:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CfoJT599";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91EB310E590
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:56:40 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3c8fe6bd1a2so583419f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158999; x=1756763799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9vU/L5xYMF2ajkjXRyGt7V2HZCmx8ZHP6J+w3RP+Vg=;
 b=CfoJT5993l4EkllAh3ML1K4pDi3+5BGWvOWSni47dio1amwo5dKu2RqPCyyHO3bUcV
 HFARqwW32Y41QcazlscPwNVy+zfah4vR/V4MY2D9FD2Etfxzg+UMHp8hv1qmxQunjbYy
 ZbwZ5jw2WfTzRdedlu2tbh/uaXgXq4MFUskN7nw70uY7YQeuN8HM1KTBopc1NYUac6vZ
 KG36wnLxTL/StABPOD81c6/l1suQ+1jq8eot2w1sTUywU5p07r0i2JO8OAaNM+PYRy0n
 OoYayCeNqokz9CqKc68VdUIGJ2+gw/inAnaVv4YGfzEIhk1pTvhwz1dPN8I6d9KVMAxf
 Ei5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158999; x=1756763799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9vU/L5xYMF2ajkjXRyGt7V2HZCmx8ZHP6J+w3RP+Vg=;
 b=mel25RafOXmIkJ1gi52aWGJCP3yjjY4Qx3swPFzdrG1cy4eYZ2akIV5FOmGydR1IWX
 0yoaCV0D4vw2lOWbDTWbWboX27xWoN4WCQz/yRvrsECor8q42OIcGyAUgY6YXp7BIWN6
 Pl6VlmaVPislYw8IKip8EQTw/v0SnjprPpeYWlrQCyQtoB4WeerOAH6Z/6N9ivm5cVcw
 9IELC8EfeCaWXPN2QBfK6ZP6nJdtDgZAmIa+nufv4KT3qWM9oT7Fn4qqWGTLLIv9sEF1
 Zr1loskgYZNZSaRZXIAGRsbDK5JcWLPQvXEFegKwE1XTYZ4AoJiaO7zNLhxhqBtOwW3f
 9smw==
X-Gm-Message-State: AOJu0Yy5is213QayfC1PXPRjolA6MuNm2IycxXNWohEdKJYGPk9wmQZ7
 6YP04DGToIu4oZvzYgrhgOQqj//8c1V/7wWsBaVBk1esKH5QnoAfcKzRKcC7zw==
X-Gm-Gg: ASbGncvhqjj3MSPnqI3ZI8CsFdhouV0w7F6VaeFngzdygKs+GzLTYrhY9NqOs2NrSAq
 LCvNWCZHfwqKCCyLqqsyFzvRsrov4KIt+ks5cOc8HZGUyltaSjH1xN5ditv1tkXplMUMCE19u0r
 6ylEYUT7tkWpo/PUER/5dVsPKUNzDpAQhHpUSiTw2+b0j9MHNA9q/uUIxH+3Ab9nY8MBtK9hIm9
 3uMb7a7O53BOqaftmreG3IbwOOyHmt8RvBMTMc/XkjG3VXYHMVzszflcFHmhfUK+BSYq6lBWKy2
 nvaDa0zeBmOxx+/9A4Zjjf15yck1To1zjGfBx+b2QBoydpRFcbWtQ3fppmGYMICwSAmkFSZRT1f
 Z1l4W0XQrJkNFJ1Gr0qd7xYTGIXjN+Nho5SegIETxMafhpD990t7qe9YpHPU13TxPBjVgodSETp
 GBj+t+yBSIKLOx/LpxudBKbc0Riw==
X-Google-Smtp-Source: AGHT+IEPa81xiiVeplLoAzaz/ivD2v54EWu3PgfqNXt6qzPOvky4/nb6bFdpe+K2/DsVF2/C8TRzGw==
X-Received: by 2002:a05:6000:2203:b0:3c9:9b3b:53c9 with SMTP id
 ffacd0b85a97d-3c99b3b586fmr3510291f8f.44.1756158999030; 
 Mon, 25 Aug 2025 14:56:39 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57499143sm121827575e9.26.2025.08.25.14.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:56:38 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 4/4] drm/amd/display: Don't use non-registered VUPDATE on DCE
 6 (v2)
Date: Mon, 25 Aug 2025 23:56:31 +0200
Message-ID: <20250825215631.628949-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825215631.628949-1-timur.kristof@gmail.com>
References: <20250825215631.628949-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The VUPDATE interrupt isn't registered on DCE 6, so don't try
to use that.

This fixes a page flip timeout after sleep/resume on DCE 6.

v2:
Fix rebase conflict with latest amd-staging-drm-next.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++-------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++++-----
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 80a221b7b701..56b19d397874 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3036,14 +3036,20 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
 
-			if (enable) {
-				if (amdgpu_dm_crtc_vrr_active(to_dm_crtc_state(acrtc->base.state)))
-					rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true);
-			} else
-				rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false);
-
-			if (rc)
-				drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n", enable ? "en" : "dis");
+			if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
+				if (enable) {
+					if (amdgpu_dm_crtc_vrr_active(
+							to_dm_crtc_state(acrtc->base.state)))
+						rc = amdgpu_dm_crtc_set_vupdate_irq(
+							&acrtc->base, true);
+				} else
+					rc = amdgpu_dm_crtc_set_vupdate_irq(
+							&acrtc->base, false);
+
+				if (rc)
+					drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n",
+						enable ? "en" : "dis");
+			}
 
 			irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
 			/* During gpu-reset we disable and then enable vblank irq, so
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 45feb404b097..466dccb355d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -317,13 +317,17 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 			dc->config.disable_ips != DMUB_IPS_DISABLE_ALL &&
 			sr_supported && vblank->config.disable_immediate)
 			drm_crtc_vblank_restore(crtc);
+	}
 
-		/* vblank irq on -> Only need vupdate irq in vrr mode */
-		if (amdgpu_dm_crtc_vrr_active(acrtc_state))
-			rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
-	} else {
-		/* vblank irq off -> vupdate irq off */
-		rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
+	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
+		if (enable) {
+			/* vblank irq on -> Only need vupdate irq in vrr mode */
+			if (amdgpu_dm_crtc_vrr_active(acrtc_state))
+				rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
+		} else {
+			/* vblank irq off -> vupdate irq off */
+			rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
+		}
 	}
 
 	if (rc)
-- 
2.50.1

