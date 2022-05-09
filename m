Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59505C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 07:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF14A11232A;
	Mon,  9 May 2022 07:47:16 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D3311232B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 07:47:16 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id d6so15231929ede.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 May 2022 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gzm0Ej6I8fTzRacBvj7ZcpG41Y2iUYizSC4ddrpXieo=;
 b=SnTmuJJ7punHWdi4X+uTJnj0P6t+3ZMThHcpeKgqZvTigVhAbsNMXs7IzkCZz4IJzN
 B4cNWvlPlJmii6txGDLAx2nuDBkOr+1K9Wx15L2pXm2I8RdW3XmcqysaYMyz1zCSk9WM
 Iw8WvEMlmxqqvjjEP4IcOyYnavlf4tMHeGGSrp+LTXQKExoi2Zns8XxmR0VDkGODl1Br
 97pBGciLUZGBckutmlqLTJ4W31ozjv8tUyXMQJqyT59wpnchreHNs3hXwuIkE9FZV2t6
 nrRfd3WWlfDfMN4Etd+Dka7eaKUt/MKQMFrs5g+Nm4zjSUKWINSymJMZGm3AP8LUMPsX
 0U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gzm0Ej6I8fTzRacBvj7ZcpG41Y2iUYizSC4ddrpXieo=;
 b=JmIBYYAhOLwfcuLzJm/FQe8XhRUMSYew++N33M2C9/oYBNkLi99FmXSlnobl96Bg53
 zdTjmgKxH7DywR6FsBVAuhUIsP9zWnSz9sa0r+Q+Z+ub1RUF3dlYx47ku9FJ3GKk2930
 H3JUcGrjBnIlVbGQZMK+hrGs9nNk1zgqTySKMptv/2TvUAnOUzNiYVRzPiMMF/xSdF33
 S4C/DfzNbWPkbiQBmwsIDLK8zW6J6NiO9dQZZcav8NVntWLzDusu1OtiSomKUl2pYSje
 NKn9LRy/joY5+3MIJjDb2ZmaIlEDCwz8zxK1YcMM1aNaRcQAVQXpY40zzYQPAOt0KxY3
 A5kA==
X-Gm-Message-State: AOAM5332x037sh8AbpyNBW3jkqyIwRqrAKt7fTFuTSEZ7g3X2zwDuZlH
 qv+ZYzeK/JN0GM9Wssu4jZEp6AjE6s4=
X-Google-Smtp-Source: ABdhPJxGUT2vVHRnJa8hO2Fto/ubO30wRsgSx2v8xsx/EHH1b6J5eZzLv3ioty/xpUX+aUFqKhsB/g==
X-Received: by 2002:a05:6402:b2e:b0:425:d3f7:4c1a with SMTP id
 bo14-20020a0564020b2e00b00425d3f74c1amr15538803edb.366.1652082434649; 
 Mon, 09 May 2022 00:47:14 -0700 (PDT)
Received: from able.fritz.box (p57b0b3fd.dip0.t-ipconnect.de. [87.176.179.253])
 by smtp.gmail.com with ESMTPSA id
 hv7-20020a17090760c700b006f3ef214e15sm4788398ejc.123.2022.05.09.00.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 00:47:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: switch DM to atomic fence helpers v2
Date: Mon,  9 May 2022 09:47:12 +0200
Message-Id: <20220509074712.163899-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Jude Shih <shenshih@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This gives us the standard atomic implicit and explicit fencing rules.

v2: move the wait to amdgpu_dm_atomic_commit_tail

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Jude Shih <shenshih@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a6880dd9c0bb..f9ce8cb45e6d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -83,6 +83,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
+#include <drm/drm_gem_atomic_helper.h>
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
@@ -7627,6 +7628,10 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 		goto error_unpin;
 	}
 
+	r = drm_gem_plane_helper_prepare_fb(plane, new_state);
+	if (unlikely(r != 0))
+		goto error_unpin;
+
 	amdgpu_bo_unreserve(rbo);
 
 	afb->address = amdgpu_bo_gpu_offset(rbo);
@@ -9160,7 +9165,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	struct dm_crtc_state *dm_old_crtc_state =
 			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
 	int planes_count = 0, vpos, hpos;
-	long r;
 	unsigned long flags;
 	struct amdgpu_bo *abo;
 	uint32_t target_vblank, last_flip_vblank;
@@ -9235,18 +9239,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		}
 
 		abo = gem_to_amdgpu_bo(fb->obj[0]);
-
-		/*
-		 * Wait for all fences on this FB. Do limited wait to avoid
-		 * deadlock during GPU reset when this fence will not signal
-		 * but we hold reservation lock for the BO.
-		 */
-		r = dma_resv_wait_timeout(abo->tbo.base.resv,
-					  DMA_RESV_USAGE_WRITE, false,
-					  msecs_to_jiffies(5000));
-		if (unlikely(r <= 0))
-			DRM_ERROR("Waiting for fences timed out!");
-
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state,
 			afb->tiling_flags,
@@ -9591,9 +9583,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	int crtc_disable_count = 0;
 	bool mode_set_reset_required = false;
+	int r;
 
 	trace_amdgpu_dm_atomic_commit_tail_begin(state);
 
+	r = drm_atomic_helper_wait_for_fences(dev, state, false);
+	if (unlikely(r))
+		DRM_ERROR("Waiting for fences timed out!");
+
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
 	dm_state = dm_atomic_get_new_state(state);
-- 
2.25.1

