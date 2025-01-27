Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF830C02188
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2025 15:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C02C10E569;
	Mon, 27 Jan 2025 15:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AccZJK/k";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F6210E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 15:32:14 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-43618283dedso48891105e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 07:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737991933; x=1738596733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wqv1uKCT7H0MD7JwQdaxscBB1T4Q3l6RVj+SexVT8QY=;
 b=AccZJK/kLvom8rNtqRV2mSFy/k9TIL28sB38welmdiYLeR0yR/yHvIp+dKyPHYWn/w
 Qyk8RIZ1jbZSwNddK50wDGNs2yUN9wXuGJqrEVSGDgssN5qCnjd38KOtqbW7NEAltDhw
 ro8r2ZQ3rZrlnqoZ1fS1J0cIDnrcpK2eXcVdW/vPcvNyh9q/wz/3DoFl30bEPP46OmI7
 gjqXxQxuoZUXW/83kxWAa9tG4GBHooxylHz0CEP+mjIt38JmHAJy7qjryXfyAf6abN+r
 coi5QW/vKmYn7QyzNDFptWnOwK8JnXtzth0wuD6ijD8ebEJpNdQp7bp50KXBoe67thrp
 jGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991933; x=1738596733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqv1uKCT7H0MD7JwQdaxscBB1T4Q3l6RVj+SexVT8QY=;
 b=xCvaJEWrWEFI+AzoiXj6IcgGnAOorVxNG5QjAV0GAz4NnWHylSDHs4H9chK/l2QMOT
 a3n1iJbFegcjR+Aq7IsUfdg7Su0BUX1YzfktyKNEG0w8CEzLYfjO+I/LaNqPv+PFoWXG
 pHimUhFW/hbDgXwZvzhE2jGPpysQ5j6Oi+e5Fj26WcD/Ni+KpGI0XuFcL0fEySC3nXdx
 IaZQcysHYDKUcnVS6KRARc2vfNWBnZtJjbp33f3vCCEiIvD5Drh3gY7FNCFi77h+y34x
 TgWLrijpfEpSyOGoNGh2D31iB2io0LIJhWHzy4s2P3AZer24d4UhnwRRL94nx5qnY5if
 8W/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCULIfQem38oozo1KoWRiIgC/07pLm8f6B8UQrw1k3A2UPbw9vA+tAULRHFg56JPS8kqqr4fazLP@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3GC87iVZZkYhN/fRSLLJQW0gNH9Dv9yhnv/HVTt0I7zrNBPMO
 S0RnJgxzKmTHab16R4/RwHi9u60RZGE+PUXuifvb9lBU+czzSf8N
X-Gm-Gg: ASbGncsuwtiweKx5H4QZtBMB59OSf1j4uG693KtpoTQXJq5/8AnMIRH2SZAtbxz8Rnd
 uJZHcR6Fala8AVh+WYbVtcS7n5rudsHhPHXOSh5n33OkdaU9ImA6oEM/dPAzTsYgbPG1DkmUwF1
 VuSUowl6JwVuIeiwLKSeWNP45V987mrVhTP0FNXPQ4m5UxB4ix+S8dScD2zC9kXWGg6Uf+E8C6A
 izJdZFKhL4/MWjAfEVIQFVM+GrHcSFyHaYaBNlAzOx6kRZLHjs2X6TxZx6lhysj2xF5esbUmYZj
 44Zfs7XaUqMb5kAilPDd/jjtBIot
X-Google-Smtp-Source: AGHT+IHXwjhxAQjc4DztsZly47WjUua66+siHO7kMt5SOnKT3E7abidEJZLdxfwLlppP9QcJXKYZ+w==
X-Received: by 2002:a05:600c:5027:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-43891430ed1mr368289225e9.29.1737991932707; 
 Mon, 27 Jan 2025 07:32:12 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:153d:dd00:1202:d6cf:5d6d:56cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm133904325e9.39.2025.01.27.07.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 07:32:12 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, srinivasan.shanmugam@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu: stop reserving VMIDs to enforce isolation
Date: Mon, 27 Jan 2025 16:32:07 +0100
Message-Id: <20250127153207.5717-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127153207.5717-1-christian.koenig@amd.com>
References: <20250127153207.5717-1-christian.koenig@amd.com>
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

