Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D19F3D5FF
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6ED710E314;
	Sun, 29 Mar 2026 09:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jumdBk95";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF99410E0C2
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 04:40:26 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5a2a70bb69eso3341541e87.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 21:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774759225; x=1775364025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reR9BnQPkWjZy1ztn6tX7OBCu0iHKhMxp0dC8tGeiNU=;
 b=jumdBk95ipOYr1tR2n4dq+3v6GTkmBbjfAzEjoYGKzC4fCuqLa5nK0zDg+rIb+J34+
 /7uMpRWBL9PuVbT+Gej25I9UtbC5Lo2CdVsBIGPp403wQnlAgWszP7Rlr+1gkSnj38/K
 P3n5TPv5sGiGEKxcCLysMAPNCgxRDMewg5NvPLNGUYTLMYblvdE2lfxOvcWP2K/YPXOM
 zmpAEK/nZxCTDOaPVeEt3vNb2AdgO/A3o18SzYeBHeaxdQNuCbMOFi8h5omB8ydVQzOR
 z1H4+ZfVM5wtimvFbQOftxSukK0qrB/YzeoF/+K8EgEsnVN5WzouLIncHup6L30v9j/l
 UjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774759225; x=1775364025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=reR9BnQPkWjZy1ztn6tX7OBCu0iHKhMxp0dC8tGeiNU=;
 b=ipsKVsJFr5jOxqs/Srv3cDBAGZkZLc7FH6BSjI8OnLmnQVcJ8icFDtk4bqWsSCakgq
 vjkUW9ZCMjnu6wvDSzXso+nZ6+g/Kur/Nr3DHvKKpG+PLRGX/chH/fUa1Nh4D+maRtif
 pI9u1pqjXN6o/Ycqnt4/64K/VGnsqVqEIDFJZKUnnVXWnqhvA4fqdUmozHaFE5JIzTPH
 ivToG/gB1GYAwLZr9OvzOdo8LzdhuoCzvidEylH8eR95pgD592Ko4rHs/N3sJ+fRp1q9
 hP3xh6tVNYVW9TD2HInOri7jwUlN7O6C6/lTcSVAu/dto2lvOpIB/G5N9WZcqUIKlLQL
 q/hA==
X-Gm-Message-State: AOJu0Yycf1of5frlwahFtFbpTbTBmR6VxWqpovP33u2XqOI+KPLKu0U+
 kXian2eRYAez/AGttrYLthqJLieqy8m7YCs9vifhLgHQo4N1q1wGkfP8E1VETIY=
X-Gm-Gg: ATEYQzykS79OfTGGzABBgWPoSOyQuV2aE4iJLBvH4ywpb9gO4wTpiJXzy1yuLu7YE6V
 6+mUL7h8gIqIA3tV84RpsdciZR9L4yx+GF+MoRSzR+w8G2BFxNEforj05ZULhWonTJKO4wLCdPl
 e97J/J7TAIkyCfD5jTMdKDMcHSB1mlZimn1pLibRniOnf3OoXhuO2CpIzAvYtGd9V6hgKH7YYG+
 91Pa9/Qoddh2VMCD/wSp97LHNtKH6dJ51J2hivIZnh0O84e3bdiJ5z3E6pcgtaGXMuYv42+V++o
 fGWs43/GhyPmYFVUS9KvPyWax1k0GEmKADk7bATWoXuwt2qCYgHgJzzC2fADH72JpSpewwY/yjP
 8iS67WVO3ianDO2lG1xtuO4Mnf97d8hnga4Oo2j5Spxwy1N3KR5DffQ8rZI0t7ELVafkDfwKO8W
 OIOMaol2OBoFWxMD68IkXiqMrC7FCuUHJydEA1hA==
X-Received: by 2002:a05:6512:118e:b0:5a1:53d1:d741 with SMTP id
 2adb3069b0e04-5a2ab7e8ddfmr2791606e87.4.1774759224666; 
 Sat, 28 Mar 2026 21:40:24 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 21:40:24 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, Sbenazar <voroninan95ton@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 4/4] drm/amd/display: add timestamp guard to
 vblank_control_worker for Replay
Date: Sun, 29 Mar 2026 07:40:08 +0300
Message-ID: <20260329044014.30276-5-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
 <20260329044014.30276-1-voroninan95ton@gmail.com>
MIME-Version: 1.0
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

amdgpu_dm_crtc_set_panel_sr_feature() in the vblank_control_worker path
can re-enable Panel Replay as soon as vblank is disabled and
allow_sr_entry is true. Unlike amdgpu_dm_enable_self_refresh() in the
commit_planes path, there is no 500ms timestamp guard here to prevent
premature re-activation during ongoing animations.

This is a problem because the vblank worker runs asynchronously: a
compositor may disable vblank events while a workspace animation is still
producing commits, causing Replay to be re-enabled mid-animation and
triggering the DMCUB firmware artifacts on affected hardware.

Fix this by adding a 500ms guard using replay_disabled_timestamp_ns
(introduced in patch 2) before re-enabling Replay in the vblank worker
path. This ensures both re-enable paths have consistent timing
protection.

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -142,6 +142,14 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 	if (link->replay_settings.replay_feature_enabled && !vrr_active &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
+		/*
+		 * Enforce 500ms delay after replay was last disabled to prevent
+		 * re-enabling during ongoing animations (e.g., workspace switch).
+		 * Mirrors the guard in amdgpu_dm_enable_self_refresh().
+		 */
+		if ((ktime_get_ns() - link->replay_settings.replay_disabled_timestamp_ns)
+		    <= 500000000)
+			return;
 		amdgpu_dm_replay_enable(vblank_work->stream, true);
 	} else if (vblank_enabled) {
 		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
--
2.48.1

