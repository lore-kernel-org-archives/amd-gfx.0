Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E72C27C5E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 11:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727B610E5C9;
	Tue, 11 Jun 2024 11:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g9Ez2gSx";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A6510E5BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 11:44:05 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2ebe0a81dc8so10956131fa.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 04:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718106243; x=1718711043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uRml+BUoOHCs0xdGcCozQdy1/MI0JaEY85Z5AsO4M8=;
 b=g9Ez2gSx0iVeSaHal5ItXEc0oBhIwKUWU1GiYl8KFeXlTfG3B9UUQodJRenRIK8wtX
 EPHStBSkctWIgwcp5yFbfBksWkvKZn7XUcV0g1hU6M5AaUXiFKfzziNfKBa5COtYcrB3
 RTWJ9wuf2i8MqDYnr996vvsXRR4NgacJ/zaQFRm6ARl8ulnEhStPxXVl4N9Mo6xldlLp
 cau0BtEX6Uo96tlvYsz5dAh75VsmAkdML2yGvztXcre94jh3fm4VbPwG8yXsHiSq/Mys
 hSjd7bufnha4PrIpocfI/T/nS5gO5ViVclK+Clh7WDDzA7CybHsSCPm16e/DzaEzxOD1
 ywQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718106243; x=1718711043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uRml+BUoOHCs0xdGcCozQdy1/MI0JaEY85Z5AsO4M8=;
 b=F4OVtPqMQS9xxk0k7hXsm6oEzCG9aTopwlBv5xSM6GG7Ky9yO1tYwwjDtW7n/TymEv
 5hmPpNnM9lHXYPKXpL2iD+z/DDI7b193THaWZ4BQos16yClls05G7S+2fcSgsYz1FvY9
 yN+2cLr6NjjY2GbHKfVMsgUbIJMTGHdB2AXAERLeq0mwrnaJNP2kh/udhmVk4Z/nPwhJ
 wodp8Cc+tWKGCF1qgcJjNYtX3Ta5k0Kkn92T1tmvcmuzb/Iv4+lRpC2sjjcKFqCyZdCz
 AJFcbjGZZAHDKgniKg0N3LVhvp5ettNxaCHiZJTzwY9RnS04QcgMK1AazRSPqSeinrz0
 fk9A==
X-Gm-Message-State: AOJu0YxtVpqF/b+B1LXVVv6cxKoOStRMZZs0rgNS0+8dEeShXDaaSzrn
 Nd7fE74CsQ8kvzgPx52BEfQsjtsAqAsMWzFQKvy5ul4FYGRfhteA
X-Google-Smtp-Source: AGHT+IGVK+7nkRCm+MpZ3PgyZbKud7qwtl2+bClWBsSixgx26n6XuRVN1x3sft49OuzlGP/YF6JsKg==
X-Received: by 2002:a05:651c:1547:b0:2eb:df11:ca0b with SMTP id
 38308e7fff4ca-2ebdf11cd1dmr76669101fa.14.1718106242606; 
 Tue, 11 Jun 2024 04:44:02 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:150f:5400:ff5e:7fcf:f525:27f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4217c59be82sm114610895e9.0.2024.06.11.04.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 04:44:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: reject gang submit on reserved VMIDs
Date: Tue, 11 Jun 2024 13:43:58 +0200
Message-Id: <20240611114358.1774-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611114358.1774-1-christian.koenig@amd.com>
References: <20240611114358.1774-1-christian.koenig@amd.com>
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
index ec888fc6ead8..916b6b8cf7d9 100644
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

