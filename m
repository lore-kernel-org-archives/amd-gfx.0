Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A77C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0542010F5D2;
	Thu,  3 Sep 2026 13:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qDcZOqnB";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBFE10F5EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:13 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so1325113f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443052; x=1789047852; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m5nFAvnp9TbeBbFXDaBPRO3V4SNXTlxxZw2s8E+92CE=;
 b=qDcZOqnBdHoFcbhmsgqhzEDdtNwCu2bJUMbjofF6qrA0ouuylP1Y4WQ7fjQluqcPJp
 ceqAGG/L0CUZA0BGxhSaZbqzKzbY53K4u/8tZSwnjjlzxbglL9o1gxeX2tRrvbTk5cHj
 Ula1ShOFsYeZqerFDLx0Xeyz95hVeSYiWdt15WAgDsF8fqq5q6WLW+Hsf5hJKinYvlBV
 33PpDW2gzUcRf2AyJa3eKzmOCLEtRfguMstpGEECcLzfk0iZUNTdxwdZnggj22GF3Jyn
 t52uZIvY5fFd/SLaimXbdD1xlr1dIynBPCLgZ9FBpri8Ng7tLDtQeLonDFHfflHA83UQ
 yLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443052; x=1789047852;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m5nFAvnp9TbeBbFXDaBPRO3V4SNXTlxxZw2s8E+92CE=;
 b=eEr2CuS+2Kv2bStCRQbO4RQiUP9EdIewZehHA7CMRhnYHLSGf5uu23BzmyphzUGZ4W
 afx51cKJdjC3lqLxC/KOaAZ/tPz37h9aHsO2WeLmcMpRcEGW5VvEi1GRB8oZhch5w09m
 bQ+jtjY4yDiWSD/PJI0YYvygnxp7FAArqNvRod2V9EGWZuXccD2ZkyT3hIzAbL+APH/1
 6SHXTxf+XUwYTyAWJPfIq1RQHNENnwXxKDDd/Kq8RUKW/d1hUlNPRVA44GPH11+DjM5H
 gMbbNQAXtF4XvzdLLOtCp4WeN1yknSwpZXsp/2DAYvhRhfJuTlxv/ZBkDw1zVCQF2Rim
 a/ZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxQzbZnFaLI2Jj2X0LPtcp64AEsipNd8tahka9hv2sXul+hzWppL/tQZ0N9J1zC/djjnTCfvcf@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqpPDp1fszShBRrP7lF4t9QkW++5w83PqCD0jNFKkHA9MO7IbV
 xgT/kLv3V5Qm3Q3hm3M3KZmSf93jQXgKsoyXdX3SrTJanOJVnOFpeyRj
X-Gm-Gg: AYBFou3N03f5Uhb3ZvFAtpGzfSR8RTWKJ4D6H+bAVyt3SUO2rmq5vGE/Acq2YPV3UUW
 //j/+l8BpCioTq10+M/Q789kSzfobWJtpW4DbUzvqeu4dU22L1LsWZnieGrecIZTIG3Kr1PnJgn
 78jtbJn7NlC4abJ0OIoJAK1UhRPPBy915DvbkQbi5xhrqF4BqMWY53iTZC2uBdxBpXis25xki5z
 Yvduh2fHQ0Rqq8qeNG2zV1/P1YS5jSVQHPKsPVTQ88lEPsS/rNvjbx6qdtcAzwaH9N7jfQaClTs
 GizlOEX3uIJIT3VY3uUhp01Vkhg9+SiPor8dvaxKWDpOo1qbqRoextnov2W5Kh923XXXJdqfBOU
 uhFoklUd12uqyfD+dYgYs7VOthz8xHV7a6edy+GmstUEXi0MMuhh0N8NRNqeqYV1gVqTi/nZq6i
 WJsBQIEF1APXDcixwNg5A2E6y1WSxqj0OG3ZllJP5lKVoTwlQkWpfBPXLR11fGsOFzDx0rYb65L
 g==
X-Received: by 2002:a05:6000:601:b0:484:36c8:ffb9 with SMTP id
 ffacd0b85a97d-48586022058mr934474f8f.4.1788443051985; 
 Thu, 03 Sep 2026 06:44:11 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/11] drm/i915: fix incorrect RCU teardown order
Date: Thu,  3 Sep 2026 15:27:56 +0200
Message-ID: <20260903134408.105317-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

i915_gem_busy_ioctl uses dma_resv_for_each_fence_unlocked() to iterate
over the fences in an GEM object without holding a reference but only
the RCU read side lock.

What can happen here is that the GEM object is destroyed concurrently
while i915_gem_busy_ioctl is still running. This won't free the GEM
objects memory, but still drops all the dma_fence references.

Now when dma_resv_for_each_fence_unlocked() sees a destroyed dma_fence it
assumes that a new fence list was installed and re-starts the loop.

But in the case of a destroyed GEM object a new fence list is never
installed, only the old one freed and therefore the iteration never
finishes resulting in an endless loop.

The solution is to drop the fence references only after the RCU grace
period.

The fixes tag is not necessary the patch introducing the problem, but the
one making it so worse that we need to address it.

This problem was pointed out by Sashiko-bot.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
CC: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 5172d3982654..9e01f8b2079a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
 
 void i915_gem_object_free(struct drm_i915_gem_object *obj)
 {
+	dma_resv_fini(&obj->base._resv);
 	return kmem_cache_free(slab_objects, obj);
 }
 
@@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
 {
 	mutex_destroy(&obj->mm.get_page.lock);
 	mutex_destroy(&obj->mm.get_dma_page.lock);
-	dma_resv_fini(&obj->base._resv);
 }
 
 /**
-- 
2.43.0

