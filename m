Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24ACC5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 14:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A55B10E31F;
	Tue, 27 Aug 2024 14:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dkRQMJjJ";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B481E10E31F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 14:16:23 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2f50966c448so30517131fa.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724768182; x=1725372982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sYl5DbLd8CeOcKJ8yP54pbE3kICjFNwTeJZUCvYcqT4=;
 b=dkRQMJjJ4nLiJR+p7Ack1OvMqThw7q/t33WvhCLuPRLSAB5r916JH/sgdnW40DXFZ+
 n3ZRKCsquSmKmd4HfqIbI2ebdMBFEszOUcT+OYLwNeTFcLpNvk3158aTqwEaHT+eplFV
 k2TI/17PfFxxAAGkjYfVItq5uYuJB6hBy0sUJoJIdEiU6LjNnh4X3v/e5Drn5reDXe/P
 B7r3zlmNzevrW4jSvhpnN9BBkbyAazQsIR8kJjB7421wlnvl9YeAGlccT54Hp2Q8XSXy
 Se62X6UTNp+44JwT680NvI5d+4iHIVTpI7ZC4MeVjWtaXxIKSttZP+aKLs86ytV2uZ2Q
 o0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768182; x=1725372982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYl5DbLd8CeOcKJ8yP54pbE3kICjFNwTeJZUCvYcqT4=;
 b=SxwIrhwQIRn7pbvSbispi/nDOc6lZ5kWcz6gbXca7qRKuDuoz1vgB8rETw6YVb0DoW
 t9hSZn2ZPlS+ZpiivyUiABL6ow6bO8HXLNVyfaDcAN6nQCdw5dJglmUvCUX/MyFuMPjZ
 Z11Bvxr0cADrIIHSKoiKkrr3I+3gGSHFq3rDvmxBiu1VFzwQOR+k58Quu+sIilql6AHt
 TYIlKCmCxYKGMLSRY1U4SOoq4k/Lyz9Z3yNHMwLyeeRIyLZTPf+rKx+xoWW/xaYtFFuh
 wzBm8o/LGwwL/1Hf8Xy4kbpIQgi7UuAV0leZyx1mIq1x80i233jdOLELfBfIECcckUUe
 +/ig==
X-Gm-Message-State: AOJu0YymZPOEU8wT0/eL5uvnZsrc4Y/5CsavyUnUJDK84aSrG29auFla
 1WeGjWn7/sEhMCBdjg+thbUAD5PYgKQA3U7rsYZ/WI9Fi/4TvrElIlmf9aX6U98=
X-Google-Smtp-Source: AGHT+IEnm/tmVQklG/29o+pmsye0gaVHLqiz6TybTjiY+oC3evpWxhxFEkXkvMZ5T67hEao+VPcdvQ==
X-Received: by 2002:a2e:d01:0:b0:2f3:f04b:5ffd with SMTP id
 38308e7fff4ca-2f514ba85b0mr20156111fa.45.1724768180964; 
 Tue, 27 Aug 2024 07:16:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b3:7800:8c1b:1972:54d8:6ca6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb4824e7sm1041546a12.92.2024.08.27.07.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:16:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: yifan1.zhang@amd.com
Subject: [PATCH] drm/amdgpu: revert "use CPU for page table update if SDMA is
 unavailable"
Date: Tue, 27 Aug 2024 16:16:19 +0200
Message-Id: <20240827141619.2553-1-christian.koenig@amd.com>
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

That is clearly not something we should do upstream. The SDMA is
mandatory for the driver to work correctly.

We could do this for emulation and bringup, but in those cases the
engineer should probably enabled CPU based updates manually.

This reverts commit 23335f9577e0b509c20ad8d65d9fdedd14545b55.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3464a7a880f0..f0ccc560fd5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2392,7 +2392,6 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int32_t xcp_id)
 {
-	struct amdgpu_ip_block *ip_block;
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
 	int r, i;
@@ -2422,11 +2421,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
-	/* use CPU for page table update if SDMA is unavailable */
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_SDMA);
-	if (!ip_block || ip_block->status.valid == false)
-		vm->use_cpu_for_update = true;
-
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
 	WARN_ONCE((vm->use_cpu_for_update &&
-- 
2.34.1

