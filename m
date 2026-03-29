Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B52CF3D604
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB1910E3DE;
	Sun, 29 Mar 2026 09:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nxqNex+R";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7896A10E087
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 03:58:36 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a10d130b37so3254831e87.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 20:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774756714; x=1775361514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZjD1xkwL8SGkzTUDkV4tP8IGubH08Om/grBGg4rNaE=;
 b=nxqNex+RZ1PpmbUGyf4IiH9NDwqq7afn2dlzG2Iktoo4gukw3hMic198X8kpZTCx6x
 wPfSg3SvcSvLbblvldh2fNqMisGCMM9ZuGCLzUhUNlDj02g/9WLzFudFnS8d7o5zVrOx
 G8583d9DUuZ/Kvb6BD6u/L8hxSe41U3j1TlJbxpJ6cCu4/sEJDJz9xi/X+qU4mOwQpIS
 aNLY6U1lJ4J9glFKgKVPJlRdEfTvsE/eHgonIwwc6cMzzf++cvviZS/3MZArOSzTi1GV
 BGXamSRcpMIoOMVkKsba8IHieTZ4j/2iFJT6HHA4WU3qbqFllK8KcoLZMoFXJyoErzTL
 lYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774756714; x=1775361514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ZjD1xkwL8SGkzTUDkV4tP8IGubH08Om/grBGg4rNaE=;
 b=Ec4cF7CLthlIBMyNDMwSvG7gUSSE0Fua+5JAc05dM4r4k0962t/zxYzlwe9oEPRRYD
 NZlS/0W1W31bklHDO1xVsqlGVZztBp/tCEh9Tw691CZgPbxAOV5nimeLFS0xqNsSSACd
 xAHWTya6nizQ7UE9cK3T8pSKBb2XOLRX1eoxrWoW2wNMVdbiIoZQpGVLR+47Hr6K1dlO
 ZQU+hbBVonzKaOzKNHH5kSpNAGZIiBJoescy180lThLGDuQpY2lWw0EYhXeFthi0D67l
 QJWuRKpNWI1379+ZnHcQlDBJ6sRtLtrdcpcnR9eNckr3CnQwQfBRUDT1aPYDGyy3CoEd
 aHRA==
X-Gm-Message-State: AOJu0YzO6/6qyB1DZYyTdbTB40EJsF6P0NJo+QRT5YVTueZ/A11uFMWx
 sBavOJWXSObza4ZCr7BBgU3KOt5CPdbFeIWIEOgXHZzcnAftmgRzfVn5bhrxate4SQ==
X-Gm-Gg: ATEYQzxKrhA0Yjpk6o6tx/B8VzJ64vnlMCqd58HbiEV3/8d6eNItREnPuIt8NCLL9v9
 Lq5Ar+g9YAWT6+gCaq5yeTqK0biSvUUA8kYVBxIRlQvP5Cj/+ZVH99RJXApYKKdlb/MusTc6uoV
 nju8bT7UgO/wtjI+XPm7yZXYIB2+RyozuZ2ClUfwZ13Hr+bWCcwk0b0nuXBOKTEYrRw8zqYzoA8
 IWh0z0mb1TirYYAt+ErOGWZwCtU32U9bWWZI1nD13Pp3b11F72xMs1RRK20vuTaxZEFgbJUGEMo
 QQ6t1HXdQhzGCSBoO0RTUtfO3MsEQRiFH5T7SO71rQeBpOTPHGUVnc2bKNkNcn5/w8z+KkC0IdF
 mF53rr/o6xtBt1tiQKFFOoOwfk803GLHiGKtcY54SEz/OxqCqHzmyOPuFKLqMqyPOyc6SqeP8PR
 HerYXlF3Ym2ek7xsGSIYbsXM50S80=
X-Received: by 2002:a05:6512:10cf:b0:5a1:56e4:1c80 with SMTP id
 2adb3069b0e04-5a2a504a61fmr4593860e87.4.1774756714319; 
 Sat, 28 Mar 2026 20:58:34 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f41f4sm806136e87.13.2026.03.28.20.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 20:58:34 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, alex.deucher@amd.com, tom.chung@amd.com,
 Sbenazar <voroninan95ton@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 1/3] drm/amd/display: reset sr_skip_count on non-fast updates
Date: Sun, 29 Mar 2026 06:58:27 +0300
Message-ID: <20260329035830.21953-2-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:57:18 +0000
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

sr_skip_count is initialized to AMDGPU_DM_PSR_ENTRY_DELAY (5) at stream
creation time but is never reset when a non-fast (MEDIUM/FULL) update
occurs. After the first 5 fast commits following stream creation, the
counter permanently stays at 0.

This means that after any full-frame update that disables Panel Replay
(e.g., a workspace switch), the very next fast update will set
allow_sr_entry = true (because !0 == true), allowing Panel Replay to be
re-enabled immediately — potentially in the middle of an ongoing
animation.

Fix this by resetting sr_skip_count to AMDGPU_DM_PSR_ENTRY_DELAY
whenever a non-fast update occurs, ensuring that at least 5 fast commits
must happen before self-refresh features are re-enabled.

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9854,6 +9854,12 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);

 	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+		/*
+		 * Reset skip count after non-fast updates to prevent
+		 * self-refresh from being re-enabled too soon during
+		 * ongoing animations (e.g., workspace switch).
+		 */
+		aconn->sr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 		if (pr->config.replay_supported && !pr->replay_feature_enabled)
 			amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
 		else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
--
2.48.1

