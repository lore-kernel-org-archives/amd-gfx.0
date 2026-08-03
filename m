Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E95C55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9BE10E20F;
	Mon,  3 Aug 2026 13:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EiAwPUeY";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9DE110E20F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:13 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so478466566b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763392; x=1786368192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rxvWOvmkmZu7Ipo1QVN2Np0h8jvNvmJlLTftfkaxD/o=;
 b=EiAwPUeYH9kI3zo9c58CIsXOURMfynpxAEUvAGDBgh7ZH9AAuEOiPNOokXs0D61D4D
 7oiJwZ8mG2zqRW02WNfMQFufx2RnljujeCK8ycmsCE5u1UOrZ6pm40vtNHAIwFaNaNuv
 AYvh5BKApRGy5QlgYajqmVNVAi+N5tFDV/5j6L27PEAGZgaf7fzXeH4jEu2LJFugcBPi
 B/qQyGmvabu+USisTadlqPJaMaeoAEYjfjoetPdt8dQBaFQlG/A1RvOd6nMGU1QPBa2t
 M32wlLlpgM9T1rsNFkVIa4ZGlKtuU07jT2W0gByT+YMF2pU9SnqOHcbc7qZGZNhPCOtT
 qiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763392; x=1786368192;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rxvWOvmkmZu7Ipo1QVN2Np0h8jvNvmJlLTftfkaxD/o=;
 b=YXJhmjBsemaSYwR592RWRbnKPbjGaJEI3lHC08ZvvzMbIhUpmWv+qOEkiQ083loVfS
 S5NBXis4QgcxAYctDyw148hXpT0v3iofUU3FMC9sbiB9D0khprDzDzRPpGXes0Pz704s
 OtDbotsgZUa+IXN23cjmEPgcDcjo53iWwxvzrDUOt2+3JKQs8tjfz63u3lnNHV6mFjuB
 1KOXKLalGUkymLwIIdWCb8snII3T91jUrHnFM/UjlcEQLNURgp47yPhwZTLjZHfqmhVO
 TWtq1lQQaxiVuTX0aKzVnKgtCa5KePxbdPVMvfokE0sMoLsr7coHcZpLxAp99zQLXJnH
 JEbw==
X-Gm-Message-State: AOJu0YxjyOplaKGDPefpzitzSRs0Let6D9/65ubn4k/sP/nu15ne2O5j
 bTRouacMMBiyDrpe+P9C0dVuTr2Fu7RPCQFXiUy6Syt5Bip/UmJ79CQBCpQH9OVo
X-Gm-Gg: AR+sD12ixLRoPUWky2BWQfqgeNKr1VyOO+OleZRkHA+0ErCVMetOD7c8BErYeP9mCsN
 NbEXqFfSbfIT4aLyRlfGzyUvOTMapZ6QPE3hPVveBdN0ejxuMnvlXDrihpLFMKpMG9ZT588Sowk
 3WmKu1WooTkbVHkFdRZXDm82NpsXNE+3LOuYKQDHeE+1PQBq1TFBqNooZ2swAIqGkU5WyqcuFQM
 8laNgoyE8Nqvw3nHRmnn2PIexoh0xISTXenpb3pdYpGLjlH67u4YehynmzpnmWykYR/xP8ziYzh
 muaTRGOM4haKNQ6nGMYAIH0OyYdo+APJ6rOeWVjFYAb5Dzg7qB+LbZOJs2MUw+eFYVTyFY1z7Df
 HtAdVsKaTrLaB/iR4H7G6XvK8qOTJvl7XSjYCBrMjsNk9mwk1LGm72k71VCFZXf+hGCR3JMuXoh
 NkG5rkQGiuFjI3BKDcJtReUYlmoPjCVI6lv3Tm5UoB03FhwWA1nxnLKO3/xfa0siDdWNj6Q7Rmw
 RMi1Ac+6SeRXWVNd0ZF89VvviIoIHC1wfqRjRmGww==
X-Received: by 2002:a17:907:d85d:b0:c1c:2007:298e with SMTP id
 a640c23a62f3a-c1fe81e7085mr707677966b.24.1785763391832; 
 Mon, 03 Aug 2026 06:23:11 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/10] drm/amdgpu/gfx6: Use GFX IP block soft reset on GFX6
 (v2)
Date: Mon,  3 Aug 2026 15:22:59 +0200
Message-ID: <20260803132309.36326-1-timur.kristof@gmail.com>
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

Fix up various things in the GFX6 code to prepare it
to work with IP block soft reset. The main challenge
was figuring out how to properly initialize the
compute queues so that they work well after a reset,
as well as realizing that on GFX6 the compute queues
also have a PFP (as opposed to GFX7+ where PFP is
a graphics only thing). There are also other minor
fixes.

Implement GFX6 IP block soft reset: just reset everything
in the GFX IP block (instead of taking a guess at which
parts need to be reset) to make it consistent, and
also handle clock and power gating to make sure not to
degrade GPU functionality after a GFX IP block soft reset.

This improves current user experience on all GFX6 chips:

On GFX6 dGPUs, the current GPU recovery method
always clears the contents of VRAM, which means that
a buggy (hanging) app can crash the whole graphical
session, which is less than ideal.

Using GFX IP block soft reset means that we can now
move on from GFX hangs on dGPUs without crashing the
whole system.

Tested on the following chips:

Tahiti (FirePro W9000, Radeon HD 7870 XT)
Cape Verde (Radeon R7 450)
Pitcairn (Radeon R9 270X)
Oland (Radeon 430)

Changes from v1 to v2:

* Add more explanation to various patches
* Drop patch that enables some IRQs
* Drop VM flush changes (will be submitted separately)

Timur Kristóf (10):
  drm/amdgpu/gfx6: Fixup emit_cntxcntl()
  drm/amdgpu/gfx6: Fixup emitting SWITCH_BUFFER packets
  drm/amdgpu/gfx6: Use PFP on the compute queues too
  drm/amdgpu/gfx6: Initialize compute rings before CP start
  drm/amdgpu/gfx6: Clean up rings during reset
  drm/amdgpu/gfx6: Execute CLEAR_STATE when initializing compute rings
  drm/amdgpu/gfx6: Adjust how harvested TCCs are set up
  drm/amdgpu/gfx6: Use COND_EXEC
  drm/amdgpu/gfx6: Add IP block soft reset implementation
  drm/amdgpu/gfx6: Enable IP block soft reset as a GPU recovery method

 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 374 +++++++++++++-----
 .../include/asic_reg/gca/gfx_6_0_sh_mask.h    |  32 +-
 2 files changed, 295 insertions(+), 111 deletions(-)

-- 
2.55.0

