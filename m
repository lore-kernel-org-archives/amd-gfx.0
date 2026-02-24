Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C17F3C9AF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 16:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FFA10E5D0;
	Tue, 24 Feb 2026 16:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T2p+CVBM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB75010E5D0;
 Tue, 24 Feb 2026 16:10:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A1F66132E;
 Tue, 24 Feb 2026 16:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B97C116D0;
 Tue, 24 Feb 2026 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771949441;
 bh=W/3XgT2jA0Ue6kiN4I9CsTWScgxl4Ipnw+a29pJVzzk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=T2p+CVBMNtwcA3zMPFwdbAjbhGBwhGzKOr0mi/b70jWfWNfJsWHRdC55wZDPYY2Ee
 IcvHnZRFVwqx3/DX0zY7wp9lgBwFQgFU3JzBmxxiOT16esiIXT42kaq92qjYHcDwXI
 no+g8x7ilrhhEt0mWwd8ESK/PltOKLjJm4sPGwdzxKEn98tXULbEGI1EApGziBu3Ua
 n/5W9saJN4sVXafkgBHFx4xXGsJfCj0R/e2HptjdTXepeSjokPnHo1SryC5AMdvCKj
 mftDhYy/2lFIedsFiKSjyue3cpgYTAZN33pwqZ+1u4BrfeAb137W+p27TJUfyBB4A0
 T5GvaB1va+76g==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 24 Feb 2026 17:10:26 +0100
Subject: [PATCH v5 1/4] drm/amdgpu: Switch private_obj initialization to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260224-drm-private-obj-reset-v5-1-5a72f8ec9934@kernel.org>
References: <20260224-drm-private-obj-reset-v5-0-5a72f8ec9934@kernel.org>
In-Reply-To: <20260224-drm-private-obj-reset-v5-0-5a72f8ec9934@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546; i=mripard@kernel.org;
 h=from:subject:message-id; bh=W/3XgT2jA0Ue6kiN4I9CsTWScgxl4Ipnw+a29pJVzzk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJlzz1a+F7p5csJnTakzyW7CrCwK09bq2G81tQpP3H5t2
 eO1YaVxHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiM70Z691WcF3fnv+kwl3i
 On+y923ZkF2arFxTnvwMv8K9j8tz6eK/+W/Wmfz/zuI6jb1icUhBLmO9Z1LxtY3hQUcOrtzIPf0
 BRxr7w9ePTd4sVfqyPHqT1jr/XX1713fXLJ3Wunhjv6ChxbYDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The amdgpu driver relies on a drm_private_obj, that is initialized by
allocating and initializing a state, and then passing it to
drm_private_obj_init.

Since we're gradually moving away from that pattern to the more
established one relying on a atomic_create_state implementation, let's
migrate this instance to the new pattern.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 52 ++++++++++++-----------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a8e4e3ab5e40276b3c723297ca6520688079e0a7..98ed54afb02864342bb2c04782d05c5fb6e38672 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4912,18 +4912,41 @@ static void dm_atomic_destroy_state(struct drm_private_obj *obj,
 		dc_state_release(dm_state->context);
 
 	kfree(dm_state);
 }
 
+static struct drm_private_state *
+dm_atomic_create_state(struct drm_private_obj *obj)
+{
+	struct amdgpu_device *adev = drm_to_adev(obj->dev);
+	struct dm_atomic_state *dm_state;
+	struct dc_state *context;
+
+	dm_state = kzalloc_obj(*dm_state);
+	if (!dm_state)
+		return ERR_PTR(-ENOMEM);
+
+	context = dc_state_create_current_copy(adev->dm.dc);
+	if (!context) {
+		kfree(dm_state);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	__drm_atomic_helper_private_obj_create_state(obj, &dm_state->base);
+	dm_state->context = context;
+
+	return &dm_state->base;
+}
+
 static struct drm_private_state_funcs dm_atomic_state_funcs = {
+	.atomic_create_state = dm_atomic_create_state,
 	.atomic_duplicate_state = dm_atomic_duplicate_state,
 	.atomic_destroy_state = dm_atomic_destroy_state,
 };
 
 static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 {
-	struct dm_atomic_state *state;
 	int r;
 
 	adev->mode_info.mode_config_initialized = true;
 
 	adev_to_drm(adev)->mode_config.funcs = (void *)&amdgpu_dm_mode_funcs;
@@ -4939,46 +4962,27 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	else
 		adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 	/* indicates support for immediate flip */
 	adev_to_drm(adev)->mode_config.async_page_flip = true;
 
-	state = kzalloc_obj(*state);
-	if (!state)
-		return -ENOMEM;
-
-	state->context = dc_state_create_current_copy(adev->dm.dc);
-	if (!state->context) {
-		kfree(state);
-		return -ENOMEM;
-	}
-
 	drm_atomic_private_obj_init(adev_to_drm(adev),
 				    &adev->dm.atomic_obj,
-				    &state->base,
+				    NULL,
 				    &dm_atomic_state_funcs);
 
 	r = amdgpu_display_modeset_create_props(adev);
-	if (r) {
-		dc_state_release(state->context);
-		kfree(state);
+	if (r)
 		return r;
-	}
 
 #ifdef AMD_PRIVATE_COLOR
-	if (amdgpu_dm_create_color_properties(adev)) {
-		dc_state_release(state->context);
-		kfree(state);
+	if (amdgpu_dm_create_color_properties(adev))
 		return -ENOMEM;
-	}
 #endif
 
 	r = amdgpu_dm_audio_init(adev);
-	if (r) {
-		dc_state_release(state->context);
-		kfree(state);
+	if (r)
 		return r;
-	}
 
 	return 0;
 }
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12

-- 
2.52.0

