Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0354C47DDF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 15:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E3110FBF1;
	Fri, 26 Jan 2024 15:55:48 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29F510FBDC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 15:55:46 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so273120a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706284485; x=1706889285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sf5QUk1nDD6WtuGpZY5YemA3SKHs8mPlIwmDInl7FSM=;
 b=CEERqdheFFcLBL5uImL3nhDaZ5Jxtmr6x/sIboaiPKZAr38pNehYYWStGQDiudTjGA
 vFLg6URReYSDMjD3j2P3vo1oN31cNNADylUvSODWGrr3nJn687F5WSIHcizOqg7q+ryb
 eAzBlbjLqMPZr5TzzZib5yX3LLEOQlxbyCl+KzReFFFcdwZNxxqqEK4/xW4xZja1Od+V
 trw98bYywECSTatAC7aqikSVhwMexq1sDdG25scN6ITvvQFTshC3y9gYQ/3R2TOS8ImE
 B/v+67gYvcAYnNPvobxKEbMmU/0POBi06y0zgnNRYQ5bnzZHJUfyWcAXEQQZt7Vp0k7L
 /JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706284485; x=1706889285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sf5QUk1nDD6WtuGpZY5YemA3SKHs8mPlIwmDInl7FSM=;
 b=k7o1flVCkiAG9Lfu3u3doD1jA1AMdW3ZXJjmk/GMPauUu1741a0+MA1DVZ5LtoFmN1
 IT4BTxDxzNN8I4J6YdWJaWXhMWynYcN1wBnMn1A53kLueVgiDkKCW6h6ZKW+6aCItI2Z
 dJirNEDH+7Ul+Sb0eCjQzOIRx0sNI4YNW+RTGnAMgQHU5JGjbsPA6L2KsOeqapNU1g9K
 bsDkDHiTru9TlpWW76mfYhyFceSuNOixdCVhAeFoJYnGi9H5V3iVQJXjA3V67DqoUO+P
 kdSfUAT12kYkNpFso4Ec1wW32rdKzi304MEE2gmSRwvoRKkVqis9vWnw6FEfjnpmYQ1g
 HC0Q==
X-Gm-Message-State: AOJu0YyICKjlggSSLPyj+PgAX05MCuc2VMhkMR5qURpQwyeidtoPumlY
 qqSutmath5ed9jwuYqXF1zKcaQxPCyuJaSzIt537m+Erb7AbFOaw
X-Google-Smtp-Source: AGHT+IEtOrmpHIrxugn1K+PZytVZZo9TlKtQt261RAQ6s8dj6WKlwnGiRE0weLzNAnPFOox/rqKt9w==
X-Received: by 2002:a05:6402:2883:b0:55c:7750:bbfe with SMTP id
 eg3-20020a056402288300b0055c7750bbfemr606673edb.29.1706284485028; 
 Fri, 26 Jan 2024 07:54:45 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1528:de00:74a1:34a:f78c:7883])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a0564020e0100b0055d312732dbsm695801edh.5.2024.01.26.07.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 07:54:44 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: vitaly.prosyak@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: reject gang submit on reserved VMIDs
Date: Fri, 26 Jan 2024 16:54:40 +0100
Message-Id: <20240126155440.2022-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126155440.2022-1-christian.koenig@amd.com>
References: <20240126155440.2022-1-christian.koenig@amd.com>
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

A gang submit won't work if the VMID is reserved and we can't flush out
VM changes from multiple engines at the same time.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index bbbd8ad0171f..3f644275adcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1093,6 +1093,21 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	unsigned int i;
 	int r;
 
+	/*
+	 * We can't use gang submit on with reserved VMIDs when the VM changes
+	 * can't be invalidated by more than one engine at the same time.
+	 */
+	if (p->gang_size > 1 && !p->adev->vm_manager.concurrent_flush) {
+		for (i = 0; i < p->gang_size; ++i) {
+			struct drm_sched_entity *entity = p->entities[i];
+			struct drm_gpu_scheduler *sched = entity->rq->sched;
+			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
+
+			if (amdgpu_vmid_uses_reserved(vm, ring->vm_hub))
+				return -EINVAL;
+		}
+	}
+
 	r = amdgpu_vm_clear_freed(adev, vm, NULL);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index b5b9d4f40f53..b6a8bddada4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -424,7 +424,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	if (r || !idle)
 		goto error;
 
-	if (vm->reserved_vmid[vmhub] || (enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)))) {
+	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
 		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
 		if (r || !id)
 			goto error;
@@ -474,6 +474,19 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	return r;
 }
 
+/*
+ * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
+ * @vm: the VM to check
+ * @vmhub: the VMHUB which will be used
+ *
+ * Returns: True if the VM will use a reserved VMID.
+ */
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
+{
+	return vm->reserved_vmid[vmhub] ||
+		(enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)));
+}
+
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
 			       unsigned vmhub)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index fa8c42c83d5d..240fa6751260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -78,6 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
 				unsigned vmhub);
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
-- 
2.34.1

