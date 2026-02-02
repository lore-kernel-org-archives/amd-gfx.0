Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC6AE73160
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703CF10E4B7;
	Mon,  2 Feb 2026 12:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B13TuAY7";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD63310E4B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:51:57 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so41656475e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 04:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770036716; x=1770641516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FCo6xPY7BIwmmSp2zOrsHzp6cN+XtIN6F/hYzQ2mk2U=;
 b=B13TuAY7xeaERXi8kbHU2wkWwbuJ63+gv/dViOcS0kjxwjINoR0EB5mYqZThpak4/v
 JoWHl7/dXVtHa6S8PIwNPC5Wa1y4F6quxMz25jmvA8Jqiujg+S5R88sfWACWa9OjQmJS
 wU4DT6RcTaS9/jFcJ++43W5S4zGw0TJdpFXdVdFcACA1xgUkGP7XbUcqv3bQJfFk2LNS
 xyC8Ft/iMhz93xCJ1Kl9fsRAUgtSAbyflVMc9imgUQ2r6NBacUVCjOnl1/BoCzbpoPNC
 vMgb93tOyxUhMpfmhDIVVKRK/rFQDnyq/7irPeD8lHXRi3S0gdDBCd7khFgIR2oS5r6N
 ySpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036716; x=1770641516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FCo6xPY7BIwmmSp2zOrsHzp6cN+XtIN6F/hYzQ2mk2U=;
 b=n13m64oHH5cTqV1ArH0KA/YDP9eCpQg0Qh201vrAlPgWsRXBt3GPxeHqFNJewTd0BT
 SB1oXgOm43xA74Lr8rboVTFsAk1MC+ruTMjUCV9pvZdZaiH+N7G+7+4PJ9vXRAYSfmu7
 kbVhTR7KrU2S0vGHQ4KZnfTp1JrPoh1yHPgZ9Az3JdnvwVrl/zbN7XLXQf9DMNdAlsr6
 jIwoIe9B+AzMraffWlRdJxGj+uAx9TDkwgr7MkOkWbgGLJkR51IXWoZI63bYjhYxkqfu
 tHfrIEz6SIJMb8WpHg68XEZ8Abnd1bvYSMGqllOk+9bW6OUL4hawMNXFvJThut12mkKo
 HDDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxQaGk+OuUTmii5H2i7S8ZY+ALgTKY+4IKGNO6bWcZHQHzXodG3WRn9n0v9Re1Lyu2h8pT490I@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsRwB5VboXL5/yDTo00cRKZFSCPLnJPZJZifinWFQq4iK17D6M
 Mz88qx1KobD60lj78FydsKxhU3xMwfFIOoJWSXAxtnT55vsdO7Gsqu9p
X-Gm-Gg: AZuq6aJxHTfKgYOsuhiOYHXHbNMmGTpoTB5iJVnghQ8M+JHZiJm04P19JdrERqn/Jt1
 GMHYz0XqB+a7ulgb/KF9IIWrHjaVqF/KIMRbUzfD2EqbkCAfJIeIil8u6JXS9yegzacIwFq8/s1
 6T86c2KuGDMjarqkGz5cRdm5yVdq65bq2bO+3vEIPEQvrJgkrVeL6gCYjJmSakH3Rl/RfZNyAmp
 8T1zLNq20j5glpz+QEYG/BdUvc9q+j5fzFO3gb5rzlPMV9q1ND/Nb38yy77cATI70WkinAeiXFX
 Dt/FwV3PMTDqAsNS0qSZKUQu2X1pGZzQ5tzZBx5YNEleLnoJ1AmnlzLHi29Xl7MkOxxpoB68rIl
 0k7ocwNekdvZmBRgL6RD8QyDBY7yHLykK1aJaUKsGXfNiJE1+mUygkA2jrj1K+j4tCKA1amZX9x
 uBay8dtWVAyEz/6JrLda6lnUE=
X-Received: by 2002:a05:600c:1549:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-482db4e3054mr144980205e9.25.1770036716164; 
 Mon, 02 Feb 2026 04:51:56 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1570:8200:7824:9bef:268:2d37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da6a042csm126165535e9.0.2026.02.02.04.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:51:55 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/9] drm/amdgpu: make amdgpu_user_wait_ioctl more resilent v2
Date: Mon,  2 Feb 2026 13:51:48 +0100
Message-ID: <20260202125149.2067-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202125149.2067-1-christian.koenig@amd.com>
References: <20260202125149.2067-1-christian.koenig@amd.com>
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
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 52 +++++++++++--------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index da329d00843b..8a1a0af59910 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -734,7 +734,7 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
 			num_fences++;
 	}
 
-	wait_info->num_fences = num_fences;
+	wait_info->num_fences = min(num_fences, USHRT_MAX);
 	r = 0;
 
 error_unlock:
@@ -743,6 +743,19 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
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
@@ -786,12 +799,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
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
@@ -808,13 +819,12 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		if (r)
 			goto free_fences;
 
-		if (num_fences >= wait_info->num_fences) {
-			r = -EINVAL;
+		r = amdgpu_userq_wait_add_fence(wait_info, fences,
+						&num_fences, fence);
+		if (r)
 			goto free_fences;
-		}
 
-		/* Give the reference to the fence array */
-		fences[num_fences++] = fence;
+		dma_fence_put(fence);
 	}
 
 	/* Lock all the GEM objects */
@@ -844,12 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
 					DMA_RESV_USAGE_READ, fence) {
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
-				goto error_unlock;
-			}
-
-			fences[num_fences++] = dma_fence_get(fence);
+			r = amdgpu_userq_wait_add_fence(wait_info, fences,
+							&num_fences, fence);
+			if (r)
+				goto free_fences;
 		}
 	}
 
@@ -860,12 +868,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
 					DMA_RESV_USAGE_WRITE, fence) {
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
-				goto error_unlock;
-			}
-
-			fences[num_fences++] = dma_fence_get(fence);
+			r = amdgpu_userq_wait_add_fence(wait_info, fences,
+							&num_fences, fence);
+			if (r)
+				goto free_fences;
 		}
 	}
 
-- 
2.43.0

