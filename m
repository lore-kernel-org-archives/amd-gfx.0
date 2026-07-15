Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC0DC44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 10:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C9D10EFA9;
	Wed, 15 Jul 2026 10:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="igKtKQMh";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A60F10EFA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 10:58:02 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so3003823f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784113080; x=1784717880; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d5gkvpI9Oyf/G2+2m0pFo39aPpeK40umw3UAR9f4Ju4=;
 b=igKtKQMhev4rbrFPfzFCnL46iyfJozJdKCapM9tktwItvvcsK/XrOYh3H+fjsm4fTQ
 TJx949R+iyhTS3inXv0lGBDw37F6e1e4AEHH1+fgdh9KXQcHTicnplWvYHpnGo/0PsgX
 osDdkRlNqMcP+QTsHjcDNmn6x5WqMv3xbMWmAW6Ew1mL1FGzqNgzn6MCWDLswuTXxgMX
 R4OaK3UU57MM47JDjBGdJjeP+IHBGU1AmLE3w4LeGQ/7ZnwvumxiQLJW2gVDGoQMdG6E
 qbD0sABxHBNU8An3eIEll6Bkj4uXBsQVSnB5SPg6tz0oixIE397/wbt0hqgkqLu9GX+F
 ifxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784113080; x=1784717880;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d5gkvpI9Oyf/G2+2m0pFo39aPpeK40umw3UAR9f4Ju4=;
 b=jeIA3LMXrGVdeDXhckGGKtvST6XXFgraRcdfzZ/XrKsnIoqjTFunbZVo8r/Sg5JS0T
 7XhmTUGIXc0hQOG5hofsXQunCS/pF1akFxZCuj8Huw/6BiU9oKNr20yiQW+GJb8eff0k
 o5tWs59o2O3g7glC78bqW81YtSUuKzL3JN8ym4haacmsRMI+uYEW+kMXZWqEsR1TOtbG
 e23l5lcPU1ofA+WZDHM4Xx0TJyaDI8gaiPjgspeHRcXTQqg7ZicMbTopdjMmXNpFRGKk
 REFox5s2WWx6knNEacEmdOaArdeouzsS1PvKv+shNpN1DUqH5GHoh+VubRttBraV3vTH
 fFog==
X-Gm-Message-State: AOJu0Yz4wfVxi5+C/hfEC2Y0d/j/uriRkc8xQy5+gpQ+5rDS8aeirKjx
 eiicFFnkISQzb7iALhZowT3AkI4RZZCMxZB/tTsjfKgdjPgnUK5ZXsxBraiODA==
X-Gm-Gg: AfdE7cnFXu5GU4YINo3Bt3Lga4z6kg/uYDL2ZrO5U0slCSI2D72EWXqJBMDYNWm48Fc
 yxfPN2Tb2M0jBEoAmuBScQwOPh6KvV2leJFbrj8R+MNVWoGNsWE3jgpuJQGxSBU61K8BY419p1C
 Gd3K9kJVV4pxuSJxNTR6B8nBHLuknmRCsoLC5YFNbFftaQZGtsxe7twngYUU0BfoE2197HLIOGk
 oUZCaFYZxR+0R9b9U/P05Nv97rasTotrvYiXplN11YTB8t1MXcVqGzxhbmF3nTEK+xw+WZZgjaR
 ivbmZa2BbptfK8/o3Uo9ddwssepNjZx8IoirZZy+zfsdjj1bzMtzY6A96LuVbhzDXxxR7pZW7j+
 x020RcK9NKFLivZjferrfdnU51QZEsUWYs6StfpJbmFrSQTM0zI0kSSYBkXSNrrUNzpQVUbKYlM
 /9s/5fL0ZbiEk+eQr2hX5Lbrkxk06Dn0J8YleJWHUbAE48CPjHaKKR1A==
X-Received: by 2002:a5d:5f0a:0:b0:47f:2dec:fd64 with SMTP id
 ffacd0b85a97d-47f488bdb5cmr7389318f8f.45.1784113080267; 
 Wed, 15 Jul 2026 03:58:00 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c4320sm15091094f8f.32.2026.07.15.03.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:57:59 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Dieter@nuetzel-hh.de
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] drm/amdgpu: Support DRM format modifiers on GFX6-8 (v2)
Date: Wed, 15 Jul 2026 12:57:53 +0200
Message-ID: <20260715105757.13125-1-timur.kristof@gmail.com>
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

Timur Kristóf (4):
  drm/fourcc: Add modifiers for AMD GFX6-8
  drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
  drm/amd/display: Support DRM format modifiers on GFX6-8
  drm/amd/display: Don't use tiling flags anymore

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 111 +++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 337 ++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   3 -
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  84 -----
 include/uapi/drm/drm_fourcc.h                 | 209 ++++++++++-
 6 files changed, 602 insertions(+), 171 deletions(-)

-- 
2.55.0

