Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322FFC87FD3
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Aug 2025 16:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48CE10E16B;
	Sat,  2 Aug 2025 16:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WCsYqj7u";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE74210E16B
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Aug 2025 16:06:09 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so3201957f8f.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Aug 2025 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754150768; x=1754755568; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zAZThbPUGQe8RdZq2V98JmB9W6AqDrcstZDvTgMxG0=;
 b=WCsYqj7uaEgbwijeSXKurQFPR1Xoe6u1dsC0QpuuNXObf2e3vsUOiN2KqL35O77M4H
 8SPYoC8gwK+nBa3TwJze5Up6bk1OwhydKBQgsYbTTEzNyxF+w3iUlfJber1EkFgLbjIT
 nbvy7/VlY49lAkH2rcpOV2hgdV55xr8tP1EQCBD2RGGJcOr6nJrMqn+13LaE4fbbubKj
 bXJ5EMxu1/H24L+wwuXoCb+V9H2frlwAfV4Lg7RI4WsoO+5gfoJajX9aptG56xjqpb8a
 ltjPHSoqcmmqGYf/Eu6iPX9Xd+IDnF5MPaATkXraVOSwrr/IVYNJEqxj7rlCfJfFBwyf
 JupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754150768; x=1754755568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zAZThbPUGQe8RdZq2V98JmB9W6AqDrcstZDvTgMxG0=;
 b=mrbjEs128v5DgWuugixaVegy/8K8w4OHwvy4F55gkiR0H8OBhzwipGo3m7G88P1UHr
 wcDUribAB74NqEgj/7tOc8xDHvQexRqp/265coodx0XYHs98n0dmIJv6IgaMJU2KRVbX
 xrUciDH7vBQOXl5pmanBbQmw5hf/eXPXg5qW6BgMuarJrVev3h4cPfQhkHK0Fl97yr4v
 Jaj5wJLnDUOd+sb1MGoT5raVfe/htjP7QPV7GcRkmGrD2XkQVdoOCwqwm7HHrhNzMxPu
 A3X+ygqYG0HIO2KJ4QseHAodCbXBacs7y+Xr8fnEt7oarxW9HPv6SiM+xW7fuP0N6m3S
 +Ysw==
X-Gm-Message-State: AOJu0YzTAv30cX/JX9hlVGLdkbokpAPDjVlMS9Lj7o5G2ZzbziUoVa/d
 6kit0grsdnJ+/cyRkfnEd+4jkJGD6bkvxpxGUY8TA3Smdllge2eXmc/pvYXAqQ==
X-Gm-Gg: ASbGncsiewogwQjH05UUbAALs3OQCaj4X7kOR84VxMIw3BQ7fe3yT4yZTQsCDqRfz+N
 OOsztgU3CwBYdOrnU2SWp8stUMtVlP9Tgo3Qrd61mn4MqzKhR98sDZ1gAjZZ3PJFZ4CAWeZoMO7
 8pV+CKZaMvTRm803HNZKfPN1HLJYxnGIq5BY/BbW6vE4cSsagLDkFiXHIK9XnJcYKat0Yt1WINE
 uw/PBLPMNFwQNwbg3zbFUcf3t9YH15cfl6vg+pqicd0h/6CTCf/eRO+qGfgnN/JMw1RCCvsSnPy
 9Ze3iLqHXQsZYsiwN6yHn4NKsj5NNNbQWvVe8r8h/xGZMWaR5w3jUrF3AXCcDtjkxknLIu/jUbI
 UTkjLGU4bkp2y3yP6uH7pRevAwRLCt9piz2ZkSBCZ01dLsZM/1gBlcdJNzIJLfES9dWs5YDwYsV
 yFaslfembs9k0mOAubHxQ=
X-Google-Smtp-Source: AGHT+IHJepswvFiBv0yzCa9xPhYS5wyrYOcNv4+MVOhTghl9TDROdNgITjxrbbY3FXq0ourIW8AGLg==
X-Received: by 2002:a05:6000:26cb:b0:3b7:90df:c53e with SMTP id
 ffacd0b85a97d-3b8d94ba720mr2494874f8f.28.1754150767821; 
 Sat, 02 Aug 2025 09:06:07 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfcc1sm151164245e9.17.2025.08.02.09.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 09:06:07 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amd/display: Don't use non-registered VUPDATE on DCE 6
Date: Sat,  2 Aug 2025 18:06:02 +0200
Message-ID: <20250802160602.12698-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802160602.12698-1-timur.kristof@gmail.com>
References: <20250802160602.12698-1-timur.kristof@gmail.com>
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

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++-------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 ++++++++------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 470f831a17f7..e8d2ba58cbfa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2981,14 +2981,20 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
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
index 2551823382f8..f2208e4224f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -298,13 +298,15 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
-	if (enable) {
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

