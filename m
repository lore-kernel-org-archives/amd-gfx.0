Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D75CCF2C4
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Oct 2026 22:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A19310E733;
	Sun, 18 Oct 2026 22:17:40 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7AA10E0AD
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Oct 2026 22:17:33 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso10517595e9.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Oct 2026 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792361852; x=1792966652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nAF9oPetXs/1/u0SmZXy5Zxa0XcvT5gTByOb4pwMeyU=;
 b=smOCMKQDuT9GcEFxymY7CScgRobn9xjBp5CO4u5+LedLxqe7F30zB0t2E3p0nwtg6T
 VZUxFb+30ERgvtz33XMt2S1tD8PGR0KtBccDZ0ELDpIqWrDfnf1DfnYNGlDy8aWaNI2j
 uLtmwuV7Si8l9k8giC6I5smJqTnUlxgCSlWO5g3b9k99wjVx/JiNrFavlI4QTqtPCCqr
 HbOMAOq5t9Cde7HCOnNumU86Q2Fr0W/8sZ1elMJnB/M60Qepi0iIrnyuN6WEETqMAiOu
 qyy5nEh07/uwWKn0dwSp7qIbBVd4zO0mm0yz6xg7XCcycjYNJXDrHTK2aATPd3zKoKK0
 YrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792361852; x=1792966652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nAF9oPetXs/1/u0SmZXy5Zxa0XcvT5gTByOb4pwMeyU=;
 b=v5aciJOUGsRLjiAiJxGm/AWWi5g0YcI6Jw/kYOSsRdzBCz7bcPUuQO3BLf8nyQJWQu
 NJeuUdioTpy5Bxqzz97Ylm9rymvkDy11Qo2O9qhNg8nWrQiIdk0MUa1Q5dRTxR116WI+
 ICsSyYY+9hNkuoLr6dFqSArhhJWbDsMTn7+O7YWEVdfRYNXUhyLsCJ10V+fqx5rHRCBy
 xxwONzXchTSLNLs49nRRFMgPdujYCiJLLlkiOgtwv/1O2KLGWW5tntjv6rpsyXb8qEHj
 qkNULyKM0KgabGIylta5NQebSYm8B1+8ZBEBPPrU9pXMDDun+A6vWDdR1KEhA1P90EFX
 lKIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8alGQScsssDlKp++Wm8qzMNpKBWoEB9+xFBVqII7oHmlYvtj9MNvWEx+sqRUZC/GbsKw8AtKn@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLjXCQQDq4gQ7HodTFU+EFhG2TZ2/LmC4fc/Y0yzVxl7nuw9wst
 CAbl8TN8vZxavijGRuZSdc6j9ymsZjJFzYM5P4ESVpCCFXbDeDlAFktz5kLOBeE47JParaWz
X-Gm-Gg: AYBFou1RmZ1ecGIJs/HuL59dCjz1NI6ugCreCTnG8AIcWNzUrJESSIS2tl1eeWnH4If
 Cl5308mvEbpBTlOa7kI6vUD/LsQsKWcMEiXUw96zf9umeKKC0875CGQEJdFd2N7Xec7zWJ4vGI/
 +oAhnW2xiL8BIfJbhBHGWF8H8dwsrmuwB9yP/IALVdBkXo9jqHiUdn/jl/7+Rw3ikeB4Y9tu37x
 Lx1p2qQch1lbjn3mAE9musHsKOBvlA0W2nMim36g2VO+PIGSbkFynbX0Sa4mtnwFb+FmYadVfaW
 campXOqlgQaS9FjpUe/25devK3ySHid2NOnqd5UWnyfbejuBS5B/IDqsNknYICbF8NrRzcZfboZ
 MfY1aWMR+uLbCi0eQAk76v1ZMoZhQZuNUngRBP2o0eDeVFE3vwQBSo92K6Fr9czgoQbfn5OWVHo
 iegObWrU39hP765c1v8gpSD4Z+9pYtSyhElEe6oSqix9173uHfcWzCFpaNmz1gsbpm2EudXvG/y
 0E91Hd4Nhb0EoBgtMvBwcQIgMX9WKvnWULFU0Lk8coCbYrNy95hY0eGVtd1eYi3xgcxtw==
X-Received: by 2002:a05:600c:8219:b0:4a1:85d9:13be with SMTP id
 5b1f17b1804b1-4a1d76031bfmr129943605e9.20.1792361851851; 
 Sun, 18 Oct 2026 15:17:31 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d85f92d9sm155398425e9.4.2026.10.18.15.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 15:17:31 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: set allow_freesync before validating a new
 stream
Date: Mon, 19 Oct 2026 03:17:26 +0500
Message-ID: <20261018221726.27259-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
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

After resume from S3, DC enables SubVP on a single FreeSync display at
a high refresh rate, although dcn32_allow_subvp_high_refresh_rate() is
meant to keep SubVP off that configuration ("For single display cases,
freesync must be disabled").  On an RX 7900 XTX driving a FreeSync TV
at 3840x2160@120, amdgpu_dm_capabilities reports sub-viewport disabled
after boot and enabled after "rtcwake -m mem", and the memory clock
starts switching.  It stays that way until a later commit re-validates
the state; a CRTC gamma change (toggling Night Light) turns SubVP off
again.

The policy reads dc_stream_state::allow_freesync while the new state
is validated, but amdgpu_dm sets that field only in
amdgpu_dm_update_freesync_state_on_stream(), on the first flip after
the commit.  A stream created by a modeset is therefore validated as
if FreeSync were off.  On resume, dm_destroy_cached_state() drops the
streams and forces a modeset, so the resumed state is validated
without FreeSync.

Set allow_freesync in amdgpu_dm_get_freesync_config_for_crtc(), which
atomic check calls for every active CRTC and which already writes
ignore_msa_timing_param to the stream.  It uses vrr_supported, the
condition the flip-time value is derived from.  With this change the
same TV keeps SubVP disabled across "rtcwake -m mem".

On this machine SubVP is also what exposes the single-frame scanout
corruption reported in the thread linked below, so the FreeSync
setting stopped working as a workaround after every suspend.

Fixes: 87f0c16e0eeb ("drm/amd/display: Enable SubVP for high refresh rate displays")
Link: https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 7e484adb4120..f26dd206dffa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -128,6 +128,14 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 					vrefresh >= aconnector->min_vfreq &&
 					vrefresh <= aconnector->max_vfreq;
 
+	/*
+	 * DC reads allow_freesync while validating the new state, for example
+	 * to keep SubVP off a single FreeSync display, but it is otherwise set
+	 * only on the first flip after the commit.  Set it here, so that a
+	 * stream created by this commit is not validated without it.
+	 */
+	new_crtc_state->stream->allow_freesync = new_crtc_state->vrr_supported;
+
 	if (new_crtc_state->vrr_supported) {
 		new_crtc_state->stream->ignore_msa_timing_param = true;
 		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
-- 
2.56.0

