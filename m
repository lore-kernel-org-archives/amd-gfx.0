Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC78C27C6E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A013910E3DA;
	Mon, 10 Jun 2024 09:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EvO+TOwz";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC0710E3BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:26:18 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-421820fc26dso8132205e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011577; x=1718616377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD5ZAUT0NiLGUg3L1j9j6DNn20gg+ongDJ63sMXI+NY=;
 b=EvO+TOwzLTbTzgnY1GSJn1eNd2eLIT2pN4mNQgmRsweUVWlyBKMCrKRpULR2pXkG3s
 Szkt/sLb0i34Aw+CVN7pwPiMZYRD6XQq+nzzKH+4TB1gZslA0YgsFss/h/EPx3WZRW7R
 oPTm86QdwKPrebqdWwnYKx6JQZkzdObwiyWO6BOcVeR5e6TnBi9Tz2GbVnj/kW151US5
 Hf4+/nlnqE7zDA7E5BXJLM4H49hO1VAhFBAryo4BYVsy9RgMIB4J2Ba/JCZi/N1SQvjD
 4iiua/OASHECVoiZAME0TjRuC17y342CMbw5ERK8+tmWyu/+RJqsVw6KhTf/pUnkbKBe
 3Xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011577; x=1718616377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD5ZAUT0NiLGUg3L1j9j6DNn20gg+ongDJ63sMXI+NY=;
 b=NbLYnzq5DZeen8qtLHkUel/IBkbJh0d/ppBwETtiTJrnUU58aXpI8JIhpirNZTtCyA
 VtCsY7KN8puRzcaFCZI0ZDU/iTGYyGBHVmi+y9MJ7WhQx14fk8vMCI0+0G+JweZBu+Er
 Wt1gCANabZBR4H0OIyhJ+eVOH/GhaxJWGvoIiVJ+Pt5FqzTJceBSlIib5b7QDL+ZUhhV
 5jHY8qov4cfNSKz/YuRMhp/m+o5JFu8UVRhExh/RzI3eOyyfFq2+v3oIFvg/cSB7nS2T
 h23UsYtxIT/qRlpe3UV73CbDLXf2X0mXbLLZeK6iegrr7AX9sPuEl1EwNfPe+fgUXhTq
 zp5g==
X-Gm-Message-State: AOJu0YzChHR3CPMmv13qhfnTp0UvLFLXN7hfgXbgxo3JIOtcQa9waDmG
 pvnxvHDhENkQ2PyN2eXmyzoU2PkICxKb4d+zYMDIrbUDINXzmJ6l
X-Google-Smtp-Source: AGHT+IFXxxGEzuWJtY/vhwGhhmvD7dT7OTWgyIvyMuODvVYUuniikosWXHQRTOLs5x+EtmbpasAhPA==
X-Received: by 2002:a05:6000:1e4e:b0:35f:444:8711 with SMTP id
 ffacd0b85a97d-35f04448802mr5209411f8f.42.1718011577012; 
 Mon, 10 Jun 2024 02:26:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f9:7000:4916:a8ec:dd12:5894])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2169fc45sm3075827f8f.10.2024.06.10.02.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:26:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/9] drm/amdgpu: cleanup seq64 VA map/unmap once more
Date: Mon, 10 Jun 2024 11:26:09 +0200
Message-Id: <20240610092611.2894-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610092611.2894-1-christian.koenig@amd.com>
References: <20240610092611.2894-1-christian.koenig@amd.com>
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

Provide a hint how many BOs we are going to use and prevent unmap from
waiting interruptible.

Also avoid using fpriv in unmap and work give VM and VA as parameter
instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 31 ++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h |  6 +++--
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 260cd0ad286d..28a8f13ab8a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1431,7 +1431,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		fpriv->csa_va = NULL;
 	}
 
-	amdgpu_seq64_unmap(adev, fpriv);
+	amdgpu_seq64_unmap(adev, &fpriv->vm, fpriv->seq64_va);
 
 	pasid = fpriv->vm.pasid;
 	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 8d0a3cce979e..8f8ed152d0d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -70,9 +70,9 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	bo = adev->seq64.sbo;
 	if (!bo)
-		return -EINVAL;
+		return 0;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 2);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
@@ -89,7 +89,8 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	seq64_addr = amdgpu_seq64_get_va_base(adev);
-	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
+	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0,
+			     AMDGPU_VA_RESERVED_SEQ64_SIZE,
 			     AMDGPU_PTE_READABLE);
 	if (r) {
 		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
@@ -106,39 +107,35 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * amdgpu_seq64_unmap - Unmap the seq64 memory
  *
  * @adev: amdgpu_device pointer
- * @fpriv: DRM file private
+ * @vm: vm pointer
+ * @bo_va: bo_va pointer
  *
  * Unmap the seq64 memory from the given VM.
  */
-void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
+void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		     struct amdgpu_bo_va *bo_va)
 {
-	struct amdgpu_vm *vm;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
 	int r;
 
-	if (!fpriv->seq64_va)
-		return;
-
 	bo = adev->seq64.sbo;
-	if (!bo)
+	if (!bo || !bo_va)
 		return;
 
-	vm = &fpriv->vm;
-
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, 0, 2);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
 			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
+		if (unlikely(r)) {
+			DRM_ERROR("Leaking SEQ64 VA (%d)\n", r);
 			goto error;
+		}
 	}
 
-	amdgpu_vm_bo_del(adev, fpriv->seq64_va);
-
-	fpriv->seq64_va = NULL;
+	amdgpu_vm_bo_del(adev, bo_va);
 
 error:
 	drm_exec_fini(&exec);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
index 4203b2ab318d..3f31f59d5625 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
@@ -38,11 +38,13 @@ struct amdgpu_seq64 {
 
 void amdgpu_seq64_fini(struct amdgpu_device *adev);
 int amdgpu_seq64_init(struct amdgpu_device *adev);
-int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
+int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr,
+		       u64 **cpu_addr);
 void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_bo_va **bo_va);
-void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv);
+void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			struct amdgpu_bo_va *bo_va);
 
 #endif
 
-- 
2.34.1

