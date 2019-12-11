Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BF2C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 16:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5838D2073D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 16:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb+GARdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5838D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10DE96EB7E;
	Wed, 11 Dec 2019 16:21:22 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA166EB7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 16:21:21 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id 38so6711107qtb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 08:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W5hchyKJPLWhRzJPdVPEfNO2uF5WNfArtaeT/M/J4o4=;
 b=Fb+GARdqeNXYUHBMbnnivbDyyWx1Dax4kPPncY3rh+oyANHrxTRkZ3qzmWuyEBQV9S
 DrZ/QorlQCD7dRByoUYbB3Eogm7d+qI7n7QHzygsv1iZ4gKd4J4WalQ4SpnYXWniZnIz
 +2WCjO2lzi34Wf89GpPa0rchUNhjm8K9zcAkRtuVRI8sP/SKsYzgpyk7LLzeW5DtdBLD
 X1FkwLHR0+PbYU7cTu/cbb6ch3qAHMuhG7gnCR/Dc4Zx4Dr5EkD/VuONr3R63oFqscfX
 4okLZ0bzscO6XGb93fpMfJj0YO2+UCuQK1s6iLjlY2yj1iWj14kaL3iwH6zu3obDSMA9
 +M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W5hchyKJPLWhRzJPdVPEfNO2uF5WNfArtaeT/M/J4o4=;
 b=H204Z0QzITEz42vIajwH5GWQt3ErG3ahKYZvzzsK+n70sLGemATnaLPuvfhAUU0BJx
 gqQYtg3RTXdu0DaBz2quTL0mMBrctZtWlyAv4xJ+8r/Og6QJ/va7wiJQYtwLbbDUwA5P
 nnWW2Av1Pzl3hLUqGHIRmKYL7JU7wcjd0DzZ0YWH9pzTFaZKGyIhkq83MG55WaxLBoBt
 SVk9MmACgsS48jEPweAmxJJc/dl9MN3DHHAu9QDaI+A9eDui3+eeDMTYCXOV16FFxWaG
 8JQ6M1EEndOkYqYNxm0Ly+7kre3VkYZkrnj5fg7yn0ruuFutkhie3nyRHcRInqgOhofq
 uMnA==
X-Gm-Message-State: APjAAAWzOOh5szWILkKLCGlHsq3FLOJ48em+X+4//ssbxpXJN7e4L7Jt
 N4NvceR23BlUvojCDCGqJt6rthcF
X-Google-Smtp-Source: APXvYqxKMWKNbdGcZsE97pf+WR6FUbRDmmGhuo5aBrI3QDjpgHsR4b+fhEbuPwx4doZlfkGuvrAXBQ==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr3551607qtj.104.1576081280387; 
 Wed, 11 Dec 2019 08:21:20 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id g18sm660340qtc.83.2019.12.11.08.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 08:21:19 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: s/ENCRYPTED/SECURE/ on GEM create flag
Date: Wed, 11 Dec 2019 11:21:12 -0500
Message-Id: <20191211162112.1991270-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
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

Rename to SECURE to align with the CS flag naming.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Several other teams thought it would be cleaner to call it SECURE
since it aligns better with the CS interface.  I don't have a
strong opinion either way.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
 include/uapi/drm/amdgpu_drm.h              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f39012e4a0fa..0691692f096e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -227,7 +227,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
 		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
 		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
-		      AMDGPU_GEM_CREATE_ENCRYPTED))
+		      AMDGPU_GEM_CREATE_SECURE))
 
 		return -EINVAL;
 
@@ -235,7 +235,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
 
-	if (!adev->tmz.enabled && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
+	if (!adev->tmz.enabled && (flags & AMDGPU_GEM_CREATE_SECURE)) {
 		DRM_ERROR("Cannot allocate secure buffer while tmz is disabled\n");
 		return -EINVAL;
 	}
@@ -261,7 +261,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		resv = vm->root.base.bo->tbo.base.resv;
 	}
 
-	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
+	if (flags & AMDGPU_GEM_CREATE_SECURE) {
 		/* XXX: pad out alignment to meet TMZ requirements */
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 2eeafc77c9c1..5728e5a27fb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -232,7 +232,7 @@ static inline bool amdgpu_bo_explicit_sync(struct amdgpu_bo *bo)
  */
 static inline bool amdgpu_bo_encrypted(struct amdgpu_bo *bo)
 {
-	return bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED;
+	return bo->flags & AMDGPU_GEM_CREATE_SECURE;
 }
 
 bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 918ac3548cd3..2ae80d31aecf 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -135,11 +135,11 @@ extern "C" {
  * releasing the memory
  */
 #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE	(1 << 9)
-/* Flag that BO will be encrypted and that the TMZ bit should be
+/* Flag that BO will be secure and that the TMZ bit should be
  * set in the PTEs when mapping this buffer via GPUVM or
  * accessing it with various hw blocks
  */
-#define AMDGPU_GEM_CREATE_ENCRYPTED		(1 << 10)
+#define AMDGPU_GEM_CREATE_SECURE		(1 << 10)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
