Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3224C79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841F310E79D;
	Mon,  7 Sep 2026 20:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ml/rHLuG";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5C210E79D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:30 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48436216a98so2666250f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813209; x=1789418009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iAKf5ka9BsNib613bsvHcKVDS+SJcGZNnQhLviHDuko=;
 b=Ml/rHLuGMKsibVQparT/kxZOmNRiGsrci0VxooGw8n6IMwIi4E+f6UgQ4usurydqdD
 iQgn021fxElOr9kTlke+r8js/lcsdWGDSiFyqlBwGvKTV9gSjbN+IwOQLmdbDWP8lCcx
 GrcU6B4lba7QuOYNl1mQK0p1f5mX6hVzmeMw7CwuOhBpWIyug3m2N0pY+ScjNxJNwM55
 5vn+bzp8ANn6WI2gGMmoHRgdDeMGI6p3P7vVU6Y19AWVuYEasdqD7y1uGQtUFoMIXzcG
 gNoiGi9Lx4uh9mNYAVFvp0X/egCwy1ETYvS72+KzAv3ouGVBbgYGWz6MLEe2+PM5xnHW
 GlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813209; x=1789418009;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iAKf5ka9BsNib613bsvHcKVDS+SJcGZNnQhLviHDuko=;
 b=rI4AkNzVabRUJPabhJ5luDK6Ure6fXSRxKJjOtBpG0Bgqk73OVb+IS+fG8utGWhBkl
 ETZnf2KELDG2Li3cPTJKY5aoljOoiEdFyKJa/0gB95QtsV8BoTyOIPEK8qyiqfcstIkG
 W+s/kW4rNgNq+1Q6rlOOjmV/sFl3fJFR5VllJipqV4YFC/4GGIsK4J2HsuhNAvRMCBAD
 NXVoyzDtoz4vD3r39AuJHuXVQfuhsgX1ybP87zEjjkjIoEiD+e7WYPA9FloI3Gut8a0N
 BczuVR61jnp2+meKW+A42FjTQ2/Y1+BLJWTYO9fOq67OJL8rGmI05NV2Q74IgXQ9zB1D
 ye2w==
X-Gm-Message-State: AFuF++n/g2yE9rrl8nBgaeZJUc4QPQvt42Gc1d3fx+0FyHoiCWQTHQ3U
 SlnN6TEprsoYp7AGW6zU09xytUXI3koNSuoiiwsYawDIgMKuc8G2KAPK8+MJxoNs
X-Gm-Gg: AYBFou0jlVD9ulwPGMSBD9v6sWvLZcpZduLdpGIrGELmZloapfwEEsx73x+fBhD6CcC
 q6hsBuRBaltXhWFycMpHT0cBqSAHwNu+HXg5aK++HgNIOlynyyqvHJ6mKJPmu00TOVCtRYmcNtG
 Q2wHF65aq02i2b4HKiIN4TzkH3Yqv2eRIXr2tNMAQ38nkrMJNypDFla4nByc0i0s5Szbw/93lav
 q9HDd2Uqk8+/3iQgjWUFYSc6wO5L2VA/rUpOk/0TPbrHPzbXPdUMluqlqb8WGUJ1QkV3Hkyw+UW
 y5Ip/ARy+MLOg1vARvDy5eIDjrXTtow6ZIlLwidV4U9OlLEZm+rvJNCpK9XK9iHBM5CzgoldP13
 mJFP2IYJudo9sot+2pZaD2db8z0DCy5c0lhSQhIUUF72Mcqu6dn+PPu7oC6G/ABOPwV/7Ze1AGJ
 cGSx7s4NeseSqtLa7kdep1mz+FtuXfUCzM9lhJvnCvk6FYR6UYjto4rLwqphl8i3DCiopH+3V58
 Gsz25E1suA2OfDWZAcU
X-Received: by 2002:adf:fa81:0:b0:484:3317:a19 with SMTP id
 ffacd0b85a97d-485872b896dmr22907481f8f.26.1788813209095; 
 Mon, 07 Sep 2026 13:33:29 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:28 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/12] RFC: drm/amdgpu/sdma: Refactor SDMA v4 and older
 functions to be per-instance
Date: Mon,  7 Sep 2026 22:33:04 +0200
Message-ID: <20260907203316.159103-1-timur.kristof@gmail.com>
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

This series applies on top of my previous series:
"Improve existing SDMA queue resets" (currently under review)

Prepare the code for implementing recovery for
SDMA v4 and all older SDMA (and SI DMA) versions.
Reorganize the SDMA 4.0 code so that the functions that are
responsible for managing the SDMA engines take an instance ID
as an argument.

This makes it possible to manage the SDMA instances
independently of each other, which will enable us to
also use these functions to implement resetting and
recovering them independently. (The actual recovery
implementation will be in a follow-up patch series
which I will submit after this one is accepted.)

Timur Kristóf (12):
  drm/amdgpu/sdma: Refactor SI DMA functions to be per instance
  drm/amdgpu/sdma: Refactor SI DMA clock gating functions to be
    per-instance
  drm/amdgpu/sdma: Refactor CIK SDMA functions to be per instance
  drm/amdgpu/sdma: Refactor CIK SDMA clock gating functions to be
    per-instance
  drm/amdgpu/sdma: Refactor SDMA v2.4 functions to be per instance
  drm/amdgpu/sdma: Refactor SDMA v2.4 golden registers to be
    per-instance
  drm/amdgpu/sdma: Refactor SDMA v3.0 functions to be per instance
  drm/amdgpu/sdma: Refactor SDMA v3.0 clock gating functions to be
    per-instance
  drm/amdgpu/sdma: Refactor SDMA v3.0 golden registers to be
    per-instance
  drm/amdgpu/sdma: Refactor SDMA v4.0 functions to be per instance
  drm/amdgpu/sdma: Refactor SDMA v4.0 clock gating functions to be
    per-instance
  drm/amdgpu/sdma: Refactor SDMA v4.0 golden registers to be
    per-instance

 drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 322 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 232 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 561 ++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 577 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/si_dma.c    | 160 ++++---
 5 files changed, 1043 insertions(+), 809 deletions(-)

-- 
2.55.0

