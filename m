Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5593C4321E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 13:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531AF10E455;
	Mon, 21 Mar 2022 13:59:15 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E6010E446;
 Mon, 21 Mar 2022 13:59:13 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id v22so6909759wra.2;
 Mon, 21 Mar 2022 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/8feDZVFHPKC3pY8v1GnW/3pzS/fVxuaXiSADYQ0yfQ=;
 b=B8igd0QaoGK6iUds+iZnlPkfS/iwY/oAb9r7JNI+6H41U2TJXhVbUO5W8IBC2QY3d0
 kmQfvcgADmiO5A5Ry2oUyp0aBAztFvrIuyQY9U5e+3XldsxYyV55lBr3Tv8DehvmjLJf
 xdqL67bhmpEr+QEkPSAqiJUgTgE8wpNCGFGj6t4GQx98ZPh654RrJiqRzEZTYrkGodQF
 TmIvlkY3m0Qx5O95zzZTuDVaH5erW8NCc6NgeMfKAsJoTQEviQOGrsK3LfZCkcco1SE9
 YBir+r0KJh8fUdqY5YCBvx6wp648OwJXRMANbnsSoGxX5jrT2z3VBpBixrVp8VJO+pcX
 zIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/8feDZVFHPKC3pY8v1GnW/3pzS/fVxuaXiSADYQ0yfQ=;
 b=7fH6cSESzWqkELlfSgG88Bn1Py+rsae6W1qjq8b9wO1iS11tpvZ/0cy6HrO84N5lte
 r54jUHemG20fBTNtW0djwfo/9Lbfm6sI51mYTkkoP8OiXJ8SmihGVR92n0g0Hp0Pyui9
 tr4eRg8aZCXmzi+LxGjaPdxiGcf2rmxXBAk5Jg2QtTquB/YODSLEPFTuSsnOaitOihnY
 2VwfP0ww68lmCI0c6YXAaVv43JhmCgK+3zsGn/P5hEXNkL8XJ71N0gwdFMrGmx4psAXB
 Ih++4Wb8GPcK1/PzIyZ7L6I+N7NEpnbzMBrAYb28itkDjoaDOC8KOfnCvxRf1A+2LwKd
 JmxQ==
X-Gm-Message-State: AOAM533Dc4x72MuXrxgpUkaQUrS/18cOuEEF/qwVO4iXAe3z9YUK1Izr
 /SwtaXwIljiGK0LQ0UYkWWw=
X-Google-Smtp-Source: ABdhPJyNTdvhuqm7Se7WGuPck7zTesA2FcyGj+nppPCqu8OZgrRYcO45SdIYOhpuHopkchPDkedJRA==
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id
 o12-20020a5d47cc000000b002041c9d2157mr1551701wrc.294.1647871151994; 
 Mon, 21 Mar 2022 06:59:11 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a5d6243000000b001e33760776fsm13317640wrv.10.2022.03.21.06.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 06:59:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel.vetter@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 15/23] drm/amdgpu: use dma_resv_get_singleton in
 amdgpu_pasid_free_cb
Date: Mon, 21 Mar 2022 14:58:48 +0100
Message-Id: <20220321135856.1331-15-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220321135856.1331-1-christian.koenig@amd.com>
References: <20220321135856.1331-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Makes the code a bit more simpler.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index be48487e2ca7..888d97143177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -107,36 +107,19 @@ static void amdgpu_pasid_free_cb(struct dma_fence *fence,
 void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 			       u32 pasid)
 {
-	struct dma_fence *fence, **fences;
 	struct amdgpu_pasid_cb *cb;
-	unsigned count;
+	struct dma_fence *fence;
 	int r;
 
-	r = dma_resv_get_fences(resv, true, &count, &fences);
+	r = dma_resv_get_singleton(resv, true, &fence);
 	if (r)
 		goto fallback;
 
-	if (count == 0) {
+	if (!fence) {
 		amdgpu_pasid_free(pasid);
 		return;
 	}
 
-	if (count == 1) {
-		fence = fences[0];
-		kfree(fences);
-	} else {
-		uint64_t context = dma_fence_context_alloc(1);
-		struct dma_fence_array *array;
-
-		array = dma_fence_array_create(count, fences, context,
-					       1, false);
-		if (!array) {
-			kfree(fences);
-			goto fallback;
-		}
-		fence = &array->base;
-	}
-
 	cb = kmalloc(sizeof(*cb), GFP_KERNEL);
 	if (!cb) {
 		/* Last resort when we are OOM */
-- 
2.25.1

