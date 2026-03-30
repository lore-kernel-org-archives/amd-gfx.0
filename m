Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEC2FF4943
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 05:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCBF10E443;
	Mon, 30 Mar 2026 05:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FxZmLNJJ";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9777E10E443
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 05:30:46 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b982518b73fso649333666b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774848645; x=1775453445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4h/NQNA+UNY/vL0CTGhvWEa0MkHre3ParL6tgrkGUs=;
 b=FxZmLNJJXfyT/qnskOZXZVs4/VzlIWk5vThZWEY6I+I6QkDXLKBOBkURDJB4inxgkE
 o1bwR7p8esp7xQwXjYgdWzSXGgfQrm+24gDM0PEA9cN4dwZ4lvrF7eWURrucemcJPJUC
 DU6FlYFRX64+lWjy3a5u4hUl3UFxtADqNogd1sPiqfFG6pYeRY/w8+MY6AIoUbTDSeYW
 Mv9cw+Zatjki+lQPfgdW2H3U5YSbUPgscPage6MdQ7RxH22+OROZF7W0U+R8YVSvIJIj
 EvmRliOaHm0J+oluieHlnWz/yFg6XKuZa3Ia+xgfdADkf4djDvzv5JwiYb8SVgBB/cl1
 67qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774848645; x=1775453445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p4h/NQNA+UNY/vL0CTGhvWEa0MkHre3ParL6tgrkGUs=;
 b=duVSUVYWZmJaHKowEY5tVjp52Uf8sqjpvYO7QX+oT874UhSIkZx61UMzkWXZ7qTMUj
 lgpZQml9W00ek6CyVx80HnV+6S3bVOs+MT9nUcX7+jdi1fpjPDB+58de5EXHklfaNa34
 D9Zk1H06adj+eg123jVL0rvXXqGXbSsqRli2JN2mZOY6HvTv3wHiTWCcRLD2uUITUomE
 zc5LRce91QMCc4bivWXqs60ZjpWtfHvpClRDPCWL9AWO/KP2TUJUrBo9vHAwtsRKteRF
 f8GrRriGy33z3lzdQ5xczMGWMarMNeo4v3NorIpyEfmD1UcZkk75B+/11mvwwMXZ/cRb
 KxFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBtYgS1IqbxD6MWM/P9bBUVZr2DBXukJkQ4JgGow/Cs8MBcNx1Sd62Mca60t9iEQnb+s/98mTI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJb1U+HcgpMhxeH8y7d6CXYqR+y9MKYBKXcV5rPXSB5u5NV0Em
 hBoUB5kyHV3ljuap5fpzvh8YzEUkgYv60azacYjsniltuB/iyvzp2n9n
X-Gm-Gg: ATEYQzyQN7UXZDFD/eHjhl9yCr+ryp7VA2QNc3RAQmoV+NS2jo94q15bOkqGhTDgmCD
 JdMtODjAf28aj9c+RguVGD1PnevEgenIvZiqgzymZGT86ZlwMb82lJXVpV38pU1CMbEsf9COMpY
 N/UUrceteO+14+I8j0G6mYOjwqSDChkjIXj/Dav2mT9Rw7Xh0i5kjN68oE5kadEpgde0bAWhmvM
 aBke+QuwqbSURQKLwI2lRKkXWhvwo3Vvo7zcSGNki13yBPS4CstWO9gHmV8XJtOSmryp+68SALU
 xhwcO2mmgAL2eNoE0RIq6EB8twrX+GZaS0fKQUeuGPRf3R8FMgnxOikymO9cnkufZ7lrJeSBx/3
 AvYaYnBSfMC176A9sa8j7Fnhtqyy11eD7Qrnfrwy468e6BFW2rE20Zkx1TOH/csnaEvy3DjAcM+
 ndotyb0FAIM5wAVHGU4K49nv0xt2kEwkxK
X-Received: by 2002:a17:907:9614:b0:b9b:e5d:71d0 with SMTP id
 a640c23a62f3a-b9b5098bb2bmr700871866b.53.1774848644973; 
 Sun, 29 Mar 2026 22:30:44 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5fc9sm240417066b.36.2026.03.29.22.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 22:30:44 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 2/2] drm/amdgpu: use spin_lock_irqsave for PASID IDR lock
Date: Mon, 30 Mar 2026 10:30:25 +0500
Message-ID: <20260330053025.19203-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
References: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
MIME-Version: 1.0
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

amdgpu_pasid_free() can be called from hardirq context via the fence
signal path:

  sdma_v6_0_process_trap_irq
   -> amdgpu_fence_process
    -> dma_fence_signal
     -> drm_sched_job_done
      -> dma_fence_signal
       -> amdgpu_pasid_free_cb
        -> amdgpu_pasid_free
         -> spin_lock(&amdgpu_pasid_idr_lock)  <- hardirq context

But the lock was originally taken with plain spin_lock() in process
context (amdgpu_pasid_alloc), creating an inconsistent
{HARDIRQ-ON-W} -> {IN-HARDIRQ-W} lock state that can deadlock if an
interrupt arrives while the lock is held on the same CPU.

Use spin_lock_irqsave/spin_unlock_irqrestore for all call sites of
amdgpu_pasid_idr_lock to prevent the deadlock.

This patch applies on top of "drm/amdgpu: fix sleeping allocation
under spinlock in PASID IDR".

Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 515775eab2ef..762ceb3c708a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -62,16 +62,17 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
+	unsigned long flags;
 	int pasid;
 
 	if (bits == 0)
 		return -EINVAL;
 
 	idr_preload(GFP_KERNEL);
-	spin_lock(&amdgpu_pasid_idr_lock);
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
 				 1U << bits, GFP_NOWAIT);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 	idr_preload_end();
 
 	if (pasid >= 0)
@@ -86,11 +87,12 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -633,7 +635,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 }
-- 
2.53.0

