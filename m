Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA09EB64DD
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Jul 2023 02:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E6FD10E013;
	Sun,  9 Jul 2023 02:07:08 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6245110E0F3
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Jul 2023 02:07:06 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31441dfbf97so3779159f8f.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Jul 2023 19:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1688868423; x=1691460423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elIzkIq9z0toasqrV8sZECLMmemJKxK8hU1qJY1jjJk=;
 b=iL9z+J/NqExmNh2dQ+MT/Hzh/Gpi38XO3f6z9AL3ficXuyz0nqoNs7auNF86mG6uri
 rsAhTsz/DAYLujASf5yLmRHvroeNE1cnO2wlAzm+gxg8/itbKmj7MvatqPuOA0/Z30/W
 r7Xdm9DCVdrvsunwpKxSmBuYHUEIKeOYSevPcudWXIoEVeI0Yr75twfD8UItUlH6vGf2
 OeirbEtPj19Z62rlgceMKHVIWVHSMF2zEWOUUuquvcuER1PSvxbkSn67nQeiBcjx6QHs
 Vp5Yw9Kc7H2PVMzpQ2Am3cFXz9SyCDkPaX4m1yohGvtXIZ4o4MtNgRUf3HfEgJKeKuyC
 9vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688868423; x=1691460423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elIzkIq9z0toasqrV8sZECLMmemJKxK8hU1qJY1jjJk=;
 b=Pt8Ve19SdTrycAtqIh5cy6+4QBffUtJl30mQ1UmKLRToRi1DJeDXjpFF9DzCL/CR1/
 bLTdwvbDb0R794eHoupIwZ1wfRduDkK9W0RQxYwH7llDE9cXWjqahUh3f9CCeNW9Jbuk
 81lo38+/KLR7ei4YxmzjxpRq77MLFhhIOQVjFM98p7fgfA7bTVL7uwZYADB8FSmDU1fM
 KHFw7uUE3OZPy/CI0eY9ETVwsC5kV+67AccxesB9ZQG6GZ0oQ19DULCM1fyNnVt5lY9N
 TJZFFRE1pJPV2C3VR2ALuLo8KvATLG9c3gi/rex6HxUD68mPn64ccweG7TyUu42DXCyv
 JceQ==
X-Gm-Message-State: ABy/qLbbS0JXd/2F60qReVWjwvxLDX5SeJ8Plo/j+LJqec+Qem4k2DwU
 79B4FErYgdl1xUY06wKGgJQ5NWhygwNtRLRV6i0=
X-Google-Smtp-Source: APBJJlFXgd8y/CmUTfyIdVUcaC+ydyDPnXv6N4EBnZF29PTeFvPQXWQsHvgkdVTcpe+MfRt2/SwmIQ==
X-Received: by 2002:a5d:540c:0:b0:315:8f4f:81b8 with SMTP id
 g12-20020a5d540c000000b003158f4f81b8mr1333841wrv.50.1688868423567; 
 Sat, 08 Jul 2023 19:07:03 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a5d4e90000000b0031424f4ef1dsm8120934wru.19.2023.07.08.19.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jul 2023 19:07:03 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/display: Implement zpos property
Date: Sun,  9 Jul 2023 03:06:58 +0100
Message-ID: <20230709020700.3116749-3-joshua@froggi.es>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709020700.3116749-1-joshua@froggi.es>
References: <20230709020700.3116749-1-joshua@froggi.es>
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
Cc: Melissa Wen <mwen@igalia.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>, Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Despite certain GPUs supporting multiple overlay planes already in
AMDGPU, the driver did not expose the zpos property which is required
for userspace to take advantage of multiple overlay planes in any
meaningful way.

The driver was already hooked up to normalized_zpos, but was just
missing the exposure of it.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8eeca160d434..2198df96ed6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1468,6 +1468,15 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		drm_plane_create_blend_mode_property(plane, blend_caps);
 	}
 
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
+		drm_plane_create_zpos_immutable_property(plane, 0);
+	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
+		unsigned int zpos = 1 + drm_plane_index(plane);
+		drm_plane_create_zpos_property(plane, zpos, 1, 254);
+	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
+		drm_plane_create_zpos_immutable_property(plane, 255);
+	}
+
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    plane_cap &&
 	    (plane_cap->pixel_format_support.nv12 ||
-- 
2.41.0

