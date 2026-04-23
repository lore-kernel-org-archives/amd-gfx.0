Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5509BFAD3E5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBC810E0C3;
	Thu, 23 Apr 2026 01:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rKklVerH";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9323310E0C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:18 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488ad135063so53638605e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906977; x=1777511777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6HZxqiDcYpB7jbl+KGPwa5BjjQDg9zh6SORexTr3XwQ=;
 b=rKklVerHf1fWi4z48sX6L1XDfaff9LOBJdE2HnrSc+uIGghRhDuONEDKKFiTGiv4xJ
 8n4lQ9mUIu376cDa08rPRjh7OSR1iSjcyTH/Ia+iTFJYQ2n3By6kT07ddPcyjYMYv/hr
 xGZTelf7JvmnayozDBHF5N5860vCygFDO+hKireUkV1GKUM00CGfCRRgSs5UU62R4Ljz
 pY75iz5HU56hJtpXJ4NctzN9bttTLTu5SJFU0aeqF1BFcM+4eGRK13JF/suCR4GFD5R4
 Yvp21WxMV1p1Rys+HGbULpRKncNr77TbuTUIUpwPOZ/sJP4FTYyGQJsWaZ8BqtAXZNvT
 +xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906977; x=1777511777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HZxqiDcYpB7jbl+KGPwa5BjjQDg9zh6SORexTr3XwQ=;
 b=S35Kac+N3DlYQqheBDYQfpZvDAULJyFVDr6VOTqCrvFF3CrNs0XF6l/VmIOZElRT1t
 JPO+tpERDuskT+BMdGCKCvYG3gahRhKdk/L7FqqNuWipKurte8McIN21p58CizINK2G1
 KsOYVQtWuMnHbVDnwG6HFeNvtyXejLEN7iNSYGP57+ofEI2oHFgpzHOPFozaRVRsDR2N
 qjiVbHhlWAZL7Cp+ZCeVk0NYU/G71MLJntH76lZTixfOgzROMKIA/LvxsLom//5lz4Gs
 +fyk0puW3Vf3Lrp22S7fbQFQldT1NPPprW1I2LC6fyj0DBHfJg64FgPD+QsMbZcptxlt
 S30g==
X-Gm-Message-State: AOJu0YwOl0D2d+kGwJZmlbjDQ+yp8SvM8pi8UTjmD7LLVcJM+hDn5HRi
 XYie92nIQEjX4rDkRcn0C9FHpiFfL+fUZ5cxD7hkfFCUNMmySaQBOQXoqXPUaw==
X-Gm-Gg: AeBDieu1XHsKVGf+5rQ7PQLwWy9KEuxZ6QgROBpubDhP1oH1kKV21qbRTLnA9yVb27G
 XF0pqCtJF/7IetoQ1t7DiZnJd5R6Har+5ZqiDGNt9EteQO1sIsI2ZDTv40kl0WkDnCnGOapcZ2m
 O7KQQxr/Oc+5lFLzw+v3zrNsj+WiUGcAukt3u9aJYtTfXQI+Qvx27bHSOwVq2Myw8w1wrjBjM69
 uwhwrq5QVnqe596M40/briUxBMPAJ2ErDtBDyEcxjHQ5oZKexBiaZ6QwBVOpaDvRYFFBiopcs5A
 7s9DxcRQqekANf6CAYVfWQ5rNVw3xZlAQobfuifZ8puAk6sPUJ2AA2jKtH138MV+GaV8AYxsywv
 XyOetU1aQVJvbCptQq/tIJpwCseoV57RoXYO9/jFptwo1t2qxrefSR+CoBZ9EWvhAYgfRozm037
 5k/beEMfZcpBwwDADDBSx0+9w/V2Xi+IeUUaF7PFe7og8OaYrfPgdJfBHhI5G03+HzahOfZIN3N
 tZa1w==
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id
 5b1f17b1804b1-4891ca2ee65mr210545995e9.11.1776906976834; 
 Wed, 22 Apr 2026 18:16:16 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:16 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/11] VCE1 fixes (v2)
Date: Thu, 23 Apr 2026 03:16:03 +0200
Message-ID: <20260423011614.309180-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fix various small issues regarding VCE1
and the workaround to ensure the VCPU BO
has a low 32-bit address.

Also fix an issue around firmware size
and offsets on all VCE versions.

Timur Kristóf (11):
  drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on Tahiti
  drm/amdgpu/vce1: Check that the GPU address is < 128 MiB
  drm/amdgpu/vce1: Remove superfluous address check
  drm/amdgpu/vce1: Check if VRAM address is lower than GART.
  drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
  drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
  drm/amdgpu/vce1: Stop using amdgpu_vce_resume
  drm/amdgpu/vce: Check maximum ucode size in amdgpu_vce_resume()
  drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
  drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets
  drm/amdgpu/vce4: Fix VCE 4 firmware size and offsets

 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c       | 64 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c       |  6 +-
 7 files changed, 61 insertions(+), 37 deletions(-)

-- 
2.53.0

