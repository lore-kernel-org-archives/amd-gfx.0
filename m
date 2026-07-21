Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B96C4451C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A6310E931;
	Tue, 21 Jul 2026 11:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRscJ+p9";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07E6610E931
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:28 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so829045066b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634206; x=1785239006; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rJaXy4eiZ/R+QixSif/Ul2tLSB9RBhOjDNwmi6fxvQY=;
 b=bRscJ+p9GFyP8K+8MauaOwyGmBW9Ee1koxunUYxZESJxQR3NI6ybHZG27ceR1vKwDy
 i6+Bjy39JUjZqTIE1UAshoAfSquZJ3dKOVerX/4cD6NIQVRT3YO7MkVg6HegEE0uKkiK
 5Zl4AQ2L5qXoun3fRl10LHgsUmwSGHO9cx8+e/yaKQhlOa67HgR2HOk1UAlgmi5xF9uB
 3z/m0mKOVOlrt+l/9C+JsG7oukJz3bbGB7Zpa03h5JTi+pcDt1PCbxTOXAVkdjFE4GUp
 YyxtTwn2lt6vQxk0v7qRmUxfqbFYpq3gqN3/yOk2xl8mVW5CAGEYdRwPX87ZxHgD7vgp
 7XGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634206; x=1785239006;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rJaXy4eiZ/R+QixSif/Ul2tLSB9RBhOjDNwmi6fxvQY=;
 b=LEV4qhDR0VoKgorF6RCvdFjiMCmaNv27OEBmenXS75gkhiuQtklQ2FBzZ0mIrfYErA
 WP0WoHJxfTb9qOrstt6+XjZTsbm0TbFj0oQMgrNkVuT+qowj0pGQskmGuorpiA2E5AQ3
 Kb+bp3NDWb1id6q1I818SbNmh+a+/0gOuaNTCB5WPe0ea2ts0zRNIeXsfgCigUREbTYW
 tcKmYGL4EhuZ/XGOo/LbozEJO/HhcwR8DOt+PUis0yKKiGbkHnD+6erYzfbb6+Ej6O8q
 w9Mnnw1xqa6ztFrmiSB7v6qAUdowfktWJoK7jVYou84TIWbAajJ0uo+TOE+QcUzYQKXr
 NSRg==
X-Gm-Message-State: AOJu0YzV/FtsFyzli+r2QR+t/lQ9tUu/ERZw+vj+c6Z/E6y4fEHTlpmm
 E2hnqzh46Hjm2uh7aR3dOdjZEwdMB7SmleZ4G2Tl2+hn34W4Q7hMxVwdYBNQYw==
X-Gm-Gg: AR+sD12n+sM7ZbKDQXqalZda9wjetrRTnUPrxdnyEPZHqB6g8Iw36MzGF5hqADAEZW2
 3+uwgvQpPrND0X/301gg/PhrM77zz+v74qmnx86T5dITKkfLrDUgiixsrImYtPegi0TnhMdCOUE
 iK7A9ExoADHFwN17HuaMzfPC5oDE2kyc4lxMnEKnmRBdQsE94y4UwH74dp2LLMWLwLEEYdZEo0M
 LLTb7E/ILrxqRJ4g4c5SufGNRxmgW3KQ5tDJJ1xvLXOu7ILzOANtSsJRKtQWvwKTMINYOzI+sbQ
 RENSvkZeGk1FwaJOwAa+mfUgioFh0/TpZUvsVjgFV/qZicrKheQKitWQir+kcIIQW5SwSdTNPEM
 hIHfDLU5g6HPwKe25zzmoYjKPWBjeBl4oKIvJgDwUp28AjjlF6VezZ2OzXBuFs57XnDRh0ZD2jP
 OvAbznLg7Ymqkmxtt+xlK2E7Uy4Dvwy9Q/A7pAy2SEeEE=
X-Received: by 2002:a17:907:1c06:b0:c11:efec:6ca9 with SMTP id
 a640c23a62f3a-c16b4699a22mr843301166b.8.1784634206071; 
 Tue, 21 Jul 2026 04:43:26 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/9] drm/amdgpu/gfx7: Use GFX IP block soft reset on GFX7 (v2)
Date: Tue, 21 Jul 2026 13:43:13 +0200
Message-ID: <20260721114322.17535-1-timur.kristof@gmail.com>
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

GFX IP block soft reset has been implemented as recovery
method so that we can have a way to reset just the GFX
block without resetting the whole GPU or losing the
contents of VRAM.

Fix up various things in the GFX7 code to prepare it
to work with IP block soft reset. The main challenge
was fixing up the MQD/HQD handling to ensure that it
doesn't hang after the soft reset. There are also
other minor fixups.

Rework the pre-existing GFX7 soft reset implementation
like the reworked version on GFX8 to make it more robust.
In practice, this means that it will now reset everything
in the GFX IP block (instead of taking a guess at which
parts need to be reset) to make it consistent, and it now
also handles clock and power gating to make sure not to
degrade GPU functionality after a GFX IP block soft reset.

This improves current user experience on all GFX7 chips:

On Kaveri and Kabini there is currently no working
GPU recovery method so those chips currently require
the user to manually reset the computer when there
was a hang.

On Hawaii and Bonaire, the current GPU recovery method
always clears the contents of VRAM, which means that
a buggy (hanging) app can crash the whole graphical
session, which is less than ideal.

Using GFX IP block soft reset means that we can now
have a working recovery on GFX7 APUs and we can also
move on from GFX hangs on dGPUs without crashing the
whole system.

Tested on the following chips:

Bonaire (Radeon HD 7790)
Hawaii (Radeon R9 390X)
Kaveri (A10-7850K)

Changes from v1 to v2:

* Add more explanation to various patches
* Address feedback from the review of the v1

Timur Kristóf (9):
  drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable on GFX7
  drm/amdgpu/gfx7: Refactor MQD initialization and finalization
  drm/amdgpu/gfx7: Return error code when compute ring tests fail
  drm/amdgpu/gfx7: Return error code when failing to start GFX ring
  drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
  drm/amdgpu/gfx7: Clean up gfx ring during reset
  drm/amdgpu/gfx7: Use COND_EXEC
  drm/amdgpu/gfx7: Fixup IP block soft reset
  drm/amdgpu/gfx7: Enable IP block soft reset as a GPU recovery method

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 331 +++++++++++++-----------
 3 files changed, 186 insertions(+), 156 deletions(-)

-- 
2.55.0

