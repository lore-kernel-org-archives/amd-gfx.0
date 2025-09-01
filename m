Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E223CA0FFD
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 10:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE32E10E321;
	Mon,  1 Sep 2025 10:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J7yIvaD5";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8603E10E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 10:00:17 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3cdfb1ff7aeso2037439f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Sep 2025 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756720816; x=1757325616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0W6YselyomSH3e7kgh1viyUyyFPEVUff9OsopCMlUUY=;
 b=J7yIvaD5UQqODqLQl1zUWV4XWHU+y8SWitTprhE2sSuI3N2odgF7nn2My5ZmsqTi98
 dHy9/A6TFg2jCD0M1MLxBWXnIO1kpPNWWmkiQhflSEnyhREp2uxfxTtJZKPMIN1JeMiK
 qJhP/GPx3XixR99H/7vZgSRMdLJ/61VXDQNBkhqu41OddpUbwOB1DX/6wk54npBo8dzy
 448yFn/zcM0su/FClLhSCQ4Q7pbVStE7rtKYffqoiv0i04AGDC9bf1XdvE2n/GHyRSIT
 aBJLSKTORxaaCLHCaGpzKFgxPAp/uLiYp0OWxxeJjdvZB2b/fR6PgO32lsymiB/kIB71
 bPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756720816; x=1757325616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0W6YselyomSH3e7kgh1viyUyyFPEVUff9OsopCMlUUY=;
 b=dxwVz1QD33Lf8+3RtPKbrY5njKayVbUDu35UW/r7Dc4UJk2V32dPhT4ljo4EGAJqgD
 jWn2Fjb7hkPAllgUKlLDCZDljQrExDQDEcGxcm4yMJpZWu08FPuwLAk8Sb3aN2VA6jZH
 yCS4na9n4ufzcT2fzxV2aIzbEgqPEnNFOz8N+SBr216upIp7tAk8BL2TPZUqUdQAoFZS
 A17Pgh5GMLcy6cPGBemcbPMAgOhAOuzalVkb7xGwogsxKdZhiNG7EY8Qmjv8pU2cG9Zf
 GejbbFv9Q9E+yecHYLdfH8zpJaPeq878rgY5WsYDa6azN53Eb/Gb64Y4c8kHU1UA9bj8
 YHug==
X-Gm-Message-State: AOJu0Yzka3S0Jg1qmmSKa0ZVWc31psH2X9LRAs7ojP2Z6lDda99lMvg9
 w0k4cN0ctuxqbFQswv4kpC6Gu8wbFMeE8T7yBT82YTfr8NSk3c4U2k8eUOg9tg==
X-Gm-Gg: ASbGnctPgEkB9+/vP0WdE67vUuhRMJ8TbKRt53kQuR9v5Dvqz2qekIhRR3T+FtY3EBH
 QneGkG2PZrE50exjCbM8DRO6QFR1CzjLTYwB5b3dfuktYUifZTcuL1tFGrqZf/9XS+1IOy4W0MS
 tYN24eNlCIrxo7fioy5s6Ia2K+16GbWq6pYdxdy3E/zHakZGt/tLfFBIdKlnv5Pn19CxWkeP+Q9
 Jl7KWf1fg2bS6hQ8EEtRwG1dO/gGlHAfsBM48nNvCfs/iKs7RaqUUBlntWSnOTpjx7DgVpSci1w
 73sYRfPNAK6kYT5TtueQ3+gVDNANZWL4tKAQpfycvupzTDN+RXuLbFFAQpUifKzzXp4Zel/nkLR
 gF4TkmGYEP8ZEMHZqvU1mITdxMgmSHT4PBZsaiqfGmixHGLoC3BbIl6WE4aLEtHifl/MezKLeen
 O8sxhBip7TKpw7awMZn0f7Iir/BQaVsOoH3Roe
X-Google-Smtp-Source: AGHT+IEG1O4ZkB8hkEf9fCwOa6+2gZ8XtZIoWobcJMtJ0yssmSp/nm50TB3r6fUkAfx1gL9xzpmEWQ==
X-Received: by 2002:a05:6000:1a8c:b0:3cf:74e0:55ac with SMTP id
 ffacd0b85a97d-3d1dfb108b2mr5922046f8f.38.1756720815201; 
 Mon, 01 Sep 2025 03:00:15 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24C19400D6AB39BC9D60A351.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:d6ab:39bc:9d60:a351])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf3458a67esm14679142f8f.62.2025.09.01.03.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 03:00:14 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/4] drm/amdgpu: Fix allocating extra dwords for rings
Date: Mon,  1 Sep 2025 12:00:09 +0200
Message-ID: <20250901100012.439155-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
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

The amdgpu_bo_create_kernel function takes a byte count,
so we need to multiply the extra dword count by four.
(The ring_size is already in bytes so that one is correct here.)

Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for jpeg ring")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5c..13f0f0209cbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -364,11 +364,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
-		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_GTT,
-					    &ring->ring_obj,
-					    &ring->gpu_addr,
-					    (void **)&ring->ring);
+		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw * 4,
+						PAGE_SIZE,
+						AMDGPU_GEM_DOMAIN_GTT,
+						&ring->ring_obj,
+						&ring->gpu_addr,
+						(void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
 			kvfree(ring->ring_backup);
-- 
2.51.0

