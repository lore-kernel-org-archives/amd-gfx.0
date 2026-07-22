Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B06C4453C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 16:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B09610E4BD;
	Wed, 22 Jul 2026 16:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YyrrlX3w";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBD610E4B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 16:59:36 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso49951565e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784739574; x=1785344374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0XPu4cnmX4ioVvWlxrR6gfQgxb2K7RaCHPUau8eHXL0=;
 b=YyrrlX3wgNk18fFmjjMUsL1DLXiaNl3TiG+raRkumfRmSiH6JA1cJvSnKwzM1Aqdk3
 2EUhDDoZ/QAVRY4fD2Fp9ypHvgb2Upw+QsyROea5ARflOabeh4TF4SGvhDq6PL6EFQWx
 iz4pyl7VQhvSGqBCj0UWF55i7RFDa6todscDEkpnM4AeX0mjahxjeErwbZi8nR5LouIS
 AVhTgX1PTU7G++43jYuJGfo2+XcxibFWBt5YHVXI/lmsm1KGOtBfFaCebl1hYy1wFXxY
 VQ6VeVCMhShjXrvSD1ms79MvaivNZDNwyXZW6esCrd4sn8CFLnK6GkbobhDtj0tlGBf/
 2RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739574; x=1785344374;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0XPu4cnmX4ioVvWlxrR6gfQgxb2K7RaCHPUau8eHXL0=;
 b=a3L5SzhluuFN3qBIg9uLmOZsw2q8S8ZLyk6tX89tR2XK8lJbvyo0yB9dDJcZ380imA
 SA1d9RlUrTTbo9W1FKV7bx7Myd93r/AkPgO0/CJQshb7RzuCiuOOkZzkOsAi6z9sHSa7
 ku615Smntb9Ej357y3Y5L/aFcCpgXk9AxqXTsSEylp2ePc8mKPvqEyMujeUjyLuVbeL9
 6O4iRqSkl0stgv5/PCHfxm+LwgeR/Sqrsw6sITr0RJVW1DGDW3iYde4PO3s1aKyhW22R
 NXVDTNsArs4IxvJXEjmj2vojyh3AZt3lJoWNKaKBj2skV319HaVQVwi9CbiGojl7wqsA
 jCVQ==
X-Gm-Message-State: AOJu0YwL3xLv3RLMUa4f/Lqw7tRVmDYRnceTy2GeBQeA0qcvo9ILKnbq
 7W2ucHx1owtWq3dqsHoc5/noUGx5R5kSQJf8rT7Xn51P4QXVyDzkSL4JqhjkFkF5
X-Gm-Gg: AR+sD11d8g/go7hCOTExu5djuYN5bsgM8+UI0uhHnQVnbsmxfrVEi5LPm0IL0M9hzCY
 Vk4tbIyQ8Qs6LTy/iz3L0uQj2ofyoz8YK9+GoySAVb2KFD+4BzkD1a1JiM4Py2pBhUMiZL9eGzq
 QUgmscy2Kgw4ep6KHQfB3kKg5R0UcvWdwhPDj4kIs3Lsfd+bNnF5FNRglPIDQ69ylVkOQk59YUh
 bUBqtdIQHseoX2xonDsc/IQYlJg6YSEJK2HWaNqdcNG3V9dI+L7mgawYRCR3ccHEMwULVTSSWTa
 GZnSUMSTtGYqQO/9rDa1peRdx6RLaGKMqRA0xMa6HysitYvhywPb+r6J5tbN9HfpcKijo35XN/E
 GWITDIsz1msgoqCjwpvVhGAfOKGb1yh7qe7VII1BHM3yUis8Mv0piiuFBlXNtdzjRQuGx8qmwCl
 zlDEQ=
X-Received: by 2002:a05:600c:a0a:b0:493:ee2b:c876 with SMTP id
 5b1f17b1804b1-4954a41302fmr281344065e9.35.1784739574132; 
 Wed, 22 Jul 2026 09:59:34 -0700 (PDT)
Received: from Timur-Max ([62.77.225.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956ab41aa2sm68369615e9.1.2026.07.22.09.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:59:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Link Mauve <linkmauve@linkmauve.fr>,
 =?UTF-8?q?Nikola=20Medi=C4=87?= <nmedic89@gmail.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Daniel Stone <daniels@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Dieter=20N=C3=BCtzel?= <Dieter@nuetzel-hh.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, airlied@gmail.com,
 simona.vetter@ffwll.ch
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] drm/amdgpu: Support DRM format modifiers on GFX6-8 (v4)
Date: Wed, 22 Jul 2026 18:59:21 +0200
Message-ID: <20260722165925.15805-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX6-8 are the oldest GPUs supported by the amdgpu
kernel driver, and the last ones that didn't support
DRM format modifiers until now.

On GFX6-8, the GFX block can only use pre-determined tiling
modes which are programmed by the kernel according to the
tiling mode table. The new modifiers encode all the details
needed for tiling on these GPUs.

For the exact details, see the commit message of:
"drm/fourcc: Add modifiers for AMD GFX6-8"

For a userspace implementation, see this Mesa MR:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41557
And for libdrm:
https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/481

This series of patches are on top of amd-staging-drm-next.

Supporting DRM format modifiers on GFX6-8 will
unblock many things in the Linux graphics ecosystem
that previously either didn't work on these GPUs
or had to implement fallbacks.
For example, compositors written in Vulkan or
compositors running on Zink, interop between
different APIs (eg. VAAPI / OpenGL / Vulkan) etc.

Changes from v1 to v2:

* Fix checking DRM_FORMAT_MOD_INVALID

Changes from v2 to v3:

* Return -EINVAL when pipe_config is invalid
* Log unsupported array mode with drm_dbg_kms()
* Fix block size calculation in amdgpu_display_verify_sizes()
* Add NULL check to amdgpu_dm_plane_add_modifier_dedup()
* Fix tile size calculation to bits not bytes

Changes from v3 to v4:

* Reword and clarify some comments
* Clarify check_tiling_flags_gfx6() and reject ROTATED mode
* Calculate block size in bytes not pixels

Timur Kristóf (4):
  drm/fourcc: Add modifiers for AMD GFX6-8
  drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
  drm/amd/display: Support DRM format modifiers on GFX6-8
  drm/amd/display: Don't use tiling flags anymore

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 177 ++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 343 ++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   3 -
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 147 --------
 include/uapi/drm/drm_fourcc.h                 | 209 ++++++++++-
 6 files changed, 665 insertions(+), 243 deletions(-)

-- 
2.55.0

