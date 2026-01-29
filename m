Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1519D61014
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74EC210E85B;
	Thu, 29 Jan 2026 12:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W/gSIlhw";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC6110E858
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 12:53:34 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43591b55727so843758f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769691213; x=1770296013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p6Wv8EJoC2sVXYIA/O7MQ4+bijtrCyXGZNXm5qE/p00=;
 b=W/gSIlhwdaL9z1OwuIOQX/h4aNlq1O+Tn0+aRb/u2aPmM5mL8qLNPk9PTNnQhPYp9o
 L3FvE2Dj38Pgu8s4dvwe1TE5N5OAcoVkq0g3qmcx9mUeYNAHoD4zZx+3gQQw9Ov6NJot
 IweUMBP+n0xWwydmrdlJ7eu1OUsQmXMEJpCWc6xod6yu/PF1ME7ITDNdhhbj2rOdGPj4
 CeyJ7uYhWbZrieRnpjaA3GRdl0NR6GGXm+5n5sidz+HmFsbiFEyGJYtAa3iMBsNLKcy8
 JvsOa9azL9HpZ6H1KPoQeAqDkkHVjsI7qq+jV4MZBfQTVZGa+x6krgikFBfzOwBVNEWU
 uzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769691213; x=1770296013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p6Wv8EJoC2sVXYIA/O7MQ4+bijtrCyXGZNXm5qE/p00=;
 b=Be5PlkYl1EV47RBM0ZBfe8KaQUwrKBFWoovcxuc18G+jeMWDPZiAISJGr66lKx7lAI
 ymEMvJY5TtNiDfGe7HZl05JuTiU4VAfsGHCCH2CU9HeczO56E5SqDMlJngJB0uvOk+FD
 Q9o8M73CRTpIUBL3/WsBjyORaMvZZWaTFa0ZoVjo9PsfY7RPPpHpOMwjmzqBsAIKFEp9
 MXfhnEz/06s6mPMphhX8C7LUJdyBh0v7438n3T3s84KcwF3HWPNu/D10k7kQ1jzZwS9z
 E/Gyhzhkis4O+1exQY4T0wwTcqyYAy0Iwj23yJt2vyT5D1av5upngKIXYPK8KeXCHt4W
 Q94g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJYP/a7beL50k/CiJ5AMvrFCZFjBkB47hynXnyXVXMBwICDHYEHpfpEFd4fCnexvDkDtVI3o/B@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZFV2BznRMtrwYw7S+7ftsxQvtCLS7dRfQoSNt9DNuTBEBitu/
 VRB6bg4z8O43eYwBUmHWwiFfwTbzVO5fzOB24yCvhj94N5oBUtmWjX85
X-Gm-Gg: AZuq6aKgbPAqWQuNcQqL9jcjgqf8m9LIdOMlzBLTiKo+i2PMuKzfaTY9wuO+C+HfuNd
 /yd/4ibEoqtrfB7SPTzzvJ3JrWelo5M3PLakgwBEbfkLVBlA/la/J7q7ee0+5kpU9670bESTMaC
 1niiE10UhCvZkB5xr0o3Q+eQIqsPiIZLP/gNTm9JIPxoC6aMk5pxE6s5jS5o7VPl20zHhqX6XZk
 RECDF9rYU8pBeJW52o2DDyj2GwSkdvGGxbV2e/4s2TuZi1twV2VE/DQIqmbdaQ50OMwdWECKsbG
 B6GYyK/PywA3UU+rxuAefn/Qzt53CnL55TAH5yGWa5fCwXdW1SQPQzFtVIdCjnVI8O5OdPPnTzu
 /ZqCHFSt9hZvgeckRZZsawN8aZiXghnRWl8RdLIBVdTCgGbYJvuRsOzAuJxjmvjf5bUpVwN6kUb
 dxNyGqBDVJ21X3TDFKUrovcGQ6JXzl3KPO0CI=
X-Received: by 2002:a05:6000:2081:b0:435:953e:589c with SMTP id
 ffacd0b85a97d-435dd0b2a29mr11857664f8f.34.1769691212988; 
 Thu, 29 Jan 2026 04:53:32 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1522:e200:97e2:f9c5:ae8b:8e89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354114sm15442569f8f.42.2026.01.29.04.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:53:32 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amdgpu: make amdgpu_user_wait_ioctl more resilent
Date: Thu, 29 Jan 2026 13:53:27 +0100
Message-ID: <20260129125327.11786-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129125327.11786-1-christian.koenig@amd.com>
References: <20260129125327.11786-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 52 ++++++++++---------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index ee8a5fbbd53b..d059712741fb 100644
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
@@ -808,12 +819,11 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		if (r)
 			goto free_fences;
 
-		if (num_fences >= wait_info->num_fences) {
-			r = -EINVAL;
+		r = amdgpu_userq_wait_add_fence(wait_info, fences,
+						&num_fences, f);
+		if (r)
 			goto free_fences;
-		}
 
-		fences[num_fences++] = fence;
 		dma_fence_put(fence);
 	}
 
@@ -844,13 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
 					DMA_RESV_USAGE_READ, fence) {
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
-				goto error_unlock;
-			}
-
-			fences[num_fences++] = fence;
-			dma_fence_get(fence);
+			r = amdgpu_userq_wait_add_fence(wait_info, fences,
+							&num_fences, f);
+			if (r)
+				goto free_fences;
 		}
 	}
 
@@ -861,13 +868,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
 					DMA_RESV_USAGE_WRITE, fence) {
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
-				goto error_unlock;
-			}
-
-			fences[num_fences++] = fence;
-			dma_fence_get(fence);
+			r = amdgpu_userq_wait_add_fence(wait_info, fences,
+							&num_fences, f);
+			if (r)
+				goto free_fences;
 		}
 	}
 
-- 
2.43.0

