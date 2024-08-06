Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FC6C52D6F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 18:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCAE10E3D7;
	Tue,  6 Aug 2024 18:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="P7bkSFbS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5338510E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722969740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=01pYy0RoeEupYF7zERqbs3TQif/Fpq9bfAeMMVajTZo=;
 b=P7bkSFbS8mVUtD8yU6dl+KsrkgxqmqpmqNdvMnuFmf2VKetZwXskT33tKWsgPlWzromcP9
 Pigt6rnvJyGo6rIVTCD5tE2Nds1JVh/Z0htfSQBDPDsXAqOzEWf5ixEFpY0xHvolfpI8Sq
 jN+ztyp5PWW6UvhbIH4A4nr6m/2KHaQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-oStN7SolNvSMaDXiAZ2V7A-1; Tue, 06 Aug 2024 14:42:17 -0400
X-MC-Unique: oStN7SolNvSMaDXiAZ2V7A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280645e3e0so7472975e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 11:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722969736; x=1723574536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01pYy0RoeEupYF7zERqbs3TQif/Fpq9bfAeMMVajTZo=;
 b=v0QGiXgTt4sXKih+invm7hsBIyU5uLQ2EWxUQHMkDsLzLSq60x84F3S0uoATvd3+By
 qu6NSMGZc1sas9iskA7sDZyRavkwIMbOV6mUGFsoHLc9BLlxFX2ZPMByF+MRtXXaxzid
 TeAVcX0jzce+s7ZOomVORucW5V/EK2RAol6HhcQ6pAUm4gqgHYm4FNzBVyqBLz7qNVWr
 h5oK41rYGjcz3osFAjqbhuTrc1/vk7MwzHwN62hlV/LrLaoNXTQcjmynovWIMpNEgduA
 Z23S07lLMpwh75GPDpoVJSMoHTN4gKe9vKlDA08voS0ZiACJhrkZJWX15C5ArqbKLvF/
 2ivg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQvOz5Zrt5e/RL0xDYsiEquZgq+Hf9gdxqxQXz+Nqn/ECYCCeS4HdE7tYiVUvtNCjwbC4PUrOqOp6AhLoIhvg/sw5rYSvlaGBue2iMvg==
X-Gm-Message-State: AOJu0YyfMPGbT/CfqOGVVFFGDSNMW5xc11oFNC6vi8zhFiykK51Fv570
 5g5YbAankevobGbGWtxuVVjgbGBpZ6R6g/DSdPBUXErBOPTKH0Mjxi+wcp/1wICXHFur9AgwJfw
 YDc9dH2hr2+1DUIv3CpVvQDL78uzRzP6Q1pATl0YHbDzuq+8JiWmLGKWW57Jnoqk=
X-Received: by 2002:a05:600c:4691:b0:426:61af:e1d3 with SMTP id
 5b1f17b1804b1-428e6b93599mr102556205e9.31.1722969735932; 
 Tue, 06 Aug 2024 11:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiFpIvlI8k7114/ZEzme3IC5OCI9T0woaEQMiy/WOE6Z1hplw5fhcTbm7blEJxF4i2lUmGOg==
X-Received: by 2002:a05:600c:4691:b0:426:61af:e1d3 with SMTP id
 5b1f17b1804b1-428e6b93599mr102556085e9.31.1722969735360; 
 Tue, 06 Aug 2024 11:42:15 -0700 (PDT)
Received: from toolbox.fritz.box ([2001:9e8:898e:ab00:d894:f48:6689:8e30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e3ef10sm196595695e9.24.2024.08.06.11.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 11:42:14 -0700 (PDT)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Sebastian Wick <sebastian@sebastianwick.net>,
 Xaver Hugl <xaver.hugl@gmail.com>, Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Hung <alex.hung@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li <roman.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "drm/amd/display: Don't register
 panel_power_savings on OLED panels"
Date: Tue,  6 Aug 2024 20:42:09 +0200
Message-ID: <20240806184214.224672-1-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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

From: Sebastian Wick <sebastian@sebastianwick.net>

This reverts commit 76cb763e6ea62e838ccc8f7a1ea4246d690fccc9.

Reverting the panel_power_savings sysfs. See next commit.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++----------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e7929f24ae4..4d4c75173fc3 100644
--- ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6840,34 +6840,12 @@ static const struct attribute_group amdgpu_group = {
 	.attrs = amdgpu_attrs
 };
 
-static bool
-amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
-{
-	if (amdgpu_dm_abm_level >= 0)
-		return false;
-
-	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
-		return false;
-
-	/* check for OLED panels */
-	if (amdgpu_dm_connector->bl_idx >= 0) {
-		struct drm_device *drm = amdgpu_dm_connector->base.dev;
-		struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
-		struct amdgpu_dm_backlight_caps *caps;
-
-		caps = &dm->backlight_caps[amdgpu_dm_connector->bl_idx];
-		if (caps->aux_support)
-			return false;
-	}
-
-	return true;
-}
-
 static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
-	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	    amdgpu_dm_abm_level < 0)
 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
 
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
@@ -6974,7 +6952,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 		to_amdgpu_dm_connector(connector);
 	int r;
 
-	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector)) {
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	    amdgpu_dm_abm_level < 0) {
 		r = sysfs_create_group(&connector->kdev->kobj,
 				       &amdgpu_group);
 		if (r)
-- 
2.45.2

