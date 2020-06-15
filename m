Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE285C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 20:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFD42078E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 20:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQolmXab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFD42078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FF26E505;
	Mon, 15 Jun 2020 20:40:19 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214476E505
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 20:40:18 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id g28so17153983qkl.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AK1MhEB/EbkGRITHFPUbS0GAL+5l8T10Tpr4pwkxXzw=;
 b=NQolmXab7L7AiU/dbS4kM2rDXZ1cwW4x2wFhLZtJNTVfTuh2CRPDH8C9aO7M8vqra/
 ujkR+sgufi0wqHzTmsrmCJ46tHfM+pi9bUz9j2lYlOUoqLULpMjd2tYEr1ku+p+oC76R
 B2hpdSza/iynhcw93c+6MHAGqv9qddTpJxcYaBm2yJQ+p7GroxzR20ZqqeUtqw0uLHGe
 au6W/cZstWm0rCxJ/7Kfufoi2L+vwyF2xFVMeblw6Gh3hf+u3vHP12NVCz9/dMLw08SF
 p6e2QhU6d/Qr7K6u9X3s2JCUNJQY0NelMet2cEJEipECl49iJiR0D6yCuyDZu2Fu22Jy
 O79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AK1MhEB/EbkGRITHFPUbS0GAL+5l8T10Tpr4pwkxXzw=;
 b=MkGS4fU3ChVWbt/JoNUUEy97PfmaGlambWIzjZ7ekSHW0ga72T1qedPiLkx/3UthsV
 0rvBJaWw/ejqQENDxyWt0llrO9rqnmMqtEkzDke9PBsuXg9+N4dlfL3tBpXAHUVgXKNT
 /P2NuabB8ArFv7M0JYokrX120o1RDj1hifI1TlgVZeKwnqJhML8L2mgBfsWowKAo1YfH
 BepCoOUAdqlTapNV8gNDs8yK0qc5g9hve4C/p+6P7b/pnaUsBarTddIBRrQx/XzekRtH
 aHRzFZLaLDNG1RjtILG9W7NxQYrv27CLZ+NpO2Tga0ODpet4k8HTi6eQCAoH4IYnJ96A
 /D7A==
X-Gm-Message-State: AOAM5327s4VetFLC0bKmEScyGwwRO3mUIi1UEryLeTOzGneJN8cwBgdI
 7k08l4NH4ZGNas4N4W0S4tBGpsme
X-Google-Smtp-Source: ABdhPJwYKuQtsQMqu8ihCOWzwO/5vDjnKxHKikUqloLSkf/U+QgQLXAS3pVXWkhgEBGHKD2/hKzkiQ==
X-Received: by 2002:a05:620a:1321:: with SMTP id
 p1mr17186735qkj.476.1592253617076; 
 Mon, 15 Jun 2020 13:40:17 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e9sm12691903qkm.7.2020.06.15.13.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 13:40:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix documentation around busy_percentage
Date: Mon, 15 Jun 2020 16:40:01 -0400
Message-Id: <20200615204001.2477190-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add rename the gpu busy percentage for consistency and
add the mem busy percentage documentation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu.rst           | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 4cc74325bf91..17112352f605 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -197,11 +197,14 @@ pp_power_profile_mode
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
    :doc: pp_power_profile_mode
 
-busy_percent
-~~~~~~~~~~~~
+*_busy_percent
+~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
-   :doc: busy_percent
+   :doc: gpu_busy_percent
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+   :doc: mem_busy_percent
 
 GPU Product Information
 =======================
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 5a8e177e4f56..42bbdf49458e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1668,7 +1668,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 }
 
 /**
- * DOC: busy_percent
+ * DOC: gpu_busy_percent
  *
  * The amdgpu driver provides a sysfs API for reading how busy the GPU
  * is as a percentage.  The file gpu_busy_percent is used for this.
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
