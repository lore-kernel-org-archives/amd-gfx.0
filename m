Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC34C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 12:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF77A6EB58;
	Thu,  2 Dec 2021 12:54:30 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20686EE2D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 12:54:28 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id e11so54558928ljo.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Dec 2021 04:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UaRC6dePK2hnXcU1WNOOgNykQl0769p2BhFiPibOLxk=;
 b=21AzlDjqNiW/c297sOahlvsNioUQgS5uXIIs1V4zN0twu/cD5NKYuA/Kjhm08rHa9J
 LMuWx7lkvfNRj+TVyG10Q4RSsw95f11FFD1Z2NUuagaLBxhVcLMZQt9pajijRD1AGKPi
 1W35EILGor+KcABz4ZOrtpyv2YKVNLhMBaLGf8tt2Nq5CmVrrRtLZHuDWbK4m8Ef1jst
 BdbEBlGxQVg34i00xf0i98XEneetWliOusXAaPKHo5ph9MNEgpqXjO56Ze7M4X1sR5Kl
 8AFSXBfVCdw+LJscZGKib+h5rqcOTlx2x0v3CQq6z1a3bSTljyz3PpmWlO3OqQSP1f3Q
 mAPg==
X-Gm-Message-State: AOAM533nYXCtiz4ACKKhwGHE0aKRg2q8fxNfiqMJ/uNh2yXpH79HFMk5
 lYZ7RzsGxC6S0cJh4ZI1FXCsjMgX5amWPw==
X-Google-Smtp-Source: ABdhPJyeUvBYLsdJJJVSPy/XzNA/iotc/lpzZFpMjC7J11K9iRskaeSZBXvhJEm9TCxX1MLkxZsaPQ==
X-Received: by 2002:a2e:95cb:: with SMTP id y11mr12615404ljh.309.1638449666923; 
 Thu, 02 Dec 2021 04:54:26 -0800 (PST)
Received: from localhost.localdomain ([176.122.114.46])
 by smtp.gmail.com with ESMTPSA id m13sm338321lfl.131.2021.12.02.04.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 04:54:26 -0800 (PST)
From: Vlad Zahorodnii <vlad.zahorodnii@kde.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/display: Use oriented source size when checking
 cursor scaling
Date: Thu,  2 Dec 2021 14:52:15 +0200
Message-Id: <20211202125215.25307-1-vlad.zahorodnii@kde.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202121650.2265-1-vlad.zahorodnii@kde.org>
References: <20211202121650.2265-1-vlad.zahorodnii@kde.org>
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
Cc: Vlad Zahorodnii <vlad.zahorodnii@kde.org>, contact@emersion.fr,
 Rodrigo.Siqueira@amd.com, xaver.hugl@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dm_check_crtc_cursor() doesn't take into account plane transforms when
calculating plane scaling, this can result in false positives.

For example, if there's an output with resolution 3840x2160 and the
output is rotated 90 degrees, CRTC_W and CRTC_H will be 3840 and 2160,
respectively, but SRC_W and SRC_H will be 2160 and 3840, respectively.

Since the cursor plane usually has a square buffer attached to it, the
dm_check_crtc_cursor() will think that there's a scale factor mismatch
even though there isn't really.

This fixes an issue where kwin fails to use hardware plane transforms.

Changes since version 1:
- s/orientated/oriented/g

Signed-off-by: Vlad Zahorodnii <vlad.zahorodnii@kde.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a3c0f2e4f4c1..c009c668fbe2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10736,6 +10736,24 @@ static int dm_update_plane_state(struct dc *dc,
 	return ret;
 }
 
+static void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
+				       int *src_w, int *src_h)
+{
+	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
+	case DRM_MODE_ROTATE_90:
+	case DRM_MODE_ROTATE_270:
+		*src_w = plane_state->src_h >> 16;
+		*src_h = plane_state->src_w >> 16;
+		break;
+	case DRM_MODE_ROTATE_0:
+	case DRM_MODE_ROTATE_180:
+	default:
+		*src_w = plane_state->src_w >> 16;
+		*src_h = plane_state->src_h >> 16;
+		break;
+	}
+}
+
 static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 				struct drm_crtc *crtc,
 				struct drm_crtc_state *new_crtc_state)
@@ -10744,6 +10762,8 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	struct drm_plane_state *new_cursor_state, *new_underlying_state;
 	int i;
 	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
+	int cursor_src_w, cursor_src_h;
+	int underlying_src_w, underlying_src_h;
 
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
@@ -10755,10 +10775,9 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 		return 0;
 	}
 
-	cursor_scale_w = new_cursor_state->crtc_w * 1000 /
-			 (new_cursor_state->src_w >> 16);
-	cursor_scale_h = new_cursor_state->crtc_h * 1000 /
-			 (new_cursor_state->src_h >> 16);
+	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
+	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
+	cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
 
 	for_each_new_plane_in_state_reverse(state, underlying, new_underlying_state, i) {
 		/* Narrow down to non-cursor planes on the same CRTC as the cursor */
@@ -10769,10 +10788,10 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 		if (!new_underlying_state->fb)
 			continue;
 
-		underlying_scale_w = new_underlying_state->crtc_w * 1000 /
-				     (new_underlying_state->src_w >> 16);
-		underlying_scale_h = new_underlying_state->crtc_h * 1000 /
-				     (new_underlying_state->src_h >> 16);
+		dm_get_oriented_plane_size(new_underlying_state,
+					   &underlying_src_w, &underlying_src_h);
+		underlying_scale_w = new_underlying_state->crtc_w * 1000 / underlying_src_w;
+		underlying_scale_h = new_underlying_state->crtc_h * 1000 / underlying_src_h;
 
 		if (cursor_scale_w != underlying_scale_w ||
 		    cursor_scale_h != underlying_scale_h) {
-- 
2.34.1

