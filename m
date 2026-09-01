Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE4BC61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8316810E05D;
	Tue,  1 Sep 2026 08:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hskRMr5h";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9964510E05D
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:26 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so6099205e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252085; x=1788856885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vdKp3llpMgaPy+5MQeXB7wWJLzP54FWaaS+59JGIb00=;
 b=hskRMr5hASl6sX+n0mEetJKw1hDRw2dvDVK+CtvJmfNzOS0znJYyTo13pFMzIgY5zd
 RdmhFyN9vY6EkFfkFfa0pL3Hcp2vwK94+7Rkh6ifCbK6LmNJ0QOngLXCvOipNgSFAmAF
 yeNGdNxbKvYYXc2fKMeavTxoGPs47q//y6NDhv51zdLfz5NKGeALYoGV1iQDw3+l6qKj
 07SHtlnuxnpFtjXpJ/zGIJb7gDHxKc6kxtvIlY/kaCQpGW5KS6PEv29Kdi+MjMcnllAf
 zmq2CMEaRE6HYQpDrvoUfEW3okILCCJlHDMwCKX/i6ORj4EmXDjDJ3WdJCtJ0o08f7yO
 9KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252085; x=1788856885;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vdKp3llpMgaPy+5MQeXB7wWJLzP54FWaaS+59JGIb00=;
 b=OgMQGp73mN9Vh2kEji/ASQ7vE5d1+d45w8ulLjg4z1pxaaLNwO+xLDXT7vUH3V63K4
 +AY68XXC+WtlM5kgw9DpTPigzv+G+KzR2gyHwhL0VM210cDu2vA9V8ERArVIxrGDrp2Y
 KrXnJVwqv/ihIvvHqa7eJWqFhyb37q/pQ/fj/Mb0sdufiYFlqwzOpVQkeXwQZUt8KK0a
 v0br7u+zcd6vNPEOpRGfOMXK1el5+n2IfDoKhdRPnTsYpx6SINLTWE8uAIcUKShFgexO
 a78ogClTCCE1dYtT04YbaeHrwqgrsGUghRnyYjoN+SFO0KYYNL9GqxSYZCBwDIr3v3sc
 q8SA==
X-Gm-Message-State: AFuF++l4h+syZEmaZnbOKnI9mvzp5ffEueAJbQQOyzcEhVYGfzh/oc8P
 G7BZKlxk1s7t3Wx+0+IhtuRd6jZrpAKP+KfHMvCDT7V0YTr5/FT8UjRIvMJNReJOz6Y=
X-Gm-Gg: AR+sD115Y8PW93Ey+pwRyJE/1AKje0pHBGdSgqZibWzlw7nStlUFvTwmsiCnu6c4X0d
 XAgnRPpAd6p0bT2+D5wGV/Se2HvQ62r+yFsxHz8l1m1kxisAiTXL8nv4YWmD4Z+mgUJTfUk3FK4
 xwaEiY9W+U0eKsnRwTHPlWR18wCueaUnB1dEBbN6/vX2K09fwSsQ/ugoX9al9SxYY9kHL+E1c6q
 W+h4QlS3kdMi0SaF4vuwWvtjHnAWxYeRXT/bk//ivV5Ea1WH4fsGmSIVm4SmnwN1p7yNt1oGKty
 rnV73y9f2FMhWEHZqTkQlz9G3t50ZiKI2EC/RlcCVkclOY8ElW0/1MiaUvWcTJ89Eg2mprzmh7+
 dsi9n+Sf/u4B+gY6sYB5tVo/6B1QZRhvxqGJ1DAkfuFUYplgZhjnPOczSAfkihyFvroq2vdUS/y
 69F+pXAfktsKObXvgLpHIJ5rJUbhEbTNatmdyB7ruYobWeJI6XVKEh60SspRATYt6UaVOPXCsw6
 6eDecEg90aNkMduk/zp7js=
X-Received: by 2002:a05:600c:a55:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-49b91c4cc2cmr559891375e9.13.1788252084653; 
 Tue, 01 Sep 2026 01:41:24 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/8] drm/amdgpu/sdma: Improve existing SDMA queue resets (v2)
Date: Tue,  1 Sep 2026 10:41:07 +0200
Message-ID: <20260901084115.262457-1-timur.kristof@gmail.com>
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

Improve SDMA queue reset for SDMA v4.4.2, v5.0, v5.2
and also moves some functionality from backend-specific
code to common code in the amdgpu_sdma.c file.

This prepares for implementing SDMA recovery
on more generations, as the same logic can be shared
with all SDMA HW generations that don't use the MES.
The actual recovery implementation for various
older SDMA versions will come in subsequent patch series
after this one is accepted.

Changes in v2:

* Added a fix for an issue in SDMA v4.4.2
* Further simplified some code

Timur Kristóf (8):
  drm/amdgpu/sdma: Remove unimplemented soft_reset() for SDMA and SI DMA
  drm/amdgpu/sdma: Remove superfluous rlc_resume and rlc_stop functions
  drm/amdgpu/sdma: Fix executing duplicate commands after recovery on
    SDMA v4.4.2
  drm/amdgpu/sdma: Remove unnecessary guilty tracking of SDMA queues
  drm/amdgpu/sdma: Clear SDMA rings after reset before starting them
  drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
  drm/amdgpu/sdma: Always handle kernel queues in
    amdgpu_sdma_reset_engine()
  drm/amdgpu/sdma: Use common SDMA legacy queue reset on SDMA v4.4.2

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 109 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  11 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  32 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  30 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  38 +----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  40 +----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 158 ++----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  60 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  52 +-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  27 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  27 ---
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   7 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
 15 files changed, 109 insertions(+), 488 deletions(-)

-- 
2.55.0

