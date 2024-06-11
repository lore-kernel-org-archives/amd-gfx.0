Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E7AC27C5E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 11:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E2C10E5BE;
	Tue, 11 Jun 2024 11:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fG5+rL+w";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3D310E5BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 11:44:03 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so7098465e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718106242; x=1718711042; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKxKrWyrj0q1Jwx7ZoM+zfR1gwdG16Q384FMJm13DUo=;
 b=fG5+rL+wtjbDqYteknReLOE1FkG1oHRc6LXIjY6si1lFd2QlZJBzAQ4FECu5A5btpS
 XZ0HdY6dXCPAnoQN4YKWWpA7VFN1Hg1ppibM8fFiGHt5osR9bFMgO81OWY2i2IrMlXPX
 QG1mpRUHOIdN4MHA0J85RgXoqndO1shzsgBNHOHUPnK0A/L8vincv4gpYBS74ekTvgYG
 RTUzim5jyDPkzC1i+cubwuTpJWAUF2Vr5eX2Na+SjRQRH9AC9gD+RjQJJ6xHCFe9m1kG
 Sv+VJGW1dfVQB/TNnsmnUNmSFpqxOROQuCvVhgc8K7ZcuhsIp2ptYPg5FZIZW0vdUPtX
 ZVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718106242; x=1718711042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKxKrWyrj0q1Jwx7ZoM+zfR1gwdG16Q384FMJm13DUo=;
 b=rLGMq47JCfqnWLbYAF3NCAgcck0ORbLHSQhXcibNCQp+uwWfK1HLG4VfAcgjL64NHz
 oFizfIba/Xiqza9YGXaezvnCWttnfBhmsgFhKBKwpKMIfE6Da56MN0hCREnjY6SRaW3V
 e1jmc0ti9oMLUtkQdcMowRJnM8WpD+mOecdFZY6cMuAcIs3Udorm0hDJGnLR0y0sI66S
 2B7VhyR1d5UJsP+1pL25f8yyXplSoSUdFXFWj0GpFqIo+PhlVl9uGXDZhzEvTKvhI98K
 EwnY6YqqejYGWBKMMICWU05JhO3AJcTnWDIJDxM/C8iGwiWdVjjS52K6MFkXNKumUDTN
 pVXg==
X-Gm-Message-State: AOJu0Yy5l1pcNn/bY+gWBHMOYOa0CiRuIcasrgImqZ13rFTitlXq6ftD
 Gd4HCFpPAYzMJniSdYOXRYmY8c2nHjrkFZDflmbhs/sWU3j8+/+O
X-Google-Smtp-Source: AGHT+IHFm7HCQmqlZNmcgcXKSx+u6mYl1j4olExdV7K4WhMuayAJhhe/IfyUuBsGHImeu99CRtiYaQ==
X-Received: by 2002:a05:600c:198c:b0:421:819c:5d76 with SMTP id
 5b1f17b1804b1-421819c6043mr62001275e9.9.1718106241920; 
 Tue, 11 Jun 2024 04:44:01 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:150f:5400:ff5e:7fcf:f525:27f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4217c59be82sm114610895e9.0.2024.06.11.04.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 04:44:01 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix using the reserved VMID with gang submit
Date: Tue, 11 Jun 2024 13:43:57 +0200
Message-Id: <20240611114358.1774-2-christian.koenig@amd.com>
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

We need to ensure that even when using a reserved VMID that the gang
members can still run in parallel.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 36 ++++++++++++++++------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f71c7b98d77..e28fc07c7dbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1450,6 +1450,7 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
 				u32 reg);
 void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 				u32 reg, u32 v);
+struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
 struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 					    struct dma_fence *gang);
 bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d549de26f931..94a6c0b1ae8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6532,6 +6532,22 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
 
+/**
+ * amdgpu_device_get_gang - return a reference to the current gang
+ * @adev: amdgpu_device pointer
+ *
+ * Returns: A new reference to the current gang leader.
+ */
+struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev)
+{
+	struct dma_fence *fence;
+
+	rcu_read_lock();
+	fence = dma_fence_get_rcu_safe(&adev->gang_submit);
+	rcu_read_unlock();
+	return fence;
+}
+
 /**
  * amdgpu_device_switch_gang - switch to a new gang
  * @adev: amdgpu_device pointer
@@ -6548,10 +6564,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 
 	do {
 		dma_fence_put(old);
-		rcu_read_lock();
-		old = dma_fence_get_rcu_safe(&adev->gang_submit);
-		rcu_read_unlock();
-
+		old = amdgpu_device_get_gang(adev);
 		if (old == gang)
 			break;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 3d7fcdeaf8cf..b5b9d4f40f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -290,18 +290,36 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	     !dma_fence_is_signaled((*id)->last_flush))) {
 		struct dma_fence *tmp;
 
-		/* Don't use per engine and per process VMID at the same time */
-		if (adev->vm_manager.concurrent_flush)
-			ring = NULL;
-
-		/* to prevent one context starved by another context */
-		(*id)->pd_gpu_addr = 0;
-		tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
-		if (tmp) {
+		/* Wait for the gang to be assembled before using a
+		 * reserved VMID or otherwise the gang could deadlock.
+		 */
+		tmp = amdgpu_device_get_gang(adev);
+		if (!dma_fence_is_signaled(tmp) && tmp != job->gang_submit) {
 			*id = NULL;
-			*fence = dma_fence_get(tmp);
+			*fence = tmp;
 			return 0;
 		}
+		dma_fence_put(tmp);
+
+		/* Make sure the id is owned by the gang before proceeding */
+		if (!job->gang_submit ||
+		    (*id)->owner != vm->immediate.fence_context) {
+
+			/* Don't use per engine and per process VMID at the
+			 * same time
+			 */
+			if (adev->vm_manager.concurrent_flush)
+				ring = NULL;
+
+			/* to prevent one context starved by another context */
+			(*id)->pd_gpu_addr = 0;
+			tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
+			if (tmp) {
+				*id = NULL;
+				*fence = dma_fence_get(tmp);
+				return 0;
+			}
+		}
 		needs_flush = true;
 	}
 
-- 
2.34.1

