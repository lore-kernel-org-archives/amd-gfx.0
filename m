Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF96C021AD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43FB10E730;
	Tue, 18 Feb 2025 16:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YppdH+rc";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DDD10E715
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:14:08 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so10073412a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 08:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739895247; x=1740500047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wqv1uKCT7H0MD7JwQdaxscBB1T4Q3l6RVj+SexVT8QY=;
 b=YppdH+rcOoHO000BfvcOC4Zq9peahDB2VaGAgfKs84r+YcAdBR8kw41OxrKFF8Xzhn
 1WDfOIYoJHB380rwH+io8b+qBTyp1ENmDqx2eQzBeztt/ZyRWZb2fAQvnGd1r/NjNmx8
 GrVS5LfI7VWOivTC3u9DS7BkQ2L12Iej6BQtV3h9l3f3bsNzzDanR7AhIpjyDzTLqiJf
 LMeS7W60RkU0JEOUrQQAjAOA+ZeeAbgvGUYEGtQEe1DyTZAqfftZMYVDO9/mUMnqTJ8Q
 iBCND1LoyxiG3JgV8l1kc5nSN2YA5PmX7MjMTA6HOumgqguq5qURFDHVs4p56ToVIYxc
 96jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895247; x=1740500047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqv1uKCT7H0MD7JwQdaxscBB1T4Q3l6RVj+SexVT8QY=;
 b=CD6ZGDSE+7dggwIbdFhbISPkhzmFZ90SzIyTnf+/gP9vsznuMr09rcxekCUI7m/tWe
 Pc43XTuvcBM98nGlNwgBVsY9db/J58VdP0HnW3Qk8qK6sv4hKpgrrUweu8tWJ1iBF9cV
 Bja0FGc5Bkme0/GNuj4Jd6jIJg1BirU4hRR927hHGkU9tmWNVT65H6mC5RlIzVnOJs8Y
 oGRYim/QHoll0BKkqjwP5jBQFcsbr8lkrdMaJ+pHKDrqwyzXqjJn375B90M43c3KfNgM
 7Ni0dWf0vtPOM9LcOFPvaul8VX4H0Jv1FCj6nw7WBr9mQMV2h6jlPf0MnfnZDehQUpjG
 uzaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpUCHwkbA92TEqZfy1062qI9Y+p0dTdbPTntEYI4asrkScEg+AehGtOrGLrxK0C4cuqzgTaOhr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzO4VsbiJCcO/wXRBvZcyekZMX5I4pGtQ7X+l/0RbSPDTKHfD8I
 aj7bG97IHwGXAselVIrC9s0hH6qkHdTlmg+oBwWzSASPIdq3uCrpr1Y0pgUs0ww=
X-Gm-Gg: ASbGnctJTvgPu5VbbjRr+abXcP2jEbzoofPJIMQUsoxkf3SHHd3vB+A0X+WNLm4e/W+
 Q9/AJgOY33XMZRmhrgkTA/BrPvtMJl/mixedsqFrjZUrtk5sdmDr/NoRkNrt3/udHWLXgYJguQf
 44zKsB8Dl51AbUziwav+2Woz2lDgVSr8VN3am2KVGL/HWObyvCKGZOBCGTCvry76doE0QFinrcv
 bR3JH1LC2+LnRtK6P4pJF60s79BvuPHFK+V6VZcMAVev9JeVTeqtdnHmYlA71orj+3bVoHO6ZBz
 OnYlUXdG5zEqSkd0q6tw7ccb9k07
X-Google-Smtp-Source: AGHT+IG1zsGyYEubM4sI5MaiYIM6yARWFrDWvKkRBmxPIcH0vPsPtR95QqUe8KWiqRWhXm11se7QHQ==
X-Received: by 2002:a17:907:7244:b0:ab7:d6c:5781 with SMTP id
 a640c23a62f3a-abb70b35452mr1307875166b.24.1739895246434; 
 Tue, 18 Feb 2025 08:14:06 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15cb:ef00:7a4e:6292:55ba:b835])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba7848676sm306762466b.144.2025.02.18.08.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:14:06 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: stop reserving VMIDs to enforce isolation
Date: Tue, 18 Feb 2025 17:13:59 +0100
Message-Id: <20250218161401.2155-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218161401.2155-1-christian.koenig@amd.com>
References: <20250218161401.2155-1-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +--
 4 files changed, 7 insertions(+), 18 deletions(-)

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
index 645efe002d06..8acee6e5e320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1640,15 +1640,10 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	mutex_lock(&adev->enforce_isolation_mutex);
 
 	for (i = 0; i < num_partitions; i++) {
-		if (adev->enforce_isolation[i] && !partition_values[i]) {
-			/* Going from enabled to disabled */
-			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
+		if (adev->enforce_isolation[i] && !partition_values[i])
 			amdgpu_mes_set_enforce_isolation(adev, i, false);
-		} else if (!adev->enforce_isolation[i] && partition_values[i]) {
-			/* Going from disabled to enabled */
-			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
+		else if (!adev->enforce_isolation[i] && partition_values[i])
 			amdgpu_mes_set_enforce_isolation(adev, i, true);
-		}
 		adev->enforce_isolation[i] = partition_values[i];
 	}
 
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

