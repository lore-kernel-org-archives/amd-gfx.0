Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12279C7115B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 14:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A076F10EA6D;
	Thu, 19 Jun 2025 14:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lfGhTahw";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 505FA10EA1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 12:55:15 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-748582445cfso428130b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750337714; x=1750942514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wuuwCmdIbqbcBHU9VhiEZI/hOwAawJBMP/z6o38vDiw=;
 b=lfGhTahw5YQvbTRYiKYan9dPtRqDFTFf9iy8KIAVhv0TcwGuUAAC9QL7s0xv2PLpfO
 HyoTfYaJBaFo6RG2h3L/M+eclJlTdbBMDvRQvj8X5N0E6/R6+n+kJTD77lXoDnuXt8wg
 rMmdD03IL5HlMOgj+3fF81heXfwjWnHp89QB7h4EoE+8bKOVPQNLjpZCkBdKb42ZtlVJ
 EQvf4G5aEezzzIp2kaLmlsDI+fVarTcR2ipvQrVhNWS6C0DciRN5WeDxJleibN5YqXhi
 LlKnN/95XZU3uCDPvC+k8UWqaWR55JmgS+q0t/iCxlOou4TEZiDNUiMphJ4753eCCJH8
 9TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750337714; x=1750942514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wuuwCmdIbqbcBHU9VhiEZI/hOwAawJBMP/z6o38vDiw=;
 b=bKzgRA9h1wQHZ9+KOrdEehMX4NYZuxJJYc6oXld3CNv7uAl1LdWOWPU9E7lJHjONFG
 /pP7d/fWhvb/v1rBCmyyPVA9SPKwQ0L2CXsSsMA6ZVrBl7PLBcU6gqmVIuZI+hK8uGdR
 YpdFJ03lFbEk3/d3JOmOS910qOQTOZwmZbwSLZAndoX8VPZlWlGLkiRQlKgvuqk7lLCV
 DMB3DGddZ8n/VqJeKuWxXzKJMgLUVZbIfyhcekK9VS4OiaL8y80yh5gkTS9Eeppu8PdY
 iL+yR4VMI2/x7Iy8+n+dFqV9iwvtCgCqxhdwMNuinAoBpK50G4P3N4UptdqtaqUttZky
 +Nqg==
X-Gm-Message-State: AOJu0YzP1Rz8BckJknuOSOE/nuA7M40E3tHo6mswtiTTRxDW5jZAdJti
 Wp/fkIycXkG1+3hEAHZxCg9WtXh6AhJ2TKtl9PpYc7lJywbbxHO0kpIoBilEYs+e2JE=
X-Gm-Gg: ASbGncuOsxpRbuoSZo7fU+XuwL6CTMZC4GK0rSuM20WB1ELCPckVnQegQH9XfI0SeQp
 AQpS/I+L5Mljj4chTi9SzsmLHbgEypDAx81bSKk1/LFRmMy/Z249Q3gjpmjO9yp+htqCZXRIB6A
 dbKxprcw1jH2afYAMLtQmOyttXtTSzOBXDPWOya7uGG63KS5Z4J1xJ5QDjGHe9xuF0vOISbBZDW
 i1R5rjyMhaki36imIe54MeTyOX7sXaLnMacb83DKOLIpCtNKOMNk3Ua60oEboI24kZONhP3vXyg
 6sowHzFtb0ZfFQVG0+3CWdHFH5Dtipi4T8v5z57xSJltOJBpSEezfNKwdUUWjyRe69Hh
X-Google-Smtp-Source: AGHT+IGUHL8InS0jieiqCEbs21CgAWjix3DOmyhxS34H9NDKVNoClILiY/3wBaio+AhmWANO/dzOCw==
X-Received: by 2002:a05:6a21:512:b0:21f:568c:713a with SMTP id
 adf61e73a8af0-21fbd4dffe7mr28264958637.17.1750337714244; 
 Thu, 19 Jun 2025 05:55:14 -0700 (PDT)
Received: from copycat.coywolf-snapper.ts.net ([2600:6c51:4c3f:8e93::d81])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748900b3d82sm13547664b3a.141.2025.06.19.05.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 05:55:11 -0700 (PDT)
From: Christopher Snowhill <kode54@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Christopher Snowhill <chris@kode54.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Christopher Snowhill <kode54@gmail.com>
Subject: [RFC PATCH] drm/amdgpu: Enable async flip for cursor planes
Date: Thu, 19 Jun 2025 05:55:05 -0700
Message-ID: <20250619125507.54384-1-kode54@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Jun 2025 14:02:00 +0000
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

From: Christopher Snowhill <chris@kode54.net>

amdgpu apparently fudges atomic flips if some software is also tweaking
the cursor planes during flips, which results in lovely fallback to non-
atomic flips.

Fixes: 41129e236f14 ("drm/amdgpu: Enable async flip on overlay planes")
Signed-off-by: Christopher Snowhill <chris@kode54.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

 Is there some reason why this was decided to be this way? I see it
 hasn't changed much since 2018, until the addition of overlay
 plane checking.

 Re: https://gitlab.freedesktop.org/drm/amd/-/issues/4263

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b7c6e8d13435..f0c98d67e1f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1268,7 +1268,8 @@ static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 	struct dm_crtc_state *dm_new_crtc_state;
 
 	if (flip) {
-		if (plane->type != DRM_PLANE_TYPE_OVERLAY)
+		if (plane->type != DRM_PLANE_TYPE_OVERLAY &&
+		    plane->type != DRM_PLANE_TYPE_CURSOR)
 			return -EINVAL;
 	} else if (plane->type != DRM_PLANE_TYPE_CURSOR) {
 		return -EINVAL;
-- 
2.50.0

