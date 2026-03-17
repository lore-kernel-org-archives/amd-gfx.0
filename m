Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048F0FD7079
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C3610E5C5;
	Tue, 17 Mar 2026 10:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nogrwt7f";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7053810E5C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:08 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso46908615e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744907; x=1774349707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1GhoCVLURcIe2PFGVumtMY8NQ1IKjoJtDVQzvJD7e4=;
 b=nogrwt7fKqgfzwmoydhVDzacaFr71WhKRkeFuYty2c6TN2FPgDzrw5BHTMIPxisAbW
 dgULqa1rmw3AZ1yQC+aVNYUHWN82jt0vwZwX0nEzrt1LgSUR4DKWLtquRf2AZy7hMlUx
 M0VlW/OtuSZbyqKIQceFeqcpBH5k3r+fuinJCM9Bq6wbq9qlogTBbLJJwaQr2x7j6taI
 pJpDHxNPaeVBO12vopAUsdt0CIr/Zg8wx4lD9MPBA3mZlCJzqIA8mQyUIWwHd3h+L8Ns
 xZxv3sIxJ5u4nEf7tVZRUidFZYAuMm66tI+YjmQsuSEzGJOu/hbz5/5CySwnNPabyQ06
 /AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744907; x=1774349707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w1GhoCVLURcIe2PFGVumtMY8NQ1IKjoJtDVQzvJD7e4=;
 b=QN2kh7zUw22IrBj3RSiutlGgt7heiQrNR5o2ZNLC/EjthNBdNlQzsasW4VkqVxrNJQ
 0yJSzpaudgDkeubTXIBM4lk/Ay1yCurTxex/GvV9lDBP7y7udAyezfNyTuIFt7aQSMT2
 Hwbp5QkoALR+4hsDkghydY2GphGv0H6Xv7ql5qqezA4zC6g75Z+2ndft8/rr8dPlAtI9
 I576SQAfex6qav54jC2yLW07xxLIeW6/hqeM3mnAMw8l9x7jj06bcKaC1xOEm5dxlFrG
 xfSrkkRXCohHEsQwtmwkawfwq27N7eqNgIHW/+b7PzX8TWEmA0iT1AxX0y4DHBNlJhpC
 /uLA==
X-Gm-Message-State: AOJu0YyTEQhrdPRRPDnYpk/aiHRNG/mMXbD51WxWWJpIN+ygsxv/MPcD
 ch9ejJe8T54ONauJinLBOOYuT+OQ22UbkaRpcKdSLZa9VzRH8qe+cAcy
X-Gm-Gg: ATEYQzw2WK+FCNWBA2Wja6nUruZ2tWFDyh+wQ3oTJd7W4yBwWesqmAQUUNvJCgttOVB
 Wx1Ld/LKWqY6lmRthU7Jk+Z8cj7Ifjkex5WPjJQiBzlJ6AWFz3J46eGG0EycDz84hGJ2jQtkgx6
 1W+iuJs4L1I6yrTOekROrUMMmjVHR5dyZbKoJwkNuqqTwgOyvO6Ni1chcZfIpjpxkng6esrrCQT
 0EE4cT5gacf7FIqsFeB3P/X49Slsmi2rilUbVcSM1BKxJP7bPQbqFWbZY/foa0zrof9Y6COCwAh
 d5JjTrD5VjplRSSramtYfpl3MKgZ/sG1BAZTChlhYUFIgfqSZUlV5ULbzHFJDnRmPPHnaWGS+M1
 Y9e73Um3QEntNMglPGiG3WA9JL4rBlgeEs02W9vvfa9ue+kTvWjWf3AmapWsz9vxsOHM9u836Mw
 vVEBguZUtoBQM5bh8WKAf73H6CyYyODZpqpAnH
X-Received: by 2002:a05:6000:2503:b0:439:b539:787 with SMTP id
 ffacd0b85a97d-43a04dc0519mr31233825f8f.53.1773744906838; 
 Tue, 17 Mar 2026 03:55:06 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:06 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/10] drm/amdgpu: make amdgpu_user_wait_ioctl more resilent v2
Date: Tue, 17 Mar 2026 11:54:55 +0100
Message-ID: <20260317105501.21479-5-christian.koenig@amd.com>
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

When the memory allocated by userspace isn't sufficient for all the
fences then just wait on them instead of returning an error.

v2: use correct variable as pointed out by Sunil

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 48 +++++++++++--------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 0d9a13081f2f..f93da45cfa7e 100644
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
@@ -758,13 +771,12 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 			goto free_fences;
 
 		dma_fence_unwrap_for_each(f, &iter, fence) {
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
+			r = amdgpu_userq_wait_add_fence(wait_info, fences,
+							&num_fences, f);
+			if (r) {
 				dma_fence_put(fence);
 				goto free_fences;
 			}
-
-			fences[num_fences++] = dma_fence_get(f);
 		}
 
 		dma_fence_put(fence);
@@ -781,14 +793,12 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
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
@@ -818,12 +828,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
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
 
@@ -834,12 +842,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
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

