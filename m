Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5527EC02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 11:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E234710E4A0;
	Mon,  3 Feb 2025 11:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dysI6A0o";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47BE410E4A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 11:58:54 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-38637614567so1874661f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2025 03:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738583933; x=1739188733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqv1uKCT7H0MD7JwQdaxscBB1T4Q3l6RVj+SexVT8QY=;
 b=dysI6A0o+dcpI8jZPDoOLz8tu/aOSwRVMeeaIYXCIzyx+zGqtkd8W8qvDkW+bpTeIw
 GwkVm3IzQUupofBDJY/nU75VxyGK98n1HKKyUKae4XiV9/aSn6MQly9MoDRtJbbMq39D
 +vuv4Ymfkkqghlb5bRzeqR/kVvm02tG2l87qzHzzbvjUzXLL83StHEGimwWd3koFma4s
 5f76NwXa+0tuk7wctCzbyC20ZKEaYTFFd11XcD5l2coQ2+6Drc/KgFe9816TZsK56Hcv
 rk5xReJcgz8LisuONv08FAAVOyWm4fXsICul1BV+owWqdkESMp+zWCGrCAoqTaNvvFqZ
 aRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738583933; x=1739188733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqv1uKCT7H0MD7JwQdaxscBB1T4Q3l6RVj+SexVT8QY=;
 b=EvnnWOK2h3WeEysf+u4K9tsLmT5nvf2VqcTa8ljqm6h5i86+KPxB32m4E+3hAJwZE8
 OYH6S2s2MiZwdoiDF4/n55zKvW+zz1QbMS8hUZknD4P93oWbntXi1Rb/OpNLYVkG091G
 +6uJ4dVLP8DatIcZZwwawzpUFmCea/SXAXP1sZdTvqBCAT6g0TMjhcM0QEyjK++7HWFk
 umZ/uT5DWONe4uAQzCDTZV7PTHkIPyV32DBsgeREYmxmARxTmr+gE4C2+MiwmH5UD0/m
 RfLeTSD3OSpEQrq2MTe3i7HuT+PX5os3nxkmOQT7PewNfN8hR8+zQuNSUrPew4biMjgn
 opZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBOh0Y+gaNzIhMiNU0u4Rygi29K7Rn4FRHw+qJsSY4xxNydwAC3ciZgdqrHrt2xwAJVXTDNBvr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yycpq+NwtGUop/NqGd+l99eEM9PVxsCEPWVDK7BVRoFi3qjXjSH
 2giubRUkIzeCuUT5JJjJtV8ZB6OUUslukx79hzA38u+uP1uUsk4Y
X-Gm-Gg: ASbGncsdePjCEojetNzGVxpckRSaoF4mrKljmUSlRh6SSyewOuXBDic2Qv7GtSYpiFK
 nL5BEpuVq65eyRmEZvWgNQw15M0etTjtFoeKiWLDTBa2zLd3oT9qpE6/9q4EdAwahci6ijQJJjw
 9en8eJa9x5JJ9g6QYQ7rXZZlQdJN/pXAAjLZA9lrxMT9nrYvcfKxiXbESxbaWgUFWAWXWYotgE3
 UFHps4L6TOehRs4hfNnyFvrSKeG3M3gLGVrpESliCFeS2iFS2TxrXQlpP59KD6AW/nlevurbUxp
 u240MoDWr3Q9jZzxg6OWsF5L7y4=
X-Google-Smtp-Source: AGHT+IFZ+jmlaBfUScHAm6HLTygOrRBWQZD+0yL702tX1mk1lQusfTE5nT04QplCC2qMuaBb2X4KPw==
X-Received: by 2002:a05:6000:1ace:b0:385:ec89:2f07 with SMTP id
 ffacd0b85a97d-38c51970003mr16696751f8f.32.1738583931090; 
 Mon, 03 Feb 2025 03:58:51 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c2:700:903a:ba89:5ce0:8312])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1017besm12298928f8f.26.2025.02.03.03.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:58:50 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 6/6] drm/amdgpu: stop reserving VMIDs to enforce isolation
Date: Mon,  3 Feb 2025 12:58:46 +0100
Message-Id: <20250203115846.13142-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203115846.13142-1-christian.koenig@amd.com>
References: <20250203115846.13142-1-christian.koenig@amd.com>
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

