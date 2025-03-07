Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E84C28B25
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 13:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A604910EB66;
	Fri,  7 Mar 2025 13:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FJ9Wk1gK";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF5910EB62
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 13:48:22 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so15688595e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741355301; x=1741960101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4bE9HvhTE6CDbSy7fPalUQrcXK0LBABLBlbVGw0sj2s=;
 b=FJ9Wk1gKQHWt8E87ADFEW1ZJEProJi07bjigAOIIRdcYuBn0FGxep8mbjnhgXxDXw0
 fS0gNCR3DNMK2FgQzhtYOh8MkrUf1K8NExaaFbytNHnwti7PhFLyja5c1P50x3bCqGSq
 HcNJTct87ZzeavQVnLmWXvlEYM7i3pYtMMFHlFsM2XzTOAqBfgOwUzo8NlhoQeRlczFz
 JAYAy6/a42cBQN8rLcnuheOJth/yJr6sD5LioiUJhmQ64NtaReun3t+nYIsMaKEf0wa2
 /86JNxjG2gzmJjEnFLXHD2vPevEXfmOARR4RRSNCrmYieSszXExqRBIqk+qOhyGbN295
 IsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741355301; x=1741960101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bE9HvhTE6CDbSy7fPalUQrcXK0LBABLBlbVGw0sj2s=;
 b=Km4rmbTrVUd+Ein6vwWzWhme2ltOVz6Ut0P0Dktbt6dQkm2yGEe0+4sealiChecxaB
 2A/UseF6HkRWW4BT4YxBKwTND7zMcWDnH2TatNzVfv2WIei49Nra3M5+BTSm2nc8nosR
 uzK/3gupQXcQNhMDdvcL5aS8+JkrlPdrEjklpoMoHjeJ2rgeYjmw7W68Jn7MhdrJTu++
 E5c+pUeV51Vz9QOrVcpm2XpjtUS6Ejah3fCQgVIW+j+b0XIQ2p6UwkxOJKV/yZGj372i
 FaOMgI9OtA7M9vcjvc9PLaBQj8wlMaZE4Cgsa2kkRrvfzZmF9WfDsnxeE9+omEQ5KvyX
 79wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9vYJBUi6xfx02D6RE4KDNkYm3gYv2A5yovfj+UczalTmnPDrlCyH98fzuh+OKbFUCcRqkIseS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjMEzM02xctz3DLasXYGM6wjsaetxK6SiOyT8PbrnRonZQveZg
 ZdpEvXLOlZnUQS5xE2it4GmgmbjSvZNckZ+EvGsDapXEujMmQLN07Mc8ff2TnOI=
X-Gm-Gg: ASbGncuxVPdZx8Y8Y5FMp7qglmSpsdv8ALXnTmy3IQ9EOkwfV646LzmqLxZeYrk5a2+
 Hvet8VfIA5au6NWu4XF65hlWkFXo5d8KfqyaYINuK7JlJjtwsevMHoGNborGnaRrpF1s6iN+om/
 wmDqEMpoT17l+7pfbzfNAXOOeUrt4v15qHRKSSaWzvXwTcIR4JgvGcar5sWRRIxSgEpxirbpa40
 VIWKGfM4h5L1y2/btZN8N9b/Zx9rov1+Ou1Pe03yD2N5rg25FU97jtAejkH/eB34y2I9nm30Ht8
 8busOAi6K6v3YLJ/Czn0l/uLqAarFKbqiWWx/YvnpWHJqbKi02rq5VZBEA==
X-Google-Smtp-Source: AGHT+IHYuBT8K8837WU7dVUBOHGkK+ErWomaOH8ByEtQ3+0GNw2TS7FaRFYqca+X4UF0zhQ8NqseSg==
X-Received: by 2002:a05:600c:3107:b0:43b:cd0d:944f with SMTP id
 5b1f17b1804b1-43c5a630513mr29802855e9.5.1741355300436; 
 Fri, 07 Mar 2025 05:48:20 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:14d3:5e00:ab55:e6a0:3a3d:9571])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm70613345e9.7.2025.03.07.05.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 05:48:20 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Subject: [PATCH 6/8] drm/amdgpu: stop reserving VMIDs to enforce isolation
Date: Fri,  7 Mar 2025 14:48:14 +0100
Message-Id: <20250307134816.1422-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307134816.1422-1-christian.koenig@amd.com>
References: <20250307134816.1422-1-christian.koenig@amd.com>
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

That was quite troublesome for gang submit. Completely drop this
approach and enforce the isolation separately.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  9 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +--
 4 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2ce0c6a152a6..4375e5019418 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1111,7 +1111,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			struct drm_gpu_scheduler *sched = entity->rq->sched;
 			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
 
-			if (amdgpu_vmid_uses_reserved(adev, vm, ring->vm_hub))
+			if (amdgpu_vmid_uses_reserved(vm, ring->vm_hub))
 				return -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a194bf3347cb..9e5f6b11d923 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1665,15 +1665,8 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	}
 
 	mutex_lock(&adev->enforce_isolation_mutex);
-	for (i = 0; i < num_partitions; i++) {
-		if (adev->enforce_isolation[i] && !partition_values[i])
-			/* Going from enabled to disabled */
-			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
-		else if (!adev->enforce_isolation[i] && partition_values[i])
-			/* Going from disabled to enabled */
-			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
+	for (i = 0; i < num_partitions; i++)
 		adev->enforce_isolation[i] = partition_values[i];
-	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
 
 	amdgpu_mes_update_enforce_isolation(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 92ab821afc06..4c4e087230ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -411,7 +411,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	if (r || !idle)
 		goto error;
 
-	if (amdgpu_vmid_uses_reserved(adev, vm, vmhub)) {
+	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
 		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
 		if (r || !id)
 			goto error;
@@ -464,19 +464,14 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 
 /*
  * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
- * @adev: amdgpu_device pointer
  * @vm: the VM to check
  * @vmhub: the VMHUB which will be used
  *
  * Returns: True if the VM will use a reserved VMID.
  */
-bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm, unsigned int vmhub)
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
 {
-	return vm->reserved_vmid[vmhub] ||
-		(adev->enforce_isolation[(vm->root.bo->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
-					 vm->root.bo->xcp_id : 0] &&
-		 AMDGPU_IS_GFXHUB(vmhub));
+	return vm->reserved_vmid[vmhub];
 }
 
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 4012fb2dd08a..240fa6751260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -78,8 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
-bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm, unsigned int vmhub);
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
 				unsigned vmhub);
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
-- 
2.34.1

