Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA90CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 11:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C0911211F;
	Fri,  6 May 2022 11:23:17 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF80911211F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 11:23:15 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id i19so13836469eja.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 May 2022 04:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AvC0oiX4mgP8fHfbPsPJ8AgmcICc2XQPgAkiAftPxJw=;
 b=pYJvpNDA/rRhBHrJFZpBk7E27MhrhQ4N/k8lZeMKC6LmeUg+9aM2/R0X0JYlIKnhQP
 IM2gH0mxDV4iprVHlqVzsxW4djN6Rtt5L32Lnve1vh8ZadhPJbXFPhpTGeMII/AsaGei
 kWllBMCouDFJBL/ptcw5JSB0FHm+o7zsaPrWEMCeu0Y7sO386XpFndBAqrQp7UW4kliq
 455s2wIcItm1pze1FSvsyg+f4QAv29GhRJRZ6XBOwZtMn3jUkvFjTkxXyH1BCVcJlkLi
 +nAHhAIquihQWiSQfREgjRPkm9nnPwLT64btTbTs8ph3LQU48Id58LN1L2CtfXuE6wn/
 dS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AvC0oiX4mgP8fHfbPsPJ8AgmcICc2XQPgAkiAftPxJw=;
 b=nYi4gKhLARRpPc+b92MDfyerTM93cuJ9lOdL876i1Y0dBBBj+7WNFHEy3pXhgCScaF
 3Tl5CXDCtHU3tfkdJffKuAu5KLeDqPBrdZKPdAPqQQg2M6nfLR0r8TsI7v0p7SkAkARX
 VOuVR8stsZltcv7Xt77+JunZqbCqoqQ3H9ISejHl/WZ8kanqsvY5kepn+3VDrfyc1+TR
 gh6YrJ/Lb7s8CPNWr8dp4JJRPtMPWp9+ywW1hyYFjM+6+ogWS/vuCJEDK1j/Ctxygjm0
 QZdRY2jMwO7kfsZTQufRHD+YxDkQgVNeF05otXpPDOhBaNs2INEeS8Ri8ZaX/R2uI29E
 JxZg==
X-Gm-Message-State: AOAM5308G7VksBl+yFA4/8kY0sCfj6N1GaQoqJsEFQvGNOLRMWUG5mb5
 SoNt1kqF8pXX57LnPFpPDEI=
X-Google-Smtp-Source: ABdhPJzfh1Exe3rG5U4UyH5XB+IWNi6EcHsQCeMwD2iCsYDv7in6pj4ecjfwYRdU7NeTrrZ6ojuTGw==
X-Received: by 2002:a17:907:7202:b0:6f5:17f6:3bc5 with SMTP id
 dr2-20020a170907720200b006f517f63bc5mr2464669ejc.279.1651836194289; 
 Fri, 06 May 2022 04:23:14 -0700 (PDT)
Received: from baker.fritz.box (p57b0b3fd.dip0.t-ipconnect.de.
 [87.176.179.253]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906369800b006f3ef214e37sm1816684ejc.157.2022.05.06.04.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 04:23:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Marek.Olsak@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
Date: Fri,  6 May 2022 13:23:10 +0200
Message-Id: <20220506112312.347519-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

Add a AMDGPU_GEM_CREATE_DISCARDABLE flag to note that the content of a BO
doesn't needs to be preserved during eviction.

KFD was already using a similar functionality for SVM BOs so replace the
internal flag with the new UAPI.

Only compile tested!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 2 +-
 include/uapi/drm/amdgpu_drm.h              | 4 ++++
 6 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2e16484bf606..bf97d8f07f57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -302,8 +302,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
 		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
 		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
-		      AMDGPU_GEM_CREATE_ENCRYPTED))
-
+		      AMDGPU_GEM_CREATE_ENCRYPTED |
+		      AMDGPU_GEM_CREATE_DISCARDABLE))
 		return -EINVAL;
 
 	/* reject invalid gem domains */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8b7ee1142d9a..1944ef37a61e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -567,6 +567,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		bp->domain;
 	bo->allowed_domains = bo->preferred_domains;
 	if (bp->type != ttm_bo_type_kernel &&
+	    !(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE) &&
 	    bo->allowed_domains == AMDGPU_GEM_DOMAIN_VRAM)
 		bo->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 4c9cbdc66995..147b79c10cbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -41,7 +41,6 @@
 
 /* BO flag to indicate a KFD userptr BO */
 #define AMDGPU_AMDKFD_CREATE_USERPTR_BO	(1ULL << 63)
-#define AMDGPU_AMDKFD_CREATE_SVM_BO	(1ULL << 62)
 
 #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
 #define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 41d6f604813d..ba3221a25e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -117,7 +117,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	}
 
 	abo = ttm_to_amdgpu_bo(bo);
-	if (abo->flags & AMDGPU_AMDKFD_CREATE_SVM_BO) {
+	if (abo->flags & AMDGPU_GEM_CREATE_DISCARDABLE) {
 		placement->num_placement = 0;
 		placement->num_busy_placement = 0;
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5ed8d9b549a4..835b5187f0b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -531,7 +531,7 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
-	bp.flags |= AMDGPU_AMDKFD_CREATE_SVM_BO;
+	bp.flags |= AMDGPU_GEM_CREATE_DISCARDABLE;
 	bp.type = ttm_bo_type_device;
 	bp.resv = NULL;
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9a1d210d135d..57b9d8f0133a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -140,6 +140,10 @@ extern "C" {
  * not require GTT memory accounting
  */
 #define AMDGPU_GEM_CREATE_PREEMPTIBLE		(1 << 11)
+/* Flag that BO can be discarded under memory pressure without keeping the
+ * content.
+ */
+#define AMDGPU_GEM_CREATE_DISCARDABLE		(1 << 12)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
-- 
2.25.1

