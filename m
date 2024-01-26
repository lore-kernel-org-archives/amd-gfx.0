Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630D9C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 15:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFB010FBFB;
	Fri, 26 Jan 2024 15:55:48 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C70510FBCB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 15:55:46 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-40ee8e0dd79so3571465e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706284484; x=1706889284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=62L8qlyf/iC9mBo4YHoFOIGZlmft/pziExeTxA5jaVI=;
 b=IDniZiO+w2RS+qyz9TzQJEfIsM+O7UqG0Je0iKc7b9wS0is052J9MrGpvsC2rp7dxT
 pyBiAo+r7tzVk+pTybh/dHHh4pjEF7nvthyRKhbCvljY4Yxw2K5++KSgh3yfO/gfMDmD
 BI+ySlJC7gYFWkuxWW1Xw0HgtkNMUrnV1Uly7QZwZ3LyQNl72xrxXRWs/BEcQDYqhQmI
 nn4rHv5r/rNigeALS/S97Nbt960jMCU/tgOISQN28OCFlPa4rwnp3AC1Ot66rDeyNs0+
 ZuIaLh2SytkeuwZPRzrIS74eAPnGa32/LtJkX0Zag6yfRIyPB9b5hY4cWeRT2d2X0ALw
 wV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706284484; x=1706889284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62L8qlyf/iC9mBo4YHoFOIGZlmft/pziExeTxA5jaVI=;
 b=nITbA7HzrbAZVFfZ8bLdtjOoUBx5JTLuEwlpwPbf2Dlj+WwiJ8n0N3/Vyixa2IQD2s
 8H9T0EoW63QbLsLzliTl/zLMPoVPHJTcvQiWc0QKjpIACICuwdzPJ4CsT4saEBFJ5F6Q
 P+Io+YQyZj4akiRSFOJkBNNMryvvlhIi/KyIY7+uM1P7VT5lDlYpYIpO7/NL+si4JHbf
 CrRWELkERl9OzQjlpKYnUKOaXWRiezeQiFoOoRsfPtElKr5waKtZPyLKBIMWMooA126W
 h6Icic/dskx8Ww8nPnhb3xwYCce+21BFXMCbnnx3I9j7D/74gif8yI7AdK81bhzcztc0
 irMg==
X-Gm-Message-State: AOJu0YzkYBTitj4W8JsRIbG17uddyxEGL4Xk4Mh1EVCP3XV6ozP4GlVB
 cJ6IYXJv9C+1K/eV07+pNLSP+TGXYIadj1ttPnHNtXGdZ5ZBr2vZL3/eAo8F
X-Google-Smtp-Source: AGHT+IHobpeXCPpICZrDWwmx6CLCNTY6/5ld/AL6wN/L6MnKMogngrMAIVW9NRydzOY5ui+qiZYCQA==
X-Received: by 2002:a05:600c:4594:b0:40e:ade0:a10d with SMTP id
 r20-20020a05600c459400b0040eade0a10dmr788615wmo.145.1706284484323; 
 Fri, 26 Jan 2024 07:54:44 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1528:de00:74a1:34a:f78c:7883])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a0564020e0100b0055d312732dbsm695801edh.5.2024.01.26.07.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 07:54:44 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: vitaly.prosyak@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix using the reserved VMID with gang submit
Date: Fri, 26 Jan 2024 16:54:39 +0100
Message-Id: <20240126155440.2022-2-christian.koenig@amd.com>
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

We need to ensure that even when using a reserved VMID that the gang
members can still run in parallel.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 36 ++++++++++++++++------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5f3859fd682..fd762444f9b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1418,6 +1418,7 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
 				u32 reg);
 void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 				u32 reg, u32 v);
+struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
 struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 					    struct dma_fence *gang);
 bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dac73f8fbda4..c870d3cbca94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6354,6 +6354,22 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
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
@@ -6370,10 +6386,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 
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

