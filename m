Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4827EC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 12:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D629310E8E0;
	Wed, 21 Aug 2024 12:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H41LKkhQ";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4CA10E8E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 12:03:29 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso53510505e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724241808; x=1724846608; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TETs6qhFXuUEokLxu7NQiEwolhoNkQ9JfXbUdI8r2wY=;
 b=H41LKkhQf2ZHwsi/Uw9Pny3v/ph2hUA+Rd1wy1Zwc08gq6x5NeVvp8EnGbLWxsFAF4
 2nxldNoJepNM6Q0aSt15VYe7XwgQb8aW/7LOU5oA46vt65j1uqA6Kus71VcwWUFRLAyA
 IFoy48TziSw4fdfrRZGINErcAHo9GAWdjguQSJLxEWpSLwZgXA7UxOwBYUu18B9sn1QO
 9I3zM0rDSibVTY/q4zE2+C+Crqc6SFzAu5IQL9J453z5VvBP3ooNjFF7Cmfc0Xn4TmnE
 MhsrUbECOs5WbX5APFWOdDjVAZ5UJm/D5SrtU5gCi/idH+Epssv3S2EtBvMqsU13aA9v
 YEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724241808; x=1724846608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TETs6qhFXuUEokLxu7NQiEwolhoNkQ9JfXbUdI8r2wY=;
 b=sAIHOdSITD4ItjxkWCvmLM1Nmj2jNszlW76C39N4WjvLrpVWqvxeIifteYgREekS74
 Ka48m/124iLiBJPRPgqiUP12DLbHesY6Wd97DD2CZywJ5YSXCI0wEAd2eNPQcE2sc9uf
 blnWlyLtwL1CNKNsrjhZgzXUkR/ES2z+dzD2wjZZbRn5fQ6CEqExobE2v3NdEIS66bjy
 GiAq0xGUoHKJHEZtgYeaCSor7LQSmQfJVmJrETa4E6JZBNVFBzuY38CfpQl+zpfdpYZp
 DhzyEMhtNX0pagoigD0Q2twzij2zADVK7nufWvi5gvKnuy3aSroW14fVDCMNWG2DUthA
 2dzA==
X-Gm-Message-State: AOJu0YyZOzS1JqIUcW0SWB82qukHV0RDB7oGQlbmNuAU+bu015rF2b2S
 tp85j0cXTnBZs8VOnLsKlW0rlMjFHkarEo0RQv54jVUqza2dR/0R
X-Google-Smtp-Source: AGHT+IHwdgNrlVFDYaCnVR9AvYonmuRaFvWxjyWBiXB14fFaaTHZPg4Ku4v3J5G68CLoK0rH+VhR3w==
X-Received: by 2002:a05:600c:5117:b0:429:e67f:1249 with SMTP id
 5b1f17b1804b1-42abf0485ddmr15470805e9.3.1724241807228; 
 Wed, 21 Aug 2024 05:03:27 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1526:a800:3751:35d:98bf:f3ee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ac2c6sm15534814f8f.108.2024.08.21.05.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 05:03:26 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: friedrich.vock@gmx.de, bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com,
 felix.kuehling@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: sync to KFD fences before clearing PTEs
Date: Wed, 21 Aug 2024 14:03:23 +0200
Message-Id: <20240821120324.4583-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821120324.4583-1-christian.koenig@amd.com>
References: <20240821120324.4583-1-christian.koenig@amd.com>
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

This patch tries to solve the basic problem we also need to sync to
the KFD fences of the BO because otherwise it can be that we clear
PTEs while the KFD queues are still running.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 30 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  6 +++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index bdf1ef825d89..c586ab4c911b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -260,6 +260,36 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 	return 0;
 }
 
+/**
+ * amdgpu_sync_kfd - sync to KFD fences
+ *
+ * @sync: sync object to add KFD fences to
+ * @resv: reservation object with KFD fences
+ *
+ * Extract all KFD fences and add them to the sync object.
+ */
+int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv)
+{
+	struct dma_resv_iter cursor;
+	struct dma_fence *f;
+	int r = 0;
+
+	dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
+	dma_resv_for_each_fence_unlocked(&cursor, f) {
+		void *fence_owner = amdgpu_sync_get_owner(f);
+
+		if (fence_owner != AMDGPU_FENCE_OWNER_KFD)
+			continue;
+
+		r = amdgpu_sync_fence(sync, f);
+		if (r)
+			break;
+	}
+	dma_resv_iter_end(&cursor);
+
+	return r;
+}
+
 /* Free the entry back to the slab */
 static void amdgpu_sync_entry_free(struct amdgpu_sync_entry *e)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index cf1e9e858efd..e3272dce798d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -51,6 +51,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f);
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
 		     void *owner);
+int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
 struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
 				     struct amdgpu_ring *ring);
 struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ba99d428610a..13d429b91327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1168,6 +1168,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 				     AMDGPU_SYNC_EQ_OWNER, vm);
 		if (r)
 			goto error_free;
+		if (bo) {
+			r = amdgpu_sync_kfd(&sync, bo->tbo.base.resv);
+			if (r)
+				goto error_free;
+		}
+
 	} else {
 		struct drm_gem_object *obj = &bo->tbo.base;
 
-- 
2.34.1

