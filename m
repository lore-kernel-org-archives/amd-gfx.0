Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C77FD4F2A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 19:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E79B10E2DF;
	Tue, 10 Mar 2026 19:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bVwm4J5F";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAF310E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 19:13:37 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso38608115e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773170016; x=1773774816; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZYdgVL+TtL5griCaJ8ihRd3COY0hxDs5eQzbhv1rCrM=;
 b=bVwm4J5FN60dBd4gxyK4XKS+fJ1tBMMlwu6xVc4AmH0Bb3RP7IzolB1nqiWSjoFH9b
 gM9UNrgEAbSfAEyGWYF2gMJ0UkotPMb1uG0BbwpEJFnzFpMoy+YdevJkA9W6QmnUVfPw
 fMa5CUpK9VwAIvdlClD5j39IsLJ/s+ZLUeu2oKwB+Lv4pBQMu04AkhUIb6Qzrnl5QEyh
 vG/9AxdBlgqq+pV0NWNdFqeOTi7sf5VFSpg7mkk086YErWoC3G/ZmA2CMaLwqexS1PM6
 rnO6lhwDfnVZR5CYXeDnW4aMLKu9kNYc7K1F0wVeaMpboFT+LeNeNF/waKmzwrMdwxRI
 b8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773170016; x=1773774816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZYdgVL+TtL5griCaJ8ihRd3COY0hxDs5eQzbhv1rCrM=;
 b=KBn8LHZ3BKleUKZlfKmfjFTCFNq+TXHPeQUg3GSt/Dh/hjrmiF06nK9Q6DVbHCaNNg
 gxoeyHmLqANrjfesObI1rNePgoyGk4Rw+NIutnKA+FpTwvvtUSiygVb7DDRGc8umZ4SJ
 5hnczeLuujJp3SVqbtberWL3HOJy1TPAMpn4OPNqCK1wv2Dka5dlvUzbGrtf6EBcuKKA
 bYqg9EVZUE6/P61GHOn0ZUTjNQTcbJsVFUWMfE7Yt/42TlIQzyN0y6yff6TFYdr5/06C
 +JEqG7wa6gc1lZWaDmzTNcMg4XXjVNzJrFc77bXC/+7xMPK1nispjPZ1Ihhw1LmEGtKM
 OqWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX12TtEqmcUEIzsvayP4nTgElaf4WiRLFHB2DFCSWCfQ7y9cAdAWOluc17igQl5/z4usTU/e+P5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwOy5bbmuUv/Yf01YouxBz7fryEemvlNOw/fs+NGN6uTh1SWEs
 o9Rm7ENbbTnk6HSmwM10BTxNtG6DRsgAY8jKw97Gz68qdzIR2s2QhyccO87XXT9E
X-Gm-Gg: ATEYQzxnak0pXFu8aIlJkSX3hTYL2cxiG81LfSBIN1XldwMPIybQc0OWzEDECsXnm7x
 Z1WvSrCVDA7ID85/o3WTMw/o23hS6z0n3WUhPR9OQkpDbsYVRTCP26eHxXW1F08ht5kfgDb9jXN
 PyRjEkg6au75juDE24KIQ+I27y3ry5NBekJ7brHCTGD5IKYUKhtfUQMfdQ5D4EnCSknULbp7I+B
 8unjqhSLM86PYWK6Kx+TcKcXDOgnLZqZHjFhLoPSce5WJDii8i4gSHdl1pRpeSIBPZfsFe8HY1X
 RJMBa/USo/vGNZr+ARbgRXft7whYxH19vNBYbJCcdz39KaztXB4DSXL91z/he49mwiNZ6wO3Fv5
 oN9VEpg6Dr5AiWMsIkCRuCuQkdyy4IKZp8eP126gZyniPLlo57Mt30ASJciRED2lJdtrvcFDRf3
 rFgZCY5smPHuI8Qd0htCrIfuvr+JUSHQXXUco=
X-Received: by 2002:a05:600c:540e:b0:485:39d1:b500 with SMTP id
 5b1f17b1804b1-48539d1bbedmr142309855e9.16.1773170016101; 
 Tue, 10 Mar 2026 12:13:36 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d0:d800:5198:df3e:59ca:cf4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3079efsm2601625e9.7.2026.03.10.12.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:13:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] drm/amdgpu: make amdgpu_user_wait_ioctl more resilent v2
Date: Tue, 10 Mar 2026 20:13:24 +0100
Message-ID: <20260310191327.2279-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310191327.2279-1-christian.koenig@amd.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
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

When the memory allocated by userspace isn't sufficient for all the
fences then just wait on them instead of returning an error.

v2: use correct variable as pointed out by Sunil

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 49 ++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 14a289c782ea..4d043708574e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -706,7 +706,7 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
 			num_fences++;
 	}
 
-	wait_info->num_fences = num_fences;
+	wait_info->num_fences = min(num_fences, USHRT_MAX);
 	r = 0;
 
 error_unlock:
@@ -715,6 +715,19 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
 	return r;
 }
 
+static int
+amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
+			    struct dma_fence **fences, unsigned int *num_fences,
+			    struct dma_fence *fence)
+{
+	/* As fallback shouldn't userspace allocate enough space */
+	if (*num_fences >= wait_info->num_fences)
+		return dma_fence_wait(fence, true);
+
+	fences[(*num_fences)++] = dma_fence_get(fence);
+	return 0;
+}
+
 static int
 amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 				    struct drm_amdgpu_userq_wait *wait_info,
@@ -758,12 +771,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 			goto free_fences;
 
 		dma_fence_unwrap_for_each(f, &iter, fence) {
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
+			r = amdgpu_userq_wait_add_fence(wait_info, fences,
+							&num_fences, f);
+			if (r)
 				goto free_fences;
-			}
-
-			fences[num_fences++] = dma_fence_get(f);
 		}
 
 		dma_fence_put(fence);
@@ -780,14 +791,12 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		if (r)
 			goto free_fences;
 
-		if (num_fences >= wait_info->num_fences) {
-			dma_fence_put(fence);
-			r = -EINVAL;
+		r = amdgpu_userq_wait_add_fence(wait_info, fences,
+						&num_fences, fence);
+		dma_fence_put(fence);
+		if (r)
 			goto free_fences;
-		}
 
-		/* Give the reference to the fence array */
-		fences[num_fences++] = fence;
 	}
 
 	/* Lock all the GEM objects */
@@ -817,12 +826,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
 					DMA_RESV_USAGE_READ, fence) {
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
+			r = amdgpu_userq_wait_add_fence(wait_info, fences,
+							&num_fences, fence);
+			if (r)
 				goto error_unlock;
-			}
-
-			fences[num_fences++] = dma_fence_get(fence);
 		}
 	}
 
@@ -833,12 +840,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
 					DMA_RESV_USAGE_WRITE, fence) {
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
+			r = amdgpu_userq_wait_add_fence(wait_info, fences,
+							&num_fences, fence);
+			if (r)
 				goto error_unlock;
-			}
-
-			fences[num_fences++] = dma_fence_get(fence);
 		}
 	}
 
-- 
2.43.0

