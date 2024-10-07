Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8362CFB452
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 18:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D84E10E3F8;
	Mon,  7 Oct 2024 18:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M9wiFf4z";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F0E10E3F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 18:32:44 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5c87ab540b3so10300802a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Oct 2024 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728325963; x=1728930763; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oXYej9i5u10OFpOt/KewAGBtVQTLobTUQlInqYUyHWs=;
 b=M9wiFf4zcFmrk4INqswkG3V89hqQKkVIUPTtiaKiSjTLIQB4FoN6z5YNLDvomWcg8u
 P9roS44oqI5VtlC31Yum5uQioOLgTuTcwKFiA9foeVukImYYwGUoosU5EQqeZ2jcPs9o
 aXhck89BZQDYQJNKLKUO74HBJM5irLksfPaoBL9zVMu7vOnxFDZ5QHzbTmoFkLNZxLZY
 /2QTNcsjMDqnzvTmNih7lEiDADpM2ZlkwmPaa1g1nnDQhmfgfINEljvJ8g+dXyL+W1PP
 PnHHy7r7zwe3NszTeI/VTp2ru0Rw33y9k6uUAOu4nY8DYImCtAL9C/loKm6c94QpPQZP
 jtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728325963; x=1728930763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXYej9i5u10OFpOt/KewAGBtVQTLobTUQlInqYUyHWs=;
 b=GXek3SuFotlvMNA5WSJQA65bHNThnk0Kx+SRtea7E6zFhWW4zhLPdI3Oke9mEjUG14
 Ef+wC03AfoOiRGqEXtP/HsGUy08r3WY+OHhbpwj5Od5Q+gJoT5+ZvBYFXXZcnOOkirOq
 7zF6E23kVCaUJ5arAkRnIwDB88LkH19Vg8AcS0L8mfH83ccjkupnwyQLZlmA9cZvURtT
 PvmWrV7kWt5rYPz8WL3kltv3siVVyxL+JocWfsK7JvkaN25QOIGyA+7PZ64iDcuucvu5
 qW9EmF6l1qJjmz/2guoX+qhWLqwl+zef5e5Ph94Z8NK13TcEBW7o/kPcCuZJswruU5Aw
 VXhA==
X-Gm-Message-State: AOJu0YwQbf38d2JHo3Yyig4dRWAXlOgCXE/LhRJ4iVG1Sow+2Om4W9sQ
 e4RALaO/6rJA6cFEl1CMvHUXPPPsLzkhO9TNmrgqsBljQab9pU53r7sr1/ve
X-Google-Smtp-Source: AGHT+IGzhKxYnURUQLPVcD9TrH2e8GUSN1e5oGSxA9rNAs1p/sshXblm0mobb/839SaQ8jhcX9lzdQ==
X-Received: by 2002:a05:6402:51d4:b0:5c8:97b9:58a6 with SMTP id
 4fb4d7f45d1cf-5c905d03ab8mr602058a12.1.1728325963030; 
 Mon, 07 Oct 2024 11:32:43 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15db:a000:28fa:7b49:8acd:d9b1])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05bd4e7sm3459719a12.47.2024.10.07.11.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 11:32:42 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH] drm/radeon: always set GEM function pointer
Date: Mon,  7 Oct 2024 20:32:41 +0200
Message-Id: <20241007183241.1584-1-christian.koenig@amd.com>
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

Make sure to always set the GEM function pointer even for in kernel
allocations. This fixes a NULL pointer deref caused by switching to GEM
references.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: fd69ef05029f ("drm/radeon: use GEM references instead of TTMs")
---
 drivers/gpu/drm/radeon/radeon_gem.c    | 3 ---
 drivers/gpu/drm/radeon/radeon_object.c | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 9735f4968b86..bf2d4b16dc2a 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -44,8 +44,6 @@ struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *obj);
 int radeon_gem_prime_pin(struct drm_gem_object *obj);
 void radeon_gem_prime_unpin(struct drm_gem_object *obj);
 
-const struct drm_gem_object_funcs radeon_gem_object_funcs;
-
 static vm_fault_t radeon_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
@@ -132,7 +130,6 @@ int radeon_gem_object_create(struct radeon_device *rdev, unsigned long size,
 		return r;
 	}
 	*obj = &robj->tbo.base;
-	(*obj)->funcs = &radeon_gem_object_funcs;
 	robj->pid = task_pid_nr(current);
 
 	mutex_lock(&rdev->gem.mutex);
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index d0e4b43d155c..7672404fdb29 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -151,6 +151,7 @@ int radeon_bo_create(struct radeon_device *rdev,
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(rdev_to_drm(rdev), &bo->tbo.base, size);
+	bo->tbo.base.funcs = &radeon_gem_object_funcs;
 	bo->rdev = rdev;
 	bo->surface_reg = -1;
 	INIT_LIST_HEAD(&bo->list);
-- 
2.34.1

