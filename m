Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1DDFD7075
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9574810E5C6;
	Tue, 17 Mar 2026 10:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZqTxfQZY";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208CF10E5C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:09 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso3673542f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744908; x=1774349708; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIoAe492csWddJJ8wZXPgVzwnCGrIGQG1lkew/I/9Xs=;
 b=ZqTxfQZYXIoMfYVRV+nR3g2pOvOR1oHshFysJ10fY2ILe0RBrJC8RZjxmXy7TeCDcZ
 exXT6MZDK8T1B44znsm83L3LkRWcBJH5XwtEI4sj7HFRbvjXm2S1m0Qjyo+uDOB8ZGCZ
 gxV5QomcIogNnYdigaTsoqkLgkXeBvA2OxbL224Rihs28Ebqrjvzsn8yAMYG4zz8Inuy
 vpqJejz1N+IIF0caj9kLGzCMF9boAehsMhCdEJFAJrmGEsuL/E5JslfqwMZ2AObWOSNq
 R1WDfPBHUlX6qPVkbZ5vqheCvmKasCJ9hPtq0Mq7zR5rXTgt1zl8Xed4awacqpizj/vn
 WePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744908; x=1774349708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MIoAe492csWddJJ8wZXPgVzwnCGrIGQG1lkew/I/9Xs=;
 b=TrYc6tEQV4pxzjk7WUo/MLWwqlzn875y88/s/E1vYRikQLaSD2qj1NbZTtptqpImLI
 zWzqrPMCCvl99z5LH1WMrzsIAWlXfyDMja/GG2fCspQwZkNX4xeiVLtfxtxo6wNAT5jo
 gytIp7dWmnvG9U0Spd5V/InTA0+tNOhaHGoNAJ34t/e3dUQlHEXop4kqR0hLmYvBvgZH
 PDD1FUelGcqWOiyshrWj0dZaV+bcBNeudl8EwGJiGnpYPYSbPpvkuX1pvPM4zvhG4p+W
 Tx9GK8tbTVXuTY0LLUrMrVSikE6f98cyPe2b9fhyoo8Ad08Un174Rw6InJvvH0hy7JCg
 ZI1g==
X-Gm-Message-State: AOJu0Yxa4lp+ZSfbzFi+aS9C8o/IwUnug3y3EJ48se/Ots0I+HFbR6Sc
 lS74GTZ0w5c7ffS4VzStobRjilBZVRn6yw6NYCj9t99F4ejmSEOawL42
X-Gm-Gg: ATEYQzzm8X6aNT8BIJoKq4zMTN1W3ev4hjLws1FFU+61wgAx8ZCqq+6h9frjxNkGAY7
 bhqikmeJk4r31b+qHv1axzYtBGj/NhUXR0tUsJ8WjDH/uoLknECeNLxqtI4WH1C6Citf0+/PpAK
 Z+KqsxlIWtJfcVfLfEz26Ac4LoruJu67mgub8Zghdk30F1xyV3k6X5nNB8GwiLFFMRuSKEbDWD9
 YPH8Z6afDI0La3WCNQGvgt/CZBmBP3+jac+qK3smOjBQNBLdmxq3qzZcoPLy2J8SZrfIBbZ/en9
 pURzbl2Yru3WRqBcibl92AfufUD7ark0foqDFjlT+7Mi5gET39Xu6M4tskENJ+/vFDd6bw3dXFQ
 6KO/vcSlJDnddxD7Ky/u5qyzhm2U6NDZJicFjfzWOrSs2XRlsNSxo6GzwWC6uBRkjoA7wN5xyrH
 tpc35O94QHDSV+x0lMdDMWzUvPI1R9K9XGLJUWT0l4z97Z2NY=
X-Received: by 2002:a05:6000:2010:b0:439:ddc0:4bee with SMTP id
 ffacd0b85a97d-43a04d86228mr27607232f8f.16.1773744907555; 
 Tue, 17 Mar 2026 03:55:07 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:07 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/10] drm/amdgpu: annotate eviction fence signaling path
Date: Tue, 17 Mar 2026 11:54:56 +0100
Message-ID: <20260317105501.21479-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317105501.21479-1-christian.koenig@amd.com>
References: <20260317105501.21479-1-christian.koenig@amd.com>
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

Make sure lockdep sees the dependencies here.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index ef7d07a134ce..641d03ef8608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -64,8 +64,17 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 		container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct dma_fence *ev_fence;
+	bool cookie;
 
 	mutex_lock(&uq_mgr->userq_mutex);
+
+	/*
+	 * This is intentionally after taking the userq_mutex since we do
+	 * allocate memory while holding this lock, but only after ensuring that
+	 * the eviction fence is signaled.
+	 */
+	cookie = dma_fence_begin_signalling();
+
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
 	amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
 
@@ -75,6 +84,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	 * next fence.
 	 */
 	dma_fence_signal(ev_fence);
+	dma_fence_end_signalling(cookie);
 	dma_fence_put(ev_fence);
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
-- 
2.43.0

