Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5F1C4167D
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 14:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8125610E503;
	Tue, 31 Oct 2023 14:55:40 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B783D10E513
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 14:55:37 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9d10f94f70bso547082666b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698764136; x=1699368936; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=x4TrDAB1naCr5XKrj0B8S+VhSxVk2WDuQf+nFxEgwLI=;
 b=g1lf589zBdE5ajbxpqTYvsiKzCXZOkUWQMNjFm9PPRSkolHBqA9MHpiXKxTlUVx1A/
 t8wONS2NUdxix/+pLGDw1lulwXfLArgz5OqAXxrAUUIGyY/A1kODXpkR46Qt02YTbVoa
 s08F4PzREihgfkiQpsTm0HYfRB38ZmzcPZ/pqiokJEDjUSicIbp3iDGrbvv1V/8gy1AB
 bdPm+QAo+js+vGQHLl+46kv3GZNLTEoYbDKTBWdys7Adwo97/uHa42Q8/u+8hK4FfCrI
 +4GrRQjrNAfKQY84Jo9DgmcmsFpKWWmak0E+HpMrJUR60IWBhje4I7GDaurI2SO0Ktyb
 sQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698764136; x=1699368936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x4TrDAB1naCr5XKrj0B8S+VhSxVk2WDuQf+nFxEgwLI=;
 b=S6X/YorW6lqLWWrGuYgy9I7sq7hGqchefYjMfC31oEvGEjIHDyOT6QvJn7Qt2XyvKc
 wive9xB5XU2D+Fx0pFnArC0nSv8f/ynM00TXewXrbs3KYJU/1xcZbUwnf78sF6stIJ0j
 cPBSgu17xmZAPmz5yTzMEYfxq9yXOx9/R3Tp3LH6Vy4gNWQOgmvsxB0dKlVE48s4TchP
 /3v2Pp+vEBDQxSPT6+o9KHnmIO8oUPK6vt26XTL4rYatXpXbbzoNe8782I06pEbkzwda
 PEHYu7fOFN4XflaLqJTXYgxBIYrDVQqtv33Yxc5LbNCRRVbxTALY87gxvkS2mVGYqKrq
 qJBw==
X-Gm-Message-State: AOJu0Yymb/cmLN7pqcjgdR/rIYkSBP7urZCrG04P/iL3z52fHnjqzaUj
 2aBUZcJ1hLfELmd7iplCK/m00otlF2WTNg==
X-Google-Smtp-Source: AGHT+IHt7+sDlz4dyrlzZdog9AMHfZPYinGuHqhv+H45S93Ar2hgip129Uc6hp3CcXpe+0K1/vJRVQ==
X-Received: by 2002:a17:906:6a1b:b0:9b2:b2ad:2a76 with SMTP id
 qw27-20020a1709066a1b00b009b2b2ad2a76mr10559614ejc.16.1698764135948; 
 Tue, 31 Oct 2023 07:55:35 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:155f:5600:3ae3:53b8:6e8e:248e])
 by smtp.gmail.com with ESMTPSA id
 bg6-20020a170906a04600b009a1c05bd672sm1079090ejb.127.2023.10.31.07.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:55:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, Kenny.Ho@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix error handling in amdgpu_vm_init
Date: Tue, 31 Oct 2023 15:55:34 +0100
Message-Id: <20231031145534.2501-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

When clearing the root PD fails we need to properly release it again.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 31 +++++++++++++-------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d72daf15662f..5877f6e9b893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2042,7 +2042,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id)
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		   int32_t xcp_id)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2061,6 +2062,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp
 	INIT_LIST_HEAD(&vm->done);
 	INIT_LIST_HEAD(&vm->pt_freed);
 	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
+	INIT_KFIFO(vm->faults);
 
 	/* create scheduler entities for page table updates */
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
@@ -2103,34 +2105,33 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp
 				false, &root, xcp_id);
 	if (r)
 		goto error_free_delayed;
-	root_bo = &root->bo;
+
+	root_bo = amdgpu_bo_ref(&root->bo);
 	r = amdgpu_bo_reserve(root_bo, true);
-	if (r)
-		goto error_free_root;
+	if (r) {
+		amdgpu_bo_unref(&root->shadow);
+		amdgpu_bo_unref(&root_bo);
+		goto error_free_delayed;
+	}
 
+	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
 	r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
 	if (r)
-		goto error_unreserve;
-
-	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
+		goto error_free_root;
 
 	r = amdgpu_vm_pt_clear(adev, vm, root, false);
 	if (r)
-		goto error_unreserve;
+		goto error_free_root;
 
 	amdgpu_bo_unreserve(vm->root.bo);
-
-	INIT_KFIFO(vm->faults);
+	amdgpu_bo_unref(&root_bo);
 
 	return 0;
 
-error_unreserve:
-	amdgpu_bo_unreserve(vm->root.bo);
-
 error_free_root:
-	amdgpu_bo_unref(&root->shadow);
+	amdgpu_vm_pt_free_root(adev, vm);
+	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
-	vm->root.bo = NULL;
 
 error_free_delayed:
 	dma_fence_put(vm->last_tlb_flush);
-- 
2.34.1

