Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95A1CDE008
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A6310F14B;
	Thu, 25 Jun 2026 07:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HTr58yUD";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FCA10EFF6
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 17:21:10 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so8330215e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782321669; x=1782926469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TbgHCjopHlS/2Xfh1jkQjyRfQ4ZwvIFloenkAWi04I4=;
 b=HTr58yUDoCrXBJdS3SUqhMyTjkggeh1sqzgWyPd13oXEDvZTGY/FO7HPWF7EF0jMzD
 i7XIL1oBpNg9SB2J9siHWTIAQ3kwFmqzvTWw+5QO2OZ0RdVZlYMSQREI/HQNMWLVrd5q
 XVuT/1+O7vN+nzadZsYLMWwYeJVGGPSnkCjfZsvHspc3HEmNpQj+GvpgcQhMFbya6A4P
 T5MmKVHAsiv5YHyuz7GEIajWkJztema/DashMxT2gdq21q+uJzn0fs7fXBRKERyMszKb
 hFOQz9nttYCbwjo2TcwvODYvO5dvj1IBp0B9WSjDwCTK8FTkdMXEe1s1tlZ7ceyq0qOa
 d36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782321669; x=1782926469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbgHCjopHlS/2Xfh1jkQjyRfQ4ZwvIFloenkAWi04I4=;
 b=KCOLL3H5NDwLxm7knu5rGxNb8evcPf1YJ34jjClIKvlhQorLSqxExPe3z53D9P6REk
 XLzxaJ2LKPViBmeUYi7dyJKBLB97A+ThOtB+jtVuxX5w57cfRm45d4i7s2EAq2hm7WEa
 MGQ2gx/lrEI/Xg95pp2ILxZyWZBNEfinwXYbdq3nMj7u020jOkmVa1TIBeb/oTEKdMzX
 ApH47Y2ZlkOjgD8FzYQRwl6Png2udVddM7XQBuxW0vrRDbPCusPpm2FJrUEYhJNsKs9b
 ZRKs7wO6xofH7u2D2KwOKLFZc4kAcTiF02wTWPbFlMupcYZtbjOHW/GXoMOhePRBsfXr
 eEFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yIycCHbHtn2+DJY1CWNvP9XDQrd0PhH+HPdbJmXjyfCdbnIHCOWAWWO8d6bg4UUBlUpqStBV7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKZ+34sAgK9ljCIfrWC0A5p+e1seWotiLVmreTQmbWCp2uI8vK
 p6slpxMx96SciDl39uC60avEmaOZUUiA5N9GheQ8sk9OzUh824Sok2U+
X-Gm-Gg: AfdE7cnTNntBAfnHzz/dNoCaamHM3lvgp3KVJawc10g1DTC5u76GGattMolLSJqC6rW
 XZkz1GfbMxqncBekxeknYZQpPZLSa9dNY7iL92lkCASaRlppomhFoS1mlk3WUJ7Szfxo6bT/yfY
 IJ7vW1skrkJmQL0Y4Ae381xCJgAPvE8fwhR3geqfaiWenlbt1WybwHyF8Pg9gxl/mybeHsFkFYw
 vECpPhyIuptZDC2kYJ3HuwOOz1A2nem7sAvfG9uNcCNUh7ZfnFMufCW4GuEaLv2qd7l+C9wHeCC
 vAQ1mHMdcPCcmjGPzNKl3qgY5c/3ViW30rLQr8wtA3r66YJpMu7q0JqtqT7abLZo5bVxTTbQSgC
 Iq5PeMWdCRF4fYxPtyS+vrK1G0WCvfm6BxQNfkyuMHabUs6053zEVTtBj4pNiLv2/2vUdyT4pVr
 X9Ad5Dikq8Ck3Om2hJ9IkCmrEqjA==
X-Received: by 2002:a05:600c:6290:b0:492:463c:48b7 with SMTP id
 5b1f17b1804b1-4925b379813mr131866485e9.22.1782321668471; 
 Wed, 24 Jun 2026 10:21:08 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49264021121sm10826125e9.4.2026.06.24.10.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:21:07 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] drm/amdgpu: reject mapping info for unmapped BOs
Date: Wed, 24 Jun 2026 19:20:29 +0200
Message-ID: <20260624172029.2508-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:56 +0000
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

AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the BO's VM mapping and then
iterates the valid and invalid mapping lists unconditionally. A GEM BO can
be queried before it has been mapped into the file VM, in which case
amdgpu_vm_bo_find() returns NULL and the list walk dereferences it.

Return -ENOENT for an unmapped BO, matching the VA operation path that
already rejects missing BO-VA state before touching the mapping lists.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 212c14d99..4b2699931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		struct drm_amdgpu_gem_vm_entry *vm_entries;
 		struct amdgpu_bo_va_mapping *mapping;
 		int num_mappings = 0;
+
+		if (!bo_va) {
+			r = -ENOENT;
+			goto out_exec;
+		}
+
 		/*
 		 * num_entries is set as an input to the size of the user-allocated array of
 		 * drm_amdgpu_gem_vm_entry stored at args->value.
-- 
2.54.0

