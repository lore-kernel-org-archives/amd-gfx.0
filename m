Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453DBF3D603
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8953710E341;
	Sun, 29 Mar 2026 09:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nEkbLgP0";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FB310E0C2
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 04:40:24 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-38a2f196cbaso20883321fa.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 21:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774759223; x=1775364023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfxKOQy6FvJNNu8OfNtSYo3Uuobrp4S+heAsvLGL+ac=;
 b=nEkbLgP0NI6v76ZH5K6AzBOe5r+yBNFg+a3j369LPvUAdaBnmFz/jFSngVg1yLtWPA
 1yOXV/BcKsR94tyYBKVvlWVdPp5lA15y0F+N20HNfhoW8vzU0GhODtd9fbD+Q+0wS9rj
 +nw3A/uvCZf7ZdhEoZGOLQYw4XDi9ny8hYTLSVmCyOQR7HWRi5pUydTtO7B8Txg+YNb/
 jQwRiDaXdMrdondMpqsbLVOHxbmPvFjgYOYqFG9xL2xtv8aX3oaoEY5FmC8ZfMCOdc6i
 SFXwb9/sCsxR6bW2ZJVT5Mc5Gu62tV542foQuH/+aUGNkSfuXUHLuifvgvwBvRpgmX1f
 0pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774759223; x=1775364023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lfxKOQy6FvJNNu8OfNtSYo3Uuobrp4S+heAsvLGL+ac=;
 b=jzcDoZLtb13cH8eJCtfMH8pbl9byFhKHdoExgPOybPxAfs1gjZVmbgFLumbeatk07j
 Px5FUYoxLFe0mhOE8PYpmyk6+4PDN8vR5LqfkEG2Kb5oVifUV6OYlidNGCwEUPF2OOnK
 N03AUlJyUDazVOIhRPpWtEVD6U0GInjti4n4NA2Me+emuQimdW93aY4QrA2Vud9P5LbB
 1AEEDcqA/I/UFYb4NbQSMA24E35HPsqMGDlb/n7ED9xDRuzyNYzg7bWyJt4RigNimuXH
 gairl1GpXXL8DMyIO40flcnMfDWYHR0nnPsIn2B7Uqv/mcQIoN/vakFMfVQ4zw5yIqFO
 VKpw==
X-Gm-Message-State: AOJu0YzknDqsTkVRVElHlgpqfeEi+C4wUzN61aOm9DblDb2FD2XOl2oU
 VleaILwh6gaTJzqMuSqX5ALkImSwMxAYitftXRQGro0w4yQcVrdQYPSOTHLzy/w=
X-Gm-Gg: ATEYQzzS16oM8zmhaMzjM1lHqUdq/MHUIoDQQ4f3u+s9gv32qO4RkqFI/dE6YZ7p34b
 nT4rRR8oMCv43zikgjoFPEU9OBkubXFSq2GxMuyrY4WSuNMUw98e92JuG17UrAETzxqG0xui4jQ
 ux+vPN/8AOtcgraK8rFcE5/ZXJf6Lv+zHjRhSisgtXN5GCCEOuQALHD10U93Yfm8lPH5hPOnIvW
 U56kzfHvG+LMPL1uOm4vVsERKTatXMDk5o5YmlkbfhidgDig2xc2ZZXs+jIHfR2cUTPbHKw33Uj
 UnoSnbTi5rGFNGmpjjadLN+K5KtqdmInAxVljf6ty6OQltcmDXNpqGrBnO/K5g7RvtelldTNM7b
 VOdx1lgXUUlZ1JCtnAeBaCxAEPf4Bth6WP6rKj1u6K8lSDJnrkx/Q5a4agOwH1fd5loYrrKNxqc
 xv6oqt27nKjkeEaD4w+s7U8ettDfc=
X-Received: by 2002:a05:6512:8006:20b0:5a2:abe6:7bcd with SMTP id
 2adb3069b0e04-5a2abe67d29mr1866036e87.19.1774759222537; 
 Sat, 28 Mar 2026 21:40:22 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 21:40:22 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, Sbenazar <voroninan95ton@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 2/4] drm/amd/display: add replay-specific timestamp for
 re-enable guard
Date: Sun, 29 Mar 2026 07:40:06 +0300
Message-ID: <20260329044014.30276-3-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
 <20260329044014.30276-1-voroninan95ton@gmail.com>
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

amdgpu_dm_enable_self_refresh() uses psr_dirty_rects_change_timestamp_ns
as a 500ms guard to prevent premature re-enabling of self-refresh
features. However, this timestamp is only updated in the PSR-SU dirty
rects path. For Panel Replay, it is never updated, so the guard always
passes — the 500ms delay is ineffective.

Add a dedicated replay_disabled_timestamp_ns field to struct
replay_settings. Set it when Replay is disabled in commit_planes, and
check it in the inner Replay re-enable condition independently of the
PSR-SU timestamp.

The outer if-condition still uses the PSR-SU timestamp, which is always
stale (and therefore passes) on Replay links since PSR-SU and Replay
are mutually exclusive per-link. The new inner check provides the actual
500ms guard for Replay re-enable.

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1208,6 +1208,8 @@ struct replay_settings {
 	uint32_t replay_desync_error_fail_count;
 	/* The frame skip number dal send to DMUB */
 	uint16_t frame_skip_number;
+	/* Timestamp of when replay was last disabled, for re-enable delay */
+	unsigned long long replay_disabled_timestamp_ns;
 };

 #endif /* DC_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9887,7 +9887,8 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 		    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
-			if (pr->replay_feature_enabled && !pr->replay_allow_active)
+			if (pr->replay_feature_enabled && !pr->replay_allow_active &&
+			    (current_ts - pr->replay_disabled_timestamp_ns) > 500000000)
 				amdgpu_dm_replay_enable(acrtc_state->stream, true);
 			if (psr->psr_version == DC_PSR_VERSION_SU_1 &&
@@ -10227,8 +10229,16 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		mutex_lock(&dm->dc_lock);
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) || vrr_active) {
-			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
+			if (acrtc_state->stream->link->replay_settings.replay_allow_active) {
 				amdgpu_dm_replay_disable(acrtc_state->stream);
+				/*
+				 * Record when replay was disabled so the 500ms
+				 * re-enable guard in amdgpu_dm_enable_self_refresh()
+				 * and vblank_control_worker works correctly.
+				 */
+				acrtc_state->stream->link->replay_settings.replay_disabled_timestamp_ns =
+					ktime_get_ns();
+			}
 			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(acrtc_state->stream, true);
 		}
--
2.48.1

