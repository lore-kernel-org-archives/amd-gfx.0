Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EA3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 15:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD0A10EB4F;
	Wed,  9 Mar 2022 15:06:10 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF5710EB3F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 15:06:08 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id hu12so2166290qvb.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Mar 2022 07:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=phfpGCAWK6F5JTjCKOY8WlzoMPYGjZxGaJcDSIHgU9A=;
 b=Az86fnE8IJamYX+rLNsFIeRxGZh8rtkX4/L1KpCWdasUqgbyxJsKGDZmUZQxEsntQ+
 XnNOlzphyt8rxpw37+1eNSjGGZ4qp7sjlAKnZxn7IYIjmuH0AzeYp9UZsp5V2LFVVIWf
 2R/bzFJefyJfq2HpKWoZ901hnki9QdpVazzT0xZBKocE3OCtx9+nfGSj+rOwU7qfpL7p
 RWpxsLDHG6yW/5V48nMzu/0+Vl0fv0XXqdxAeeK+kPl15qPZMoxXE/Q/foGuiwUesQ5d
 S/TjeB33OPRb4z6i/MdgZAJ0RziDx9gkabnzRsYWrlNXSqJs6nmhYoUPeSCDn8A6E5II
 j89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=phfpGCAWK6F5JTjCKOY8WlzoMPYGjZxGaJcDSIHgU9A=;
 b=V7wEKIvywIk3f6AzhZtTI3S0dkIeqR+ibduG0EgmQWuDZcXMHgq1oBv3Kgul3bjpy7
 44iLFQUXpKQ9aR+hs4oYeneTNqZKAS6ZCw4EYEjdswak6LzF8/BeoBipu2exaq4Yk8xs
 NU5xKO/N+cHKyjpIxBrgsGVfSYsnrI/oiunQWCP+eF+tQpbs2Jo0MJs0gq2dJerOrKqo
 ikej265q/mI1kVmvfMLhG81psG6T5gl2azzp3452XAlEBGcZ93LDUXbaArHF5lIyw7O8
 5C35KraIxFeQhQlscUOGXDPTqRv+q/jiLRjR3bFr2FXyG1WYDV8B/eMfdQESeW4hHZCJ
 SP2A==
X-Gm-Message-State: AOAM533DXWV1wGCzSG5nCMWXlKnp3eqa5JZLTwwa4GRukZpe+P6dLVMp
 te1Qg9RQcyuFLViuQVl6L1qQYA==
X-Google-Smtp-Source: ABdhPJx7Q2uYu5FrmxzQCm84dd1ZUD62niBUtSWvFqpbcmw2DGK6VUjuvydGd9jC+qs1ZQs8j6F6EA==
X-Received: by 2002:a05:6214:29ec:b0:435:bf4e:1337 with SMTP id
 jv12-20020a05621429ec00b00435bf4e1337mr2204546qvb.122.1646838367414; 
 Wed, 09 Mar 2022 07:06:07 -0800 (PST)
Received: from localhost (29.46.245.35.bc.googleusercontent.com.
 [35.245.46.29]) by smtp.gmail.com with ESMTPSA id
 c16-20020a05622a059000b002dc93dc92d1sm1392483qtb.48.2022.03.09.07.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 07:06:06 -0800 (PST)
From: Sean Paul <sean@poorly.run>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, alexdeucher@gmail.com
Subject: [PATCH v2] drm/amdgpu: Add support for drm_privacy_screen
Date: Wed,  9 Mar 2022 15:06:02 +0000
Message-Id: <20220309150606.1877288-1-sean@poorly.run>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>,
 hdegoede@redhat.com, Sean Paul <seanpaul@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 rajatja@google.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sean Paul <seanpaul@chromium.org>

This patch adds the necessary hooks to make amdgpu aware of privacy
screens. On devices with privacy screen drivers (such as thinkpad-acpi),
the amdgpu driver will defer probe until it's ready and then sync the sw
and hw state on each commit the connector is involved and enabled.

Changes in v2:
-Tweaked the drm_privacy_screen_get() error check to avoid logging
 errors when privacy screen is absent (Hans)

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/477640/ #v1
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |  9 +++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 16 +++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2ab675123ae3..e2cfae56c020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -26,6 +26,7 @@
 #include <drm/drm_aperture.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_privacy_screen_consumer.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_managed.h>
 #include "amdgpu_drv.h"
@@ -1988,6 +1989,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 {
 	struct drm_device *ddev;
 	struct amdgpu_device *adev;
+	struct drm_privacy_screen *privacy_screen;
 	unsigned long flags = ent->driver_data;
 	int ret, retry = 0, i;
 	bool supports_atomic = false;
@@ -2063,6 +2065,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	size = pci_resource_len(pdev, 0);
 	is_fw_fb = amdgpu_is_fw_framebuffer(base, size);
 
+	/* If the LCD panel has a privacy screen, defer probe until its ready */
+	privacy_screen = drm_privacy_screen_get(&pdev->dev, NULL);
+	if (IS_ERR(privacy_screen) && PTR_ERR(privacy_screen) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	drm_privacy_screen_put(privacy_screen);
+
 	/* Get rid of things like offb */
 	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &amdgpu_kms_driver);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1d3db3fe8de..9e2bb6523add 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9781,6 +9781,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		if (acrtc) {
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+
+			/* Sync the privacy screen state between hw and sw */
+			drm_connector_update_privacy_screen(new_con_state);
 		}
 
 		/* Skip any modesets/resets */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 740435ae3997..594a8002975a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -27,6 +27,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/dp/drm_dp_mst_helper.h>
 #include <drm/dp/drm_dp_helper.h>
+#include <drm/drm_privacy_screen_consumer.h>
 #include "dm_services.h"
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
@@ -506,6 +507,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 				       struct amdgpu_dm_connector *aconnector,
 				       int link_index)
 {
+	struct drm_device *dev = dm->ddev;
 	struct dc_link_settings max_link_enc_cap = {0};
 
 	aconnector->dm_dp_aux.aux.name =
@@ -519,8 +521,20 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 	drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
 				      &aconnector->base);
 
-	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
+	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
+		struct drm_privacy_screen *privacy_screen;
+
+		/* Reference given up in drm_connector_cleanup() */
+		privacy_screen = drm_privacy_screen_get(dev->dev, NULL);
+		if (!IS_ERR(privacy_screen)) {
+			drm_connector_attach_privacy_screen_provider(&aconnector->base,
+								     privacy_screen);
+		} else if (PTR_ERR(privacy_screen) != -ENODEV) {
+			drm_err(dev, "Error getting privacy screen, ret=%d\n",
+				PTR_ERR(privacy_screen));
+		}
 		return;
+	}
 
 	dc_link_dp_get_max_link_enc_cap(aconnector->dc_link, &max_link_enc_cap);
 	aconnector->mst_mgr.cbs = &dm_mst_cbs;
-- 
Sean Paul, Software Engineer, Google / Chromium OS

