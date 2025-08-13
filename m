Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D76BCA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 00:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE74A10E06C;
	Wed, 13 Aug 2025 00:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fFjgWDJJ";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1A010E06C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 00:46:33 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-7074bad03ceso71588166d6.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 17:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755045992; x=1755650792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CB08Mm+5oJmX1yP3kncEpb2aBObIPaLMBgeIquIAY/o=;
 b=fFjgWDJJZExke8pS+ODz3N2FmF54bupfNLqTxFYxiONg/Nvn05ObgPDFGskCuw+BIa
 QoIs2Ui5niYEo910L2TKvSwbzwSpANeSUBMTCghcVVACiTb84oN0u334yGxgjzfENVzf
 dwuVoEzMjI57UgHExIApE44QeGtaAahQoo5IG2KB4QgIs/OM2yMMCgN9i5AwHut08NLl
 nHmP15WYvAgCM2+MtiMTxr946X1oVm1SN68PfBxIZ7ozB7Io0o+m8kijt6dOe0wMqORW
 Sy3KcLeEYZEPbnmRr2N9TMfHDb+i/qlfCfiI2OdrLfFUNI7ixNtwNv57d6qYZgoUdq8S
 a5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755045992; x=1755650792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CB08Mm+5oJmX1yP3kncEpb2aBObIPaLMBgeIquIAY/o=;
 b=OznMRwHdGOsTdYker6f642C/SBm6Fni6vZX9mRz1OL8RM65flW9SJxh6KKj45u0+q+
 7ZiCEFUY+cbKTVSBeHrMPOqthJQbdBZxeqrqk8iDBMe8dEsGJEnI1l1nVK9ON7wR6X2s
 zjk8DbGovEZtJyiTorEIRO0i/EZ2QED9YXfdRWzvym8hP4fdWVG9LedK8cBf5a7r4xrl
 2lTzsOIethJfOS8YajVQw5CF4frsK2nv0nXREveXVXjLG5g77PH7XAOu3YAuDhDVKhuV
 jloXkxoJ/RDYkpNxtd15fArYVEnum/ZzifDkVxRXxEtkv178JftygJrztFUcxPT8CFiv
 xjCA==
X-Gm-Message-State: AOJu0YyXIsnsuL4tG53kD/k7UmHpLgV53dlBXIwvtM5GpgjH+yasZvik
 /TK8192RhWWZ1naxJ5DE+juDMCMFWbpornKAMaXK5iQHdpbDXcpCIDzMT7Ld7nIc
X-Gm-Gg: ASbGnctlnApA7bhuOcjdlawjm4miAlRXoUVTKr3LlOoEZiowBjsl6AsDNMmW1xeRBmB
 55NQXfqGhzimU8J2nKqPQ1p5lfWog4wCMAmybvY8DE5bXjva+u9vDLZk3NJBiKe6Ia6gi3vxfXo
 8tvvQCfs+Ec+KAqxq/XvSWTUMIAx9iOeOijvUou3eMCvaWE93kbZdQZGHBmqjlrFCBcoyKwjf34
 XLEEY4J0FsB9FynKwEF/wq9mqD+m7YDODe+jrSlmaj4golPLExo57omyiDNFoFBVr3DHvWfnjdQ
 frVu6ngfLjFCWruu7OO6+zr5VoBk3Z/Tr7rqqsdnCPWNwi8PHRhJWAgj5ouddVY/zgzBVhUeo2V
 TouxBOZocVAY9YxKA6v+Us0fLsME=
X-Google-Smtp-Source: AGHT+IGi3x6vaycVwYiMwcVeJcc6jqGOcbN+SGuJ/6w0d5fEeTi7ZQ+aGNQ7xPd5kWLylyCmBLQZ7w==
X-Received: by 2002:ad4:5947:0:b0:6ff:7678:bd0e with SMTP id
 6a1803df08f44-709e87eaeeemr14353156d6.8.1755045992518; 
 Tue, 12 Aug 2025 17:46:32 -0700 (PDT)
Received: from Xander ([104.251.39.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077c9da570sm183896206d6.18.2025.08.12.17.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 17:46:32 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH] drm/radeon: fix typos
Date: Tue, 12 Aug 2025 20:46:25 -0400
Message-ID: <20250813004625.111508-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
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

Various small typos found around.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 4 ++--
 drivers/gpu/drm/radeon/radeon_test.c   | 4 ++--
 drivers/gpu/drm/radeon/radeon_vce.c    | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 40b49bd4a10b..5328ff18ed61 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -555,7 +555,7 @@ int radeon_wb_init(struct radeon_device *rdev)
  * cover the whole aperture even if VRAM size is inferior to aperture size
  * Novell bug 204882 + along with lots of ubuntu ones
  *
- * Note 3: when limiting vram it's safe to overwritte real_vram_size because
+ * Note 3: when limiting vram it's safe to overwrite real_vram_size because
  * we are not in case where real_vram_size is inferior to mc_vram_size (ie
  * note affected by bogus hw of Novell bug 204882 + along with lots of ubuntu
  * ones)
@@ -563,7 +563,7 @@ int radeon_wb_init(struct radeon_device *rdev)
  * Note 4: IGP TOM addr should be the same as the aperture addr, we don't
  * explicitly check for that thought.
  *
- * FIXME: when reducing VRAM size align new size on power of 2.
+ * FIXME: when reducing VRAM size, align new size on power of 2.
  */
 void radeon_vram_location(struct radeon_device *rdev, struct radeon_mc *mc, u64 base)
 {
diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeon/radeon_test.c
index c9fef9b61ced..818554e60537 100644
--- a/drivers/gpu/drm/radeon/radeon_test.c
+++ b/drivers/gpu/drm/radeon/radeon_test.c
@@ -455,7 +455,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
 
 	r = radeon_ring_lock(rdev, ringC, 64);
 	if (r) {
-		DRM_ERROR("Failed to lock ring B %p\n", ringC);
+		DRM_ERROR("Failed to lock ring C %p\n", ringC);
 		goto out_cleanup;
 	}
 	radeon_semaphore_emit_signal(rdev, ringC->idx, semaphore);
@@ -481,7 +481,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
 
 	r = radeon_ring_lock(rdev, ringC, 64);
 	if (r) {
-		DRM_ERROR("Failed to lock ring B %p\n", ringC);
+		DRM_ERROR("Failed to lock ring C %p\n", ringC);
 		goto out_cleanup;
 	}
 	radeon_semaphore_emit_signal(rdev, ringC->idx, semaphore);
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index 761e8b453e1e..0b9bca3860ba 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -86,7 +86,7 @@ int radeon_vce_init(struct radeon_device *rdev)
 
 	r = request_firmware(&rdev->vce_fw, fw_name, rdev->dev);
 	if (r) {
-		dev_err(rdev->dev, "radeon_vce: Can't load firmware \"%s\"\n",
+		dev_err(rdev->dev, "radeon_vce: can't load firmware \"%s\"\n",
 			fw_name);
 		return r;
 	}
@@ -126,7 +126,7 @@ int radeon_vce_init(struct radeon_device *rdev)
 
 	rdev->vce.fw_version = (start << 24) | (mid << 16) | (end << 8);
 
-	/* we can only work with this fw version for now */
+	/* we can only work with these fw versions for now */
 	if ((rdev->vce.fw_version != ((40 << 24) | (2 << 16) | (2 << 8))) &&
 	    (rdev->vce.fw_version != ((50 << 24) | (0 << 16) | (1 << 8))) &&
 	    (rdev->vce.fw_version != ((50 << 24) | (1 << 16) | (2 << 8))))
@@ -281,7 +281,7 @@ static void radeon_vce_idle_work_handler(struct work_struct *work)
  *
  * @rdev: radeon_device pointer
  *
- * Make sure VCE is powerd up when we want to use it
+ * Make sure VCE is powered up when we want to use it
  */
 void radeon_vce_note_usage(struct radeon_device *rdev)
 {
-- 
2.50.1

