Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCD3F3D5FE
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C79010E347;
	Sun, 29 Mar 2026 09:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UqKG1dTM";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC61510E087
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 03:58:38 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a12c19affeso5752910e87.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774756717; x=1775361517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tCXEdj2YgaEL32qjVel/tUPs3C0C+6eC3HnQoDVSqc=;
 b=UqKG1dTMLTfs+1UzN/nt286mETbedgk95VGROF85XHwCVbhSceZhDOAU2HkVcvPziV
 +Vy3hrEzFlRnB4zRLGffss1wGjS73FyWEJbeABKAqNjZBxxga7tVNXPqbd0njLBeKwY1
 hytdTQkrkjuaRAc5AOEPmJGHag17NrzBXOCq7eWUyjueEmRelQix85mJizjLJylAC/Ci
 MML4tH/chL9qXZNiB93VNy3IUVZUjtjlUYUgmRdmQHwNyOLwT8WvNhI1rUvMiKUw1IJP
 95gY9IlYbuqZ4oRS2nsA5k4TH+AUOfvFPtuLgk6Hz5jRKT5lXfzsURuTu5hffh+r8N22
 lXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774756717; x=1775361517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tCXEdj2YgaEL32qjVel/tUPs3C0C+6eC3HnQoDVSqc=;
 b=snBRdcBaK6ru0ihL/zoL4wD9IujMwTl61gd4G5w6VpqaAcjzMYET7IKHhORAiOtb0H
 07CR6GbBkZOC+aREzWvH7jz9cgAbsnCKzUr4aKDYGgKSdroy8FED/cQMD4OE7a0NuO7/
 ylVDzIoPbQwP4EebOu/aFWxnQLFqmAPx2V+i8cWb1cZIjfPWu53DIkSDcsh5WUVbEwbE
 sDSeZEIaQppIoU7KrlFqB/qJA9+f61JfVOB7eALD1ae6KV0rFEj6JEf0pAeLBCzK1bO+
 tRzcicWnDaRlVXOTCCWfnKBHdRrFVpr21LNoaihm9ctZtYmrxJ9GifxiZp2g2UZ2fL7n
 vmXg==
X-Gm-Message-State: AOJu0YxSTsaDgjL3UBW3/v+LrMjHE0wUmY1hGWlHrkeRzAASt6bm9cCZ
 c5eDDSO5IRFpXCwoMq3zrnDW8FXwvyolomV/rp/mWjgJaRVc1IaktOUb7A1dVX4mzA==
X-Gm-Gg: ATEYQzyqKJiddVC/v2+z1z2p26FqsUxjxBgliP4e6pqW4tJfRPCehWhkN933+KH/dzU
 UdHMqDNK5Nm9/xzOBv97uwUAW2qwAvP1yY7mz0Fj9VNSYsGHyLufG1fj2OfYoOZ+I8rXp7B/9+B
 kpaydDefkK1qize6TFV2dYXKdAcNDua/16mVQGG9NXN+wBxzp4xSLroxi1MhULeCOHjq1vF2vMm
 r0MK7LvrKNqTwr5a5nk34y1t9tkn2WNCXN+YirDfKS9P2wAJJjJBvoQ3JxSDebMYijJNxRgZ3iw
 j4C6+lVV4EiCD7hi8yCtyjzJm5bmIYtSUvSxXdayhmBkcujxE8b8vkkX98G45oYMcPLfNE3DqbR
 BSqTrNhCJ9erRzauLon2BlFXyo3taejE8xpTFmgSF+m6v7NmhSJI4GIXYG0Hp3WF2WgdiS7UlOW
 Lj4uxRU/Zn/Xyvm2zx0Dqn0F2BW4E=
X-Received: by 2002:a05:6512:a85:b0:5a2:7cde:3438 with SMTP id
 2adb3069b0e04-5a2a508cfddmr4020108e87.22.1774756715989; 
 Sat, 28 Mar 2026 20:58:35 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f41f4sm806136e87.13.2026.03.28.20.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 20:58:35 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, alex.deucher@amd.com, tom.chung@amd.com,
 Sbenazar <voroninan95ton@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 2/3] drm/amd/display: fix Panel Replay using stale PSR
 timestamp for re-enable guard
Date: Sun, 29 Mar 2026 06:58:28 +0300
Message-ID: <20260329035830.21953-3-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
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

amdgpu_dm_enable_self_refresh() uses psr_dirty_rects_change_timestamp_ns
as a 500ms guard to prevent premature re-enabling of self-refresh
features after screen updates. However, this timestamp is only updated
in the PSR-SU dirty rects path (when psr_version >= DC_PSR_VERSION_SU_1
and dirty_rects_changed). For Panel Replay, this timestamp is never
updated, so the guard check:

    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000

always evaluates to true (since the timestamp is 0 or stale), rendering
the 500ms delay ineffective for Panel Replay.

Fix this by updating the timestamp when Panel Replay is disabled during
non-fast updates. This ensures the 500ms guard correctly prevents
re-enabling Replay during animations that generate a mix of full and
fast commits (e.g., GNOME workspace switch animations).

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10225,8 +10225,14 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		mutex_lock(&dm->dc_lock);
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) || vrr_active) {
-			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
+			if (acrtc_state->stream->link->replay_settings.replay_allow_active) {
 				amdgpu_dm_replay_disable(acrtc_state->stream);
+				/*
+				 * Update timestamp so the 500ms re-enable guard in
+				 * amdgpu_dm_enable_self_refresh() works for Replay too.
+				 */
+				acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns = ktime_get_ns();
+			}
 			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(acrtc_state->stream, true);
 		}
--
2.48.1

