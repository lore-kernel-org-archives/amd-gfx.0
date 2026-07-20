Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7C1C4452A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 14:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2786189C49;
	Mon, 20 Jul 2026 14:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JMBeSe+Z";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF5A89C49
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 14:24:46 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso10535606a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784557485; x=1785162285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PmBvn+AX3Qnuwr/pMW67QihkJ9ghecGIp8Ygs9aw8VI=;
 b=JMBeSe+ZASBQz7MCykF/jU2U3k1HHAawuPWh9aTDKVnqcDYvOirRkoGaFiHlvo2ikN
 oXJVYL9HwszpyJzhhHK4lX7JtZKkdmgeIJleh0K4YuAsM1YaWEPpcY09lJsjI+qKc9z7
 z/ZQQIUyHHcQVl58APqW4WYzHhjAacIIxTWA2SxjCZegZfrv/2dWxeNO1Z42VfFPJPCr
 31x84ruHFyKtmPVWJOGcW1z9i3IeiM1a/vPhnrHfxBUdRx+7eocjyeMdAY1u6/UfkDA+
 rJvM7Z8zQn5x+1e37mViKrHsw5WUoRdQ5vuBO4RC5AFdf9/mOb1Ys5aBp2FDg1Pm0Zpb
 VMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557485; x=1785162285;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PmBvn+AX3Qnuwr/pMW67QihkJ9ghecGIp8Ygs9aw8VI=;
 b=oHQUBy7KI1rXb9EHNOi3i8RY5P2eTiToPihusM+9CVSj1VmHlT0NMvUy4vgWQYh6Dk
 6Dzw8D36sLA6Geh42BNLl7fxNtkQrPTOtdL6bOQ4PqCn2lwNuxnrEqqY++NjWNivsj8W
 tl17y7fR4kMO7vgY1FBTym8g0yyPSttx75tZjZxNtguzl5hvjXex0QofI8TdnuhLGfjV
 P3WigTGLRP8pD3UIrUfNG4xXQonAutHiRzL6OxisTpmJi1fBWem/9E3zYB3AcE61kzIn
 dvTs8qUzgRwBEXPBMQMKotuli91rVIfnPZWNqWP8mHoOt9skm7TZuMBclah7aGqv3Hih
 JcKg==
X-Gm-Message-State: AOJu0YyZpjDPRMDoFw0kq1MptiQHbx/w8roE3JGLT9euX8+bBQzftQ3W
 FV9oBYS+uDyFxPr5lmNdK1deIukTeBsIzK8lmGB38RAUMsUTY9mEz0ENMCNGo2Cf
X-Gm-Gg: AfdE7clNF2scQGY/rf0UK9U05AYnBw8u8oBE0uN3/dhUqxmRRBJytj00WKpFhFnJaof
 7rsdHIJr7QfFzVT2wtMAs9dILrKp5JC048q5xUDDpd7UTRz+rgJG84CTE7Fd+G3/5FTFFVI2EId
 HzUdtzaPSj1oNBkSpL2S9j8c8XprQMYZ0K4is+QpFYVcRacDHnuzvSOj4UztxuOvyUnftXol+jW
 WUaBGP6dyC+9fvF5UkoVWOCInZrODBuPA4UK1C9phN60Gx+M/hikK2TUg2rnuPSCXkMHn56kKRB
 iZNOI3IIfIge5J07ml1UdhB5R297P1/9UVkJfit3v/vk8TVDS+yUM0o6ccIxbLDYXoIUOw4IIfE
 SDdMua2e7NigqbC7V/Awt2DUHDj1rBOGOEmgqTqgD0DBgZuWqnA8kgv8vLLNKIdhQDZyIykC2gP
 RQFFxlXTyIXVyySfbrIfZtjSC+9XonjEO14eagaICCoUc=
X-Received: by 2002:a05:6402:455a:b0:699:39c5:204b with SMTP id
 4fb4d7f45d1cf-69e6528aa2cmr4079154a12.18.1784557484524; 
 Mon, 20 Jul 2026 07:24:44 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6fff5efasm4999534a12.26.2026.07.20.07.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:24:43 -0700 (PDT)
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
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] drm/amdgpu: Support DRM format modifiers on GFX6-8 (v3)
Date: Mon, 20 Jul 2026 16:24:36 +0200
Message-ID: <20260720142440.22076-1-timur.kristof@gmail.com>
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

Timur Kristóf (4):
  drm/fourcc: Add modifiers for AMD GFX6-8
  drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
  drm/amd/display: Support DRM format modifiers on GFX6-8
  drm/amd/display: Don't use tiling flags anymore

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 144 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 343 ++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   3 -
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  84 -----
 include/uapi/drm/drm_fourcc.h                 | 209 ++++++++++-
 6 files changed, 641 insertions(+), 171 deletions(-)

-- 
2.55.0

