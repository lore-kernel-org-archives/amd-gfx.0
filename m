Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E422EB64DC
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Jul 2023 02:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83B710E0F3;
	Sun,  9 Jul 2023 02:07:08 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60DBA10E013
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Jul 2023 02:07:06 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-314313f127fso3405030f8f.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Jul 2023 19:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1688868422; x=1691460422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PmLULFc4vI9tFO31l5iijgGXYExeOMtPEfF9vpSnUC8=;
 b=KXLYRtQGDeuxlvjT4mPYkGlnHiqjDKCMi70nVXUeIAuSc8JFv+cMClGPxne+ak20YX
 qB52xCeC4DFHgbQnn0kylpDoIPYb7g4WfSxVN+lphBrpa3SNTcLb0wDExR5tPUabOcEV
 HLqEcn5vFQJpV4cQ4HZ6JfqRvVlpIJcAGwewqmFRMw+rwU2OSwZ/9boUuiMgnh7RC0bG
 EHzvu/VZa1Kzd219ITLZBaxS+n4Iiic/6SN7TuIewatLPE+ovKe/mVtLBJ6liAsfdXSO
 mKYTkaqJbbYOkviWV6armdF69nrmmsCy8wszKg/jsGwao7rJ1+Z3xz1WjIRQ7eSv93ob
 xWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688868422; x=1691460422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PmLULFc4vI9tFO31l5iijgGXYExeOMtPEfF9vpSnUC8=;
 b=kVubjLAF0YItgQ1T5vTpsXZdEWRxh6WZLSzhU4prugOnAAfKJRaU54eyRzpU2RkiGC
 e/mkGZCCrBY5e4uiUdAcS/DnvQeazwnHMToSGOAqh1baFx5AeH0oS38MkV/8LB/M/ZQ/
 x/8PQUFrXj7/r/Ahs8mpogrFqhTl9qSdCpABSJrBOfXTpzrwkavNlv8aejWRetSAz1gn
 FrxDxqxUdzn/FQ7tkRD8ApW0C4R2A3a+Jf6oc73M6GFunt0oyfkur2f9zrEQpFtRVkoq
 OLA++sreYi7ZWju7BZKUiTwRI2h8EL2NHoS7vftRa/KktV4A/EKJj8CsMCucj6X+yxAT
 ydTA==
X-Gm-Message-State: ABy/qLYFhb7PFJ7wFHewSlL1RchEOe9+jMRoc00DAUM6F3L4ZtK78Zt5
 1g9xKbGeUSONQz6Koa3QJ8p5IbhtSBWJ5ijBbSs=
X-Google-Smtp-Source: APBJJlFIQMOkUvjDCVSInmaEEQRECmqiT0Sb3pc+oFEkbI4W6NK+I+iEavs1XXiIPuVEBZHQIwLCgw==
X-Received: by 2002:a5d:4891:0:b0:314:c14:64d2 with SMTP id
 g17-20020a5d4891000000b003140c1464d2mr6138308wrq.42.1688868422345; 
 Sat, 08 Jul 2023 19:07:02 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a5d4e90000000b0031424f4ef1dsm8120934wru.19.2023.07.08.19.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jul 2023 19:07:02 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/display: Expose more formats for overlay planes
 on DCN
Date: Sun,  9 Jul 2023 03:06:56 +0100
Message-ID: <20230709020700.3116749-1-joshua@froggi.es>
X-Mailer: git-send-email 2.41.0
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

DCN planes are universal and therefore overlay planes can use the same
formats as primary planes, unlike DCE.

Gamescope/Steam Deck would like to take advantage of this functionality
for partial composition which in some cases in our pipeline, can contain
negative values in some instances.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Simon Ser <contact@emersion.fr>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 41 +++++++++++--------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index de1c7026ffcd..8eeca160d434 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -113,6 +113,11 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 			DRM_FORMAT_ARGB8888,
 			DRM_FORMAT_RGBA8888,
 			DRM_FORMAT_ABGR8888,
+			DRM_FORMAT_ARGB2101010,
+			DRM_FORMAT_ABGR2101010,
+			DRM_FORMAT_ARGB16161616,
+			DRM_FORMAT_ABGR16161616,
+			DRM_FORMAT_ARGB16161616F,
 		};
 		uint32_t format = plane_state->fb->format->format;
 		unsigned int i;
@@ -698,8 +703,8 @@ static int get_plane_formats(const struct drm_plane *plane,
 	 * caps list.
 	 */
 
-	switch (plane->type) {
-	case DRM_PLANE_TYPE_PRIMARY:
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY ||
+		(plane_cap && plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL && plane->type != DRM_PLANE_TYPE_CURSOR)) {
 		for (i = 0; i < ARRAY_SIZE(rgb_formats); ++i) {
 			if (num_formats >= max_formats)
 				break;
@@ -717,25 +722,29 @@ static int get_plane_formats(const struct drm_plane *plane,
 			formats[num_formats++] = DRM_FORMAT_XBGR16161616F;
 			formats[num_formats++] = DRM_FORMAT_ABGR16161616F;
 		}
-		break;
+	} else {
+		switch (plane->type) {
+		case DRM_PLANE_TYPE_OVERLAY:
+			for (i = 0; i < ARRAY_SIZE(overlay_formats); ++i) {
+				if (num_formats >= max_formats)
+					break;
 
-	case DRM_PLANE_TYPE_OVERLAY:
-		for (i = 0; i < ARRAY_SIZE(overlay_formats); ++i) {
-			if (num_formats >= max_formats)
-				break;
+				formats[num_formats++] = overlay_formats[i];
+			}
+			break;
 
-			formats[num_formats++] = overlay_formats[i];
-		}
-		break;
+		case DRM_PLANE_TYPE_CURSOR:
+			for (i = 0; i < ARRAY_SIZE(cursor_formats); ++i) {
+				if (num_formats >= max_formats)
+					break;
 
-	case DRM_PLANE_TYPE_CURSOR:
-		for (i = 0; i < ARRAY_SIZE(cursor_formats); ++i) {
-			if (num_formats >= max_formats)
-				break;
+				formats[num_formats++] = cursor_formats[i];
+			}
+			break;
 
-			formats[num_formats++] = cursor_formats[i];
+		default:
+			break;
 		}
-		break;
 	}
 
 	return num_formats;
-- 
2.41.0

